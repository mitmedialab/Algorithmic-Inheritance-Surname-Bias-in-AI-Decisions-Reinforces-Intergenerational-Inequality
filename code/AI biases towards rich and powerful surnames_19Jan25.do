**AI Discrimination**

**Thai surnames - no profiles

cap cd "/Users/nattavudhpowdthavee/Library/CloudStorage/Dropbox/AI discrimination/Data/Data v2/"

import delimited Thai_processed_output_lastnames.csv, clear 

gen Thai = 1

save Thai_noprofile.dta, replace

**US surnames
import delimited US_processed_output_lastnames.csv, clear 


gen US = 1

save US_noprofile.dta, replace

append using Thai_noprofile.dta

*Clean
encode category, gen(cat)

replace cat = 0 if cat == 3
replace cat = 7 if cat == 4
lab def cat_name 0 "Common surnames" 1 "Legacy surnames" 2 "Legacy variants" 5 "Rich surnames" 6 "Rich variants" 7 "Common variants"
lab val cat cat_name

*Label
lab var powerful_mean "Perceived power"
lab var rich_mean "Perceived wealth"
lab var smart_mean "Perceived intelligence"
lab var commonality_mean "Perceived commonality"

gen Legacy_R = cat==1
lab var Legacy_R "Legacy surnames"
gen Legacy_V = cat==2
lab var Legacy_V "Legacy variants"
gen Rich_R = cat==5
lab var Rich_R "Rich surnames"
gen Rich_V = cat==6
lab var Rich_V "Rich variants"
gen Common_V = cat==7
lab var Common_V "Common variants"

save merged_noprofile.dta, replace

eststo clear

**Predicting rich, powerful, smart, and commonality
*Thailand
asdocx reg powerful_mean Legacy_R Legacy_V Rich_R Rich_V Common_V  if Thai==1, vce(bootstrap, reps(1000)) save(Table1_Thailand.docx) title(Perceived power: Thailand) label fs(9) replace
eststo Powerful_T
asdocx  reg rich_mean Legacy_R Legacy_V Rich_R Rich_V Common_V  if Thai==1, vce(bootstrap, reps(1000)) save(Table1_Thailand.docx)  title(Perceived wealth: Thailand) label fs(9) append
eststo Rich_T
asdocx reg smart_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if Thai==1, vce(bootstrap, reps(1000))  save(Table1_Thailand.docx)  title(Perceived intelligence: Thailand) label fs(9) append
eststo Smart_T
asdocx reg commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if Thai==1, vce(bootstrap, reps(1000))  save(Table1_Thailand.docx)  title(Perceived commonality: Thailand) label fs(9) append
eststo Commonality_T


*US
asdocx reg powerful_mean Legacy_R Legacy_V Rich_R Rich_V Common_V  if US==1, vce(bootstrap, reps(1000)) save(Table1_US.docx) title(Perceived power: US) label fs(9) replace
eststo Powerful_U
asdocx  reg rich_mean Legacy_R Legacy_V Rich_R Rich_V Common_V  if US==1, vce(bootstrap, reps(1000)) save(Table1_US.docx)  title(Perceived wealth: US) label fs(9) append
eststo Rich_U
asdocx reg smart_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if US==1, vce(bootstrap, reps(1000))  save(Table1_US.docx)  title(Perceived intelligence: US) label fs(9) append
eststo Smart_U
asdocx reg commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if US==1, vce(bootstrap, reps(1000))  save(Table1_US.docx)  title(Perceived commonality: US) label fs(9) append
eststo Commonality_U


*coefplot Powerful_T Rich_T Smart_T   , drop(_cons)  xline(0)

coefplot (Powerful_T, label("Perceived power"))  , bylabel(Thailand) /// 
		 || (Powerful_U, label("Perceived power"))  , bylabel(USA) ///
		 ||, keep( Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))   legend(size(small))  xtitle("Coefficient size") ytitle("Surname categories") title("Perceived power", size(small))  
		  	  
graph save "merged_noprofile_power.gph", replace

coefplot  (Rich_T, label("Perceived wealth"))  , bylabel(Thailand) /// 
		 ||  (Rich_U, label("Perceived wealth"))  , bylabel(USA) ///
		 ||, keep( Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale)  legend(size(small))  xtitle("Coefficient size") ytitle("Surname categories") title("Perceived wealth", size(small))

graph save "merged_noprofile_rich.gph", replace

coefplot  (Smart_T, label("Perceived intelligence")), bylabel(Thailand) /// 
		 ||  (Smart_U, label("Perceived intelligence")), bylabel(USA) ///
		 ||, keep( Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale)  legend(size(small))  xtitle("Coefficient size") ytitle("Surname categories") title("Perceived intelligence", size(small))

graph save "merged_noprofile_smart.gph", replace

coefplot  (Commonality_T, label("Perceived commonality")), bylabel(Thailand) /// 
		 ||  (Commonality_U, label("Perceived commonality")), bylabel(USA) ///
		 ||, keep( Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale)  legend(size(small))  xtitle("Coefficient size") ytitle("Surname categories") title("Perceived commonality", size(small))

graph save "merged_noprofile_commonality.gph", replace

graph combine "merged_noprofile_power.gph" "merged_noprofile_rich.gph"  "merged_noprofile_smart.gph" "merged_noprofile_commonality.gph", col(2)  iscale(0.7)
graph export "noprofile_1.pdf", replace
graph export "noprofile_1.png", replace
 
*Figure 1.2: Reduced form
*Thailand
asdocx reg exec_hire_mean  Legacy_R Legacy_V Rich_R Rich_V Common_V   if Thai==1, vce(bootstrap, reps(1000)) save(Table1_2_Thailand.docx) title(Executive hiring: Thailand) label fs(9) replace
eststo Exec_hire_T

asdocx reg leadership_mean  Legacy_R Legacy_V Rich_R Rich_V Common_V   if Thai==1, vce(bootstrap, reps(1000)) save(Table1_2_Thailand.docx) title(Leadership: Thailand) label fs(9) append
eststo Leadership_T

asdocx reg entry_hire_mean  Legacy_R Legacy_V Rich_R Rich_V Common_V   if Thai==1, vce(bootstrap, reps(1000)) save(Table1_2_Thailand.docx) title(Entry hire: Thailand) label fs(9) append
eststo Entry_hire_T

asdocx reg international_school_mean  Legacy_R Legacy_V Rich_R Rich_V Common_V   if Thai==1, vce(bootstrap, reps(1000)) save(Table1_2_Thailand.docx) title(International school admission: Thailand) label fs(9) append
eststo InterSchool_T

asdocx reg political_career_mean  Legacy_R Legacy_V Rich_R Rich_V Common_V  if Thai==1, vce(bootstrap, reps(1000)) save(Table1_2_Thailand.docx) title(Political career: Thailand) label fs(9) append
eststo Politics_T

asdocx reg loan_approve_mean   Legacy_R Legacy_V Rich_R Rich_V Common_V   if Thai==1, vce(bootstrap, reps(1000)) save(Table1_2_Thailand.docx) title(Loan approval: Thailand) label fs(9) append 
eststo Loan_T

*USA
asdocx reg exec_hire_mean  Legacy_R Legacy_V Rich_R Rich_V Common_V   if US==1, vce(bootstrap, reps(1000)) save(Table1_2_US.docx) title(Executive hiring: US) label fs(9) replace
eststo Exec_hire_U

asdocx reg leadership_mean  Legacy_R Legacy_V Rich_R Rich_V Common_V   if US==1, vce(bootstrap, reps(1000)) save(Table1_2_US.docx) title(Leadership: US) label fs(9)append
eststo Leadership_U

asdocx reg entry_hire_mean  Legacy_R Legacy_V Rich_R Rich_V Common_V   if US==1, vce(bootstrap, reps(1000)) save(Table1_2_US.docx) title(Entry hire: US) label fs(9) append
eststo Entry_hire_U

asdocx reg international_school_mean  Legacy_R Legacy_V Rich_R Rich_V Common_V   if US==1, vce(bootstrap, reps(1000)) save(Table1_2_US.docx) title(International school admission: US) label fs(9) append
eststo InterSchool_U

asdocx reg political_career_mean  Legacy_R Legacy_V Rich_R Rich_V Common_V   if US==1, vce(bootstrap, reps(1000)) save(Table1_2_US.docx) title(Political career: US) label fs(9) append
eststo Politics_U

asdocx reg loan_approve_mean   Legacy_R Legacy_V Rich_R Rich_V Common_V   if US==1, vce(bootstrap, reps(1000)) save(Table1_2_US.docx) title(Loan approval: US) label fs(9) append
eststo Loan_U

**Coefplot 

coefplot (Exec_hire_T, label("Exec hire")) , bylabel(Thailand) /// 
		 || (Exec_hire_U, label("Exec hire")) , bylabel(USA) ///
		 ||, drop(_cons) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small)) title("Executive hire", size(small))

graph save "merged_noprofile_exec_hire_rf.gph", replace
		 
coefplot  ( Leadership_T, label("Leadership")), bylabel(Thailand) /// 
		 ||  (Leadership_U, label("Leadership"))  , bylabel(USA) ///
		 ||, drop(_cons   ) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small))  title("Leadership", size(small))

graph save "merged_noprofile_leadership_rf.gph", replace

coefplot  (Entry_hire_T, label("Entry hire")), bylabel(Thailand) /// 
		 ||  (Entry_hire_U, label("Entry hire")), bylabel(USA) ///
		 ||, drop(_cons   ) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small)) title("Entry hire", size(small))
		 
graph save "merged_noprofile_entry_hire_rf.gph", replace
		
