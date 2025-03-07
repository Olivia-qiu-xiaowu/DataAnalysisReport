#####

rm(list = ls())

library(zoo)
library(x12)
library(chron)

setwd('C:/RDatadoc/降息预测')
source('C:/RDatadoc/Global/Global/EconAnalysisLib.R')

Plotbar=function(data1,data2,main){
  plot(data1,main=main,col='blue',xaxt = "n",type='l',ylim=c(0,4),lwd=2)
  MakeAxis.zoo(data1)
  MakeGrid.zoo(data2)
  par(new=TRUE)
  barplot(data2,col='orange',xaxt = "n", yaxt = "n",ylab = "", xlab = "",border ='orange',ylim=c(0,2.5))
  axis(4)
}

Plotbarresult=function(data1,data2,main){
  Win()
  barplot(data2,col='orange',xaxt = "n",ylab = "", xlab = "",border ='white',ylim=c(0,1.5))
  par(new=TRUE)
  plot(data1,main=main,col='blue',xaxt = "n",yaxt = "n",ylab = "", xlab = "",type='l',ylim=c(1,4),lwd=2)
  MakeAxis.zoo(data1)
  MakeGrid.zoo(data2)
  axis(4)
}


irc=read.csv("C:/RDatadoc/降息预测/降息预测：拇指法则5.csv",sep=',',as.is=TRUE)
irc.ts=ts(irc[,-1],start =c(1982,9),frequency = 12)
cnames=colnames(irc.ts)
irc=ToZoo(irc.ts)
colnames(irc)=cnames
irc=window(irc,start = chron('1/31/2005'))

#####PMI
#连续2个月低于过去5年同期平均数

irc.pmi=irc[,2]
irc.pmi.num=as.numeric(irc.pmi)
irc.pmi.average=0*irc.pmi.num
irc.pmi.compare=0*irc.pmi.num
for (i in 61:length(irc.pmi.num)) {
  irc.pmi.average[i-12]=(irc.pmi.num[i-12]+irc.pmi.num[i-24]+irc.pmi.num[i-36]+
                           irc.pmi.num[i-48]+irc.pmi.num[i-60])/5
  irc.pmi.compare[i]=irc.pmi.num[i]<irc.pmi.average[i-12] && irc.pmi.num[i-1]<irc.pmi.average[i-13]
}

irc.pmi.compare.z=zoo(irc.pmi.compare,order.by = index(irc.pmi))
irc.pmi.compare.z=na.fill0(irc.pmi.compare,0)
irc.pmi.compare.z=zoo(irc.pmi.compare,order.by = index(irc.pmi))
Plotbar(irc[,1][132:length(irc[,1])],irc.pmi.compare.z[132:length(irc[,1])],"子模型1：制造业PMI")

#####人民币贷款
#新增额低于过去3年同期平均数

irc.loan=irc[,3]
irc.loan.num=as.numeric(irc.loan)
irc.loan.average=0*irc.loan.num
irc.loan.compare=0*irc.loan.num
for (i in 37:length(irc.loan.num)) {
  irc.loan.average[i-12]=(irc.loan.num[i-12]+irc.loan.num[i-24]+irc.loan.num[i-36])/3
  irc.loan.compare[i]=irc.loan.num[i]<irc.loan.average[i-12]
}

irc.loan.compare.z=zoo(irc.loan.compare,order.by = index(irc.loan))
irc.loan.compare.z=na.fill0(irc.loan.compare,0)
irc.loan.compare.z=zoo(irc.loan.compare,order.by = index(irc.loan))
Plotbar(irc[,1][132:length(irc[,1])],irc.loan.compare.z[132:length(irc[,1])],"子模型2：人民币贷款")

######就业
#就业人员平均工作时间环比下降或者制造与非制造PMI从业人员小于过去2年均值

