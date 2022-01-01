/* 	=============================================================
	This is the template do-file for Patrick Blanchenay's 
	ECO372 Assignment 4. Before anything else, rename this file, 
	changing "SURNAME" to your ACORN surname, and "Firstname" to 
	your ACORN first name. Use _ for spaces.
	
	For me, it would be: ECO372_Assignment4_BLANCHENAY_Patrick.do

	Comment your code, explain what steps you are doing. 
	You can insert comments before the instruction, or at the 
	end of lines.
	
	You should also use indentation to make your code easy to read.
	
	Remember that running this do-file does not save it.
	============================================================= */
log close _all 														// closes any previously opened log file	

/* =============================================================
	THINGS TO CHANGE
	============================================================= */

// Working directory:  This is the folder where your do-file and dataset are located
cd "D:\UofT\Y2 Winter\ECO372\A4"

// SURNAME (Last name) as on ACORN (replace BLANCHENAY)
local surname Si // One word only

// First name as on ACORN (replace Patrick)
local firstname YokeHong // Only the fist of your given names, as it appears on ACORN

// Student number, replace 12345678 by your student number, without quotes
local studentnumber 1005815806

																		
/* 	=============================================================
	Do not change these commands
	============================================================= */
cap log close
log using "ECO372_Assignment4_`surname'_`firstname'.log", replace text 	// This log file will regenerated everytime you run the do-file
set more off 	// This tells Stata to automatically continue if displays exceed screen capacity, instead of making user click
clear			// Removes any data from memory every time this script is run.
display "ECO372_Assignment4 " _n "`surname' `firstname' `studentnumber'" _n c(current_date) c(current_time)

/* 	=============================================================
	============ EXERCISE 1 ============
	============================================================= */

use "datasets/AganStarr2018.dta", clear			// If your files are placed correctly, you should not need to change that 
datasignature									// checks data integrity													

// YOUR COMMANDS FOR EXERCISE 1 GO HERE

// question a.
summarize
// (ii) 14,637 observations
describe
// (iii) posresponse, interview
// (iv)
count if posresponse == 1 & interview == 1 // 928
count if posresponse == 1 // 1,715
// 928/1,715 
// (v) crime, white, empgap, ged
// (vi) pre or post; unsure
// (vii) box

// question b.
// table white, contents(mean pre mean post)
//
// tabstat white empgap ged crime box, stat(mean)
summarize white crime ged empgap box posresponse interview if post==0
summarize white crime ged empgap box posresponse interview if post==1

// question c.
reg post white, robust
reg post crime, robust
reg post ged, robust
reg post empgap, robust
reg post box, robust

// question d.
reg posresponse white crime ged empgap pre i.chain_id i.center, vce(cluster chain_id)
estimates store column_one
reg posresponse white crime ged empgap i.chain_id i.center if box==1, vce(cluster chain_id)
estimates store column_two
esttab column_one column_two using "question d.rtf", drop(*.chain_id *.center _cons) label replace mtitles("Sample: All" "Sample: Box") stats(N, labels("N"))

// xtset center chain_id pre
// xtreg posresponse white crime ged empgap pre i.chain_id i.center, fe vce(cluster chain_id)

// xtset idcode year
// xtreg ln_wage tenure, fe vce(cluster idcode)
// xtreg ln_wage tenure i.year, fe vce(cluster idcode)

// question e.
reg interview white crime ged empgap pre i.chain_id i.center, vce(cluster chain_id)
estimates store column_1
reg interview white crime ged empgap i.chain_id i.center if box==1, vce(cluster chain_id)
estimates store column_2
esttab column_1 column_2 using "question e.rtf", drop(*.chain_id *.center _cons) label replace mtitles("Sample: All" "Sample Box") stats(N, labels("N"))

// question g.
// balanced

// question h.
gen interact = box * white
// col 1
reg posresponse interact white box ged empgap i.center if post==0, vce(cluster chain_id)
estimates store col_1
// col 2
reg posresponse interact white box ged empgap if remover==1 & balanced==1, vce(cluster chain_id)
estimates store col_2
// col 3
reg posresponse interact white box ged empgap i.center if remover==1, vce(cluster chain_id)
estimates store col_3
// col 5
gen interact_5 = white * pre
reg posresponse interact_5 white pre ged empgap if balanced==1 & remover==0, vce(cluster chain_id)
estimates store col_5
// esttabing
esttab col_1 col_2 col_3 col_5 using "question h.rtf", drop(ged empgap *.center _cons) label replace mtitles("Cross-section" "Temporal" "Temporal" "None") stats(N, labels("N"))


// question i.
// col 1
reg interview interact white box ged empgap i.center if post==0, vce(cluster chain_id)
estimates store intcol_1
// col 2
reg interview interact white box ged empgap if remover==1 & balanced==1, vce(cluster chain_id)
estimates store intcol_2
// col 3
reg interview interact white box ged empgap i.center if remover==1, vce(cluster chain_id)
estimates store intcol_3
// col 5
reg interview interact_5 white pre ged empgap if balanced==1 & remover==0, vce(cluster chain_id)
estimates store intcol_5
// esttabing
esttab intcol_1 intcol_2 intcol_3 intcol_5 using "question i.rtf", drop(ged empgap *.center _cons) label replace mtitles("Cross-section" "Temporal" "Temporal" "None") stats(N, labels("N"))

// question j.

// question k.


/* 	=============================================================
	============ 	FINAL COMMANDS 	(do not change)	============
	============================================================= */
	
log close
graph close _all

/* 	=============================================================
	============ 			END OF SCRIPT			 ============
	============================================================= */
