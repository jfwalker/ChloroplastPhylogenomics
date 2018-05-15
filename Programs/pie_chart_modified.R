setwd("~/Analyses/chloro_4_joe/R-analyses/")
library("ggplot2")

rm(list=ls())

pep_nosupport<-read.csv("pep_nosupport_v2.csv")
pep_support<-read.csv("pep_support_v2.csv")

nuc_nosupport<-read.csv("nuc_nosupport_v2.csv")
nuc_support<-read.csv("nuc_support_v2.csv")

codon_nosupport<-read.csv("codon_nosupport_v2.csv")
codon_support<-read.csv("codon_support_v2.csv")

data_pep_codon<-list(pep_nosupport,pep_support,codon_nosupport,codon_support)
names(data_pep_codon)<-c("pep_nosupport","pep_support","codon_nosupport","codon_support")
data_nuc<-list(nuc_nosupport,nuc_support)
names(data_nuc)<-c("nuc_nosupport","nuc_support")

data_pep_codon<-lapply(data_pep_codon,function(x) {
  x[order(x$Length),]
})

data_pep_codon<-lapply(data_pep_codon,function(x) {
  rownames(x)<-seq(length=79)
  return(x)
})

data_pep_codon<-lapply(data_pep_codon,function(x) {
  x$Length[78]<-1632
  x$Length[79]<-1633
  return(x)
})

data_nuc<-lapply(data_nuc,function(x) {
  x[order(x$Length),]
})

data_nuc<-lapply(data_nuc,function(x) {
  rownames(x)<-seq(length=79)
  return(x)
})

data_nuc<-lapply(data_nuc,function(x) {
  x$Length[78]<-4661
  x$Length[79]<-4662
  return(x)
})

p_pep_codon_list<-lapply(data_pep_codon,function(x) {
  ggplot(x,aes(factor(Gene),fill=(TC/(TC+TD)))) +
    geom_bar() +
    geom_bar(aes(fill=(Ts5C/(Ts5C+Ts5D)))) +
    geom_bar(aes(fill=(Ts4C/(Ts4C+Ts4D)))) +
    geom_bar(aes(fill=(Ts3C/(Ts3C+Ts3D)))) +
    geom_bar(aes(fill=(Ts2C/(Ts2C+Ts2D)))) +
    geom_bar(aes(fill=(Ts1C/(Ts1C+Ts1D)))) +
    scale_fill_continuous(low="green",high="blue",name="",breaks=c(0,25,50,75,100),labels=c("0%","25%","50%","75%","100%")) +
    scale_x_discrete(limits=x$Gene)
})

p_nuc_list<-lapply(data_nuc,function(x) {
  ggplot(x,aes(factor(Gene),fill=(TC/(TC+TD)))) +
    geom_bar() +
    geom_bar(aes(fill=(Ts5C/(Ts5C+Ts5D)))) +
    geom_bar(aes(fill=(Ts4C/(Ts4C+Ts4D)))) +
    geom_bar(aes(fill=(Ts3C/(Ts3C+Ts3D)))) +
    geom_bar(aes(fill=(Ts2C/(Ts2C+Ts2D)))) +
    geom_bar(aes(fill=(Ts1C/(Ts1C+Ts1D)))) +
    scale_fill_continuous(low="green",high="blue",name="",breaks=c(0,25,50,75,100),labels=c("0%","25%","50%","75%","100%")) +
    scale_x_discrete(limits=x$Gene)
})

g_pep_codon_list<-lapply(p_pep_codon_list,function(x) {
  ggplot_build(x)
})

g_nuc_list<-lapply(p_nuc_list,function(x) {
  ggplot_build(x)
})

fillcollist_pep_nosupport<-vector("list",6)
for (i in c(1:6)) {
  fillcollist_pep_nosupport[[i]]<-g_pep_codon_list[[1]]$data[[i]]$fill
}

fillcollist_pep_support<-vector("list",6)
for (i in c(1:6)) {
  fillcollist_pep_support[[i]]<-g_pep_codon_list[[2]]$data[[i]]$fill
}


fillcollist_codon_nosupport<-vector("list",6)
for (i in c(1:6)) {
  fillcollist_codon_nosupport[[i]]<-g_pep_codon_list[[3]]$data[[i]]$fill
}

fillcollist_codon_support<-vector("list",6)
for (i in c(1:6)) {
  fillcollist_codon_support[[i]]<-g_pep_codon_list[[4]]$data[[i]]$fill
}

fillcollist_nuc_nosupport<-vector("list",6)
for (i in c(1:6)) {
  fillcollist_nuc_nosupport[[i]]<-g_nuc_list[[1]]$data[[i]]$fill
}

fillcollist_nuc_support<-vector("list",6)
for (i in c(1:6)) {
  fillcollist_nuc_support[[i]]<-g_nuc_list[[2]]$data[[i]]$fill
}

fillcollist_list_pep_codon<-list(fillcollist_pep_nosupport,fillcollist_pep_support,fillcollist_codon_nosupport,fillcollist_codon_support)

fillcollist_list_nuc<-list(fillcollist_nuc_nosupport,fillcollist_nuc_support)

odds<-seq(1,157,2)

fillcollist_list_pep_codon<-lapply(fillcollist_list_pep_codon,function(x) {
  lapply(x,function(y) {
    for (i in odds) {
      y <- append(y,"white",i)
    }
    return(y)
  })
})

fillcollist_list_nuc<-lapply(fillcollist_list_nuc,function(x) {
  lapply(x,function(y) {
    for (i in odds) {
      y <- append(y,"white",i)
    }
    return(y)
  })
})

pep_codon_length_standard<-data_pep_codon[[1]]$Length
for (i in odds) {
  pep_codon_length_standard<-append(pep_codon_length_standard,40,i)
}
pep_codon_length_standard[158]<-400

nuc_length_standard<-data_nuc[[1]]$Length
for (i in odds) {
  nuc_length_standard<-append(nuc_length_standard,120,i)
}
nuc_length_standard[158]<-1200

svg()

lapply(fillcollist_list_pep_codon,function(x) {
  lapply(x,function(y) {
    pie(pep_codon_length_standard,col=y,border=F,labels="",clockwise=T,init.angle=87)
  })
})
lapply(fillcollist_list_nuc,function(x) {
  lapply(x,function(y) {
    pie(nuc_length_standard,col=y,border=F,labels="",clockwise=T,init.angle=87)
  })
})

dev.off()