irc.pmiep=irc[,4]
irc.pmiep.num=as.numeric(irc.pmiep)
num=0
irc.pmiep.compare=0*irc.pmiep.num
irc.collect=0*irc.pmiep.num
for (i in 25:length(irc.pmiep.num)) {
  num=(irc.pmiep.num[i-1]+irc.pmiep.num[i-2]+irc.pmiep.num[i-3]+
         irc.pmiep.num[i-4]+irc.pmiep.num[i-5]+irc.pmiep.num[i-6]+
         irc.pmiep.num[i-7]+irc.pmiep.num[i-8]+irc.pmiep.num[i-9]+
         irc.pmiep.num[i-10]+irc.pmiep.num[i-11]+irc.pmiep.num[i-12]+
         irc.pmiep.num[i-13]+irc.pmiep.num[i-14]+irc.pmiep.num[i-15]+
         irc.pmiep.num[i-16]+irc.pmiep.num[i-17]+irc.pmiep.num[i-18]+
         irc.pmiep.num[i-19]+irc.pmiep.num[i-20]+irc.pmiep.num[i-21]+
         irc.pmiep.num[i-22]+irc.pmiep.num[i-23]+irc.pmiep.num[i-24])/24
  irc.pmiep.compare[i]=irc.pmiep.num[i]<num
}

irc.npmiep=irc[,5]
irc.npmiep.num=as.numeric(irc.npmiep)
irc.npmiep.average=0*irc.npmiep.num
irc.npmiep.compare=0*irc.npmiep.num
for (i in 36:length(irc.pmiep.num)) {
  num=(irc.npmiep.num[i-1]+irc.npmiep.num[i-2]+irc.npmiep.num[i-3]+
         irc.npmiep.num[i-4]+irc.npmiep.num[i-5]+irc.npmiep.num[i-6]+
         irc.npmiep.num[i-7]+irc.npmiep.num[i-8]+irc.npmiep.num[i-9]+
         irc.npmiep.num[i-10]+irc.npmiep.num[i-11]+irc.npmiep.num[i-12]+
         irc.npmiep.num[i-13]+irc.npmiep.num[i-14]+irc.npmiep.num[i-15]+
         irc.npmiep.num[i-16]+irc.npmiep.num[i-17]+irc.npmiep.num[i-18]+
         irc.npmiep.num[i-19]+irc.npmiep.num[i-20]+irc.npmiep.num[i-21]+
         irc.npmiep.num[i-22]+irc.npmiep.num[i-23]+irc.npmiep.num[i-24])/24
  irc.npmiep.compare[i]=irc.npmiep.num[i]<num
}


irc.time=irc[,6]
irc.time.num=as.numeric(irc.time)
irc.time.decrease=0*irc.time.num
for (i in 2:length(irc.time.num)) {
  irc.time.decrease[i]=irc.time.num[i]<0
}

irc.ep=0*irc.pmiep.compare
for (i in 1:length(irc.pmiep.compare)) {
  irc.collect[i]=irc.pmiep.compare[i] && irc.npmiep.compare[i]
  irc.ep[i]=irc.collect[i] || irc.time.decrease[i]
}

irc.ep.z=zoo(irc.ep,order.by = index(irc.pmiep))
irc.ep.z=na.fill0(irc.ep,0)
irc.ep.z=zoo(irc.ep,order.by = index(irc.pmiep))
Plotbar(irc[,1][132:length(irc[,1])],irc.ep.z[132:length(irc[,1])],"子模型3：就业")

#####CPI
#同比没有出现连续3个月上行

irc.cpi=irc[,7]
irc.cpi.num=as.numeric(irc.cpi)
irc.cpi.decrease=0*irc.cpi.num
for (i in 4:length(irc.cpi.num)) {
  irc.cpi.decrease[i]=irc.cpi.num[i-3]>=irc.cpi.num[i-2] || irc.cpi.num[i-2]>=irc.cpi.num[i-1] || irc.cpi.num[i-1]>=irc.cpi.num[i]
}

irc.cpi.decrease.z=zoo(irc.cpi.decrease,order.by = index(irc.cpi))
irc.cpi.decrease.z=na.fill0(irc.cpi.decrease,0)
irc.cpi.decrease.z=zoo(irc.cpi.decrease,order.by = index(irc.cpi))
Plotbar(irc[,1][132:length(irc[,1])],irc.cpi.decrease.z[132:length(irc[,1])],"子模型4：CPI通胀")

#####PMI出场价格
#连续3个月低于50

irc.op=irc[,8]
irc.op.num=as.numeric(irc.op)
irc.op.decrease=0*irc.op.num
for (i in 3:length(irc.op.decrease)) {
  irc.op.decrease[i]=(irc.op.num[i-2]<50 && irc.op.num[i-1]<50 && irc.op.num[i]<50)
}

irc.op.decrease.z=zoo(irc.op.decrease,order.by = index(irc.op))
irc.op.decrease.z=na.fill0(irc.op.decrease,0)
irc.op.decrease.z=zoo(irc.op.decrease,order.by = index(irc.op))
Plotbar(irc[,1][132:length(irc[,1])],irc.op.decrease.z[132:length(irc[,1])],"子模型5：PMI出场价格")

