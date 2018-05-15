rm(list=ls())
setwd("~/Analyses/chloro_4_joe/R-analyses/")
require(ggplot2)
require(gridExtra)
require(cowplot)
require(stargazer)

pep_ns <- read.csv("pep_nosupport_v2.csv")
pep_s <- read.csv("pep_support_v2.csv")

codon_ns <- read.csv("codon_nosupport_v2.csv")
codon_s <- read.csv("codon_support_v2.csv")

nuc_ns <- read.csv("nuc_nosupport_v2.csv")
nuc_s <- read.csv("nuc_support_v2.csv")

pep_ns_mod <- pep_ns[-c(76,77),] ## removes ycf1 and 2
pep_s_mod <- pep_s[-c(76,77),]

codon_ns_mod <- codon_ns[-c(16,45,52,56,76,77),] ## removes ycf1, 2 and 4 outlier genes
codon_s_mod <- codon_s[-c(16,45,52,56,76,77),]

nuc_ns_mod <- nuc_ns[-c(76,77),] ## removes ycf1 and 2 
nuc_s_mod <- nuc_s[-c(76,77),]

data_sets_no_mod <- list(pep_ns,pep_s,codon_ns,codon_s,nuc_ns,nuc_s)
names(data_sets_no_mod) <- c("pep_ns","pep_s","codon_ns","codon_s","nuc_ns","nuc_s")

data_sets_no_mod <- lapply(data_sets_no_mod, function(x) {
  x <- cbind(x,x$TC/(x$TC+x$TD))
  colnames(x)[17]<-"Proportion_Concordant_Nodes"
  return(x)
}) ## calculates proportion of concordant nodes as variable

fullmodels <- lapply(data_sets_no_mod, function(x) { glm(cbind(TC,TD) ~ Length + Tree_Length + Length*Tree_Length, data = x,
                     family = binomial(link = "logit")) })
fullqmodels <- lapply(data_sets_no_mod, function(x) { glm(cbind(TC,TD) ~ Length + Tree_Length + Length*Tree_Length, data = x,
                                                          family = quasibinomial(link = "logit")) })
fullsummaries <- lapply(fullmodels,summary)
fullqsummaries <- lapply(fullqmodels,summary)

fullsummaries
fullqsummaries

fullmodels_noint <- lapply(data_sets_no_mod, function(x) { glm(cbind(TC,TD) ~ Length + Tree_Length, data = x,
                                                               family = binomial(link = "logit")) })
fullqmodels_noint <- lapply(data_sets_no_mod, function(x) { glm(cbind(TC,TD) ~ Length + Tree_Length, data = x,
                                                                family = quasibinomial(link = "logit")) })
fullsummaries_noint <- lapply(fullmodels_noint,summary)
fullqsummaries_noint <- lapply(fullqmodels_noint,summary)

fullsummaries_noint
fullqsummaries_noint

data_sets<-list(pep_ns_mod,pep_s_mod,codon_ns_mod,codon_s_mod,nuc_ns_mod,nuc_s_mod)
names(data_sets)<-c("pep_ns","pep_s","codon_ns","codon_s","nuc_ns","nuc_s")

data_sets <- lapply(data_sets, function(x) {
  x <- cbind(x,x$TC/(x$TC+x$TD))
  colnames(x)[17]<-"Proportion_Concordant_Nodes"
  return(x)
}) ## calculates proportion of concordant nodes as variable

models <- lapply(data_sets, glm, formula = cbind(TC,TD) ~ Length + Tree_Length + Length*Tree_Length,
                 family = binomial(link = "logit"))

summaries <- lapply(models, summary)
summaries 

models_noint <- lapply(data_sets, function(x) { glm(cbind(TC,TD) ~ Length + Tree_Length, data=x,
                 family = binomial(link = "logit")) })

summaries_noint <- lapply(models_noint,summary)

