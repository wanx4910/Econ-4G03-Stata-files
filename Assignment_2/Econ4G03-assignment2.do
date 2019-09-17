
capture drop _all
cd "/Volumes/NO NAME/Econ 4G03/Assignment 2" 
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
g age2 = age*age
rename hrlyearn hrearn
g byte earnflag = 0
replace earnflag = 1 if hrearn ~= .
replace earnflag = . if lfsstat >=3
drop if earn~=1
g lnearn = ln(hrearn)
*Question 1
*Part a
g elementary = 0
replace elementary = 1 if educ90==0
g somesecondary = 0
replace somesecondary = 1 if educ90==1
g highschoolgrad = 0
replace highschoolgrad = 1 if educ90==2
g somepostsecondary = 0
replace somepostsecondary = 1 if educ90==3
g postsecondarycert = 0
replace postsecondarycert = 1 if educ90==4
g bachelordegree = 0
replace bachelordegree = 1 if educ90==5
g graduatedegree = 0
replace graduatedegree = 1 if educ90==6
*Generating dummy variables for each education level in the EDUC90 dataset
*Part b
reg lnearn age age2 male elementary somesecondary somepostsecondary postsecondarycert bachelordegree graduatedegree urb nf-ab
*Frish-Waugh Theorem
*Step 1
reg male age age2 elementary somesecondary somepostsecondary postsecondarycert bachelordegree graduatedegree urb nf-ab
*Frish-Waugh Theorem
predict double uhat, residuals
*Step 2
reg lnearn age age2 elementary somesecondary somepostsecondary postsecondarycert bachelordegree graduatedegree urb nf-ab
*Frish-Waugh Theorem
predict double uhat2, residuals
*Step 3 
reg uhat2 uhat