####美联储
#美联储没有处于加息/缩表周期

irc.fed=irc[,9]
irc.fed.num=as.numeric(irc.fed)
irc.fed.decrease=0*irc.fed.num  
num=irc.fed.num[1]

for (i in 2:length(irc.fed.num)) {
  if(is.na(irc.fed.num[i]) ||is.na(irc.fed.num[i-1])){
    irc.fed.decrease[i]=0
  }
  else if((irc.fed.num[i-1]-irc.fed.num[i]) == 0){
    irc.fed.decrease[i]=irc.fed.num[i]-num<0
  }
  else{
    num=irc.fed.num[i-1]
    irc.fed.decrease[i]=irc.fed.num[i]-num<0
    
  }
}

irc.fed.decrease.z=zoo(irc.fed.decrease,order.by = index(irc.fed))
irc.fed.decrease.z=na.fill0(irc.fed.decrease,0)
irc.fed.decrease.z=zoo(irc.fed.decrease,order.by = index(irc.fed))
Plotbar(irc[,1][132:length(irc[,1])],irc.fed.decrease.z[132:length(irc[,1])],"子模型6：美联储策略立场")

####人民币汇率
#人民币兑美元没有连续两个月贬值0.3%以上

irc.dtr=irc[,10]
irc.dtr.num=as.numeric(irc.dtr)
irc.dtr.ir=0*irc.dtr.num
irc.dtr.decrease=0*irc.dtr.num
for (i in 2:length(irc.dtr.decrease)) {
  irc.dtr.ir[i]=(irc.dtr.num[i]/irc.dtr.num[i-1])-1
  irc.dtr.decrease[i]=irc.dtr.ir[i]<(-0.001) && irc.dtr.ir[i-1]<(-0.001)
}

irc.dtr.ser=irc[,13]
irc.dtr.ser.num=as.numeric(irc.dtr.ser)
irc.dtr.ser.ir=0*irc.dtr.ser.num
irc.dtr.ser.decrease=0*irc.dtr.ser.num
for(i in 2:length(irc.dtr.ser.num)) {
  irc.dtr.ser.ir[i]=(irc.dtr.ser.num[i]/irc.dtr.ser.num[i-1])-1
  irc.dtr.ser.decrease[i]=irc.dtr.ser.ir[i]<(-0.0005) && irc.dtr.ser.ir[i-1]<(-0.0005)
}

#irc.dtr.decrease.z=zoo(irc.dtr.decrease,order.by = index(irc.dtr))
#irc.dtr.decrease.z=na.fill0(irc.dtr.decrease,0)
#irc.dtr.decrease.z=zoo(irc.dtr.decrease,order.by = index(irc.dtr))
#Plotbar(irc[,1][132:length(irc[,1])],irc.dtr.decrease.z[132:length(irc[,1])],"子模型7：人民币汇率")
irc.both.decrease=0*irc.dtr.num
for (i in 1:length(irc.dtr.ser.decrease)) {
  irc.both.decrease[i]= irc.dtr.ser.decrease[i] && irc.dtr.decrease[i]
}

irc.both.decrease.z=zoo(irc.both.decrease,order.by = index(irc.dtr))
irc.both.decrease.z=na.fill0(irc.both.decrease,0)
irc.both.decrease.z=zoo(irc.both.decrease,order.by = index(irc.dtr))
Plotbar(irc[,1][132:length(irc[,1])],irc.both.decrease.z[132:length(irc[,1])],"子模型7：人民币汇率")

#####存单到期收益率
#1年AAA存单收益率偏离度（低于MLF）大于20BP

irc.a=irc[,11]
irc.aaa=as.numeric(irc[,11])
irc.mlf=as.numeric(irc[,12])
irc.aaa.decrease=0*irc.mlf
for (i in 1:length(irc.mlf)) {
  if(is.na(irc.aaa[i])){
    irc.aaa.decrease[i]=FALSE
  }
  irc.aaa.decrease[i]=irc.mlf[i]-irc.aaa[i]>0.2
}

irc.aaa.decrease.z=zoo(irc.aaa.decrease,order.by = index(irc.a))
irc.aaa.decrease.z=na.fill0(irc.aaa.decrease,0)
irc.aaa.decrease.z=zoo(irc.aaa.decrease,order.by = index(irc.a))
Plotbar(irc[,1][132:length(irc[,1])],irc.aaa.decrease.z[132:length(irc[,1])],"子模型8：存单收益率偏差度")

