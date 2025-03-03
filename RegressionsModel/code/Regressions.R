
rm(list = ls())

library(zoo)
library(chron)
library(x12)
library(ggplot2)
library(segmented)
library(mgcv)
source('C:/RDatadoc/影响因素/EconAnalysisLib.R')


library(tidyverse)
library(caret)
theme_set(theme_classic())

data=read.csv('C:/RDatadoc/影响因素/EPMI与PMI2.csv',fileEncoding = 'gbk')
data=zoo(data[,-1],chron(data[,1],format=c('y/m/d')))
colnames(data)=c('epmi','ep','eo','eim','epp','eoi','eem','era',
                 'pmi','pp','po','pneo','pooh','ppi','ppv','pim','ppp','prmp','prmi','pem','pdt','poo')

data=read.csv('C:/RDatadoc/影响因素/环比.csv',fileEncoding = 'gbk')
data=zoo(data[,-1],chron(data[,1],format=c('y/m/d')))

data=read.csv('C:/RDatadoc/影响因素/Factor.csv',fileEncoding = 'gbk')
data=zoo(data[,-1],chron(data[,1],format=c('y/m/d')))



####非线性回归
pmi = data[,'pmi']
eo = data[,'eo']

ggplot(data, aes(eo,pmi) ) +
  geom_point() +
  stat_smooth()

pd=window(cbind(pmi,eo),start = chron('01/01/2018'))
pd.na=pd
train=pd.na[-c(53:61)]
train1 = window(train,start = chron('01/01/2019'))
train2 = window(train,start = chron('01/01/2020'))
train3 = window(train,start = chron('01/01/2021'))
test = window(pd.na[,'eo'],start = chron('01/01/2023'))


model.log<- lm(pmi ~ log(eo), data = train)
summary(model.log)
ggplot(train, aes(eo, pmi)) +
  
  geom_point() +
  
  stat_smooth(method = lm, formula = y ~ log(x))

model.lm <- lm(pmi ~ eo, data = train)
model.segmented <- segmented(model.lm)
summary(model.segmented)

plot(eo,pmi, pch=1, cex=1.5)

abline(a=coef(model.lm)[1],b=coef(model.lm)[2],col="red",lwd= 2.5)

plot(model.segmented, col='blue', lwd= 2.5 ,add=T)
predict(model.log,test)




######Multiple Linear Regression
pmi=data[,'PMI']
epmi=data[,'EPMI']
epp=data[,'epp']

ggplot(data, aes(epmi, pmi) ) +
       geom_point() +
       stat_smooth()
pd=cbind(pmi=pmi,epmi=epmi)
pd.na=na.omit(pd)
model.log<- lm(pmi ~ log(epmi), data = pd.na)
summary(model.log)

ggplot(data, aes(epmi, pmi)) +
  
  geom_point() +
  
  stat_smooth(method = lm, formula = y ~ log(x))


model <- gam(pmi ~ s(epmi), data = data)
ggplot(data, aes(epmi, pmi) ) +
  geom_point() +
  stat_smooth(method = gam, formula = y ~ s(x))



pd = cbind(PMI=data[,1],工业主成分=data[,2],EPMI=data[,3],计量PMI=data[,4],EPMI生产量=data[,5],EPMI产品订货=data[,6],EPMI进口=data[,7],EPMI就业=data[,8])
pd.na=na.omit(pd)

train=pd.na[-c(53:63)]
train1 = window(train,start = chron('01/01/2019'))
train2 = window(train,start = chron('01/01/2020'))
train3 = window(train,start = chron('01/01/2021'))
test = window(pd.na,start = chron('01/01/2023'))

mlr <- lm(PMI~ 工业主成分 + EPMI + EPMI生产量+ 计量PMI+EPMI产品订货+EPMI进口+EPMI就业 , pd.na)
summary(mlr)

mlr <- lm(PMI~ 工业主成分 + EPMI + EPMI生产量+ 计量PMI+EPMI产品订货+EPMI进口+EPMI就业 , train)
summary(mlr)
predict(mlr, test)

