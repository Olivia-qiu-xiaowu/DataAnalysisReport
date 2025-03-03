#### 

rm(list = ls())

library(zoo)
library(chron)
library(x12)


setwd("C:/RDatadoc/影响因素")
source('C:/RDatadoc/影响因素/EconAnalysisLib.R')
color = c("blue","red")

Diff=function(numlist){
  numlist = (ToTS(numlist))
  list.diff = 0*numlist
  list.diff[1] = NA
  for(i in 2:length(numlist)){
    if(is.na(numlist[i]-numlist[i-1])){
      list.diff[i] = NA
    }
    else if((numlist[i]-numlist[i-1]) > 0){
      list.diff[i] = 1}
    else if((numlist[i]-numlist[i-1]) < 0){
      list.diff[i]=-1
    }
  }
  return(list.diff)
}

DiffInc=function(numlist){
  numlist = na.omit(ToTS(numlist))
  list.diff = 0*numlist
  list.diff[1] = NA
  for(i in 2:length(numlist)){
    if((numlist[i]-numlist[i-1]) > 0){
      list.diff[i] = TRUE}
    else if((numlist[i]-numlist[i-1]) < 0){
      list.diff[i]=FALSE
    }
  }
  return(list.diff)
}

DiffD=function(numlist){
  numlist = na.omit(ToTS(numlist))
  list.diff = 0*numlist
  list.diff[1] = NA
  for(i in 2:length(numlist)){
    if((numlist[i]-numlist[i-1]) > 0){
      list.diff[i] = FALSE}
    else if((numlist[i]-numlist[i-1]) < 0){
      list.diff[i]=TRUE
    }
  }
  return(list.diff)
}

data=read.csv('C:/RDatadoc/影响因素/EPMI与PMI2.csv',fileEncoding = 'gbk')
data=zoo(data[,-1],chron(data[,1],format=c('y/m/d')))

pmi = data[,'PMI']

industry=read.csv("C:/RDatadoc/影响因素/高频数据-工业.csv")
industry=window(zoo(industry[,-1],order.by=chron(as.character(industry[,1]),format=c(dates='y/m/d'))))
industryPCA = industry[,'工业主成分']
industryPCA = monthly(industryPCA,tailFunc)
industryPCA = zoo(industryPCA,chron(index(industryPCA),format = c(dates='y/m/d')))

pd = window(cbind(ToZoo(ToTS(pmi)),industryPCA),start = chron("01/01/2018"))
legend = c("PMI","工业主成分")
PlotY2(pd,position="topright",legend,col=color)

pmi.diff = Diff(pmi)
pca=Diff(industryPCA)

pmi.diffInc = DiffInc(pmi)
pcaInc=DiffInc(industryPCA)

pmi.diffD = DiffD(pmi)
pcaD=DiffD(industryPCA)

comp1 = pca==pmi.diff


epmi = data[,1]
epmi.diff = Diff(epmi)
epmi.diffInc = DiffInc(epmi)
epmi.diffD=DiffD(epmi)

pd = window(cbind(pmi,epmi),start = chron("01/01/2018"))
legend = c("PMI","EPMI")
PlotY2(pd,position="topright",legend,col=color)

comp2 = epmi.diff==pmi.diff


load('C:/RDatadoc/china/china/CPI_PREDResult1125.RData')
pred.pmi.diff=Diff(ToZoo(pred.PMI[,'M']))
pred.pmi.diffInc=DiffInc(ToZoo(pred.PMI[,'M']))
pred.pmi.diffD=DiffD(ToZoo(pred.PMI[,'M']))

pd = window(cbind(ToZoo(ToTS(pmi)),ToZoo(pred.PMI)),start = chron("01/01/2018"))
legend = c("PMI","PRED.PMI")
PlotY2(pd,position="topright",legend,col=color)

comp3 = pred.pmi.diff==pmi.diff

graphic=window(cbind(高频工业=ToZoo(pca),EPMI=ToZoo(epmi.diff),计量PMI=ToZoo(pred.pmi.diff),PMI=ToZoo(pmi.diff)),start = chron('01/01/2018'))
dataf=data.frame(日期=index(graphic),graphic)

write.csv(dataf,file = "compare.csv",row.names = FALSE)

pd = window(cbind(PMI增降=ToZoo(pmi.diffInc),PCA上涨=ToZoo(pcaInc),EPMI上涨=ToZoo(epmi.diffInc),计量PMI上涨=ToZoo(pred.pmi.diffInc)),start = chron("01/01/2018"))
dataf=data.frame(日期=index(pd),pd)
write.csv(dataf,file = "compare1.csv",row.names = FALSE)

pd = window(cbind(PMI增降=ToZoo(pmi.diff),PCA下跌=ToZoo(pcaD),EPMI下跌=ToZoo(epmi.diffD),计量PMI下跌=ToZoo(pred.pmi.diffD)),start = chron("01/01/2018"))
dataf=data.frame(日期=index(pd),pd)
write.csv(dataf,file = "compareD.csv",row.names = FALSE)


write.csv(window(日期=index(ToZoo(comp1)), comp1,start=c(2018,1)),file = "detail.csv",row.names = FALSE)
write.csv(window(日期=index(comp3), comp2,start=c(2018,1)),file = "detail2.csv",row.names = FALSE)
write.csv(window(日期=index(comp3), comp3,start=c(2018,1)),file = "detail3.csv",row.names = FALSE)


data=read.csv('C:/RDatadoc/影响因素/EPMI与PMI2.csv',fileEncoding = 'gbk')
data=zoo(data[,-1],chron(data[,1],format=c('y/m/d')))
colnames(data)=c('epmi','ep','eo','eim','epp','eoi','eem','era',
                 'pmi','pp','po','pneo','pooh','ppi','ppv','pim','ppp','prmp','prmi','pem','pdt','poo')


ep.diff=Diff(data[,'ep'])
pp.diff=Diff(data[,'pp'])

eo.diff=Diff(data[,'eo'])
po.diff=Diff(data[,'po'])

eim.diff=Diff(data[,'eim'])
pim.diff=Diff(data[,'pim'])

epp.diff=Diff(data[,'epp'])
ppp.diff=Diff(data[,'ppp'])

eem.diff=Diff(data[,'eem'])
pem.diff=Diff(data[,'pem'])

pd=window(cbind(PCA=ToZoo(pca),EPMI=ToZoo(epmi.diff),计量PMI=ToZoo(pred.pmi.diff),EPMI生产量=ToZoo(ep.diff),
                EPMI产品订单=ToZoo(eo.diff),EPMI进口=ToZoo(eim.diff),EPMI就业=ToZoo(eem.diff),PMI=ToZoo(pmi.diff)),start = chron('01/01/2018'))
write.csv(pd,file = 'Factor.csv',row.names = FALSE)
data=read.csv('c:/RDatadoc/影响因素/Factor.csv',fileEncoding = 'gbk')




