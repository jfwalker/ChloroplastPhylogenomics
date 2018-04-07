setwd("~/Analyses/chloro_4_joe/R-analyses/")
rm(list=ls())
library(ggplot2)

pep_ns<-read.csv("pep_nosupport_genome.csv.sorted")
pep_s<-read.csv("pep_support_genome.csv.sorted")

codon_ns<-read.csv("codon_nosupport_genome.csv.sorted")
codon_s<-read.csv("codon_support_genome.csv.sorted")

nuc_ns<-read.csv("nuc_nosupport_genome.csv.sorted")
nuc_s<-read.csv("nuc_support_genome.csv.sorted")

data_pep_codon<-list(pep_ns,pep_s,codon_ns,codon_s)
names(data_pep_codon)<-c("pep_ns","pep_s","codon_ns","codon_s")
data_nuc<-list(nuc_ns,nuc_s)
names(data_nuc)<-c("nuc_ns","nuc_s")

data_pep_codon<-lapply(data_pep_codon,function(x) {
  x$Length[45]<-41.75
  x$Length[68]<-125.25
  x$Length[65]<-1632
  x$Length[69]<-326.6
  x$Length[81]<-1306.4
  return(x)
})

data_nuc<-lapply(data_nuc,function(x) {
  x$Length[45]<-116.2
  x$Length[68]<-464.8
  x$Length[65]<-4661
  x$Length[69]<-932.4
  x$Length[81]<-3729.6
  return(x)
})

p_pep_codon_list<-lapply(data_pep_codon,function(x) {
  ggplot(x,aes(factor(Gene),fill=(Concordant_Edges/50))) +
    geom_bar() +
    geom_bar(aes(fill=(Ts5/12))) +
    geom_bar(aes(fill=(Ts4/9))) +
    geom_bar(aes(fill=(Ts3/10))) +
    geom_bar(aes(fill=(Ts2/7))) +
    geom_bar(aes(fill=(Ts1/12))) +
    scale_fill_continuous(low="green",high="blue",name="",breaks=c(0,25,50,75,100),labels=c("0%","25%","50%","75%","100%")) +
    scale_x_discrete(limits=x$Gene)
})

p_nuc_list<-lapply(data_nuc,function(x) {
  ggplot(x,aes(factor(Gene),fill=(Concordant_Edges/50))) +
    geom_bar() +
    geom_bar(aes(fill=(Ts5/12))) +
    geom_bar(aes(fill=(Ts4/9))) +
    geom_bar(aes(fill=(Ts3/10))) +
    geom_bar(aes(fill=(Ts2/7))) +
    geom_bar(aes(fill=(Ts1/12))) +
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

odds<-seq(1,163,2)
odds[82]<-162

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

pep_codon_length_standard[162]<-400

nuc_length_standard<-data_nuc[[1]]$Length
for (i in odds) {
  nuc_length_standard<-append(nuc_length_standard,120,i)
}

nuc_length_standard[162]<-1200

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
