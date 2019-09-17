* Part d
capture log close
cd "/Volumes/NO NAME/Econ 4G03/Assignment 4" 
log using Econ4G03-Assign4-q4.log, replace text
capture drop _all 
set obs 21580
g byte on = 0
replace on = 1 in 1/9465
g immig = 1 in 1/5040
replace immig = 1 in 9466/13920
replace immig = 0 if immig == .
tab immig
tab on
g byte matched = 0
replace matched = 1 in 1/1330
replace matched = 1 in 5041/7020
replace matched = 1 in 9466/10625
replace matched = 1 in 13921/18920
replace matched = 0 if matched == .
tab matched 
g onimmig = on * immig 
reg matched on immig onimmig
* The coefficient on the onimmig coefficient is positive which shows that
* immigrants in ontario are being matched more frequently compared to immigrants
* who are not residing in Ontario. The t stat on the onimmig is 16.08 which is 
* greater than 1.96 therefore the difference is statistically significant.
* Part e
* There are advantages to using Stata to do more in-depth analysis of this data
* as using stata allows for accurate computation of statistical parameters of 
* interest. However, the ability of stata to compute the correct results is 
* highly dependent on the ability of the researcher to write the program in a 
* way that is valid statistically as computers are machines that cannot 
* interpret the difference between what the programmer meant vs what the
* programmer actually wrote in code.
