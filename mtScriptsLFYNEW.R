# Before reading CSV file into data frame,
#  copy the most recent version from parent directory:

mtDataAll <- read.csv("QTLStudyTraitAnalysis_survMarkers.csv", header=TRUE)

# Generate calculated fields:
mtDataAll$dDiam21 <- with(mtDataAll,Diam2 - Diam1)
mtDataAll$dDiam32 <- with(mtDataAll,Diam3 - Diam2)
mtDataAll$meanBLvs <- apply(mtDataAll[,c(12:14)],1,mean,na.rm=TRUE)
mtDataAll$meanOrder <- apply(mtDataAll[,c(15,18,21)],1,mean,na.rm=TRUE)
mtDataAll$meanBrNode <- apply(mtDataAll[,c(16,19,22)],1,mean,na.rm=TRUE)
mtDataAll$meanFlNode <- apply(mtDataAll[,c(17,20,23)],1,mean,na.rm=TRUE)

names(mtDataAll)
class(mtDataAll$Pop)
class(mtDataAll$Fam)
class(mtDataAll$PShootStatus0215)
class(mtDataAll$LShootStatus0215)
mtDataAll$Pop <- as.factor(mtDataAll$Pop)
mtDataAll$Fam <- as.factor(mtDataAll$Fam)
mtDataAll$PShootStatus0215 <- as.factor(mtDataAll$PShootStatus0215)
mtDataAll$LShootStatus0215 <- as.factor(mtDataAll$LShootStatus0215)

mtDataF2 <- with(mtDataAll,mtDataAll[Pop=="F2",]) # New dataframe with just the F2 plants.

names(mtDataF2)

# Decompose GI genotype into additive and dominance components:
mtDataF2$GIAdd <- mtDataF2$GI-1
mtDataF2$GIDom <- 1-abs(1-mtDataF2$GI)

# Calculate mean number of inflorescence branches:
mtDataF2$meanBrNumber <- mtDataF2$meanFlNode - mtDataF2$meanBrNode

# Single-trait regressions on GI genotype:

Diam3_mt <- lm(Diam3 ~ GI, data=mtDataF2)
summary(Diam3_mt)
plot(Diam3 ~ GI, data=mtDataF2)
abline(reg=Diam3_mt)

dD32_mt <- lm(dDiam32 ~ GI, data=mtDataF2)
summary(dD32_mt)
plot(dDiam32 ~ GI, data=mtDataF2)
abline(reg=dD32_mt)

Infl_mt <- lm(Infl ~ GI, data=mtDataF2)
summary(Infl_mt)
plot(Infl ~ GI, data=mtDataF2)
abline(reg=Infl_mt)

Diam2_mt <- lm(Diam2 ~ GI, data=mtDataF2)
summary(Diam2_mt)
plot(Diam2 ~ GI, data=mtDataF2)
abline(reg=Diam2_mt)

Diam1_mt <- lm(Diam1 ~ GI, data=mtDataF2)
summary(Diam1_mt)
plot(Diam1 ~ GI, data=mtDataF2)
abline(reg=Diam1_mt)

dD21_mt <- lm(dDiam21 ~ GI, data=mtDataF2)
summary(dD21_mt)
plot(dDiam21 ~ GI, data=mtDataF2)
abline(reg=dD21_mt)

BLvs_mt <- lm(meanBLvs ~ GI, data=mtDataF2)
summary(BLvs_mt)
plot(meanBLvs ~ GI, data=mtDataF2)
abline(reg=BLvs_mt)

Order_mt <- lm(meanOrder ~ GI, data=mtDataF2)
summary(Order_mt)
plot(meanOrder ~ GI, data=mtDataF2)
abline(reg=Order_mt)

Rating_mt <- lm(LatRating0215 ~ GI, data=mtDataF2)
summary(Rating_mt)
plot(LatRating0215 ~ GI, data=mtDataF2)
abline(reg=Rating_mt)