quasimodels <- lapply(data_sets, glm, formula = cbind(TC,TD) ~ Length + Tree_Length + Length*Tree_Length,
                 family = quasibinomial(link = "logit"))

quasisummaries <- lapply(quasimodels, summary)
quasisummaries

quasimodels_noint <- lapply(data_sets, function(x) { glm(cbind(TC,TD) ~ Length + Tree_Length, data=x,
                                                         family = quasibinomial(link = "logit")) })
quasisummaries_noint <- lapply(quasimodels_noint, summary)
quasisummaries_noint

models_length <- lapply(data_sets, glm, formula = cbind(TC,TD) ~ Length,
                      family = binomial(link = "logit"))
summaries_length <- lapply(models_length,summary)

summaries_length

quasimodels_length <- lapply(data_sets,glm,formula = cbind(TC,TD) ~ Length,
                             family = quasibinomial(link = "logit"))
quasisummaries_length <- lapply(quasimodels_length,summary)

quasisummaries_length

models_tree_length <- lapply(data_sets, glm, formula = cbind(TC,TD) ~ Tree_Length,
                             family = binomial(link = "logit"))
summaries_tree_length <- lapply(models_tree_length,summary)

summaries_tree_length

quasimodels_tree_length <- lapply(data_sets,glm,formula = cbind(TC,TD) ~ Tree_Length,
                             family = quasibinomial(link = "logit"))
quasisummaries_tree_length <- lapply(quasimodels_tree_length,summary)

quasisummaries_tree_length

## plots per dataset 

## get the new data span for predictions of values
new_data_pep_codon_length <- data.frame(Length = seq(range(pep_ns_mod$Length)[1],range(pep_ns_mod$Length)[2],len = 150))
new_data_pep_tree_length <- data.frame(Tree_Length = seq(range(pep_ns_mod$Tree_Length)[1],range(pep_ns_mod$Tree_Length)[2],len = 150))
new_data_codon_tree_length <- data.frame(Tree_Length = seq(range(codon_ns_mod$Tree_Length)[1],range(codon_ns_mod$Tree_Length)[2],len = 150))
new_data_nuc_length <- data.frame(Length = seq(range(nuc_ns_mod$Length)[1],range(nuc_ns_mod$Length)[2],len = 1500))
new_data_nuc_tree_length <- data.frame(Tree_Length = seq(range(codon_ns_mod$Tree_Length)[1],range(codon_ns_mod$Tree_Length)[2],len = 150))

## peptide scatterplot and lines
new_data_pep_ns_length <- cbind(new_data_pep_codon_length,predict(quasimodels_length[[1]],newdata = new_data_pep_codon_length,type="response"))
colnames(new_data_pep_ns_length) <- c("Length","Proportion_Concordant_Nodes")

p_pep_ns_length <- ggplot(data_sets[[1]],aes(x= Length, y = Proportion_Concordant_Nodes, colour = Proportion_Concordant_Nodes)) + 
  geom_point() + 
  theme_bw() + 
  theme(legend.position = "none") + 
  xlab("Length (aa)") + 
  ylab("Proportion of Concordant Nodes") +
  ggtitle("Amino Acid") + 
  scale_color_gradient(low="green",high="blue") +
  geom_line(data = new_data_pep_ns_length, col = "red")
  
new_data_pep_ns_tree_length <- cbind(new_data_pep_tree_length,predict(quasimodels_tree_length[[1]],newdata = new_data_pep_tree_length,type="response"))
colnames(new_data_pep_ns_tree_length) <- c("Tree_Length","Proportion_Concordant_Nodes")

p_pep_ns_tree_length <- ggplot(data_sets[[1]],aes(x = Tree_Length, y = Proportion_Concordant_Nodes, colour = Proportion_Concordant_Nodes)) + 
  geom_point() + 
  theme_bw() + 
  #scale_y_continuous(limits = ggplot_build(p_pep_ns_length)$layout$panel_ranges[[1]]$y.range) +
  xlab("Tree Length (substitutions per site)") + 
  ylab("Proportion of Concordant Nodes") +
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        legend.position = "none") +
  scale_color_gradient(low="green",high="blue") + 
  geom_line(data = new_data_pep_ns_tree_length, col = "red")

