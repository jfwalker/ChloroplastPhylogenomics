rm(list=ls())
setwd("~/Analyses/chloro_4_joe/R-analyses/")
require(ggplot2)
require(stargazer)

pep_ns <- read.csv("pep_nosupport_v2.csv")
pep_s <- read.csv("pep_support_v2.csv")

codon_ns <- read.csv("codon_nosupport_v2.csv")
codon_s <- read.csv("codon_support_v2.csv")

nuc_ns <- read.csv("nuc_nosupport_v2.csv")
nuc_s <- read.csv("nuc_support_v2.csv")

raw_data <- list(pep_ns,pep_s,codon_ns,codon_s,nuc_ns,nuc_s)
names(raw_data) <- c("pep_ns","pep_s","codon_ns","codon_s","nuc_ns","nuc_s")

raw_data <- lapply(raw_data, function(x) {
  x <- cbind(x,x$TC/(x$TC+x$TD))
  colnames(x)[17]<-"Proportion_Concordant_Nodes"
  return(x)
}) ## calculates proportion of concordant nodes as variable

pep_ns <- raw_data[[1]]
pep_s <- raw_data[[2]]

codon_ns <- raw_data[[3]]
codon_s <- raw_data[[4]]

nuc_ns <- raw_data[[5]]
nuc_s <- raw_data[[6]]

full_models <- lapply(raw_data,function(x) {glm(cbind(TC,TD) ~ Length + Tree_Length + variance, data = x, family = binomial())})
full_summaries <- lapply(full_models,summary)
full_summaries

full_qmodels <- lapply(raw_data,function(x) {glm(cbind(TC,TD) ~ Length + Tree_Length + variance, data = x, family = quasibinomial())})
full_qsummaries <- lapply(full_qmodels,summary)
full_qsummaries

full_models_influence <- lapply(full_models,influence)
full_models_influence

cooks <- lapply(full_models,cooks.distance)
cooks

pep_ns_mod <- pep_ns[-c(54,57,76,77),]
pep_s_mod <- pep_s[-c(54,57,76,77),]

codon_ns_mod <- codon_ns[-c(16,45,52,56,76,77),]
codon_s_mod <- codon_s[-c(16,45,52,56,76,77),]

nuc_ns_mod <- nuc_ns[-c(10,67,76,77),]
nuc_s_mod <- nuc_ns[-c(10,67,76,77),]

mod_data <- list(pep_ns_mod,pep_s_mod,codon_ns_mod,codon_s_mod,nuc_ns_mod,nuc_s_mod)
names(mod_data) <- c("pep_ns","pep_s","codon_ns","codon_s","nuc_ns","nuc_s")

mod_models <- lapply(mod_data,function(x) {glm(cbind(TC,TD) ~ Length + Tree_Length + variance, data = x, family = binomial())})
mod_summaries <- lapply(mod_models,summary)
mod_summaries

mod_qmodels <- lapply(mod_data,function(x) {glm(cbind(TC,TD) ~ Length + Tree_Length + variance, data = x, family = quasibinomial())})
mod_qsummaries <- lapply(mod_qmodels,summary)
mod_qsummaries

stargazer(full_models, type = "html",title = "Full Data",dep.var.caption = "Dependent variable: Total Concordant/Total Discordant",dep.var.labels.include = F,
          model.names = T,notes.align = "l")

stargazer(full_qmodels, type = "html",title = "Full Data",dep.var.caption = "Dependent variable: Total Concordant/Total Discordant",dep.var.labels.include = F,
          model.names = T,notes.align = "l",add.lines = list(c("Dispersion",round(full_qsummaries[[1]]$dispersion,3),round(full_qsummaries[[2]]$dispersion,3),round(full_qsummaries[[3]]$dispersion,3),
                                                          round(full_qsummaries[[4]]$dispersion,3),round(full_qsummaries[[5]]$dispersion,3),round(full_qsummaries[[6]]$dispersion,3))))

stargazer(mod_models, type = "html",title = "Reduced Data",dep.var.caption = "Dependent variable: Total Concordant/Total Discordant",dep.var.labels.include = F,
          model.names = T,notes.align = "l")

stargazer(mod_qmodels, type = "html",title = "Reduced Data",dep.var.caption = "Dependent variable: Total Concordant/Total Discordant",dep.var.labels.include = F,
          model.names = T,notes.align = "l",add.lines = list(c("Dispersion",round(mod_qsummaries[[1]]$dispersion,3),round(mod_qsummaries[[2]]$dispersion,3),round(mod_qsummaries[[3]]$dispersion,3),
                                                               round(mod_qsummaries[[4]]$dispersion,3),round(mod_qsummaries[[5]]$dispersion,3),round(mod_qsummaries[[6]]$dispersion,3))))