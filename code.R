# import libraries
library(fastDummies)
library(performanceEstimation)
library(plyr)
library(dplyr)
library(tree)
library(randomForest)

# df = read.csv(file.choose(), header=TRUE, stringsAsFactors=TRUE)
# attach(df)
# names(df)

# EDA
# head(df)
# dim(df)
# str(df)
# summary(df)

# check number of nulls
# sum(is.na(df))
# check duplicates and remove them
# sum(duplicated(df))
# df = distinct(df)

# plot(HeartDisease, xlab="Heart Disease", ylab="Frequency", main="Heart Disease Distribution")
# The "HeartDisease" variable is highly unbalanced

# data restructuring
# create dummy variables
# new_df = dummy_cols(df, remove_first_dummy=TRUE, remove_selected_columns=TRUE)
# reorder columns
# new_df = new_df[, c(5, 1, 2, 3, 4, 6:38)]
# rename columns
# new_df = new_df %>% rename("AgeCategory_TwentyFiveToTwentyNine"="AgeCategory_25-29",
#                            "AgeCategory_ThirtyToThirtyFour"="AgeCategory_30-34",
#                            "AgeCategory_ThirtyFiveToThirtyNine"="AgeCategory_35-39",
#                            "AgeCategory_FortyToFourtyFour"="AgeCategory_40-44",
#                            "AgeCategory_FourtyFiveToFourtyNine"="AgeCategory_45-49",
#                            "AgeCategory_FiftyToFiftyFour"="AgeCategory_50-54",
#                            "AgeCategory_FiftyFiveToFiftyNine"="AgeCategory_55-59",
#                            "AgeCategory_SixtyToSixtyFour"="AgeCategory_60-64",
#                            "AgeCategory_SixtyFiveToSixtyNine"="AgeCategory_65-69",
#                            "AgeCategory_SeventyToSeventyFour"="AgeCategory_70-74",
#                            "AgeCategory_SeventyFiveToSeventyNine"="AgeCategory_75-79",
#                            "AgeCategory_EightyOrOlder"="AgeCategory_80 or older",
#                            "Diabetic_No_borderline_diabetes"="Diabetic_No, borderline diabetes",
#                            "Diabetic_Yes_during_pregnancy"="Diabetic_Yes (during pregnancy)",
#                            "GenHealth_Very_good"="GenHealth_Very good")

# change HeartDisease_Yes to factor
# new_df$HeartDisease_Yes = as.factor(new_df$HeartDisease_Yes)
# attach(new_df)

# using smote to oversample the minority
# balanced_df = smote(HeartDisease_Yes~., data=new_df, perc.over=10, perc.under=1, k=3)
# write.csv(balanced_df, "~/workspace/cis3920/Project/balanced_df.csv", row.names = FALSE)

balanced_df = read.csv(file.choose(), header=TRUE)
balanced_df$HeartDisease_Yes = as.factor(balanced_df$HeartDisease_Yes)
attach(balanced_df)

# Logistic Regression
set.seed(1)
train = sample(nrow(balanced_df), nrow(balanced_df)*0.8) # 80% for training
balanced_df.test = balanced_df[-train,]
test.truevalue = HeartDisease_Yes[-train]
glm.fit = glm(HeartDisease_Yes~., data=balanced_df, subset=train, family='binomial')
summary(glm.fit)
coef(glm.fit)
exp(coef(glm.fit))

glm.probs = predict(glm.fit, balanced_df.test, type="response")
contrasts(HeartDisease_Yes)
glm.pred = rep("0", 114497)
glm.pred[glm.probs>0.5]="1"

table(glm.pred, test.truevalue)
mean(glm.pred==test.truevalue)

# 5-fold Logistic Regression
k = 5
folds = sample(1:k, nrow(balanced_df), replace=TRUE)
accuracy = rep(0,k)

for(i in 1:k)
{
  glm.fit = glm(HeartDisease_Yes~., family="binomial", data=balanced_df[folds!=i,])
  balanced_df.test = balanced_df[folds==i, ]
  glm.probs = predict(glm.fit, balanced_df.test, type="response")
  glm.pred = rep("0", nrow(balanced_df[folds==i,]))
  glm.pred[glm.probs>0.5]="1"
  
  test.truevalue = HeartDisease_Yes[folds==i]
  accuracy[i] = mean(glm.pred==test.truevalue)
}

mean(accuracy)

# Classification and Regression Tree (CART)
set.seed(1)
train = sample(nrow(balanced_df), nrow(balanced_df)*0.8) # 80% for training
balanced_df.test = balanced_df[-train,]
test.truevalue = HeartDisease_Yes[-train]

tree.model = tree(HeartDisease_Yes~., balanced_df, subset=train)

cv.model = cv.tree(tree.model, FUN=prune.misclass)
cv.model

prune.model = prune.tree(tree.model, best=7)
plot(prune.model)
text(prune.model, pretty=0)

prunetree.pred = predict(prune.model, balanced_df.test, type="class")
table(prunetree.pred, test.truevalue)
mean(prunetree.pred==test.truevalue)

plot(x=cv.model$size, y=cv.model$dev, main='Error Rate Decreases as Size Increases')

# Random Forest
set.seed(1)
train = sample(nrow(balanced_df), nrow(balanced_df)*0.8) # 80% for training
balanced_df.test = balanced_df[-train,]
test.truevalue = HeartDisease_Yes[-train]

rf.balanced_df = randomForest(HeartDisease_Yes~., data=balanced_df, subset=train, importance=TRUE)
yhat.rf = predict(rf.balanced_df, newdata=balanced_df[-train,])
table(yhat.rf,test.truevalue)
mean((yhat.rf==test.truevalue)^2)

importance(rf.balanced_df)
varImpPlot(rf.balanced_df)