#####excel Test
data=data.frame(index(irc[,1]),cbind(irc[,12],irc[,1],irc.pmi.compare,irc.loan.compare.z,irc.ep,irc.cpi.decrease,irc.op.decrease,irc.fed.decrease,irc.both.decrease,irc.aaa.decrease))
data=na.fill0(data,0)
names(data) <- c("日期","中期借贷便利(MLF):利率",'7天逆回购利率','PMI','新增贷款','工作时长','CPI通胀','PMI出厂价格','美联储立场','人民币汇率','存单利率')
write.table(data,file='Change12.csv',row.names=FALSE,sep=",",na=" ")




#更改了数据类型画图不能用了，只能转移到excel手动画图

#####################################################################################
Win()
color=c('#6699cc','#1c86ee','#8ee5ee','#2E8B57','#43CD80','#ff6600','#ff9900','#ffcc00','black')
pd=cbind(irc.pmi.compare.z,irc.loan.compare.z,irc.ep.z,irc.cpi.decrease.z,irc.op.decrease.z,irc.fed.decrease.z,irc.dtr.decrease.z,irc.aaa.decrease.z)
barplot(pd[1:61,],col=color,main="2005-2010预警",border="white",xaxt = "n",ylab = "", xlab = "个数")
par(new=TRUE)
plot(irc[,1][1:61],col='black',xaxt = "n",yaxt = "n",ylab = "", xlab = "时间",type='l',ylim=c(0,4),lwd=2)
MakeGrid.zoo(irc[,1])
MakeAxis.zoo(irc[,1])
axis(4)
legend("topleft", legend=c("制造业PMI","新增贷款","工作时长","CPI通胀","PMI出厂价格","美联储立场","人名币汇率","存单利率","七天逆回购利率"),fill=color,bty="n",cex=0.8)

Win()
#pd=cbind(irc.pmi.compare.z,irc.loan.compare.z,irc.ep.z,irc.cpi.decrease.z,irc.op.decrease.z,irc.fed.decrease.z,irc.dtr.decrease.z,irc.aaa.decrease.z)
barplot(pd[61:144],col=color,main="2010-2017预警",border="white",xaxt = "n",ylab = "", xlab = "个数",ylim=c(0,7))
par(new=TRUE)
plot(irc[,1][61:144],col='black',xaxt = "n",yaxt = "n",ylab = "", xlab = "时间",type='l',ylim=c(0,4),lwd=2)
MakeGrid.zoo(irc[,1])
MakeAxis.zoo(irc[,1])
axis(4)
legend("topleft", legend=c("制造业PMI","新增贷款","工作时长","CPI通胀","PMI出厂价格","美联储立场","人名币汇率","存单利率","七天逆回购利率"),fill=color,bty="n",cex=0.8)

Win()
#pd=cbind(irc.pmi.compare,irc.loan.compare,irc.ep,irc.cpi.decrease,irc.op.decrease,irc.fed.decrease,irc.dtr.decrease,irc.aaa.decrease)
barplot(pd[145:length(irc[,1])],col=color,main="2017-2023预警",border="white",xaxt = "n",ylab = "个数", xlab = "",ylim=c(0,7))
par(new=TRUE)
plot(irc[,1][145:length(irc[,1])],col='black',xaxt = "n",yaxt = "n",ylab = "", xlab = "时间",type='l',ylim=c(0,4),lwd=2)
MakeGrid.zoo(irc[,1])
MakeAxis.zoo(irc[,1])
axis(4)
legend("topleft", legend=c("制造业PMI","新增贷款","工作时长","CPI通胀","PMI出厂价格","美联储立场","人名币汇率","存单利率","七天逆回购利率"),fill=color,bty="n",cex=0.8)

result=0*irc.pmi.num
result=(irc.pmi.compare+irc.loan.compare+irc.ep+irc.cpi.decrease+irc.op.decrease+irc.fed.decrease+irc.dtr.decrease+irc.aaa.decrease)>5
Plotbarresult(irc[,1][1:61],result[1:61],"2005-2010预警与降息")
Plotbarresult(irc[,1][62:144],result[62:144],"2010-2017预警与降息")
Plotbarresult(irc[,1][145:length(irc[,1])],result[145:length(irc[,1])],"2017-2023预警与降息")
