*setting up Stata

capture log close /* in case a log file is open from previous use */

cd "C:\Users\User\Documents\teaching\4G03\2016-4G03\Stata\Lab1" 
* cd f:\
* changes Stata's default directory. The Default Directory is displayed 
* in the lower left of the "main" stata screen. 

log using Econ4G03-Lab1.log, replace text
* The *.log file captures Stata's output in plain text format. 
* An alterantive format is *.smcl. smcl format allows colour and 
* some slightly fancier formating. 

capture drop _all
* There are various "parts" (partitions) of memory in Stata. 
* The "drops" all data in memory, 
* but leaves macros, regression results etc. in place 

set more on /* automatically on, but in case i turned it off earlier. 
			Stops stata after each page of output to allow us to read */
** When "more" appears hit any key to continue (after "clicking into" the command box)

pause on 
/* this is normally a programming command, 
but I use "pause" for pedagogical purposes. It temporarily stops (pauses) 
execution to allow the user to explore the data at her/his leisure. */
** After the "pause" command executed you need to type  "q" or "exit" to continue
** (after "clicking into" the command box)
** but before you continue you can execute other commands from the command line 
** to explore the data yourselves

* The "use" command loads the data into memory. (NOTE: Stata is case sensitive.)
* Make sure the data file is in the default directory, or include the full path 
* to the data in advance of the filename.
use "lfs2000feb"

* This is Statistics Canada's Labour Force Survey data for Feb 2000 
* (why Feb 2000? why not?)
* The "codebook" (sometimes called a record layout) for the data is in an 
* Excel file "lfs1999to2001rcl.xls" on Avenue.
* You will need to look at this codebook to understand the data.

* Executing some simple commands in Stata
describe
desc
*See: Stata allows abbreviations (I like abbreviations, 
* although they can be tough for new learners).
summarize
sum
* again, I like abbreviations

* Do you understand what the desc & sum commands are producing?
* If not, then use the help files and Stata manuals. 

* notice name of variable sex is about to change in variables window

* Also, not that you "sum" (summarize) continuous variables and/or discrete vars
* but you only use teh tab (tablulate) command for discrete variables. 
tab sex 

* changing the value of the elements of the variable
* NOTE: Each varaible is a VECTOR!! (not a scalar)
* THis changes the value of each element of the vector 
* where the "if" condition is true.
replace sex = 0 if sex == 2

* Renaming the variable
rename sex male
tab male
* Compare this tablulate output to that for the varialbe sex above.

tab male, m
** NOTICE: in this case the ", m" does nothing since no missing observations
** Let's create some to see what happens 
g male2 = male
* uniform() is a function that generates a uniform random number between 0 and 1 
* set seed - sets the seed for the ranom number generator.
* YOu get random numbers, but the SAME random numbers each execution
* which helps in replications & pedegogy. 
set seed 2222
replace male2 = . if uniform()<0.1
* uniform() draws uniformly distributed random numbers between 0 & 1
* So we just set 10% of male variable obervations to missing, "." is missing
tab male2 male, m
list male male2 in 1/25 
list male male2 if male2 > 1 in 1/25
list male male2 if male2 > 1000000 in 1/25
* CAREFUL!!!  THis can lead to errors if not careful!!
* missing (i.e., ".") is treated like positive infinity by Stata.
pause
drop male2

* single, in statscan parlance, means never married
tab marstat
g single = 0 
replace single = 1 if marstat == 6 
desc single

* what does the compress command do? Use the help file/manual to find out.
compress single 
desc single
pause

* more sophisticated way of generating variable
* could have done "g single = marstat==2" above
* can do more complex boolean expressions using &'s and |'s (and's and or's)
* sophisticated can sometimes be dangerous
tab cma 
* NOtice that I'm using Boolean algebra here. In Stata "~" means "not"
* oddly, in Stata "!" also means not; so != and ~= both mean "not equal".

* Why does Stata use 2 equals signs after cma? DIfferent from 1 equals sign!!
* "==" means test and see if the RHS equals the LHS --> gives boolean result
* of true (i.e., 1) or false (i.e., 0).

* In contrast, the single equals sign after urb means "set the variable on the
* LHS equal to the variable on the RHS". It does this observation by observation
* for the entire vector of values that is the variable "urb".

* YOU NEED TO GET USED TO THINKING IN TERMS OF VECTORS OF DATA!!

g byte urb = ~(cma==4)

* If you have not already done so, use the "Data Editor (Browse)" to 
* look at the data once the "pause" occurs.
pause

* could use age_6 to get finer detail on young end
* using midpoints:  might be better to use a series of dummy variables, but
* 1) want to demonstate continuous variables
* 2) people commonly use midpoints
* 3) continuous variables maybe better if short on degrees of freedom
* Std errors are slightly wrong if use mid-points 
*  (introducing measurement error) , usually ignored
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

g age2 = age * age
tab age
tab age2
pause

* Pretend this is a nice linear variable. 

* fast way of doing this, but lose nice names
tab prov, g(prov)
desc prov*
tab prov prov1
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
pause

rename hrlyearn hrearn
sum hrearn
replace hrearn = hrearn/100
list hrearn in 1/10
* discuss missing
* WARNING: missing == positive infinity !!!
* so if use condition such as "... if x> 12" then missing is larger than 12
** CAREFUL 
pause

g byte earnflag = 0
replace earnflag = 1 if hrearn ~= .
replace earnflag = . if lfsstat >=3
tab lfsstat earnflag, m
tab earnflag, sum(hrearn)
pause

label define statlbl 1 "E" 2 "E, Absent" 3 "U, temp" 4 "U" 5 "U, FJS" 6 "NLF"
label values lfsstat statlbl
tab lfsstat earnflag, row m
pause

* **************************************************************
* OLS REGRESSIONS
* **************************************************************
drop if earn~=1

* use ln == natural logarithm in wage regressions to:
* 1)  make the error term more "normal"
* 2)  alleviate heteroskedasticity  (can see as an aspect of first)
g lnearn = ln(hrearn)

* break someplace in here 
*tab hrearn

sum hrearn lnearn
* The option "d" (options go after commas in commands) is short for "details"
sum hrearn lnearn, d
reg hrearn age age2 male urb nf-ab
hettest
pause

reg lnearn age age2 male urb nf-ab
hettest
pause 
 
reg lnearn age age2 male urb nf-ab, vce(robust)
pause 

* notice coef. on age2
g a2_100 = age2/100
reg lnearn age a2_100 male urb nf-ab, vce(robust)
pause

g lnAge = ln(age)
reg lnearn lnAge male urb nf-ab, vce(robust)
pause

log close
*

/*
*More advanced material to be explored some other time (maybe next course)

* The LFS is not a simple random sample but a stratified, cluster non-random one.
* It has a very complex survey design!
* To recover population parameters, need to use the survey weights.
* Otherwise, looking at sample, not population, parameters.
sum weight, d

* notice large cities undersampled ==> larger weights
svyset _n [pweight=weight] 
tab male urb, cell
svy: tab male urb, count cell 
pause 

* purposely leaving ALL provs in regression to let stata drop one
* to avoid perfect multicollinearity
* possible to have "small sample collinearity" 
* Stata automatically drops missing values from regression
* better to have control over what is dropped and do it yourself
probit  earn age age2 male urb prov1-prov10             [pw=weight], vce(robust)
pause
dprobit earn age age2 male urb prov1-prov5 prov7-prov10 [pw=weight], vce(robust)
pause

* last of probits until near end of course if time


*/ 