svg("pep_ns_length_tree_length.svg")
plot_grid(NULL,NULL,NULL,p_pep_ns_length,p_pep_ns_tree_length,NULL,align="h",ncol = 3,rel_widths = c(1,0.79))
dev.off()

new_data_pep_s_length <- cbind(new_data_pep_codon_length,predict(quasimodels_length[[2]],newdata = new_data_pep_codon_length,type="response"))
colnames(new_data_pep_s_length) <- c("Length","Proportion_Concordant_Nodes")

p_pep_s_length <- ggplot(data_sets[[2]],aes(x= Length, y = Proportion_Concordant_Nodes, colour = Proportion_Concordant_Nodes)) + 
  geom_point() +
  theme_bw() + 
  theme(legend.position = "none") +
  xlab("Length (aa)") + 
  ylab("Proportion of Concordant Nodes") +
  ggtitle("Amino Acid (BS > 70)") + 
  scale_color_gradient(low="green",high="blue") + 
  geom_line(data = new_data_pep_s_length, col = "red")

new_data_pep_s_tree_length <- cbind(new_data_pep_tree_length,predict(quasimodels_tree_length[[2]],newdata = new_data_pep_tree_length,type="response"))
colnames(new_data_pep_s_tree_length) <- c("Tree_Length","Proportion_Concordant_Nodes")

p_pep_s_tree_length <- ggplot(data_sets[[2]],aes(x = Tree_Length, y = Proportion_Concordant_Nodes, colour = Proportion_Concordant_Nodes)) + 
  geom_point() + 
  theme_bw() + 
  xlab("Tree Length (substitutions per site)") + 
  ylab("Proportion of Concordant Nodes") +
  theme(axis.title.y=element_blank(),
        legend.position = "none") +
  scale_color_gradient(low="green",high="blue") + 
  geom_line(data = new_data_pep_s_tree_length, col = "red")

svg("pep_s_length_tree_length.svg")
plot_grid(NULL,NULL,NULL,p_pep_s_length,p_pep_s_tree_length,NULL,align="h",ncol = 3,rel_widths = c(1,0.9))
dev.off()

## finish peptide plotting

## Codon plotting

new_data_codon_ns_length <- cbind(new_data_pep_codon_length,predict(quasimodels_length[[3]],newdata = new_data_pep_codon_length,type="response"))
colnames(new_data_codon_ns_length) <- c("Length","Proportion_Concordant_Nodes")

p_codon_ns_length <- ggplot(data_sets[[3]],aes(x= Length, y = Proportion_Concordant_Nodes, colour = Proportion_Concordant_Nodes)) + 
  geom_point() + 
  theme_bw() +
  theme(legend.position = "none") +
  xlab("Length (codons)") + 
  ylab("Proportion of Concordant Nodes") +
  ggtitle("Codon") + 
  scale_color_gradient(low="green",high = "blue") + 
  geom_line(data = new_data_codon_ns_length, col = "red")

new_data_codon_ns_tree_length <- cbind(new_data_codon_tree_length,predict(quasimodels_tree_length[[3]],newdata = new_data_codon_tree_length,type="response"))
colnames(new_data_codon_ns_tree_length) <- c("Tree_Length","Proportion_Concordant_Nodes")

p_codon_ns_tree_length <- ggplot(data_sets[[3]],aes(x = Tree_Length, y = Proportion_Concordant_Nodes, colour = Proportion_Concordant_Nodes)) + 
  geom_point() + 
  theme_bw() +
  xlab("Tree Length (substitutions per site)") + 
  ylab("Proportion of Concordant Nodes") +
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        legend.position = "none") +
  scale_color_gradient(low="green",high="blue") +
  geom_line(data = new_data_codon_ns_tree_length, col = "red")

