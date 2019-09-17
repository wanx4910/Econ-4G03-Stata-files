capture log close
cd "/Volumes/NO NAME/Econ 4G03/Assignment 3" 
log using Econ4G03-Assign3.log, replace text
capture drop _all 
*capture drop _all is required for regression to work
use "SeatBelts"

g lnIncome = ln(income)
* Question 2a
reg fatalityrate sb_useage speed65 speed70 ba08 drinkage21 lnIncome age
* The positive magnitude of the sb_useage coefficient shows that seatbelt usage
* increases fatality rate.
* 2b
xtset fips year
* Declares our dataset as a panel data
xtreg fatalityrate sb_useage speed65 speed70 ba08 drinkage21 lnIncome age, fe
* Does the fixed effect regression model
* Yes, the result changes when we add state fixed effects into our model. 
* Seatbelt usage now decreases fatality rates. A possible explanation for this 
* change in the results could be due to the fact that if you drive in a state
* with higher accident or fatality rates, you would be more likely to take 
* safety precautions like wearing seatbelts in the first place. Therefore not 
* accounting for omitted variables or fixed state characteristics would skew the
* results.
* 2c
xtreg fatalityrate sb_useage speed65 speed70 ba08 drinkage21 lnIncome age i.year, fe
* Does a multiple fixed effect regression model
* Yes the results changes compared to part a and b. As we add a time dimension 
* fixed effect, it is logical that the coefficients change.
* 2d
testparm i.year
* The model in c with includes both entity and time fixed effect is the most 
* reliable because we are controlling for unobserved fixed state characteristics
* and for unobserved fixed time effects. The Prob > F = 0, therefore we reject
* the null hypothesis of the joint test of year dummies and we need time fixed
* effect.
* 2e


* 3a
* The effect on probablity if PI ratio changed from 0.2 to 0.45 for a black 
* person is Pr(–2.26 + 2.74P/I ratio + 0.71black)= 
display normal(-0.317)
display normal(-1.002)
* 0.3756 - 0.1582 = 0.2174 Therefore increasing the PI ratio from 0.2 to 0.45 
* increase the probability of getting a loan denied by 21.74%
* 3b
* The effect on probablity if PI ratio changed from 0.2 to 0.45 for a non black 
* person is Pr(–2.26 + 2.74P/I ratio + 0.71black)= 
display normal(-1.027)
display normal(-1.712)
* 0.1522 - 0.0434 = 0.1088 Therefore increasing the PI ratio from 0.2 to 0.45
* increase the probability of getting a loan denied by 10.88%