Rhiz_mt <- lm(Rhiz0615 ~ GI, data=mtDataF2)
summary(Rhiz_mt)
plot(Rhiz0615 ~ GI, data=mtDataF2)
abline(reg=Rhiz_mt)

Rhiz_mt_glm <- glm(Rhiz0615 ~ GI, family=binomial, data=mtDataF2)
summary(Rhiz_mt_glm)

FlNode_mt <- lm(meanFlNode ~ GI, data=mtDataF2)
summary(FlNode_mt)
plot(meanFlNode ~ GI, data=mtDataF2)
abline(reg=FlNode_mt)

BrNode_mt <- lm(meanBrNode ~ GI, data=mtDataF2)
summary(BrNode_mt)
plot(meanBrNode ~ GI, data=mtDataF2)
abline(reg=BrNode_mt)

BrNumber_mt <- lm(meanBrNumber ~ GI, data=mtDataF2)
summary(BrNumber_mt)

# ---------------------------------

table(mtDataF2[,c(7,32)])
table(mtDataF2[,c(6,32)])
levels(mtDataF2$PShootStatus0215)
levels(mtDataF2$LShootStatus0215)

# Regressions on GI additive and dominance components:

Diam1_AD <- lm(Diam1 ~ GIAdd + GIDom, data=mtDataF2)
summary(Diam1_AD)
plot(Diam1 ~ GIAdd + GIDom, data=mtDataF2)

Diam2_AD <- lm(Diam2 ~ GIAdd + GIDom, data=mtDataF2)
summary(Diam2_AD)

dD21_AD <- lm(dDiam21 ~ GIAdd + GIDom, data=mtDataF2)
summary(dD21_AD)

Diam3_AD <- lm(Diam3 ~ GIAdd + GIDom, data=mtDataF2)
summary(Diam3_AD)
drop1(Diam3_AD, test = "Chisq")

dD32_AD <- lm(dDiam32 ~ GIAdd + GIDom, data=mtDataF2)
summary(dD32_AD)

Infl_AD <- lm(Infl ~ GIAdd + GIDom, data=mtDataF2)
summary(Infl_AD)

BLvs_AD <- lm(meanBLvs ~ GIAdd + GIDom, data=mtDataF2)
summary(BLvs_AD)

Order_AD <- lm(meanOrder ~ GIAdd + GIDom, data=mtDataF2)
summary(Order_AD)

Rating_AD <- lm(LatRating0215 ~ GIAdd + GIDom, data=mtDataF2)
summary(Rating_AD)

Rhiz_AD <- lm(Rhiz0615 ~ GIAdd + GIDom, data=mtDataF2)
summary(Rhiz_AD)

Rhiz_AD_glm <- glm(Rhiz0615 ~ GIAdd + GIDom, family=binomial, data=mtDataF2)
summary(Rhiz_AD_glm)

FlNode_AD <- lm(meanFlNode ~ GIAdd + GIDom, data=mtDataF2)
summary(FlNode_AD)

BrNode_AD <- lm(meanBrNode ~ GIAdd + GIDom, data=mtDataF2)
summary(BrNode_AD)

table(mtDataF2[,c(7,32)])
table(mtDataF2[,c(6,32)])
levels(mtDataF2$PShootStatus0215)
levels(mtDataF2$LShootStatus0215)

# Make cross vector to correspond to which cross each F2 individual is from:
levels(mtDataF2$Fam)
crossNames <- c("A","A","B","B","B")
families <- c("AM","AS","BS","BS1","BS2")
cross <- crossNames[match(mtDataF2$Fam,families)]
length(cross)
length(mtDataF2$Fam) # Verify correct length for cross vector
names(mtDataF2)

# Test for effects of GI genotype * cross:
Diam1_ADxC <- lm(Diam1 ~ (GIAdd + GIDom)*cross, data=mtDataF2)
summary(Diam1_ADxC)
drop1(Diam1_ADxC, test="Chisq")