svg("codon_ns_length_tree_length.svg")
plot_grid(NULL,NULL,NULL,p_codon_ns_length,p_codon_ns_tree_length,NULL,align="h",ncol = 3,rel_widths = c(1,0.79))
dev.off()

new_data_codon_s_length <- cbind(new_data_pep_codon_length,predict(quasimodels_length[[4]],newdata = new_data_pep_codon_length,type="response"))
colnames(new_data_codon_s_length) <- c("Length","Proportion_Concordant_Nodes")

p_codon_s_length <- ggplot(data_sets[[4]],aes(x= Length, y = Proportion_Concordant_Nodes, colour = Proportion_Concordant_Nodes)) + 
  geom_point() + 
  theme_bw() + 
  theme(legend.position = "none") + 
  xlab("Length (codons)") + 
  ylab("Proportion of Concordant Nodes") +
  ggtitle("Codon (BS > 70)") + 
  scale_color_gradient(low="green",high="blue") + 
  geom_line(data = new_data_codon_s_length, col = "red")

new_data_codon_s_tree_length <- cbind(new_data_codon_tree_length,predict(quasimodels_tree_length[[4]],newdata = new_data_codon_tree_length,type="response"))
colnames(new_data_codon_s_tree_length) <- c("Tree_Length","Proportion_Concordant_Nodes")

p_codon_s_tree_length <- ggplot(data_sets[[4]],aes(x = Tree_Length, y = Proportion_Concordant_Nodes, colour = Proportion_Concordant_Nodes)) + 
  geom_point() + 
  theme_bw() + 
  xlab("Tree Length (substitutions per bp)") + 
  ylab("Proportion of Concordant Nodes") +
  theme(axis.title.y=element_blank(),
        legend.position = "none") +
  scale_color_gradient(low="green",high="blue") + 
  geom_line(data = new_data_codon_s_tree_length, col = "red")

svg("codon_s_length_tree_length.svg")
plot_grid(NULL,NULL,NULL,p_codon_s_length,p_codon_s_tree_length,NULL,align="h",ncol = 3,rel_widths = c(1,0.9))
dev.off()

## finish codon plotting

## Nucleotide plotting

new_data_nuc_ns_length <- cbind(new_data_nuc_length,predict(quasimodels_length[[5]],newdata = new_data_nuc_length,type="response"))
colnames(new_data_nuc_ns_length) <- c("Length","Proportion_Concordant_Nodes")

p_nuc_ns_length <- ggplot(data_sets[[5]],aes(x= Length, y = Proportion_Concordant_Nodes, colour = Proportion_Concordant_Nodes)) + 
  geom_point() + 
  theme_bw() + 
  theme(legend.position = "none") + 
  xlab("Length (bp)") + 
  ylab("Proportion of Concordant Nodes") +
  ggtitle("Nucleotide") + 
  scale_color_gradient(low="green",high="blue") +
  geom_line(data = new_data_nuc_ns_length, col = "red")

new_data_nuc_ns_tree_length <- cbind(new_data_nuc_tree_length,predict(quasimodels_tree_length[[5]],newdata = new_data_nuc_tree_length,type="response"))
colnames(new_data_nuc_ns_tree_length) <- c("Tree_Length","Proportion_Concordant_Nodes")

p_nuc_ns_tree_length <- ggplot(data_sets[[5]],aes(x = Tree_Length, y = Proportion_Concordant_Nodes, colour = Proportion_Concordant_Nodes)) + 
  geom_point() + 
  theme_bw() + 
  xlab("Tree Length (substitutions per bp)") + 
  ylab("Proportion of Concordant Nodes") +
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        legend.position = "none") +
  scale_color_gradient(low="green",high="blue") +
  geom_line(data = new_data_nuc_ns_tree_length, col = "red")

