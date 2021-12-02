import delimited "\\wsl.localhost\bastianin\home\tosho\bastianin-2022\datasets-clean\xxx-2012-insample-final-dataset.csv"

gen satias = (2*z_4 + house_midterm -1)*incumbent/2
*gen satias = (2*z_mt_2 + house_midterm -1)*incumbent/2

* fair
replace fair_p_1 = fair_p_1*incumbent
replace fair_g_1 = fair_g_1*incumbent

* z and inc same

* yeet2year
forvalues j = 1/4 {
*replace def_`j'= def_`j'*incumbent
*replace gdp_`j' = gdp_`j'*incumbent
replace z_`j'= z_`j'*incumbent

*replace avg_inc_`j'= avg_inc_`j'*incumbent
*replace unemp_`j' = unemp_`j'*incumbent
}

* meed2mid
forvalues j = 1/2 {
replace def_mt_`j'= def_mt_`j'*incumbent
replace gdp_mt_`j' = gdp_mt_`j'*incumbent
replace z_mt_`j'= z_mt_`j'*incumbent

replace avg_inc_mt_`j'= avg_inc_mt_`j'*incumbent
*replace unemp_mt_`j' = unemp_mt_`j'*incumbent

gen gdp_mt_`j'_pw2 = gdp_mt_`j'^2
gen avg_inc_mt_`j'_pw2 = avg_inc_mt_`j'^2
gen def_mt_`j'_pw2 = def_mt_`j'^2

}

replace unemp_rn = unemp_rn*incumbent
gen fair_z_1 = z_1 + z_2 + z_3 + z_4

gen was_a_vice = sudden_vice + lag_vice

tab state, gen(S)
tab year, gen(Y)

encode state, gen(tmp)
drop state
rename tmp state
xtset state year, delta(4)


***** Start from the estimation of a fixed effects model that contains the same variables used by Fair. 

* xtreg y_votes_percent fair_g_1 fair_p_1 fair_z_1 incumbent-former_party_morethan_2, fe vce(cluster state)

reg y_votes_percent fair_g_1 fair_p_1 fair_z_1 incumbent-former_party_morethan_2 i.state, vce(robust)

*<<<< Discuss coefficient estimates and inferences.

**** Perform a test for the joint significance of economic variables in the model.

testparm fair_*

**** Check if the panel dataset can be pooled by testing the joint significance of state-level fixed effects.

testparm i.state

* Now compute fitted values and assign the State to the candidate with the majority of votes.

predict y_hat_fr
 
*<<<<<<<< Translate popular vote into elector vote using the information here and compare your forecasts with the results for 2012 and 2020. (https://www.archives.gov/electoral-college/allocation).





* Next, you need to apply the LASSO to the same regression, but add additional terms that you think can help forecasting presidential elections. Always keep real per capita GDP in the regression.

global x_all fair_p_1-def_mt_1 gdp_mt_1 z_mt_2-former_party_morethan_2 house_midterm-was_a_vice

global x_fe S1-S27 S29-S50 Y1-Y9

xtreg y_votes_percent fair_g_1 gdp_mt_2 $x_all, fe vce(cluster state)


************************************************************************

* Y-LASSO
lasso linear y_votes_percent ($x_fe) $x_all gdp_mt_2, selection(plugin, heteroskedastic) nolog
lassocoef

/*
house_midterm |     x    
 def_mt_2_pw2 |     x    
*/
global yyy house_midterm def_mt_2_pw2


* X-LASSO
lasso linear fair_g_1 ($x_fe) $x_all gdp_mt_2, selection(plugin, heteroskedastic) nolog
lassocoef


/*
**************************
      satias |     x    
gdp_mt_2_pw2 |     x    
    gdp_mt_2 |     x    
**************************
      z_mt_2 |     x    
avg_inc_mt_2 |     x    
    fair_g_1 |     x 
**************************
*/
global xxx satias gdp_mt_2 gdp_mt_2_pw2


* YX REG
reg y_votes_percent fair_g_1 $yyy $xxx $x_fe, vce(robust)

xtreg y_votes_percent fair_g_1 $yyy $xxx, fe vce(cluster state)

predict y_hat_ds

* <<<<<<<<<  Compare the performance of LASSO with the performance of the previous model.

export delimited datasets-clean\xxx-fitted-values.csv

* <<<<<<<<< Provide valid inferences for the variables selected by the LASSO and comment in relation to the OLS estimates.

* <<<<<< Explain why a double-post-model selection approach is needed and a naïve post-model selection approach that simply excludes GDP from the LASSO penalty is not appropriate.


********************************END******************************

****************************USELESS DSREG***********************

dsregress y_votes_percent gdp_mt_2, controls(($x_fe) $x_all fair_g_1) lasso(*, selection(cv, alllambdas))
lassocoef (.,for(y_votes_percent)) (.,for(gdp_mt_2))
*****************************                 ******************
dsregress y_votes_percent fair_g_1, controls(($x_fe) $x_all gdp_mt_2) lasso(*, selection(cv, alllambdas))
lassocoef (.,for(y_votes_percent)) (.,for(fair_g_1))
****************************************************************