# Generate vectors specific to primary and lateral shoot bolting and flowering
#   and use for regression on GI genotype:

PBolted0215 <- as.numeric(c("NA",1,1,0,1)[match(mtDataF2$PShootStatus0215,
                                            levels(mtDataF2$PShootStatus0215))])
PFlowered0215 <- as.numeric(c("NA",0,1,0,1)[match(mtDataF2$PShootStatus0215,
                                                levels(mtDataF2$PShootStatus0215))])
LBolted0215 <- as.numeric(c("NA",1,1,0,1)[match(mtDataF2$LShootStatus0215,
                                                  levels(mtDataF2$LShootStatus0215))])
LFlowered0215 <- as.numeric(c("NA",0,1,0,1)[match(mtDataF2$LShootStatus0215,
                                                  levels(mtDataF2$LShootStatus0215))])

PBolted_AD <- lm(PBolted0215 ~ GIAdd + GIDom, data=mtDataF2)
summary(PBolted_AD)

PFlowered_AD <- lm(PFlowered0215 ~ GIAdd + GIDom, data=mtDataF2)
summary(PFlowered_AD)

LBolted_AD <- lm(LBolted0215 ~ GIAdd + GIDom, data=mtDataF2)
summary(LBolted_AD)

LFlowered_AD <- lm(LFlowered0215 ~ GIAdd + GIDom, data=mtDataF2)
summary(LFlowered_AD)


# Linear models with genotypes as categories:

GICat <- as.factor(mtDataF2$GI)
levels(GICat) <- c("SP/SP","SP/MA","MA/MA")

Diam3_mtCat <- lm(Diam3 ~ GICat, data=mtDataF2)
summary(Diam3_mtCat)
plot(Diam3 ~ GICat, data=mtDataF2)

dD32_mtCat <- lm(dDiam32 ~ GICat, data=mtDataF2)
summary(dD32_mtCat)
plot(dDiam32 ~ GICat, data=mtDataF2)

Diam1_mtCat <- lm(Diam1 ~ GICat, data=mtDataF2)
summary(Diam1_mtCat)
plot(Diam1 ~ GICat, data=mtDataF2)

Infl_mtCat <- lm(Infl ~ GICat, data=mtDataF2)
summary(Infl_mtCat)
plot(Infl ~ GICat, data=mtDataF2)

BLvs_mtCat <- lm(meanBLvs ~ GICat, data=mtDataF2)
summary(BLvs_mtCat)
plot(meanBLvs ~ GICat, data=mtDataF2)

Rating_mtCat <- lm(LatRating0215 ~ GICat, data=mtDataF2)
summary(Rating_mtCat)
plot(LatRating0215 ~ GICat, data=mtDataF2)

FlNode_mtCat <- lm(meanFlNode ~ GICat, data=mtDataF2)
summary(FlNode_mtCat)
plot(meanFlNode ~ GICat, data=mtDataF2)

BrNode_mtCat <- lm(meanBrNode ~ GICat, data=mtDataF2)
summary(BrNode_mtCat)
plot(meanBrNode ~ GICat, data=mtDataF2)

Order_mtCat <- lm(meanOrder ~ GICat, data=mtDataF2)
summary(Order_mtCat)
plot(meanOrder ~ GICat, data=mtDataF2)

Rhiz_mtCat <- lm(Rhiz0615 ~ GICat, data=mtDataF2)
summary(Rhiz_mtCat)
plot(Rhiz0615 ~ GICat, data=mtDataF2)


# Multiple regressions on GI genotype and possible "upstream" traits:
Infl_ADMultA <- lm(Infl ~ GIAdd + GIDom + Diam3, data=mtDataF2)
summary(Infl_ADMultA)
drop1(Infl_ADMultA, test="Chisq")

Diam3_ADMultA <- lm(Diam3 ~ GIAdd + GIDom + Infl, data=mtDataF2)
summary(Diam3_ADMultA)
drop1(Diam3_ADMultA, test="Chisq")

