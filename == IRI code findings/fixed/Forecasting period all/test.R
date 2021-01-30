 

 

# one way ANOVA 
xx.aov= aov(old_nor ~ model, data=exp2)
summary(xx.aov)

xx.aov= aov(old_nor ~ model, data=exp2_ind)
summary(xx.aov)

xx.aov= aov(old_nor ~ model, data=exp2_dep)
summary(xx.aov)

kruskal.test(old_nor ~ model, data=exp2)
kruskal.test(model ~ old_nor, data=exp2)
require(PMCMR)
attach(exp2)
posthoc.kruskal.nemenyi.test(x=old_nor, g=model, dist="Tukey")
 
kruskal.test(model ~ old_nor, data=exp2_ind)
kruskal.test(old_nor ~ model, data=exp2_ind)
require(PMCMR)
attach(exp2_ind)
posthoc.kruskal.nemenyi.test(x=old_nor, g=model, dist="Tukey")


kruskal.test(model ~ old_nor, data=exp2_dep)
require(PMCMR)
attach(exp2_dep)
posthoc.kruskal.nemenyi.test(x=old_nor, g=model, dist="Tukey")







# Wilcoxon and t 
data(exp1)
attach(exp1)
wilcox.test(old_nor,new_ind, paired=TRUE)
wilcox.test(old_nor,new_dep, paired=TRUE)

 


summary(exp2_ind)
attach(exp2_ind)
boxplot(old_nor ~ model)

shapiro.test(old_nor)
shapiro.test(new_ind)
shapiro.test(new_dep)



t.test(old_nor, new_ind)
t.test(old_nor, new_dep)
t.test(old_nor,new_ind,paired=TRUE) 
t.test(old_nor,new_dep,paired=TRUE) 







require(PMCMR)
data(data.for.PMCMR.listed.categories)
attach(data.for.PMCMR.listed.categories)
posthoc.kruskal.nemenyi.test(x=smape, g=model, dist="Tukey")

data(data.all)
attach(data.all)
wilcox.test(smape_adl,smape_adl_ic, paired=TRUE)
t.test(smape_adl,smape_adl_ic,paired=TRUE) 
 