svg("nuc_ns_length_tree_length.svg")
plot_grid(NULL,NULL,NULL,p_nuc_ns_length,p_nuc_ns_tree_length,NULL,align="h",ncol = 3,rel_widths = c(1,0.79))
dev.off()

new_data_nuc_s_length <- cbind(new_data_nuc_length,predict(quasimodels_length[[6]],newdata = new_data_nuc_length,type="response"))
colnames(new_data_nuc_s_length) <- c("Length","Proportion_Concordant_Nodes")

p_nuc_s_length <- ggplot(data_sets[[6]],aes(x= Length, y = Proportion_Concordant_Nodes, colour = Proportion_Concordant_Nodes)) + 
  geom_point() + 
  theme_bw() + 
  theme(legend.position = "none") +
  xlab("Length (bp)") + 
  ylab("Proportion of Concordant Nodes") +
  ggtitle("Nucleotide (BS > 70)") +
  scale_color_gradient(low="green",high="blue") +
  geom_line(data = new_data_nuc_s_length, col = "red")

new_data_nuc_s_tree_length <- cbind(new_data_nuc_tree_length,predict(quasimodels_tree_length[[6]],newdata = new_data_nuc_tree_length,type="response"))
colnames(new_data_nuc_s_tree_length) <- c("Tree_Length","Proportion_Concordant_Nodes")

p_nuc_s_tree_length <- ggplot(data_sets[[6]],aes(x = Tree_Length, y = Proportion_Concordant_Nodes, colour = Proportion_Concordant_Nodes)) + 
  geom_point() + 
  theme_bw() + 
  xlab("Tree Length (substitutions per bp)") + 
  ylab("Proportion of Concordant Nodes") +
  theme(axis.title.y=element_blank(),
        legend.position = "none") +
  scale_color_gradient(low="green",high="blue") +
  geom_line(data = new_data_nuc_s_tree_length, col = "red")

svg("nuc_s_length_tree_length.svg")
plot_grid(NULL,NULL,NULL,p_nuc_s_length,p_nuc_s_tree_length,NULL,align="h",ncol = 3,rel_widths = c(1,0.9))
dev.off()

## finish nucleotide plotting

## stargazer tables

stargazer(fullmodels_noint, type = "html", title = "Full Data", dep.var.caption = "Dependent Variable: Total Concordant/Total Discordant", dep.var.labels.include = F,
          model.names = T,notes.align = "l")

stargazer(fullqmodels_noint,type = "html", title = "Full Data", dep.var.caption = "Dependent Variable: Total Concordant/Total Discordant", dep.var.labels.include = F,
          model.names = T,notes.align = "l",add.lines = list(c("Dispersion",round(fullqsummaries_noint[[1]]$dispersion,3),round(fullqsummaries_noint[[2]]$dispersion,3),round(fullqsummaries_noint[[3]]$dispersion,3),
                                                               round(fullqsummaries_noint[[4]]$dispersion,3),round(fullqsummaries_noint[[5]]$dispersion,3),round(fullqsummaries_noint[[6]]$dispersion,3))))

stargazer(models_noint,type = "html", title = "Reduced Data", dep.var.caption = "Dependent Variable: Total Concordant/Total Discordant", dep.var.labels.include = F,
          model.names = T,notes.align = "l")

stargazer(quasimodels_noint,type = "html", title = "Reduced Data", dep.var.caption = "Dependent Variable: Total Concordant/Total Discordant", dep.var.labels.include = F,
          model.names = T,notes.align = "l",add.lines = list(c("Dispersion",round(quasisummaries_noint[[1]]$dispersion,3),round(quasisummaries_noint[[2]]$dispersion,3),round(quasisummaries_noint[[3]]$dispersion,3),
                                                               round(quasisummaries_noint[[4]]$dispersion,3),round(quasisummaries_noint[[5]]$dispersion,3),round(quasisummaries_noint[[6]]$dispersion,3))))