mlr <- lm(PMI~ 工业主成分 + EPMI + EPMI生产量+ 计量PMI+EPMI产品订货+EPMI进口+EPMI就业 , train1)
summary(mlr)
predict(mlr, test)

mlr <- lm(PMI~ 工业主成分 + EPMI + EPMI生产量+ 计量PMI+EPMI产品订货+EPMI进口+EPMI就业 , train2)
summary(mlr)
predict(mlr, test)

mlr <- lm(PMI~ 工业主成分 + EPMI + EPMI生产量+ 计量PMI+EPMI产品订货+EPMI进口+EPMI就业 , train3)
summary(mlr)
predict(mlr, test)

step(mlr)
mlr <- lm(PMI~ EPMI生产量+EPMI进口+EPMI就业, train1)
summary(mlr)
predict(mlr, test)

step(mlr)
mlr <- lm(pmi~ eo, train)
summary(mlr)
predict(mlr, test)




test.df <- data.frame(
  ep = c(0.124567474,-0.073846154),
  pca = c(0.138384471,-0.2739274),
  epmi = c(0.07037037,-0.05363322),
  pred = c(-0.09631672,-0.00302236),
  eo = c(0.136612022,-0.084935897),
  eim = c(-0.113537118,-0.017647059),
  eem = c(0.041587902,-0.032667877),
  check.names = F
)
predict(mlr, test.df)

step(mlr)

newmlr <- lm(pmi~ eo, train)
summary(newmlr)
test.df <- data.frame(
  epmi = c(0.07037037,-0.05363322),
  pred = c(-0.09631672,-0.00302236),
  check.names = F
)
predict(newmlr, test.df)


pd = window(cbind(pmi=data[,1],pca=data[,2],epmi=data[,3],pred=data[,4],ep=data[,5],eo=data[,6],eim=data[,7],eem=data[,8],epp=data[,9]),start=chron('01/01/2018'))
pd.na=na.omit(pd)
train=pd.na[-c(53:61)]
test = window(pd.na,start = chron('01/01/2023'))

mlr <- lm(pmi~ pca + epmi + ep+eo+eim+eem+epp + pred, pd.na)
summary(mlr)
predict(mlr, test)



pd = cbind(pmi=data[,1],pca=data[,2],epmi=data[,3],pred=data[,4])
pd.na=na.omit(pd)
mlr <- lm(pmi~ pca + epmi + pred, pd.na)
summary(mlr)

test.df <- data.frame(
  pca = c(0.1383845,-0.2739274),
  epmi = c(0.07037037,-0.05363322),
  pred = c(-0.09631672,-0.00302236),
  check.names = F
)
predict(mlr, test.df)


pd = cbind(pmi=data[,1],pca=data[,2],pred=data[,4],ep=data[,5],eo=data[,6],eim=data[,7],eem=data[,8])
pd.na=na.omit(pd)
mlr <- lm(pmi~ pca + ep+eo+eim+eem + pred, pd.na)
summary(mlr)

test.df <- data.frame(
  ep = c(-0.110769231,-0.073846154),
  epmi = c(0.07037037,-0.05363322),
  pca = c(0.1383845,-0.2739274),
  pred = c(-0.09631672,-0.00302236),
  eo = c(-0.120192308,-0.084935897),
  eim = c(-0.101960784,-0.017647059),
  eem = c(-0.029304029,-0.053113553),
  check.names = F
)
predict(mlr, test.df)

compare=read.csv('C:/RDatadoc/影响因素/compare1.csv',fileEncoding = 'gbk')
compare=zoo(compare[,-1],chron(compare[,1],format=c('y/m/d')))
data=ToZoo(ToTS(data))
pd=cbind(pca=data[,2],epmi=data[,3],pred=data[,4],pmi=compare[,'PMI增降'])
train=pd[-c(61:71),]
test=window(pd,start=chron('01/01/2023'))
test=test[-c(10,11)]
train1 = window(train,start=chron('01/01/2019'))
train2 = window(train,start = chron('01/01/2020'))
train3 = window(train,start = chron('01/01/2021'))

