#PCA & FA

rm(list = ls())

library(zoo)
library(chron)
library(stats)
library(stringr)
library(psych)
library(nFactors)

setwd('C:/RDatadoc/主成分分析和因子分析')
source('C:/RDatadoc/CIDI/CIDI/CIDI.R')

CompareX=read.csv("C:/RDatadoc/主成分分析和因子分析/万德全A十年国债螺纹钢.csv",sep=',',as.is=TRUE)
CompareX=window(zoo(CompareX[,-1],order.by=chron(as.character(CompareX[,1]),format=c(dates='y/m/d'))),start=chron('5/15/10'))
cnames=colnames(CompareX)
CompareX=zoo(matrix(as.numeric(str_remove(CompareX, ",")),ncol=ncol(CompareX)),order.by=index(CompareX))
colnames(CompareX)=cnames
#CompareX=scale(CompareX)
fa.parallel(CompareX,fa="pc",n.iter=100)
CPCA=principal(CompareX,nfactors = 1,scores = TRUE,rotate='varimax')
print(CPCA)
PCAc=princomp(na.omit(CompareX),cor = TRUE)
summary(PCAc)
PCACScore=zoo(PCAc$scores,order.by=index(CompareX))
#fa.diagram(CPCA)
plot(CPCA)

plot(PCACScore[,1],col='red',ylab = "主成分1得分", xlab = "时间",type='l')
par(new=TRUE)
plot(PCACScore[,2],col='blue',xaxt = "n", yaxt = "n",ylab = "", xlab = "",type='l')
axis(side = 4)
mtext("主成分2得分", side = 4, line = 3)
legend("topright", c("主成分1得分", "主成分2得分"),col = c("red", "blue"), lty =1)

KMO(CompareX)

#fa.res1 <- fa(CompareX, nfactors = 1, rotate = "varimax", fm="ml")
#print(fa.res1)
#fa.diagram(fa.res1)
#fa.pa <- fa(CompareX, nfactors = 1, rotate = "varimax", fm="pa")
#print(fa.pa)
#fa.diagram(fa.pa)

fa.parallel(CompareX,fa="fa",n.iter=100)
#ev = eigen(cor(na.omit(CompareX))) # 获取特征值
#ap=parallel(subject=nrow(CompareX),var=ncol(CompareX),rep=100,cent=0.05)# subject指样本个数，var是指变量个数
#nS=nScree(x=ev$values,aparallel=ap$eigen$qevpea)# 确定探索性因子分析中应保留的因子
#plotnScree(nS)

ShangX=read.csv("C:/RDatadoc/主成分分析和因子分析/上证周stl.csv",sep=',',as.is=TRUE)
ShangX=window(zoo(ShangX[,-1],order.by=chron(as.character(ShangX[,1]),format=c(dates='y/m/d'))),start=chron('5/15/10'))
cnames=colnames(ShangX)
ShangX.x12=zoo(matrix(as.numeric(str_remove(ShangX, ",")),ncol=ncol(ShangX)),order.by=index(ShangX))
colnames(ShangX.x12)=cnames

ShenX=read.csv("C:/RDatadoc/主成分分析和因子分析/深证周stl.csv",sep=',',as.is=TRUE)
ShenX=window(zoo(ShenX[,-1],order.by=chron(as.character(ShenX[,1]),format=c(dates='y/m/d'))),start=chron('5/15/10'))
cnames=colnames(ShenX)
ShenX.x12=zoo(matrix(as.numeric(str_remove(ShenX, ",")),ncol=ncol(ShenX)),order.by=index(ShenX))
colnames(ShenX.x12)=cnames

ChuangX=read.csv("C:/RDatadoc/主成分分析和因子分析/创业周stl.csv",sep=',',as.is=TRUE)
ChuangX=window(zoo(ChuangX[,-1],order.by=chron(as.character(ChuangX[,1]),format=c(dates='y/m/d'))),start=chron('5/15/10'))
cnames=colnames(ChuangX)
ChuangX.x12=zoo(matrix(as.numeric(str_remove(ChuangX, ",")),ncol=ncol(ChuangX)),order.by=index(ChuangX))
colnames(ChuangX.x12)=cnames

GongX=read.csv("C:/RDatadoc/主成分分析和因子分析/高频数据-工业2.csv",sep=',',as.is=TRUE)
GongX=window(zoo(GongX[,-1],order.by=chron(as.character(GongX[,1]),format=c(dates='y/m/d'))),start=chron('5/15/10'))
cnames=colnames(GongX)
GongX.x12=zoo(matrix(as.numeric(str_remove(GongX, ",")),ncol=ncol(GongX)),order.by=index(GongX))
colnames(GongX.x12)=cnames

#ShangX.x12=x12.m(ShangX)
#ShenX.x12=x12.m(ShenX)
#ChuangX.x12=x12.m(ChuangX)

total=window(cbind(ShangX.x12,ShenX.x12,ChuangX.x12),order.by = index(ShangX))
#fa.parallel(total,fa="pc",n.iter=100)
PCA=principal(total,nfactors = 2,scores = TRUE)
print(PCA)
PCAt=princomp(na.omit(total),cor = TRUE)
summary(PCAt)

ev = eigen(cor(na.omit(total)))
#ap=parallel(subject=nrow(total),var=ncol(total),rep=100,cent=0.05)
#nS=nScree(x=ev$values,aparallel=ap$eigen$qevpea)
#plotnScree(nS)

