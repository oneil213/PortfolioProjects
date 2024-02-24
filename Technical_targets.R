# 1. Preparing workstation

# Load the tidyverse library.
library(tidyverse)

# Import the data set.
tec_data <- read.csv(file.choose(), header=T)

# 2. Sense Check and prepare data set

# View the Structure of the Data
str(tec_data)

# Convert month column to factor
tec_data$Month <- as.factor(tec_data$Month)

# Summary Statistics
summary(tec_data)

# View First Few Rows
head(tec_data)

# View last Few Rows
tail(tec_data)

# Remove missing values
tec_data <- na.omit(tec_data)

# Check for Missing Values
anyNA(tec_data)

# Exclude the Month column from the correlation analysis
cor_data <- tec_data[, -which(names(tec_data) == "Month")]

# View DataFrame
cor_data

#3. Explore the data

# Determine correlation between variables.
cor(cor_data)

# Visualise the correlation
# Install the psych package.
# install.packages('psych')

# Import the psych package.
library(psych)

# Using the corPlot() function.
# Specify the data frame (cor_data) and set 
# character size (cex=1).
corPlot(cor_data, cex = 1, main = "Electricity Distribution KPI Correlation Plot")


#Create a model

# 4. Regression modelling

# Create a new object and 
# specify the lm function and the variables.
modela = lm(Revenue~Energy.Received+Complaints, data=cor_data)

# Print the summary statistics.
summary(modela)

# Interpretation of t values and p-values
interpretation <- "Based on the t values and associated p-values, none of the 
coefficients for the predictor variables ('Energy Received' and 'Complaints') 
are statistically significant at a conventional significance level of 0.05. 
Therefore, there is insufficient evidence to reject the null hypothesis for 
these coefficients.The adjusted R-squared value is 0.6273, which penalizes the 
R-squared value for the inclusion of additional predictors."

# Add new variables.
modelb = lm(Revenue~Metered.Customer+Energy.Received+Complaints, data=cor_data)

# Change the model name.
summary(modelb)

text <- "Based on these metrics, Model 2 appears to be better for predicting 
revenue:
- It has a higher adjusted R-squared, indicating that it explains a larger 
proportion of the variance in revenue.
- The residual standard error is lower in Model 2, suggesting a better fit of 
the model to the data.
- The F-statistic for Model 2 is higher, indicating a better overall fit of 
the model.
- Although not all coefficients in Model 2 are statistically significant, at 
least one predictor variable ('Energy.Received') shows marginal significance, 
which suggests a potential impact on revenue."

# 5. Test the model

# Load the new data file (tec_test.csv), and view its structure.
tec_test <- read.csv(file.choose(), header=TRUE)

# View the data.
str(tec_test)

# Create a new object and specify the predict function.
predictTest = predict(modela, newdata=tec_test,
                      interval='confidence')
# Print the object.
predictTest

Conclusion <- "Comparing the predicted revenue with the actual revenue:

- The predicted revenue for month 7 is lower than the actual revenue of
2122000000.
- The predicted revenue for month 8 is higher than the actual revenue of 
2144000000.

This suggests that the model may not accurately predict revenue for these months.
There could be several reasons for this discrepancy, such as:

1. Inadequate predictor variables: The model may not include all relevant 
predictors that affect revenue.
2. Non-linear relationships: The relationship between predictors and revenue 
may not be linear, and the model may not capture this adequately.
3. Data limitations: The model may not have been trained on a sufficiently 
diverse dataset, leading to poor generalization to unseen data considering only 
six month records were provided.
4. Random variability: Predictions can vary due to random variability, 
especially when dealing with small datasets or short time periods.

In conclusion, while the model provides predictions for revenue, 
its accuracy may be limited, as evidenced by the discrepancy between predicted 
and actual revenue values. Further investigation and possibly model refinement 
are needed and more historical data to improve the predictive performance for 
revenue estimation."