f = glm(pmi ~ pca  + epmi + pred, data = train, family = binomial())
summary(f)


f = glm(pmi ~ pca  + epmi + pred, data = train1, family = binomial())
summary(f)

f = glm(pmi ~ pca  + epmi + pred, data = train3, family = binomial())
summary(f)

glm.pred1=predict(f, test[,-4], type="response")
glm.pred1
glm.pred1=predict(f, test.df, type="response")


#####Logistic Regreesion
#############################################################################################
data=ToZoo(ToTS(data))
pd=cbind(pca=data[,2],epmi=data[,3],pred=data[,4],ep=data[,5],eo=data[,6],eim=data[,7],eem=data[,8],pmi=compare[,'PMI增降'])
train=pd[-c(61:73),]
test=window(pd,start=chron('01/01/2023'))
train1 = window(train,start=chron('01/01/2019'))
train2 = window(train,start = chron('01/01/2020'))
train3 = window(train,start = chron('01/01/2021'))


f = glm(pmi ~ pca  + epmi + pred+ ep + eo + eim + eem, data = train, family = binomial())
summary(f)

f = glm(pmi ~ pca  + epmi + pred+ ep + eo + eim + eem, data = train2, family = binomial())
glm.pred1=predict(f, test[,-8], type="response")
glm.pred1

f = glm(pmi ~ pca  + epmi + pred+ ep + eo + eim + eem, data = train3, family = binomial())
summary(f)
glm.pred1=predict(f, test.df, type="response")
glm.pred1

f1 <- step(f, direction = "backward")
f2 <- step(f, direction = "both")

f = glm(pmi ~ pca  +ep, data = train3, family = binomial())
summary(f)
glm.pred1=predict(f, test[,-8], type="response")
glm.pred1




pd=cbind(pca=data[,2],epmi=data[,3],pred=data[,4],ep=data[,5],eo=data[,6],eim=data[,7],eem=data[,8],pmi=compare[,'PMI增降'])
train=pd[-c(61:71),]
test=window(pd,start=chron('01/01/2023'))
test=test[-c(10,11)]
train1 = window(train,start=chron('01/01/2019'))
train2 = window(train,start = chron('01/01/2020'))
train3 = window(train,start = chron('01/01/2021'))


f = glm(pmi ~ pca  + pred+ ep + eo + eim + eem, data = train, family = binomial())
summary(f)

f = glm(pmi ~ pca   + pred+ ep + eo + eim + eem, data = train1, family = binomial())
glm.pred1=predict(f, test[,-8], type="response")
glm.pred1

f = glm(pmi ~ pca  + ep + eo + eim + eem, data = train3, family = binomial())
summary(f)
glm.pred1=predict(f, test.df, type="response")
glm.pred1

#########################################################################
data=ToZoo(ToTS(data))
pd=cbind(pca=data[,1],epmi=data[,2],pred=data[,3],ep=data[,4],eo=data[,6],eim=data[,6],eem=data[,7],pmi=compare[,'PMI增降'])
train=pd[-c(61:71),]
test=window(pd,start=chron('01/01/2023'))
test=test[-c(10,11)]
train1 = window(train,start=chron('01/01/2019'))
train2 = window(train,start = chron('01/01/2020'))
train3 = window(train,start = chron('01/01/2021'))


f = glm(pmi ~ pca  + pred+ ep + eo + eim + eem, data = train, family = binomial())
summary(f)

f = glm(pmi ~ pca   + pred+ ep + eo + eim + eem, data = train1, family = binomial())
glm.pred1=predict(f, test[,-8], type="response")
glm.pred1

f = glm(pmi ~ pca  + ep + eo + eim + eem, data = train3, family = binomial())
summary(f)
glm.pred1=predict(f, test.df, type="response")
glm.pred1


