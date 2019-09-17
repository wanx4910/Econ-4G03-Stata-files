capture log close
cd "/Volumes/NO NAME/Econ 4G03/Assignment 4" 
log using Econ4G03-Assign4-q2.log, replace text
capture drop _all 
use "fertility"
* Part a
g weeksworked = weeksm1
reg weeksworked morekids
* On average women with more than 2 children work less than women with 2 
* children, they work 5.39 weeks less in a year.
* Part b
* OLS regression done in a would be inappropriate to estimate the causal effect
* of fertility and it is because we don't have ordinal information of the causal
* effect of fertility on labour supply
* Part c
reg morekids samesex
* Couples whose first 2 children are of the same sex are more likely to have a 
* third child. As you are 6.75% more likely to have a third child if your first
* two children are the same sex. the effect is somewhat large as it is 
* statistically significant and different from zero.
* Part d
* Samesex is a valid instrument for an IV regression of weeksworked on morekids
* because the sex of your children should be random and it should not affect 
* your labour supply differently whether they are the same sex or not.
* Therefore it grabs the variation in X as shown in part c but should not 
* directly correlated with labour supply. 
* Part e
* samesex is not a weak instrument because the F-stat is >> 10, this shows that
* it is well correlated with whether you have more than 2 kids.
* Part f
ivregress 2sls weeksworked (morekids = samesex) 
* The effect of fertility on labour supply is they work less with more children.
* Women with more than 2 children work 6.31 weeks less a year than women who 
* have less than 2 children. Using samesex as a instrument, it shows that the 
* true effect of fertility on labour supply is slightly larger than the OLS 
* results would suggest.
* Part g
ivregress 2sls weeksworked agem1 black hispan othrace (morekids = samesex)
* The results change numerically, because the additional regressors serve as 
* control variables so they grab the some of the variance of Y however, the
* causal effect of fertility on labour supply remains robust as the results do
* not change directions or vary significantly in magnitude. Therefore the 
* results in part g are more precise compared to part f.