factor.result=factanal(x=na.omit(total),factors = 2,scores = "regression")
names(factor.result)
print(factor.result)
fa.factor=fa(total, nfactors = 2, rotate = "varimax", fm="ml")
fa.diagram(fa.factor)

load = factor.result$loadings[,1:2]
#plot(load,type="n")
#text(load,labels=names(total),cex = .7)

lambdas=eigen(factor.result$correlation)$value
w=lambdas[1:2]/sum(lambdas[1:2])
score=factor.result$scores
eva=score %*% w
#eva[order(eva,decreasing = TRUE),]

PCAscores=zoo(PCAt$scores,order.by = index(ChuangX))
FAscores=zoo(factor.result$scores,order.by = index(ChuangX))
plot(PCAscores[,1],col='red',ylab = "主成分得分", xlab = "时间",type='l')
par(new=TRUE)
plot(FAscores[,1],col='blue',xaxt = "n", yaxt = "n",ylab = "", xlab = "",type='l')
axis(side = 4)
mtext("因子得分", side = 4, line = 3)
legend("topleft", c("PCA", "FA"),col = c("red","blue"), lty = 1)

plot(PCAscores[,1],col='red',ylab = "主成分1得分", xlab = "时间",type='l')
par(new=TRUE)
plot(PCAscores[,2],col='blue',xaxt = "n", yaxt = "n",ylab = "", xlab = "",type='l')
axis(side = 4)
mtext("主成分2得分", side = 4, line = 3)
legend("topleft", c("主成分1得分", "主成分2得分"),col = c("red", "blue"), lty =1)

plot(PCAscores[,1],col='red',ylab = "主成分1得分", xlab = "时间",type='l')
par(new=TRUE)
plot(eva[,1],col='blue',xaxt = "n", yaxt = "n",ylab = "", xlab = "",type='l')
axis(side = 4)
mtext("因子评估", side = 4, line = 3)
legend("topleft", c("PCA", "FA评估"),col = c("red", "blue"), lty =1)

plot(FAscores[,1],col='red',ylab = "主成分1得分", xlab = "时间",type='l')
par(new=TRUE)
plot(FAscores[,2],col='blue',xaxt = "n", yaxt = "n",ylab = "", xlab = "",type='l')
legend("topleft", c("因子1得分", "因子2得分"),col = c("red", "blue"), lty =1)


plot(GongX.x12[,2],col='red',ylab = "", xlab = "时间",type='l')
par(new=TRUE)
plot(GongX.x12[,4],col='blue',xaxt = "n", yaxt = "n",ylab = "", xlab = "",type='l')
par(new=TRUE)
plot(PCAscores[168:612,1],col='orange',xaxt = "n", yaxt = "n",ylab = "", xlab = "",type='l')
par(new=TRUE)
plot(PCAscores[168:612,2],col='black',xaxt = "n", yaxt = "n",ylab = "", xlab = "",type='l')
legend("topleft", c("工业主成分", "螺纹钢","PCA1","PCA2"),col = c("red", "blue","orange"), lty =1)

plot(GongX.x12[,1],col='red',ylab = "", xlab = "时间",type='l')
par(new=TRUE)
plot(GongX.x12[,3],col='blue',xaxt = "n", yaxt = "n",ylab = "", xlab = "",type='l')
par(new=TRUE)
plot(PCAscores[168:612,1],col='orange',xaxt = "n", yaxt = "n",ylab = "", xlab = "",type='l')
par(new=TRUE)
plot(PCAscores[168:612,2],col='black',xaxt = "n", yaxt = "n",ylab = "", xlab = "",type='l')
legend("topleft", c("精对苯二甲酸", "全钢胎","PCA1","PCA2"),col = c("red", "blue","orange"), lty =1)

PMI=read.csv("C:/RDatadoc/主成分分析和因子分析/EPMI与PMI.csv",sep=',',as.is=TRUE)
PMI=na.omit(PMI)
PMI=zoo(PMI[,-1],order.by=chron(PMI[,1],format=c(dates='y/m/d')))

PMI.x12=x12.m(PMI)

plot(PCAscores[,1],col='red',ylab = "", xlab = "时间",type='l')
par(new=TRUE)
plot(FAscores[,1],col='blue',xaxt = "n", yaxt = "n",ylab = "", xlab = "",type='l')
par(new=TRUE)
plot(PMI[,1],col='orange',xaxt = "n", yaxt = "n",ylab = "", xlab = "",type='l')
legend("topleft", c("PCA", "FA","PMI"),col = c("red", "blue","orange"), lty =1)

SAtotal=cbind(ShangX.x12[,4],ShenX.x12[,4],ChuangX.x12[,4])
SA_PCA=princomp(na.omit(SAtotal),cor = TRUE)
plot(SA_PCA$scores[,1],col='red',ylab = "", xlab = "时间",type='l')
par(new=TRUE)
plot(PMI[,1],col='orange',xaxt = "n", yaxt = "n",ylab = "", xlab = "",type='l')

#pmipca=window(cbind(PCAscores,PMI),order.by = index(PCAscores))

#Test1=zoo(cbind(Gong.x12[,2],ShangX.x12[,1],ShenX.x12[,1],ChuangX.x12[,1]),order.by = index(ShangX.x12))
#ev1 = eigen(cor(na.omit(Test1)))