coefplot  (InterSchool_T, label("Inter School")), bylabel(Thailand) /// 
		 ||  (InterSchool_U, label("Inter School")), bylabel(USA) ///
		 ||, drop(_cons    ) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small))	title("International school", size(small))	
		
graph save "merged_noprofile_interschool_rf.gph", replace		
		
coefplot (Politics_T, label("Politics Career")), bylabel(Thailand) /// 
		 || (Politics_U, label("Politics Career")) , bylabel(USA) ///
		 ||, drop(_cons   ) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small)) title("Political career", size(small))	
		
graph save "merged_noprofile_politics_rf.gph", replace			
		
coefplot  (Loan_T, label("Loan Approval")), bylabel(Thailand) /// 
		 ||   (Loan_U, label("Loan Approval")), bylabel(USA) ///
		 ||, drop(_cons) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small))	title("Loan approval", size(small))	

graph save "merged_noprofile_loan_rf.gph", replace				 
		 
graph combine "merged_noprofile_exec_hire_rf.gph" "merged_noprofile_leadership_rf.gph" "merged_noprofile_entry_hire_rf.gph" "merged_noprofile_interschool_rf.gph" ///
 "merged_noprofile_politics_rf.gph" "merged_noprofile_loan_rf.gph", col(2)  iscale(0.7)
 
graph export "noprofile_rf.pdf", replace
graph export "noprofile_rf.png", replace

 
u merged_noprofile.dta, clear
drop if US==1
wyoung powerful_mean rich_mean smart_mean commonality_mean, cmd(reg OUTCOMEVAR  Legacy_R Legacy_V Rich_R Rich_V Common_V) bootstraps(1000) familyp(Legacy_R Legacy_V Rich_R Rich_V Common_V) seed(124)  

matrix list r(table)
putexcel set wyoung_thai_noprof.xlsx, replace
putexcel A1=matrix(r(table)) 

u merged_noprofile.dta, clear
drop if Thai==1
wyoung powerful_mean rich_mean smart_mean commonality_mean, cmd(reg OUTCOMEVAR  Legacy_R Legacy_V Rich_R Rich_V Common_V) bootstraps(1000) familyp(Legacy_R Legacy_V Rich_R Rich_V Common_V) seed(124)  

matrix list r(table)
putexcel set wyoung_US_noprof.xlsx, replace
putexcel A1=matrix(r(table)) 


u merged_noprofile.dta, clear

**Predicting other forms of judgment
*Thailand
asdocx reg exec_hire_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if Thai==1, vce(bootstrap, reps(1000)) save(Table2_Thailand.docx) title(Executive hiring: Thailand) label fs(9) replace
eststo Exec_hire_T

asdocx reg leadership_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if Thai==1, vce(bootstrap, reps(1000)) save(Table2_Thailand.docx) title(Leadership: Thailand) label fs(9) append
eststo Leadership_T

asdocx reg entry_hire_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if Thai==1, vce(bootstrap, reps(1000)) save(Table2_Thailand.docx) title(Entry hire: Thailand) label fs(9) append
eststo Entry_hire_T

asdocx reg international_school_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if Thai==1, vce(bootstrap, reps(1000)) save(Table2_Thailand.docx) title(International school admission: Thailand) label fs(9) append
eststo InterSchool_T

asdocx reg political_career_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if Thai==1, vce(bootstrap, reps(1000)) save(Table2_Thailand.docx) title(Political career: Thailand) label fs(9) append
eststo Politics_T

asdocx reg loan_approve_mean  powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if Thai==1, vce(bootstrap, reps(1000)) save(Table2_Thailand.docx) title(Loan approval: Thailand) label fs(9) append 
eststo Loan_T

*USA
asdocx reg exec_hire_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if US==1, vce(bootstrap, reps(1000)) save(Table2_US.docx) title(Executive hiring: US) label fs(9) replace
eststo Exec_hire_U

asdocx reg leadership_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if US==1, vce(bootstrap, reps(1000)) save(Table2_US.docx) title(Leadership: US) label fs(9)append
eststo Leadership_U

asdocx reg entry_hire_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if US==1, vce(bootstrap, reps(1000)) save(Table2_US.docx) title(Entry hire: US) label fs(9) append
eststo Entry_hire_U

asdocx reg international_school_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if US==1, vce(bootstrap, reps(1000)) save(Table2_US.docx) title(International school admission: US) label fs(9) append
eststo InterSchool_U

asdocx reg political_career_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if US==1, vce(bootstrap, reps(1000)) save(Table2_US.docx) title(Political career: US) label fs(9) append
eststo Politics_U

asdocx reg loan_approve_mean  powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if US==1, vce(bootstrap, reps(1000)) save(Table2_US.docx) title(Loan approval: US) label fs(9) append
eststo Loan_U

**Coefplot 

coefplot (Exec_hire_T, label("Exec hire")) , bylabel(Thailand) /// 
		 || (Exec_hire_U, label("Exec hire")) , bylabel(USA) ///
		 ||, drop(_cons Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small)) title("Executive hire", size(small))

graph save "merged_noprofile_exec_hire.gph", replace
		 
coefplot  ( Leadership_T, label("Leadership")), bylabel(Thailand) /// 
		 ||  (Leadership_U, label("Leadership"))  , bylabel(USA) ///
		 ||, drop(_cons Legacy_R Legacy_V Rich_R Rich_V Common_V  ) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small))  title("Leadership", size(small))

graph save "merged_noprofile_leadership.gph", replace

coefplot  (Entry_hire_T, label("Entry hire")), bylabel(Thailand) /// 
		 ||  (Entry_hire_U, label("Entry hire")), bylabel(USA) ///
		 ||, drop(_cons Legacy_R Legacy_V Rich_R Rich_V Common_V  ) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small)) title("Entry hire", size(small))
		 
graph save "merged_noprofile_entry_hire.gph", replace
		
coefplot  (InterSchool_T, label("Inter School")), bylabel(Thailand) /// 
		 ||  (InterSchool_U, label("Inter School")), bylabel(USA) ///
		 ||, drop(_cons Legacy_R Legacy_V Rich_R Rich_V Common_V  ) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small))	title("International school", size(small))	
		
graph save "merged_noprofile_interschool.gph", replace		
		
coefplot (Politics_T, label("Politics Career")), bylabel(Thailand) /// 
		 || (Politics_U, label("Politics Career")) , bylabel(USA) ///
		 ||, drop(_cons Legacy_R Legacy_V Rich_R Rich_V Common_V  ) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small)) title("Political career", size(small))	
		
graph save "merged_noprofile_politics.gph", replace			
		
coefplot  (Loan_T, label("Loan Approval")), bylabel(Thailand) /// 
		 ||   (Loan_U, label("Loan Approval")), bylabel(USA) ///
		 ||, drop(_cons Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small))	title("Loan approval", size(small))	

graph save "merged_noprofile_loan.gph", replace				 
		 
graph combine "merged_noprofile_exec_hire.gph" "merged_noprofile_leadership.gph" "merged_noprofile_entry_hire.gph" "merged_noprofile_interschool.gph" ///
 "merged_noprofile_politics.gph" "merged_noprofile_loan.gph", col(2)  iscale(0.7)
 
graph export "noprofile_2.pdf", replace
graph export "noprofile_2.png", replace
		

