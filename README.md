
# Heart Disease Detection

**Goal**: To predict the presence of heart disease using various health status.

**Motivation**: We wanted to know what are the leading causes for heart disease.

## Data Source: [Personal Key Indicators of Heart Disease](https://www.kaggle.com/datasets/kamilpytlak/personal-key-indicators-of-heart-disease)

This dataset is from Kaggle and it contains 320K observations and 18 attributes.

Attributes:
- HeartDisease: Ever reported having coronary heart disease (CHD) or myocardial infarction (MI)
- BMI: Body Mass Index (BMI)
- Smoking: Ever smoked at least 100 cigarettes in your entire life? [Note: 5 packs = 100 cigarettes]
- AlcoholDrinking: Heavy drinkers (adult men having more than 14 drinks per week and adult women having more than 7 drinks per week
- Stroke: (Ever told) (you had) a stroke?
- PhysicalHealth: Now thinking about your physical health, which includes physical illness and injury, for how many days during the past 30 days was your physical health not good? (0-30 days)
- MentalHealth: How many days during the past 30 days was your mental health not good?
- DiffWalking: Do you have serious difficulty walking or climbing stairs?
- Sex: Are you male or female?
- AgeCategory: Fourteen-level age category
- Race: Imputed race/ethnicity value
- Diabetic: (Ever told) (you had) diabetes?
- PhysicalActivity: Adults who reported doing physical activity or exercise during the past 30 days other than their regular job
- GenHealth: Would you say that in general your health is…
- SleepTime: On average, how many hours of sleep do you get in a 24-hour period?
- Asthma: (Ever told) (you had) asthma?
- KidneyDisease: Not including kidney stones, bladder infection or incontinence, were you ever told you had kidney disease?
- SkinCancer: (Ever told) (you had) skin cancer?

## Summary

1. Performed exploratory data analysis, data cleaning, and data restructuring.
2. We found that the response variable (Heart Disease) is highly unbalanced so we used the Synthetic Minority Oversampling Technique (SMOTE) to oversample the minority and undersample the majority to create a balanced dataset.
3. Implemented 3 different machine learning algorithms (logistic regression, decision tree, and random forest).
4. Evaluated model performance using confusion matrix to get the accuracy and recall score.

## Results

The random forest model yielded the best classification results with 91% accuracy and 93% recall.

Top 5 most importance by Mean Decrease Accuracy in descending order are:
1. Male
2. Asthma
3. BMI (Body Mass Index)
4. Stroke
5. Diabetic

Top 5 most importance by Mean Decrease Gini in descending order are:
1. Sleep time
2. Physical health
3. BMI (Body Mass Index)
4. Difficulty walking
5. Mental health

- The Mean Decrease Accuracy expresses how much accuracy the model losses by excluding each variable.
- The Mean Decrease Gini is a measure of how each variable contributes to the homogeneity of the nodes and leaves in the resulting random forest.

## Tech Stack

**Language:** R

**Libraries:** fastDummies, performanceEstimation, plyr, dplyr, tree, randomForest

**Tool:** Rstudio

## Feedback

If you have any feedback, please reach out to me at LiJake2001@gmail.com

## Authors

JianHui (Jake) Li, Richard Lim, Jianhong Li, Dev Patel

