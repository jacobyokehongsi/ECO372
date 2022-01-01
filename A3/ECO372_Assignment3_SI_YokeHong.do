/* 	=============================================================
	This is the template do-file for Patrick Blanchenay's 
	ECO372 Assignment 3. Before anything else, rename this file, 
	changing "SURNAME" to your ACORN surname, and "Firstname" to 
	your ACORN first name. Use _ for spaces.
	
	For me, it would be: ECO372_Assignment2_BLANCHENAY_Patrick.do

	Comment your code, explain what steps you are doing. 
	You can insert comments before the instruction, or at the 
	end of lines.
	
	You should also use indentation to make your code easy to read.
	
	Remember that running this do-file does not save it.
	============================================================= */
	
											
/* =============================================================
	THINGS TO CHANGE
	============================================================= */

// Working directory:  This is the folder where your do-file and dataset are located
cd "D:\UofT\Y2 Winter\ECO372\A3"

// SURNAME (Last name) as on ACORN (replace BLANCHENAY)
local surname SI // One word only

// First name as on ACORN (replace Patrick)
local firstname YokeHong // Only the fist of your given names, as it appears on ACORN

// Student number, replace 12345678 by your student number, without quotes
local studentnumber 1005815806

/* 	=============================================================
	Do not change the following commands
	============================================================= */
cap log close _all // closes any previously opened log files
set seed `studentnumber'
log using "ECO372_Assignment3_`surname'_`firstname'.log", replace text 	// This log file will be regenerated everytime you run the do-file
set more off 	// This tells Stata to automatically continue if displays exceed screen capacity, instead of making user click
clear			// Removes any data from memory every time this script is run.
display "ECO372_Assignment3 " _n "`surname' `firstname' `studentnumber'" _n c(current_date) c(current_time)
																		


/* 	====================================
	============ EXERCISE  1  ============
	==================================== */

use "datasets/Angrist_etal_Columbia2002_1.dta", clear		// Loads the file
datasignature												// checks data integrity			

// your code for the Exercise questions a-e goes here

// question a. ii.
count if id

// question a. iii, iv
describe
// vouch0
// math
// reading
// writing
// totalpts

// question b.
summarize math reading writing

// question c.
reg totalpts vouch0 i.t_site, robust // regressing total points on vouch. allocation
estimates store OLSTotalPoints

reg math vouch0 i.t_site, robust // regressing math points on vouch. allocation
estimates store OLSMath

reg reading vouch0 i.t_site, robust // regressing reading points on vouch. allocation
estimates store OLSReading

reg writing vouch0 i.t_site, robust // regressing writing points on vouch. allocation
estimates store OLSWriting

// data tabulation
esttab OLSTotalPoints OLSMath OLSReading OLSWriting using "OLSPointsData.rtf", drop(*t_site _cons) ///
	label ///
	replace mtitles("Total Points" "Math Scores" "Reading Scores" "Writing Scores") 



// question d. 
reg totalpts vouch0 age sex mom_sch dad_sch strata svy hsvisit, robust // regressing total points on vouch. allocation controlling for several variables
estimates store OLSCovTotalPts
esttab OLSCovTotalPts using "OLSCovTotalPointsData.rtf", drop(age sex mom_sch dad_sch strata svy hsvisit _cons) ///
	label ///
	replace mtitles("Total Points") 




use "datasets/Angrist_etal_Columbia2002_2.dta", clear		// Loads the file
datasignature												// checks data integrity			

// your code for the Exercise questions f-l goes here

// question f. 
summarize
describe
// 1135 // (i)
// vouch0 // (ii)
// usesch // (iii)
// scyfnsh inschl // (iv)


// question g.
reg scyfnsh vouch0 svy hsvisit age sex i.strata i.month, robust
estimates store OLSHighestGrade
reg inschl vouch0 svy hsvisit age sex i.strata i.month, robust
estimates store OLSInSchl

esttab OLSHighestGrade OLSInSchl using "OLSHighestGradeInSchPartG.rtf", drop(svy hsvisit age sex *strata *month _cons) ///
	label ///
	replace mtitles("Highest Grade Achieved by Student" "School Status at Time of Survey")
	

// question j.
reg scyfnsh usesch svy hsvisit age sex i.strata i.month, robust
estimates store OLSHighestGradeUsedVouch

ivregress 2sls scyfnsh (usesch = vouch0) svy hsvisit age sex i.strata i.month, robust
estimates store IVHighestGradeUsedVouch

esttab OLSHighestGradeUsedVouch IVHighestGradeUsedVouch using "OLSandIV.rtf", drop(svy hsvisit age sex *strata *month _cons) ///
	label ///
	replace mtitles("OLS with controls" "IV with controls") ///
	addnote("Dependent variable: Highest Grade Completed")
	

// question k.
reg scyfnsh usesch svy hsvisit age sex i.strata i.month, robust // regression to determine t statistic


// question l.
reg inschl usesch svy hsvisit age sex i.strata i.month, robust // regression to determine t statistic







/* 	=============================================================
	============ 	FINAL COMMANDS 	(do not change)	============
	============================================================= */
log close				// closes your log file
/* 	=============================================================
	============ 			END OF SCRIPT			 ============
	============================================================= */