coefplot (Exec_hire_T, label("Exec hire")) , bylabel(Thailand) /// 
		 || (Exec_hire_U, label("Exec hire")) , bylabel(USA) ///
		 ||, keep(Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Surname categories", size(small))   title("Executive hire", size(small))

graph save "merged_noprofile_exec_hire_b.gph", replace
		 
coefplot  ( Leadership_T, label("Leadership")), bylabel(Thailand) /// 
		 ||  (Leadership_U, label("Leadership"))  , bylabel(USA) ///
		 ||, keep(Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Surname categories", size(small))   title("Leadership", size(small))

graph save "merged_noprofile_leadership_b.gph", replace

coefplot  (Entry_hire_T, label("Entry hire")), bylabel(Thailand) /// 
		 ||  (Entry_hire_U, label("Entry hire")), bylabel(USA) ///
		 ||, keep(Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Surname categories", size(small)) title("Entry hire", size(small))
		 
graph save "merged_noprofile_entry_hire_b.gph", replace
		
coefplot  (InterSchool_T, label("Inter School")), bylabel(Thailand) /// 
		 ||  (InterSchool_U, label("Inter School")), bylabel(USA) ///
		 ||, keep(Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Surname categories", size(small)) 	title("International school", size(small))	
		
graph save "merged_noprofile_interschool_b.gph", replace		
		
coefplot (Politics_T, label("Politics Career")), bylabel(Thailand) /// 
		 || (Politics_U, label("Politics Career")) , bylabel(USA) ///
		 ||, keep(Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Surname categories", size(small)) title("Political career", size(small))	
		
graph save "merged_noprofile_politics_b.gph", replace			
		
coefplot  (Loan_T, label("Loan Approval")), bylabel(Thailand) /// 
		 ||   (Loan_U, label("Loan Approval")), bylabel(USA) ///
		 ||, keep(Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Surname categories", size(small)) 	title("Loan approval", size(small))	

graph save "merged_noprofile_loan_b.gph", replace				 
		 
graph combine "merged_noprofile_exec_hire_b.gph" "merged_noprofile_leadership_b.gph" "merged_noprofile_entry_hire_b.gph" "merged_noprofile_interschool_b.gph" ///
 "merged_noprofile_politics_b.gph" "merged_noprofile_loan_b.gph", col(2)  iscale(0.7)
 
graph export "noprofile_3.pdf", replace
graph export "noprofile_3.png", replace
		  
 
u merged_noprofile.dta, clear
drop if Thai==1
wyoung exec_hire_mean leadership_mean entry_hire_mean international_school_mean political_career_mean loan_approve_mean, cmd(reg OUTCOMEVAR powerful_mean rich_mean smart_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean) bootstraps(1000) familyp(powerful_mean rich_mean smart_mean) seed(124)  

matrix list r(table)
putexcel set wyoung_thai_noprof2.xlsx, replace
putexcel A1=matrix(r(table)) 

u merged_noprofile.dta, clear
drop if US==1
wyoung exec_hire_mean leadership_mean entry_hire_mean international_school_mean political_career_mean loan_approve_mean, cmd(reg OUTCOMEVAR powerful_mean rich_mean smart_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean) bootstraps(1000) familyp(powerful_mean rich_mean smart_mean) seed(124)  

matrix list r(table)
putexcel set wyoung_US_noprof2.xlsx, replace
putexcel A1=matrix(r(table)) 


log using medsem.log, replace

u merged_noprofile.dta, clear
keep if Thai==1 
**Mediation analysis
 
bootstrap , reps(1000): sem 	(exec_hire_mean  leadership_mean  entry_hire_mean international_school_mean political_career_mean loan_approve_mean <-  powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V ) ///	
		(powerful_mean <- Legacy_R Legacy_V Rich_R Rich_V Common_V  ) ///
		(rich_mean <- Legacy_R Legacy_V Rich_R Rich_V Common_V  ) ///
		(smart_mean <- Legacy_R Legacy_V Rich_R Rich_V Common_V  ) ///
		(commonality_mean <- Legacy_R Legacy_V Rich_R Rich_V Common_V  ), nocapslatent

		log close
		
*Exec_hire		
asdoc medsem, indep(Legacy_R) med(powerful_mean) dep(exec_hire_mean) zlc rid , save(medsem_exec_hire_thai.doc) title(Legacy-Powerful)  replace
asdoc medsem, indep(Legacy_R) med(rich_mean) dep(exec_hire_mean) zlc rid, save(medsem_exec_hire_thai.doc) title(Legacy-Rich) append
asdoc medsem, indep(Legacy_R) med(smart_mean) dep(exec_hire_mean) zlc rid, save(medsem_exec_hire_thai.doc) title(Legacy-Smart) append
asdoc medsem, indep(Rich_R) med(powerful_mean) dep(exec_hire_mean) zlc rid, save(medsem_exec_hire_thai.doc) title(Rich-Powerful) append
asdoc medsem, indep(Rich_R) med(rich_mean) dep(exec_hire_mean) zlc rid, save(medsem_exec_hire_thai.doc) title(Rich-Rich) append
asdoc medsem, indep(Rich_R) med(smart_mean) dep(exec_hire_mean) zlc rid, save(medsem_exec_hire_thai.doc) title(Rich-Smart) append
*Leadership
asdoc medsem, indep(Legacy_R) med(powerful_mean) dep(leadership_mean) zlc rid, save(medsem_leader_thai.doc) title(Legacy-Powerful) replace	
asdoc medsem, indep(Legacy_R) med(rich_mean) dep(leadership_mean) zlc rid, save(medsem_leader_thai.doc) title(Legacy-Rich) append
asdoc medsem, indep(Legacy_R) med(smart_mean) dep(leadership_mean) zlc rid, save(medsem_leader_thai.doc) title(Legacy-Smart) append
asdoc medsem, indep(Rich_R) med(powerful_mean) dep(leadership_mean) zlc rid, save(medsem_leader_thai.doc) title(Rich-Powerful) append
asdoc medsem, indep(Rich_R) med(rich_mean) dep(leadership_mean) zlc rid, save(medsem_leader_thai.doc) title(Rich-Rich) append
asdoc medsem, indep(Rich_R) med(smart_mean) dep(leadership_mean) zlc rid, save(medsem_leader_thai.doc) title(Rich-Smart) append	
*Entry hire
asdoc medsem, indep(Legacy_R) med(powerful_mean) dep(entry_hire_mean) zlc rid, save(medsem_entry_thai.doc) title(Legacy-Powerful) replace			
asdoc medsem, indep(Legacy_R) med(rich_mean) dep(entry_hire_mean) zlc rid, save(medsem_entry_thai.doc) title(Legacy-Rich) append
asdoc medsem, indep(Legacy_R) med(smart_mean) dep(entry_hire_mean) zlc rid, save(medsem_entry_thai.doc) title(Legacy-Smart) append
asdoc medsem, indep(Rich_R) med(powerful_mean) dep(entry_hire_mean) zlc rid, save(medsem_entry_thai.doc) title(Rich-Powerful) append
asdoc medsem, indep(Rich_R) med(rich_mean) dep(entry_hire_mean) zlc rid, save(medsem_entry_thai.doc) title(Rich-Rich) append
asdoc medsem, indep(Rich_R) med(smart_mean) dep(entry_hire_mean) zlc rid, save(medsem_entry_thai.doc) title(Rich-Smart) append
*InterSchool
asdoc medsem, indep(Legacy_R) med(powerful_mean) dep(international_school_mean) zlc rid, save(medsem_interschool_thai.doc) title(Legacy-Powerful) replace		
asdoc medsem, indep(Legacy_R) med(rich_mean) dep(international_school_mean) zlc rid, save(medsem_interschool_thai.doc) title(Legacy-Rich) append
asdoc medsem, indep(Legacy_R) med(smart_mean) dep(international_school_mean) zlc rid, save(medsem_interschool_thai.doc) title(Legacy-Smart) append
asdoc medsem, indep(Rich_R) med(powerful_mean) dep(international_school_mean) zlc rid, save(medsem_interschool_thai.doc) title(Rich-Powerful) append
asdoc medsem, indep(Rich_R) med(rich_mean) dep(international_school_mean) zlc rid, save(medsem_interschool_thai.doc) title(Rich-Rich) append
asdoc medsem, indep(Rich_R) med(smart_mean) dep(international_school_mean) zlc rid, save(medsem_interschool_thai.doc) title(Rich-Smart) append
*Political career
asdoc medsem, indep(Legacy_R) med(powerful_mean) dep(political_career_mean) zlc rid, save(medsem_politics_thai.doc) title(Legacy-Powerful) replace		
asdoc medsem, indep(Legacy_R) med(rich_mean) dep(political_career_mean) zlc rid, save(medsem_politics_thai.doc) title(Legacy-Rich) append
asdoc medsem, indep(Legacy_R) med(smart_mean) dep(political_career_mean) zlc rid, save(medsem_politics_thai.doc) title(Legacy-Smart) append
asdoc medsem, indep(Rich_R) med(powerful_mean) dep(political_career_mean) zlc rid, save(medsem_politics_thai.doc) title(Rich-Powerful) append
asdoc medsem, indep(Rich_R) med(rich_mean) dep(political_career_mean) zlc rid, save(medsem_politics_thai.doc) title(Rich-Rich) append
asdoc medsem, indep(Rich_R) med(smart_mean) dep(political_career_mean) zlc rid, save(medsem_politics_thai.doc) title(Rich-Smart) append	
*Loan		
asdoc medsem, indep(Legacy_R) med(powerful_mean) dep(loan_approve_mean) zlc rid, save(medsem_loan_thai.doc) title(Legacy-Powerful) replace		
asdoc medsem, indep(Legacy_R) med(rich_mean) dep(loan_approve_mean) zlc rid, save(medsem_loan_thai.doc) title(Legacy-Rich) append
asdoc medsem, indep(Legacy_R) med(smart_mean) dep(loan_approve_mean) zlc rid, save(medsem_loan_thai.doc) title(Legacy-Smart) append
asdoc medsem, indep(Rich_R) med(powerful_mean) dep(loan_approve_mean) zlc rid, save(medsem_loan_thai.doc) title(Rich-Powerful) append
asdoc medsem, indep(Rich_R) med(rich_mean) dep(loan_approve_mean) zlc rid, save(medsem_loan_thai.doc) title(Rich-Rich) append
asdoc medsem, indep(Rich_R) med(smart_mean) dep(loan_approve_mean) zlc rid, save(medsem_loan_thai.doc) title(Rich-Smart) append		  

log using medsem.log, append

u merged_noprofile.dta, clear
keep if Thai==.
**Mediation analysis
 
bootstrap , reps(1000): sem 	(exec_hire_mean  leadership_mean  entry_hire_mean international_school_mean political_career_mean loan_approve_mean <-  powerful_mean rich_mean smart_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean) ///	
		(powerful_mean <- Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean) ///
		(rich_mean <- Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean) ///
		(smart_mean <- Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean) , nocapslatent

log close
		
*Exec_hire		
asdoc medsem, indep(Legacy_R) med(powerful_mean) dep(exec_hire_mean) zlc rid , save(medsem_exec_hire_US.doc) title(Legacy-Powerful)  replace
asdoc medsem, indep(Legacy_R) med(rich_mean) dep(exec_hire_mean) zlc rid, save(medsem_exec_hire_US.doc) title(Legacy-Rich) append
asdoc medsem, indep(Legacy_R) med(smart_mean) dep(exec_hire_mean) zlc rid, save(medsem_exec_hire_US.doc) title(Legacy-Smart) append
asdoc medsem, indep(Rich_R) med(powerful_mean) dep(exec_hire_mean) zlc rid, save(medsem_exec_hire_US.doc) title(Rich-Powerful) append
asdoc medsem, indep(Rich_R) med(rich_mean) dep(exec_hire_mean) zlc rid, save(medsem_exec_hire_US.doc) title(Rich-Rich) append
asdoc medsem, indep(Rich_R) med(smart_mean) dep(exec_hire_mean) zlc rid, save(medsem_exec_hire_US.doc) title(Rich-Smart) append
*Leadership
asdoc medsem, indep(Legacy_R) med(powerful_mean) dep(leadership_mean) zlc rid, save(medsem_leader_US.doc) title(Legacy-Powerful) replace	
asdoc medsem, indep(Legacy_R) med(rich_mean) dep(leadership_mean) zlc rid, save(medsem_leader_US.doc) title(Legacy-Rich) append
asdoc medsem, indep(Legacy_R) med(smart_mean) dep(leadership_mean) zlc rid, save(medsem_leader_US.doc) title(Legacy-Smart) append
asdoc medsem, indep(Rich_R) med(powerful_mean) dep(leadership_mean) zlc rid, save(medsem_leader_US.doc) title(Rich-Powerful) append
asdoc medsem, indep(Rich_R) med(rich_mean) dep(leadership_mean) zlc rid, save(medsem_leader_US.doc) title(Rich-Rich) append
asdoc medsem, indep(Rich_R) med(smart_mean) dep(leadership_mean) zlc rid, save(medsem_leader_US.doc) title(Rich-Smart) append	
*Entry hire
asdoc medsem, indep(Legacy_R) med(powerful_mean) dep(entry_hire_mean) zlc rid, save(medsem_entry_US.doc) title(Legacy-Powerful) replace			
asdoc medsem, indep(Legacy_R) med(rich_mean) dep(entry_hire_mean) zlc rid, save(medsem_entry_US.doc) title(Legacy-Rich) append
asdoc medsem, indep(Legacy_R) med(smart_mean) dep(entry_hire_mean) zlc rid, save(medsem_entry_US.doc) title(Legacy-Smart) append
asdoc medsem, indep(Rich_R) med(powerful_mean) dep(entry_hire_mean) zlc rid, save(medsem_entry_US.doc) title(Rich-Powerful) append
asdoc medsem, indep(Rich_R) med(rich_mean) dep(entry_hire_mean) zlc rid, save(medsem_entry_US.doc) title(Rich-Rich) append
asdoc medsem, indep(Rich_R) med(smart_mean) dep(entry_hire_mean) zlc rid, save(medsem_entry_US.doc) title(Rich-Smart) append
*InterSchool
asdoc medsem, indep(Legacy_R) med(powerful_mean) dep(international_school_mean) zlc rid, save(medsem_interschool_US.doc) title(Legacy-Powerful) replace		
asdoc medsem, indep(Legacy_R) med(rich_mean) dep(international_school_mean) zlc rid, save(medsem_interschool_US.doc) title(Legacy-Rich) append
asdoc medsem, indep(Legacy_R) med(smart_mean) dep(international_school_mean) zlc rid, save(medsem_interschool_US.doc) title(Legacy-Smart) append
asdoc medsem, indep(Rich_R) med(powerful_mean) dep(international_school_mean) zlc rid, save(medsem_interschool_US.doc) title(Rich-Powerful) append
asdoc medsem, indep(Rich_R) med(rich_mean) dep(international_school_mean) zlc rid, save(medsem_interschool_US.doc) title(Rich-Rich) append
asdoc medsem, indep(Rich_R) med(smart_mean) dep(international_school_mean) zlc rid, save(medsem_interschool_US.doc) title(Rich-Smart) append
*Political career
asdoc medsem, indep(Legacy_R) med(powerful_mean) dep(political_career_mean) zlc rid, save(medsem_politics_US.doc) title(Legacy-Powerful) replace		
asdoc medsem, indep(Legacy_R) med(rich_mean) dep(political_career_mean) zlc rid, save(medsem_politics_US.doc) title(Legacy-Rich) append
asdoc medsem, indep(Legacy_R) med(smart_mean) dep(political_career_mean) zlc rid, save(medsem_politics_US.doc) title(Legacy-Smart) append
asdoc medsem, indep(Rich_R) med(powerful_mean) dep(political_career_mean) zlc rid, save(medsem_politics_US.doc) title(Rich-Powerful) append
asdoc medsem, indep(Rich_R) med(rich_mean) dep(political_career_mean) zlc rid, save(medsem_politics_US.doc) title(Rich-Rich) append
asdoc medsem, indep(Rich_R) med(smart_mean) dep(political_career_mean) zlc rid, save(medsem_politics_US.doc) title(Rich-Smart) append	
*Loan		
asdoc medsem, indep(Legacy_R) med(powerful_mean) dep(loan_approve_mean) zlc rid, save(medsem_loan_US.doc) title(Legacy-Powerful) replace		
asdoc medsem, indep(Legacy_R) med(rich_mean) dep(loan_approve_mean) zlc rid, save(medsem_loan_US.doc) title(Legacy-Rich) append
asdoc medsem, indep(Legacy_R) med(smart_mean) dep(loan_approve_mean) zlc rid, save(medsem_loan_US.doc) title(Legacy-Smart) append
asdoc medsem, indep(Rich_R) med(powerful_mean) dep(loan_approve_mean) zlc rid, save(medsem_loan_US.doc) title(Rich-Powerful) append
asdoc medsem, indep(Rich_R) med(rich_mean) dep(loan_approve_mean) zlc rid, save(medsem_loan_US.doc) title(Rich-Rich) append
asdoc medsem, indep(Rich_R) med(smart_mean) dep(loan_approve_mean) zlc rid, save(medsem_loan_US.doc) title(Rich-Smart) append		  

 

**Analyse with bad profiles
 
import delimited Thai_processed_output_bad_profiles.csv, clear 

gen Thai = 1

save Thai_badprofile.dta, replace

**US surnames
import delimited US_processed_output_bad_profiles.csv, clear 


gen US = 1

save US_noprofile.dta, replace

append using Thai_badprofile.dta

*Clean
encode category, gen(cat)

replace cat = 0 if cat == 3
replace cat = 7 if cat == 4
lab def cat_name 0 "Common surnames" 1 "Legacy surnames" 2 "Legacy variants" 5 "Rich surnames" 6 "Rich variants" 7 "Common variants"
lab val cat cat_name

*Label
lab var powerful_mean "Perceived power"
lab var rich_mean "Perceived wealth"
lab var smart_mean "Perceived intelligence"

gen Legacy_R = cat==1
lab var Legacy_R "Legacy surnames"
gen Legacy_V = cat==2
lab var Legacy_V "Legacy variants"
gen Rich_R = cat==5
lab var Rich_R "Rich surnames"
gen Rich_V = cat==6
lab var Rich_V "Rich variants"
gen Common_V = cat==7
lab var Common_V "Common variants"

save merged_badprofile.dta, replace



eststo clear

**Predicting rich, powerful, smart, and commonality
*Thailand
asdocx reg powerful_mean Legacy_R Legacy_V Rich_R Rich_V Common_V  if Thai==1, vce(bootstrap, reps(1000)) save(Table3_Thailand.docx) title(Perceived power: Thailand) label fs(9) replace
eststo Powerful_T
asdocx  reg rich_mean Legacy_R Legacy_V Rich_R Rich_V Common_V  if Thai==1, vce(bootstrap, reps(1000)) save(Table3_Thailand.docx)  title(Perceived wealth: Thailand) label fs(9) append
eststo Rich_T
asdocx reg smart_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if Thai==1, vce(bootstrap, reps(1000))  save(Table3_Thailand.docx)  title(Perceived intelligence: Thailand) label fs(9) append
eststo Smart_T
asdocx reg commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if Thai==1, vce(bootstrap, reps(1000))  save(Table3_Thailand.docx)  title(Perceived commonality: Thailand) label fs(9) append
eststo Commonality_T


*US
asdocx reg powerful_mean Legacy_R Legacy_V Rich_R Rich_V Common_V  if US==1, vce(bootstrap, reps(1000)) save(Table3_US.docx) title(Perceived power: US) label fs(9) replace
eststo Powerful_U
asdocx  reg rich_mean Legacy_R Legacy_V Rich_R Rich_V Common_V  if US==1, vce(bootstrap, reps(1000)) save(Table3_US.docx)  title(Perceived wealth: US) label fs(9) append
eststo Rich_U
asdocx reg smart_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if US==1, vce(bootstrap, reps(1000))  save(Table3_US.docx)  title(Perceived intelligence: US) label fs(9) append
eststo Smart_U
asdocx reg commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if US==1, vce(bootstrap, reps(1000))  save(Table3_US.docx)  title(Perceived commonality: US) label fs(9) append
eststo Commonality_U


*coefplot Powerful_T Rich_T Smart_T   , drop(_cons)  xline(0)

coefplot (Powerful_T, label("Perceived power"))  , bylabel(Thailand) /// 
		 || (Powerful_U, label("Perceived power"))  , bylabel(USA) ///
		 ||, keep( Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))   legend(size(small))  xtitle("Coefficient size") ytitle("Surname categories") title("Perceived power", size(small)) 
		  
graph save "merged_badprofile_power.gph", replace

coefplot  (Rich_T, label("Perceived wealth"))  , bylabel(Thailand) /// 
		 ||  (Rich_U, label("Perceived wealth"))  , bylabel(USA) ///
		 ||, keep( Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale)  legend(size(small))  xtitle("Coefficient size") ytitle("Surname categories") title("Perceived wealth", size(small))

graph save "merged_badprofile_rich.gph", replace

coefplot  (Smart_T, label("Perceived intelligence")), bylabel(Thailand) /// 
		 ||  (Smart_U, label("Perceived intelligence")), bylabel(USA) ///
		 ||, keep( Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale)  legend(size(small))  xtitle("Coefficient size") ytitle("Surname categories") title("Perceived intelligence", size(small))

graph save "merged_badprofile_smart.gph", replace

coefplot  (Commonality_T, label("Perceived commonality")), bylabel(Thailand) /// 
		 ||  (Commonality_U, label("Perceived commonality")), bylabel(USA) ///
		 ||, keep( Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale)  legend(size(small))  xtitle("Coefficient size") ytitle("Surname categories") title("Perceived commonality", size(small))

graph save "merged_badprofile_commonality.gph", replace

graph combine "merged_badprofile_power.gph" "merged_badprofile_rich.gph"  "merged_badprofile_smart.gph" "merged_badprofile_commonality.gph", col(2)  iscale(0.7)
graph export "badprofile_1.pdf", replace
graph export "badprofile_1.png", replace
 

**Predicting other forms of judgment
*Thailand
asdocx reg exec_hire_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if Thai==1, vce(bootstrap, reps(1000)) save(Table4_Thailand.docx) title(Executive hiring: Thailand) label fs(9) replace
eststo Exec_hire_T

asdocx reg leadership_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if Thai==1, vce(bootstrap, reps(1000)) save(Table4_Thailand.docx) title(Leadership: Thailand) label fs(9) append
eststo Leadership_T

asdocx reg entry_hire_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if Thai==1, vce(bootstrap, reps(1000)) save(Table4_Thailand.docx) title(Entry hire: Thailand) label fs(9) append
eststo Entry_hire_T

asdocx reg international_school_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if Thai==1, vce(bootstrap, reps(1000)) save(Table4_Thailand.docx) title(International school admission: Thailand) label fs(9) append
eststo InterSchool_T

asdocx reg political_career_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if Thai==1, vce(bootstrap, reps(1000)) save(Table4_Thailand.docx) title(Political career: Thailand) label fs(9) append 
eststo Politics_T

asdocx reg loan_approve_mean  powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if Thai==1, vce(bootstrap, reps(1000)) save(Table4_Thailand.docx) title(Loan approval: Thailand) label fs(9) append 
eststo Loan_T

*USA
asdocx reg exec_hire_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if US==1, vce(bootstrap, reps(1000)) save(Table4_US.docx) title(Executive hiring: US) label fs(9) replace
eststo Exec_hire_U

asdocx reg leadership_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if US==1, vce(bootstrap, reps(1000)) save(Table4_US.docx) title(Leadership: US) label fs(9) append
eststo Leadership_U

asdocx reg entry_hire_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if US==1, vce(bootstrap, reps(1000)) save(Table4_US.docx) title(Entry hire: US) label fs(9) append
eststo Entry_hire_U

asdocx reg international_school_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if US==1, vce(bootstrap, reps(1000)) save(Table4_US.docx) title(International school admission: US) label fs(9) append
eststo InterSchool_U

asdocx reg political_career_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if US==1, vce(bootstrap, reps(1000)) save(Table4_US.docx) title(Political career: US) label fs(9) append
eststo Politics_U

asdocx reg loan_approve_mean  powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if US==1, vce(bootstrap, reps(1000)) save(Table4_US.docx) title(Loan approval: US) label fs(9) append
eststo Loan_U

**Coefplot 

coefplot (Exec_hire_T, label("Exec hire")) , bylabel(Thailand) /// 
		 || (Exec_hire_U, label("Exec hire")) , bylabel(USA) ///
		 ||, drop(_cons Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small)) title("Executive hire", size(small))

graph save "merged_badprofile_exec_hire.gph", replace
		 
coefplot  ( Leadership_T, label("Leadership")), bylabel(Thailand) /// 
		 ||  (Leadership_U, label("Leadership"))  , bylabel(USA) ///
		 ||, drop(_cons Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small))  title("Leadership", size(small))

graph save "merged_badprofile_leadership.gph", replace

coefplot  (Entry_hire_T, label("Entry hire")), bylabel(Thailand) /// 
		 ||  (Entry_hire_U, label("Entry hire")), bylabel(USA) ///
		 ||, drop(_cons Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small)) title("Entry hire", size(small))
		 
graph save "merged_badprofile_entry_hire.gph", replace
		
coefplot  (InterSchool_T, label("Inter School")), bylabel(Thailand) /// 
		 ||  (InterSchool_U, label("Inter School")), bylabel(USA) ///
		 ||, drop(_cons Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small))	title("International school", size(small))	
		
graph save "merged_badprofile_interschool.gph", replace		
		
coefplot (Politics_T, label("Politics Career")), bylabel(Thailand) /// 
		 || (Politics_U, label("Politics Career")) , bylabel(USA) ///
		 ||, drop(_cons Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small)) title("Political career", size(small))	
		
