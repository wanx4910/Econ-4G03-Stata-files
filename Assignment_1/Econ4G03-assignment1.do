capture log close

cd "D:\Econ 4G03\Assignment 1"

log using Econ4G03-Lab1.log, replace text

capture drop _all

use "lfs2000feb"

*Question 6

replace sex = 0 if sex == 2
*Makes the reference category female
*Changes female into standard statistical format for dummy variables

rename sex male
*rename the sex variable as male

ci male
*Computes the 95% confidence interval of the dummy variable male
*Lower Bound: 0.4806925
*Upper Bound: 0.4868838

sum male
*Provides a statistical summary of the variable
*The mean of the variable male is 0.4837882
*The standard error of the variable male is 0.0015794
*The standard deviation of the variable male is 0.04997396
*The standard deviation is a number that tell us the spread of the data assuming
*a normal distribution. Low Standard deviation number compared to the mean tells 
*us the data is relatively tight grouped which gives us a better idea of where 
*the true mean lies.
*The standard error of the mean is the standard deviation of the error in the
*sample mean compared to the true mean.
*They can be converted from one another using the formula SE = s/(n^0.5). 

reg male
*The output is related to part a and b because since we are regressing a dummy
*variable, the result would be a flat line with the intercept at the mean of 
*the variable. And there are more females than males in this set of data the
*mean is less than 0.5. The standard error of the intercept would become the
*standard error of the mean of the sample. Also the confidence interval of the 
*intercept would be the confidence interval of the mean of the sample.

*Question 7

g byte urb = ~(cma==4)

g age = .

replace age = 17   if age_12 == 1
replace age = 22   if age_12 == 2
replace age = 27   if age_12 == 3
replace age = 32   if age_12 == 4
replace age = 37   if age_12 == 5
replace age = 42   if age_12 == 6
replace age = 47   if age_12 == 7
replace age = 52   if age_12 == 8
replace age = 57   if age_12 == 9
replace age = 62   if age_12 == 10
replace age = 67   if age_12 == 11
replace age = 73   if age_12 == 12

g byte nf = prov==10
g byte pe = prov==11
g byte ns = prov==12
g byte nb = prov==13
g byte qu = prov==24
g byte on = prov==35
g byte mn = prov==46
g byte sk = prov==47
g byte ab = prov==48
g byte bc = prov==59

*a)
rename hrlyearn hrearn
reg hrearn age male urb nf-ab

*b)
g lnearn = ln(hrearn)
reg lnearn age male urb nf-ab

*c)
reg lnearn age male urb pe-bc

*d)
g lnAge = ln(age)
reg lnearn lnAge urb nf-ab
*R^2 is the percentage of the variance in the data explained by the regression
*model and measures the fit of the model to the data.
*The R^2 of the regression models in b and c are both 0.2222
*They do not differ because the only change made to the model was instead of 
*using British Columbia as the reference category like b, c used Newfoundland
*as the reference category.
*The interpretation of the coefficient age and male in a and b is that being
*older and a male has positive impact on a person's hourly earnings.
*The interpretation of lnAge in d is that being older is correlated with 
*earning more.

*Question 8

g age2 = age*age

*a)
reg lnearn age age2 male urb nf-ab

*b)
reg lnearn age age2 male urb nf-ab, vce(robust)
test age age2
*The value of the coefficient of age in both models are a  small positive number 
*which tells us that there is relationship between age and ln(earnings).
*However the positive effect of age on earnings is very marginal, the shape of
*relationship is almost a flat line.
*F-stat = 11891.65, F-crit(2,infinity) = 4.61 at the 1% level. 
*Since 46832 degrees of freedom can be approximate infinity and the large sample
*critical value F-critical values from the back of the textbook tells us to
*reject the null hypothesis of age = 0 and age2 = 0. 
*We use the F-test statistics because we are jointly restricting age and age2 
*to be zero, the p value tells us that there is no chance that we fail to
*reject the null hypothesis.
*Homoskedasticity is when the error terms are uniform and heteroskedasticity is
*when the error terms' variance vary. The implications of not using 
*heteroskedasticity robust standard erros is not important in this model because
*the changes in R^2 is insignificant.









