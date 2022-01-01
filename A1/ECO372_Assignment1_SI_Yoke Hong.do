/* 	=============================================================
	This is the template do-file for Patrick Blanchenay's 
	ECO372 Assignment 1. Before anything else, rename this file, 
	changing "SURNAME" to your ACORN surname, and "Firstname" to 
	your ACORN first name. Use _ for spaces.
	
	For me, it would be: ECO372_Assignment1_BLANCHENAY_Patrick.do

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
cd "D:\UofT\Y2 Winter\ECO372\Assignment 1"

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
log using "ECO372_Assignment1_`surname'_`firstname'.log", replace text 	// This log file will be regenerated every time you run the do-file
set more off 	// This tells Stata to automatically continue if displays exceed screen capacity, instead of making the user click
clear			// Removes any data from memory every time this script is run.
set seed `studentnumber' // Fixes randomization issues
display "ECO372_Assignment1 " _n "`surname' `firstname' `studentnumber'" _n c(current_date) c(current_time)
																		

/* 	====================================
	============ EXERCISE  =============
	==================================== */

use "datasets/BurdeLinden_2013.dta", clear			
datasignature										// checks data integrity			

// your code for the Exercise questions goes below this
describe // question b (i), (ii)
browse // question b (iii), (v) and (vi)


count if treatment == 1 // question b.(iv) no. of participants in village with school
count if treatment == 0 // question b.(iv) no. of participants in village without school

graph bar f07_both_norma_total, over(treatment) // question d bar graph where 0 is control and 1 is treatment

ttest f07_both_norma_total, by(treatment) unequal // question e, conducting ttest for test scores of both genders

kdensity f07_both_norma_total if f07_girl_cnt == 1, title("Fall 2007 test scores for girls only") // question h, distribution of Fall 2007 test scores for girls only

// some additional data to help answer question h
tabulate f07_girl_cnt
count if treatment == 1 & f07_girl_cnt == 1 // no. of girls who receive treatment
count if treatment == 0 & f07_girl_cnt == 1 // no. of girls who did not receive treatment

ttest f07_both_norma_total if f07_girl_cnt == 1, by(treatment) unequal // question i, ttest for test scores of girls

ttest f07_yrs_ed_head_cnt, by(treatment) unequal // question k, ttest for level of education head of household

// question l, generating variables
generate randvar = runiform(0,1)
generate randvar1 = 1 if randvar >= 0.5
replace randvar1 = 0 if randvar < 0.5
count if randvar1 == 1
count if randvar1 == 0

ttest f07_both_norma_total, by(randvar1) unequal // question m, ttest for generated variables

/* 	=============================================================
	============ 	FINAL COMMANDS 	(do not change)	============
	============================================================= */
log close				// closes your log file
/* 	=============================================================
	============ 			END OF SCRIPT			 ============
	============================================================= */