graph save "merged_badprofile_politics.gph", replace			
		
coefplot  (Loan_T, label("Loan Approval")), bylabel(Thailand) /// 
		 ||   (Loan_U, label("Loan Approval")), bylabel(USA) ///
		 ||, drop(_cons Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small))	title("Loan approval", size(small))	

graph save "merged_badprofile_loan.gph", replace				 
		 
graph combine "merged_badprofile_exec_hire.gph" "merged_badprofile_leadership.gph" "merged_badprofile_entry_hire.gph" "merged_badprofile_interschool.gph" ///
 "merged_badprofile_politics.gph" "merged_badprofile_loan.gph", col(2)  iscale(0.7)
 
graph export "badprofile_2.pdf", replace
graph export "badprofile_2.png", replace
		 
coefplot (Exec_hire_T, label("Exec hire")) , bylabel(Thailand) /// 
		 || (Exec_hire_U, label("Exec hire")) , bylabel(USA) ///
		 ||, keep(Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Surname categories", size(small))  title("Executive hire", size(small))

graph save "merged_badprofile_exec_hire_b.gph", replace
		 
coefplot  ( Leadership_T, label("Leadership")), bylabel(Thailand) /// 
		 ||  (Leadership_U, label("Leadership"))  , bylabel(USA) ///
		 ||, keep(Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Surname categories", size(small))   title("Leadership", size(small))

graph save "merged_badprofile_leadership_b.gph", replace

coefplot  (Entry_hire_T, label("Entry hire")), bylabel(Thailand) /// 
		 ||  (Entry_hire_U, label("Entry hire")), bylabel(USA) ///
		 ||, keep(Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Surname categories", size(small))  title("Entry hire", size(small))
		 
graph save "merged_badprofile_entry_hire_b.gph", replace
		
coefplot  (InterSchool_T, label("Inter School")), bylabel(Thailand) /// 
		 ||  (InterSchool_U, label("Inter School")), bylabel(USA) ///
		 ||, keep(Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Surname categories", size(small)) 	title("International school", size(small))	
		
graph save "merged_badprofile_interschool_b.gph", replace		
		
coefplot (Politics_T, label("Politics Career")), bylabel(Thailand) /// 
		 || (Politics_U, label("Politics Career")) , bylabel(USA) ///
		 ||, keep(Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Surname categories", size(small))  title("Political career", size(small))	
		
graph save "merged_badprofile_politics_b.gph", replace			
		
coefplot  (Loan_T, label("Loan Approval")), bylabel(Thailand) /// 
		 ||   (Loan_U, label("Loan Approval")), bylabel(USA) ///
		 ||, keep(Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Surname categories", size(small)) 	title("Loan approval", size(small))	

graph save "merged_badprofile_loan_b.gph", replace				 
		 
graph combine "merged_badprofile_exec_hire_b.gph" "merged_badprofile_leadership_b.gph" "merged_badprofile_entry_hire_b.gph" "merged_badprofile_interschool_b.gph" ///
 "merged_badprofile_politics_b.gph" "merged_badprofile_loan_b.gph", col(2)  iscale(0.7)
 
graph export "badprofile_3.pdf", replace
graph export "badprofile_3.png", replace


**Analyse with medium profiles
 
import delimited Thai_processed_output_medium_profiles.csv, clear 

gen Thai = 1

save Thai_mediumprofile.dta, replace

**US surnames
import delimited US_processed_output_medium_profiles.csv, clear 


gen US = 1

save US_noprofile.dta, replace

append using Thai_mediumprofile.dta

*Clean
encode category, gen(cat)

replace cat = 0 if cat == 3
replace cat = 7 if cat == 4
lab def cat_name 0 "Common surnames" 1 "Legacy surnames" 2 "Legacy variants" 5 "Rich surnames" 6 "Rich variants" 7 "Common variants"
lab val cat cat_name

*Label
lab var powerful_mean "Perceived power"
lab var rich_mean "Perceived wealth"
lab var smart_mean "Perceived intelligence"

gen Legacy_R = cat==1
lab var Legacy_R "Legacy surnames"
gen Legacy_V = cat==2
lab var Legacy_V "Legacy variants"
gen Rich_R = cat==5
lab var Rich_R "Rich surnames"
gen Rich_V = cat==6
lab var Rich_V "Rich variants"
gen Common_V = cat==7
lab var Common_V "Common variants"

save merged_mediumprofile.dta, replace



eststo clear

**Predicting rich, powerful, smart, and commonality
*Thailand
asdocx reg powerful_mean Legacy_R Legacy_V Rich_R Rich_V Common_V  if Thai==1, vce(bootstrap, reps(1000)) save(Table5_Thailand.docx) title(Perceived power: Thailand) label fs(9) replace
eststo Powerful_T
asdocx  reg rich_mean Legacy_R Legacy_V Rich_R Rich_V Common_V  if Thai==1, vce(bootstrap, reps(1000)) save(Table5_Thailand.docx)  title(Perceived wealth: Thailand) label fs(9) append
eststo Rich_T
asdocx reg smart_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if Thai==1, vce(bootstrap, reps(1000))  save(Table5_Thailand.docx)  title(Perceived intelligence: Thailand) label fs(9) append
eststo Smart_T
asdocx reg commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if Thai==1, vce(bootstrap, reps(1000))  save(Table5_Thailand.docx)  title(Perceived commonality: Thailand) label fs(9) append
eststo Commonality_T


*US
asdocx reg powerful_mean Legacy_R Legacy_V Rich_R Rich_V Common_V  if US==1, vce(bootstrap, reps(1000)) save(Table5_US.docx) title(Perceived power: US) label fs(9) replace
eststo Powerful_U
asdocx  reg rich_mean Legacy_R Legacy_V Rich_R Rich_V Common_V  if US==1, vce(bootstrap, reps(1000)) save(Table5_US.docx)  title(Perceived wealth: US) label fs(9) append
eststo Rich_U
asdocx reg smart_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if US==1, vce(bootstrap, reps(1000))  save(Table5_US.docx)  title(Perceived intelligence: US) label fs(9) append
eststo Smart_U
asdocx reg commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if US==1, vce(bootstrap, reps(1000))  save(Table5_US.docx)  title(Perceived commonality: US) label fs(9) append
eststo Commonality_U



*coefplot Powerful_T Rich_T Smart_T   , drop(_cons)  xline(0)

coefplot (Powerful_T, label("Perceived power"))  , bylabel(Thailand) /// 
		 || (Powerful_U, label("Perceived power"))  , bylabel(USA) ///
		 ||, keep( Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))   legend(size(small))  xtitle("Coefficient size") ytitle("Surname categories") title("Perceived power", size(small)) 
		  
graph save "merged_mediumprofile_power.gph", replace

coefplot  (Rich_T, label("Perceived wealth"))  , bylabel(Thailand) /// 
		 ||  (Rich_U, label("Perceived wealth"))  , bylabel(USA) ///
		 ||, keep( Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale)  legend(size(small))  xtitle("Coefficient size") ytitle("Surname categories") title("Perceived wealth", size(small))

graph save "merged_mediumprofile_rich.gph", replace

coefplot  (Smart_T, label("Perceived intelligence")), bylabel(Thailand) /// 
		 ||  (Smart_U, label("Perceived intelligence")), bylabel(USA) ///
		 ||, keep( Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale)  legend(size(small))  xtitle("Coefficient size") ytitle("Surname categories") title("Perceived intelligence", size(small))

graph save "merged_mediumprofile_smart.gph", replace

coefplot  (Commonality_T, label("Perceived comonality")), bylabel(Thailand) /// 
		 ||  (Commonality_U, label("Perceived commonality")), bylabel(USA) ///
		 ||, keep( Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale)  legend(size(small))  xtitle("Coefficient size") ytitle("Surname categories") title("Perceived commonality", size(small))

graph save "merged_mediumprofile_commonality.gph", replace


graph combine "merged_mediumprofile_power.gph" "merged_mediumprofile_rich.gph"  "merged_mediumprofile_smart.gph"  "merged_mediumprofile_commonality.gph", col(2)  iscale(0.7)
graph export "mediumprofile_1.pdf", replace
graph export "mediumprofile_1.png", replace

**Coefplot Commonality_T
coefplot (Commonality_T, label("Perceived commonality")), bylabel(Thailand) /// 
		 || (Commonality_U, label("Perceived commonality")) , bylabel(USA) ///
		 ||, keep( Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale)  legend(size(small))  xtitle("Coefficient size") ytitle("Surname categories")
		 
graph save "merged_mediumprofile_common.gph", replace
graph export "merged_mediumprofile_common.pdf",  replace
graph export "merged_mediumprofile_common.png",  replace
 
**Predicting other forms of judgment
*Thailand
asdocx reg exec_hire_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if Thai==1, vce(bootstrap, reps(1000)) save(Table6_Thailand.docx) title(Executive hiring: Thailand) label fs(9) replace
eststo Exec_hire_T

asdocx reg leadership_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if Thai==1, vce(bootstrap, reps(1000)) save(Table6_Thailand.docx) title(Leadership: Thailand) label fs(9) append
eststo Leadership_T

asdocx reg entry_hire_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if Thai==1, vce(bootstrap, reps(1000)) save(Table6_Thailand.docx) title(Entry hire: Thailand) label fs(9) append
eststo Entry_hire_T

asdocx reg international_school_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if Thai==1, vce(bootstrap, reps(1000)) save(Table6_Thailand.docx) title(International school admission: Thailand) label fs(9) append
eststo InterSchool_T

asdocx reg political_career_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if Thai==1, vce(bootstrap, reps(1000)) save(Table6_Thailand.docx) title(Political career: Thailand) label fs(9) append
eststo Politics_T

asdocx reg loan_approve_mean  powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if Thai==1, vce(bootstrap, reps(1000)) save(Table6_Thailand.docx) title(Loan approval: Thailand) label fs(9) append
eststo Loan_T

*USA
asdocx reg exec_hire_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if US==1, vce(bootstrap, reps(1000)) save(Table6_US.docx) title(Executive hiring: US) label fs(9) replace
eststo Exec_hire_U

asdocx reg leadership_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if US==1, vce(bootstrap, reps(1000)) save(Table6_US.docx) title(Leadership: US) label fs(9) append
eststo Leadership_U

asdocx reg entry_hire_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if US==1, vce(bootstrap, reps(1000)) save(Table6_US.docx) title(Entry hire: US) label fs(9) append
eststo Entry_hire_U

asdocx reg international_school_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if US==1, vce(bootstrap, reps(1000)) save(Table6_US.docx) title(International school admission: US) label fs(9) append
eststo InterSchool_U

asdocx reg political_career_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if US==1, vce(bootstrap, reps(1000)) save(Table6_US.docx) title(Political career: US) label fs(9) append
eststo Politics_U

asdocx reg loan_approve_mean  powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if US==1, vce(bootstrap, reps(1000)) save(Table6_US.docx) title(Loan approval: US) label fs(9) append
eststo Loan_U


**Coefplot 

coefplot (Exec_hire_T, label("Exec hire")) , bylabel(Thailand) /// 
		 || (Exec_hire_U, label("Exec hire")) , bylabel(USA) ///
		 ||, drop(_cons Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small)) title("Executive hire", size(small))

graph save "merged_mediumprofile_exec_hire.gph", replace
		 
coefplot  ( Leadership_T, label("Leadership")), bylabel(Thailand) /// 
		 ||  (Leadership_U, label("Leadership"))  , bylabel(USA) ///
		 ||, drop(_cons Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small))  title("Leadership", size(small))

graph save "merged_mediumprofile_leadership.gph", replace

coefplot  (Entry_hire_T, label("Entry hire")), bylabel(Thailand) /// 
		 ||  (Entry_hire_U, label("Entry hire")), bylabel(USA) ///
		 ||, drop(_cons Legacy_R Legacy_V Rich_R Rich_V Common_V ) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small)) title("Entry hire", size(small))
		 
graph save "merged_mediumprofile_entry_hire.gph", replace
		
coefplot  (InterSchool_T, label("Inter School")), bylabel(Thailand) /// 
		 ||  (InterSchool_U, label("Inter School")), bylabel(USA) ///
		 ||, drop(_cons Legacy_R Legacy_V Rich_R Rich_V Common_V ) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small))	title("International school", size(small))	
		