Infl_mtMultA <- lm(Infl ~ GI + dDiam32, data=mtDataF2)
summary(Infl_mtMultA)
drop1(Infl_mtMultA, test="Chisq")

Infl_mtMultI <- lm(Infl ~ GI*dDiam32, data=mtDataF2)
summary(Infl_mtMultI)
drop1(Infl_mtMultI, test="Chisq")

dD32_mtMultA <- lm(dDiam32 ~ GI + Infl, data=mtDataF2)
summary(dD32_mtMultA)
drop1(dD32_mtMultA, test="Chisq")

# Trait-only regressions:
Infl_D3 <- lm(Infl ~ Diam3, data=mtDataF2)
summary(Infl_D3)

D3_Infl <- lm(Diam3 ~ Infl, data=mtDataF2)
summary(D3_Infl)

Infl_dD32 <- lm(Infl ~ dDiam32, data=mtDataF2)
summary(Infl_dD32)

dD32_Infl <- lm(dDiam32 ~ Infl, data=mtDataF2)
summary(dD32_Infl)

ls()
sum(mtDataF2$GI,na.rm=TRUE)/mean(mtDataF2$GI,na.rm=TRUE)  # Gives count of genotyped plants

mtDataF2A <- with(mtDataF2, mtDataF2[Fam == "AM" | Fam == "AS",])
mtDataF2B <- with(mtDataF2, mtDataF2[Fam == "BS1" | Fam == "BS2",])

cytoA_Infl <- lm(Infl ~ Fam, data=mtDataF2A)
summary(cytoA_Infl)

InflxCytoA <- lm(Infl ~ GI*Fam, data = mtDataF2A)
summary(InflxCytoA)

levels(mtDataF2$Fam)

# Make cross vector to correspond to which cross each F2 individual is from:
levels(traitDataF2$Fam)
crossNames <- c("A","A","B","B","B")
families <- c("AM","AS","BS","BS1","BS2")
cross <- crossNames[match(mtDataF2$Fam,families)]
length(cross)
length(mtDataF2$Fam) # Verify correct length for cross vector
names(mtDataF2)

# Test for cross effect in combination with PIN region effects:
Infl_mtCross <- lm(Infl ~ GI*cross, data=mtDataF2)
summary(Infl_mtCross)

Diam3_mtCross <- lm(Diam3 ~ GI*cross, data=mtDataF2)
summary(Diam3_mtCross)
drop1(Diam3_mtCross, test = "Chisq")

# PC Analysis

PCTraitsF2dExt <- mtDataF2[,c(5,27,31,24,41,30,39,40)]
PCTraitsF2dExtTrim <- na.omit(PCTraitsF2dExt)
length(PCTraitsF2dExtTrim[,1])

names(PCTraitsF2dExtTrim)

PCModelF2dExt <- prcomp(PCTraitsF2dExtTrim, scale.=TRUE)
summary(PCModelF2dExt)
PCModelF2dExt$rotation

PCPredictF2 <- predict(PCModelF2dExt, newdata = mtDataF2)
mtDataF2 <- cbind(mtDataF2, PCPredictF2)
mtDataF2 <- mtDataF2[,c(1:55)]
names(mtDataF2)

PC1_PIN <- lm(PC1 ~ PIN_combined, data = mtDataF2)
summary(PC1_PIN)

PC1_SOC1 <- lm(PC1 ~ SOC1, data = mtDataF2)
summary(PC1_SOC1)

PC2_SOC1 <- lm(PC2 ~ SOC1, data = mtDataF2)
summary(PC2_SOC1)

PC3_SOC1 <- lm(PC3 ~ SOC1, data = mtDataF2)
summary(PC3_SOC1)

PC4_SOC1 <- lm(PC4 ~ SOC1, data = mtDataF2)
summary(PC4_SOC1)
