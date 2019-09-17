*setting up Stata

capture log close /* in case a log file is open from previous use */

*Desktop
cd "C:\Users\User\Documents\teaching\4G03\2016-4G03\Stata-Labs\Lab3\" 
*Surface
*cd "C:\Users\arthur\Documents\teaching\4G03\2016-4G03\Stata-Labs\Lab3\" 
*KTH B123
* cd f:\
* changes Stata's default directory. The Default Directory is displayed 
* in the lower left of the "main" stata screen. 

log using Econ4G03-Lab3.log, replace text
capture drop _all
pause on
use "lfs2000feb"

replace sex = 0 if sex == 2
rename sex male
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

g lnAge = ln(age)
g age2 = age*age
g age3 = age2*age
g age4 = age2*age2

* or, more work but maybe clearer
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

sum hrlyearn, d
drop if hrlyearn==.
rename hrlyearn hrearn
replace hrearn = hrearn/100
g lnearn = ln(hrearn)


* ****************** 
* making a working dataset
* sometimes useful to have intermediate *.dta files
keep lnearn age age2 age3 age4 lnAge male urb nf-ab
capture save using lfsFeb2000-Working1, replace
* ****************** 

reg lnearn age     				male urb nf-ab
preserve 
collapse lnearn age age2 age3 age4 lnAge male urb nf-ab
expand 40
replace age = _n + 24
capture drop linear
predict linear
twoway line linear age
pause
keep age linear
sort age
save AgePlot , replace
restore

reg lnearn age age2 			male urb nf-ab
preserve 
collapse lnearn age age2 age3 age4 lnAge male urb nf-ab
expand 40
replace age = _n + 24
replace age2 = age*age
capture drop quad
predict quad
twoway line quad age
pause
sort age
merge age using AgePlot
keep age linear quad 
sort age
save  AgePlot, replace 
twoway line quad linear age
pause
restore


/*

reg lnearn age age2 age3		male urb nf-ab
predict cubic

reg lnearn age age2 age3 age4   male urb nf-ab
predict quartic

reg lnearn age lnAge            male urb nf-ab
predict lnLinear

*/

log close
* 
