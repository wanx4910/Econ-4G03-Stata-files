capture log close
cd "/Volumes/NO NAME/Econ 4G03/Assignment 3" 
log using Econ4G03-Assign3pt2.log, replace text
capture drop _all 
use "Smoking"
g age2 = age * age
* 4a
probit smoker smkban female age age2 hsdrop hsgrad colsome colgrad black hispanic
* 4b
ttest smkban = 0, level (95)
* Since the t-statistic is 125.0053, and the p value is 0 therefore we reject
* the null hypothesis and the coefficient of smkban is not equal to zero.
* 4c
test hsdrop=hsgrad=colsome=colgrad=0
* As the p value of the f test is zero, we reject the null hypothesis that 
* probability of smoking does not depend on the level of education.
* 4d
generate mra = _b[smkban]*0 + _b[female]*0 + _b[age]*20 + _b[age2]*400 + _b[hsdrop]*1 + _b[hsgrad]*0 + _b[colsome]*0 + _b[colgrad]*0  + _b[black]*0 + _b[hispanic]*0 + _b[_cons]
display mra
display normal(mra)
generate mra1 = _b[smkban]*1 + _b[female]*0 + _b[age]*20 + _b[age2]*400 + _b[hsdrop]*1 + _b[hsgrad]*0 + _b[colsome]*0 + _b[colgrad]*0  + _b[black]*0 + _b[hispanic]*0 + _b[_cons]
display normal(mra1)
* Probability of that Mr.A smokes is 46.41% and effect of smoking ban on 
* probaility of smoking is a decrease of 6.23%
generate msb = _b[smkban]*0 + _b[female]*1 + _b[age]*40 + _b[age2]*1600 + _b[hsdrop]*0 + _b[hsgrad]*0 + _b[colsome]*0 + _b[colgrad]*1  + _b[black]*1 + _b[hispanic]*0 + _b[_cons]
display msb
display normal(msb)
generate msb1 = _b[smkban]*1 + _b[female]*1 + _b[age]*40 + _b[age2]*1600 + _b[hsdrop]*0 + _b[hsgrad]*0 + _b[colsome]*0 + _b[colgrad]*1  + _b[black]*1 + _b[hispanic]*0 + _b[_cons]
display normal(msb1)
* Probability of that Ms.B smokes is 14.37% and effect of smoking ban on 
* probaility of smoking is a decrease of 3.29%