graph save "merged_mediumprofile_interschool.gph", replace		
		
coefplot (Politics_T, label("Politics Career")), bylabel(Thailand) /// 
		 || (Politics_U, label("Politics Career")) , bylabel(USA) ///
		 ||, drop(_cons Legacy_R Legacy_V Rich_R Rich_V Common_V ) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small)) title("Political career", size(small))	
		
graph save "merged_mediumprofile_politics.gph", replace			
		
coefplot  (Loan_T, label("Loan Approval")), bylabel(Thailand) /// 
		 ||   (Loan_U, label("Loan Approval")), bylabel(USA) ///
		 ||, drop(_cons Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small))	title("Loan approval", size(small))	

graph save "merged_mediumprofile_loan.gph", replace				 
		 
graph combine "merged_mediumprofile_exec_hire.gph" "merged_mediumprofile_leadership.gph" "merged_mediumprofile_entry_hire.gph" "merged_mediumprofile_interschool.gph" ///
 "merged_mediumprofile_politics.gph" "merged_mediumprofile_loan.gph", col(2)  iscale(0.7)
 
graph export "mediumprofile_2.pdf", replace
graph export "mediumprofile_2.png", replace		 
		 
coefplot (Exec_hire_T, label("Exec hire")) , bylabel(Thailand) /// 
		 || (Exec_hire_U, label("Exec hire")) , bylabel(USA) ///
		 ||, keep(Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Surname categories", size(small))  title("Executive hire", size(small))

graph save "merged_mediumprofile_exec_hire_b.gph", replace
		 
coefplot  ( Leadership_T, label("Leadership")), bylabel(Thailand) /// 
		 ||  (Leadership_U, label("Leadership"))  , bylabel(USA) ///
		 ||, keep(Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Surname categories", size(small))   title("Leadership", size(small))

graph save "merged_mediumprofile_leadership_b.gph", replace

coefplot  (Entry_hire_T, label("Entry hire")), bylabel(Thailand) /// 
		 ||  (Entry_hire_U, label("Entry hire")), bylabel(USA) ///
		 ||, keep(Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Surname categories", size(small))  title("Entry hire", size(small))
		 
graph save "merged_mediumprofile_entry_hire_b.gph", replace
		
coefplot  (InterSchool_T, label("Inter School")), bylabel(Thailand) /// 
		 ||  (InterSchool_U, label("Inter School")), bylabel(USA) ///
		 ||, keep(Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Surname categories", size(small)) 	title("International school", size(small))	
		
graph save "merged_mediumprofile_interschool_b.gph", replace		
		
coefplot (Politics_T, label("Politics Career")), bylabel(Thailand) /// 
		 || (Politics_U, label("Politics Career")) , bylabel(USA) ///
		 ||, keep(Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Surname categories", size(small))  title("Political career", size(small))	
		
graph save "merged_mediumprofile_politics_b.gph", replace			
		
coefplot  (Loan_T, label("Loan Approval")), bylabel(Thailand) /// 
		 ||   (Loan_U, label("Loan Approval")), bylabel(USA) ///
		 ||, keep(Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Surname categories", size(small)) 	title("Loan approval", size(small))	

graph save "merged_mediumprofile_loan_b.gph", replace				 
		 
graph combine "merged_mediumprofile_exec_hire_b.gph" "merged_mediumprofile_leadership_b.gph" "merged_mediumprofile_entry_hire_b.gph" "merged_mediumprofile_interschool_b.gph" ///
 "merged_mediumprofile_politics_b.gph" "merged_mediumprofile_loan_b.gph", col(2)  iscale(0.7)
 
graph export "mediumprofile_3.pdf", replace
graph export "mediumprofile_3.png", replace

**Analyse with good profiles
 
import delimited Thai_processed_output_good_profiles.csv, clear 

gen Thai = 1

save Thai_goodprofile.dta, replace

**US surnames
import delimited US_processed_output_good_profiles.csv, clear 


gen US = 1

save US_noprofile.dta, replace

append using Thai_goodprofile.dta

*Clean
encode category, gen(cat)

replace cat = 0 if cat == 3
replace cat = 7 if cat == 4
lab def cat_name 0 "Common surnames" 1 "Legacy surnames" 2 "Legacy variants" 5 "Rich surnames" 6 "Rich variants" 7 "Common variants"
lab val cat cat_name

*Label
lab var powerful_mean "Perceived power"
lab var rich_mean "Perceived wealth"
lab var smart_mean "Perceived intelligence"

gen Legacy_R = cat==1
lab var Legacy_R "Legacy surnames"
gen Legacy_V = cat==2
lab var Legacy_V "Legacy variants"
gen Rich_R = cat==5
lab var Rich_R "Rich surnames"
gen Rich_V = cat==6
lab var Rich_V "Rich variants"
gen Common_V = cat==7
lab var Common_V "Common variants"

save merged_goodprofile.dta, replace



eststo clear

**Predicting rich, powerful, smart, and commonality
*Thailand
asdocx reg powerful_mean Legacy_R Legacy_V Rich_R Rich_V Common_V  if Thai==1, vce(bootstrap, reps(1000)) save(Table7_Thailand.docx) title(Perceived power: Thailand) label fs(9) replace
eststo Powerful_T
asdocx  reg rich_mean Legacy_R Legacy_V Rich_R Rich_V Common_V  if Thai==1, vce(bootstrap, reps(1000)) save(Table7_Thailand.docx)  title(Perceived wealth: Thailand) label fs(9) append
eststo Rich_T
asdocx reg smart_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if Thai==1, vce(bootstrap, reps(1000))  save(Table7_Thailand.docx)  title(Perceived intelligence: Thailand) label fs(9) append
eststo Smart_T
asdocx reg commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if Thai==1, vce(bootstrap, reps(1000))  save(Table7_Thailand.docx)  title(Perceived commonality: Thailand) label fs(9) append
eststo Commonality_T


*US
asdocx reg powerful_mean Legacy_R Legacy_V Rich_R Rich_V Common_V  if US==1, vce(bootstrap, reps(1000)) save(Table7_US.docx) title(Perceived power: US) label fs(9) replace
eststo Powerful_U
asdocx  reg rich_mean Legacy_R Legacy_V Rich_R Rich_V Common_V  if US==1, vce(bootstrap, reps(1000)) save(Table7_US.docx)  title(Perceived wealth: US) label fs(9) append
eststo Rich_U
asdocx reg smart_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if US==1, vce(bootstrap, reps(1000))  save(Table7_US.docx)  title(Perceived intelligence: US) label fs(9) append
eststo Smart_U
asdocx reg commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if US==1, vce(bootstrap, reps(1000))  save(Table7_US.docx)  title(Perceived commonality: US) label fs(9) append
eststo Commonality_U


*coefplot Powerful_T Rich_T Smart_T   , drop(_cons)  xline(0)

coefplot (Powerful_T, label("Perceived power"))  , bylabel(Thailand) /// 
		 || (Powerful_U, label("Perceived power"))  , bylabel(USA) ///
		 ||, keep( Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))   legend(size(small))  xtitle("Coefficient size") ytitle("Surname categories") title("Perceived power", size(small)) 
		  
graph save "merged_goodprofile_power.gph", replace

coefplot  (Rich_T, label("Perceived wealth"))  , bylabel(Thailand) /// 
		 ||  (Rich_U, label("Perceived wealth"))  , bylabel(USA) ///
		 ||, keep( Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale)  legend(size(small))  xtitle("Coefficient size") ytitle("Surname categories") title("Perceived wealth", size(small))

graph save "merged_goodprofile_rich.gph", replace

coefplot  (Smart_T, label("Perceived intelligence")), bylabel(Thailand) /// 
		 ||  (Smart_U, label("Perceived intelligence")), bylabel(USA) ///
		 ||, keep( Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale)  legend(size(small))  xtitle("Coefficient size") ytitle("Surname categories") title("Perceived intelligence", size(small))

		 graph save "merged_goodprofile_smart.gph", replace
		 
coefplot  (Commonality_T, label("Perceived commonality")), bylabel(Thailand) /// 
		 ||  (Commonality_U, label("Perceived intelligence")), bylabel(USA) ///
		 ||, keep( Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale)  legend(size(small))  xtitle("Coefficient size") ytitle("Surname categories") title("Perceived commonality", size(small))

graph save "merged_goodprofile_commonality.gph", replace

graph combine "merged_goodprofile_power.gph" "merged_goodprofile_rich.gph"  "merged_goodprofile_smart.gph" "merged_goodprofile_commonality.gph", col(2)  iscale(0.7)
graph export "goodprofile_1.pdf", replace
graph export "goodprofile_1.png", replace
 

**Predicting other forms of judgment
*Thailand
*Thailand
asdocx reg exec_hire_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if Thai==1, vce(bootstrap, reps(1000)) save(Table8_Thailand.docx) title(Executive hiring: Thailand) label fs(9) replace
eststo Exec_hire_T

asdocx reg leadership_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if Thai==1, vce(bootstrap, reps(1000)) save(Table8_Thailand.docx) title(Leadership: Thailand) label fs(9) append
eststo Leadership_T

asdocx reg entry_hire_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if Thai==1, vce(bootstrap, reps(1000)) save(Table8_Thailand.docx) title(Entry hire: Thailand) label fs(9) append
eststo Entry_hire_T

asdocx reg international_school_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if Thai==1, vce(bootstrap, reps(1000)) save(Table8_Thailand.docx) title(International school admission: Thailand) label fs(9) append
eststo InterSchool_T

asdocx reg political_career_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if Thai==1, vce(bootstrap, reps(1000)) save(Table8_Thailand.docx) title(Political career: Thailand) label fs(9) append
eststo Politics_T

asdocx reg loan_approve_mean  powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if Thai==1, vce(bootstrap, reps(1000)) save(Table8_Thailand.docx) title(Loan approval: Thailand) label fs(9) append
eststo Loan_T

*USA
asdocx reg exec_hire_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if US==1, vce(bootstrap, reps(1000)) save(Table8_US.docx) title(Executive hiring: US) label fs(9) replace
eststo Exec_hire_U

asdocx reg leadership_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if US==1, vce(bootstrap, reps(1000)) save(Table8_US.docx) title(Leadership: US) label fs(9) append
eststo Leadership_U

asdocx reg entry_hire_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if US==1, vce(bootstrap, reps(1000)) save(Table8_US.docx) title(Entry hire: US) label fs(9) append
eststo Entry_hire_U

asdocx reg international_school_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if US==1, vce(bootstrap, reps(1000)) save(Table8_US.docx) title(International school admission: US) label fs(9) append
eststo InterSchool_U

asdocx reg political_career_mean powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if US==1, vce(bootstrap, reps(1000)) save(Table8_US.docx) title(Political career: US) label fs(9) append
eststo Politics_U

asdocx reg loan_approve_mean  powerful_mean rich_mean smart_mean commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V commonality_mean if US==1, vce(bootstrap, reps(1000)) save(Table8_US.docx) title(Loan approval: US) label fs(9) append
eststo Loan_U

**Coefplot 

coefplot (Exec_hire_T, label("Exec hire")) , bylabel(Thailand) /// 
		 || (Exec_hire_U, label("Exec hire")) , bylabel(USA) ///
		 ||, drop(_cons Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small)) title("Executive hire", size(small))

graph save "merged_goodprofile_exec_hire.gph", replace
		 
coefplot  ( Leadership_T, label("Leadership")), bylabel(Thailand) /// 
		 ||  (Leadership_U, label("Leadership"))  , bylabel(USA) ///
		 ||, drop(_cons Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small))  title("Leadership", size(small))

graph save "merged_goodprofile_leadership.gph", replace

coefplot  (Entry_hire_T, label("Entry hire")), bylabel(Thailand) /// 
		 ||  (Entry_hire_U, label("Entry hire")), bylabel(USA) ///
		 ||, drop(_cons Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small)) title("Entry hire", size(small))
		 
graph save "merged_goodprofile_entry_hire.gph", replace
		
coefplot  (InterSchool_T, label("Inter School")), bylabel(Thailand) /// 
		 ||  (InterSchool_U, label("Inter School")), bylabel(USA) ///
		 ||, drop(_cons Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small))	title("International school", size(small))	
		
graph save "merged_goodprofile_interschool.gph", replace		
		
coefplot (Politics_T, label("Politics Career")), bylabel(Thailand) /// 
		 || (Politics_U, label("Politics Career")) , bylabel(USA) ///
		 ||, drop(_cons Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small)) title("Political career", size(small))	
		
