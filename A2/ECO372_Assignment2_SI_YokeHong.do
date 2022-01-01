/* 	=============================================================
	This is the template do-file for ECO372 Assignment 2. Before 
	anything else, rename this file, 
	changing "SURNAME" to your ACORN surname, and "Firstname" to 
	your ACORN first name. Use _ for spaces.
	
	For me, it would be: ECO372_Assignment2_BLANCHENAY_Patrick.do

	Comment your code, explain what steps you are doing. 
	You can insert comments before the instruction, or at the 
	end of lines.
	
	You should also use indentation to make your code easy to read.
	
	Remember that running this do-file does not save it.
	============================================================= */
	
											
/* 	=============================================================
	THINGS TO CHANGE
	============================================================= */

// Working directory:  This is the folder where your do-file and dataset are located
cd "D:\UofT\Y2 Winter\ECO372\A2"

// SURNAME (Last name) as on ACORN (replace BLANCHENAY)
local surname SI // One word only

// First name as on ACORN (replace Patrick)
local firstname Yoke Hong // Only the first of your given names, as it appears on ACORN

// Student number, replace 12345678 by your student number, without quotes
local studentnumber 1005815806

/* 	=============================================================
	Do not change the commands below
	============================================================= */
cap log close _all // closes any previously opened log files
log using "ECO372_Assignment2_`surname'_`firstname'.log", replace text 	// This log file will be regenerated every time you run the do-file
set more off 	// This tells Stata to automatically continue if displays exceed screen capacity, instead of making the user click
clear			// Removes any data from memory every time this script is run.
set seed `studentnumber' // Fixes randomization issues
display "ECO372_Assignment2 " _n "`surname' `firstname' `studentnumber'" _n c(current_date) c(current_time)
																		

/* 	====================================
	============ EXERCISE  =============
	==================================== */

use "datasets/LaLonde_experimental.dta", clear			
datasignature										// checks data integrity			

// your code for the Exercise questions a-f goes below this

// part a.
reg age treat
reg education treat
reg black treat
reg hispanic treat
reg married treat
reg nodegree treat
ttest nodegree, by(treat) unequal

// part b.
reg re78 treat, robust

// part c.
gen age_squared = age^2
reg re78 treat age age_squared education black hispanic nodegree, robust
reg re78 treat age age_squared education black hispanic, robust

// part d.
reg re78 treat age age_squared education black hispanic nodegree

// part f.
ttest re78, by(treat) unequal

use "datasets/LaLonde_PSID3.dta", clear			
datasignature										// checks data integrity			

// your code for the Exercise questions g-l goes below this

// part h.
reg age treat
reg education treat
reg black treat
reg hispanic treat
reg married treat
reg nodegree treat

// part i.
gen age_squared = age^2 // generating age squared variable
reg re78 treat age age_squared education black hispanic nodegree, robust

// part j.
gen earningsgrowth = re78 - re75
reg earningsgrowth age education black hispanic married nodegree if treat == 0, robust

// part k.

reg earningsgrowth treat age age_squared, robust





/* 	=============================================================
	============ 	FINAL COMMANDS 	(do not change)	============
	============================================================= */
log close				// closes your log file
/* 	=============================================================
	============ 			END OF SCRIPT			 ============
	============================================================= */