graph save "merged_goodprofile_politics.gph", replace			
		
coefplot  (Loan_T, label("Loan Approval")), bylabel(Thailand) /// 
		 ||   (Loan_U, label("Loan Approval")), bylabel(USA) ///
		 ||, drop(_cons Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Perception of names", size(small))	title("Loan approval", size(small))	

graph save "merged_goodprofile_loan.gph", replace				 
		 
graph combine "merged_goodprofile_exec_hire.gph" "merged_goodprofile_leadership.gph" "merged_goodprofile_entry_hire.gph" "merged_goodprofile_interschool.gph" ///
 "merged_goodprofile_politics.gph" "merged_goodprofile_loan.gph", col(2)  iscale(0.7)
 
graph export "goodprofile_2.pdf", replace
graph export "goodprofile_2.png", replace		 
		 
coefplot (Exec_hire_T, label("Exec hire")) , bylabel(Thailand) /// 
		 || (Exec_hire_U, label("Exec hire")) , bylabel(USA) ///
		 ||, keep(Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Surname categories", size(small))  title("Executive hire", size(small))

graph save "merged_goodprofile_exec_hire_b.gph", replace
		 
coefplot  ( Leadership_T, label("Leadership")), bylabel(Thailand) /// 
		 ||  (Leadership_U, label("Leadership"))  , bylabel(USA) ///
		 ||, keep(Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Surname categories", size(small))   title("Leadership", size(small))

graph save "merged_goodprofile_leadership_b.gph", replace

coefplot  (Entry_hire_T, label("Entry hire")), bylabel(Thailand) /// 
		 ||  (Entry_hire_U, label("Entry hire")), bylabel(USA) ///
		 ||, keep(Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Surname categories", size(small))  title("Entry hire", size(small))
		 
graph save "merged_goodprofile_entry_hire_b.gph", replace
		
coefplot  (InterSchool_T, label("Inter School")), bylabel(Thailand) /// 
		 ||  (InterSchool_U, label("Inter School")), bylabel(USA) ///
		 ||, keep(Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Surname categories", size(small)) 	title("International school", size(small))	
		
graph save "merged_goodprofile_interschool_b.gph", replace		
		
coefplot (Politics_T, label("Politics Career")), bylabel(Thailand) /// 
		 || (Politics_U, label("Politics Career")) , bylabel(USA) ///
		 ||, keep(Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Surname categories", size(small))  title("Political career", size(small))	
		
graph save "merged_goodprofile_politics_b.gph", replace			
		
coefplot  (Loan_T, label("Loan Approval")), bylabel(Thailand) /// 
		 ||   (Loan_U, label("Loan Approval")), bylabel(USA) ///
		 ||, keep(Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale) legend(size(small))   xtitle("Coefficient size", size(small)) ytitle("Surname categories", size(small)) 	title("Loan approval", size(small))	

graph save "merged_goodprofile_loan_b.gph", replace				 
		 
graph combine "merged_goodprofile_exec_hire_b.gph" "merged_goodprofile_leadership_b.gph" "merged_goodprofile_entry_hire_b.gph" "merged_goodprofile_interschool_b.gph" ///
 "merged_goodprofile_politics_b.gph" "merged_goodprofile_loan_b.gph", col(2)  iscale(0.7)
 
graph export "goodprofile_3.pdf", replace
graph export "goodprofile_3.png", replace

**Combine graphs

eststo clear

**Predicting rich, powerful, smart, and commonality
*Thailand
asdocx reg powerful_mean Legacy_R Legacy_V Rich_R Rich_V Common_V  if Thai==1, vce(bootstrap, reps(1000)) save(Table1_Thailand.docx) title(Perceived power: Thailand) label fs(9) replace
eststo Powerful_T
asdocx  reg rich_mean Legacy_R Legacy_V Rich_R Rich_V Common_V  if Thai==1, vce(bootstrap, reps(1000)) save(Table1_Thailand.docx)  title(Perceived wealth: Thailand) label fs(9) append
eststo Rich_T
asdocx reg smart_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if Thai==1, vce(bootstrap, reps(1000))  save(Table1_Thailand.docx)  title(Perceived intelligence: Thailand) label fs(9) append
eststo Smart_T
asdocx reg commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if Thai==1, vce(bootstrap, reps(1000))  save(Table1_Thailand.docx)  title(Perceived commonality: Thailand) label fs(9) append
eststo Commonality_T


*US
asdocx reg powerful_mean Legacy_R Legacy_V Rich_R Rich_V Common_V  if US==1, vce(bootstrap, reps(1000)) save(Table1_US.docx) title(Perceived power: US) label fs(9) replace
eststo Powerful_U
asdocx  reg rich_mean Legacy_R Legacy_V Rich_R Rich_V Common_V  if US==1, vce(bootstrap, reps(1000)) save(Table1_US.docx)  title(Perceived wealth: US) label fs(9) append
eststo Rich_U
asdocx reg smart_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if US==1, vce(bootstrap, reps(1000))  save(Table1_US.docx)  title(Perceived intelligence: US) label fs(9) append
eststo Smart_U
asdocx reg commonality_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if US==1, vce(bootstrap, reps(1000))  save(Table1_US.docx)  title(Perceived commonality: US) label fs(9) append
eststo Commonality_U



*Figure 4

u merged_noprofile.dta, clear

*Smart - no profiles
reg smart_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if Thai==1, vce(bootstrap, reps(1000))   
eststo Smart_noprofile_T
reg smart_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if US==1, vce(bootstrap, reps(1000)) 
eststo Smart_noprofile_U

coefplot  (Smart_noprofile_T, label("Perceived intelligence")), bylabel(Thailand) /// 
		 ||  (Smart_noprofile_U, label("Perceived intelligence")), bylabel(USA) ///
		 ||, keep( Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale)  legend(size(small))  xtitle("Coefficient size") ytitle("Surname categories") title("Perceived intelligence", size(small)) title("No profiles", size(medium))

graph save "smart_noprofiles.gph", replace


u merged_badprofile.dta, clear

*Smart - bad profiles
reg smart_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if Thai==1, vce(bootstrap, reps(1000))    
eststo Smart_badprofile_T
reg smart_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if US==1, vce(bootstrap, reps(1000))   
eststo Smart_badprofile_U

coefplot  (Smart_badprofile_T, label("Perceived intelligence")), bylabel(Thailand) /// 
		 ||  (Smart_badprofile_U, label("Perceived intelligence")), bylabel(USA) ///
		 ||, keep( Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale)  legend(size(small))  xtitle("Coefficient size") ytitle("Surname categories") title("Perceived intelligence", size(small)) title("Bad profiles", size(medium))


graph save "smart_badprofiles.gph", replace


u merged_mediumprofile.dta, clear

*Smart - medium profiles
reg smart_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if Thai==1, vce(bootstrap, reps(1000))   
eststo Smart_mediumprofile_T
reg smart_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if US==1, vce(bootstrap, reps(1000))   
eststo Smart_mediumprofile_U


coefplot  (Smart_mediumprofile_T, label("Perceived intelligence")), bylabel(Thailand) /// 
		 ||  (Smart_mediumprofile_U, label("Perceived intelligence")), bylabel(USA) ///
		 ||, keep( Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale)  legend(size(small))  xtitle("Coefficient size") ytitle("Surname categories") title("Perceived intelligence", size(small)) title("Medium profiles", size(medium))

graph save "smart_mediumprofiles.gph", replace


u merged_goodprofile.dta, clear

*Smart - good profiles
reg smart_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if Thai==1, vce(bootstrap, reps(1000))  
eststo Smart_goodprofile_T
reg smart_mean Legacy_R Legacy_V Rich_R Rich_V Common_V   if US==1, vce(bootstrap, reps(1000))  
eststo Smart_goodprofile_U

coefplot  (Smart_goodprofile_T, label("Perceived intelligence")), bylabel(Thailand) /// 
		 ||  (Smart_goodprofile_U, label("Perceived intelligence")), bylabel(USA) ///
		 ||, keep( Legacy_R Legacy_V Rich_R Rich_V Common_V) xline(0)  xlabel(, labsize(small))  byopts(xrescale)  legend(size(small))  xtitle("Coefficient size") ytitle("Surname categories") title("Perceived intelligence", size(small)) title("Good profiles", size(medium))

graph save "smart_goodprofiles.gph", replace


graph combine "smart_noprofiles.gph" "smart_badprofiles.gph"  ///
"smart_mediumprofiles.gph" "smart_goodprofiles.gph"   , col(2)  iscale(0.7)
 
graph export "all_profiles.pdf", replace
graph export "all_profiles.png", replace

u merged_noprofile.dta, clear

lab var powerful_mean "Perceived power"
lab var rich_mean "Perceived wealth"
lab var smart_mean "Perceived intelligence"
lab var commonality_mean "Perceived commonality"
lab var exec_hire_mean "Executive hire"
lab var leadership_mean "Leadership"
lab var entry_hire_mean "Entry hire"
lab var international_school_mean "International School"
lab var political_career_mean "Political career"
lab var loan_approve_mean "Loan approval"


**Summary statistics
bys cat: asdocx sum powerful_mean rich_mean smart_mean commonality_mean exec_hire_mean leadership_mean entry_hire_mean international_school_mean political_career_mean loan_approve_mean if Thai==1, replace label stat(N mean sd) dec(3) tzok save(summary_Thai.docx) 

bys cat: asdocx sum powerful_mean rich_mean smart_mean commonality_mean exec_hire_mean leadership_mean entry_hire_mean international_school_mean political_career_mean loan_approve_mean if Thai==., replace label stat(N mean sd) dec(3) tzok save(summary_US.docx)  

