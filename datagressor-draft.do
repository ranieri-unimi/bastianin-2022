import delimited "\\wsl.localhost\bastianin\home\tosho\bastianin-2022\datasets-clean\xxx-final-dataset.csv"

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

tab state, gen(DS)
tab year, gen(DY)

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

predict y_hat_vote

export delimited datasets\fair-fitted-values.csv
 
*<<<<<<<< Translate popular vote into elector vote using the information here and compare your forecasts with the results for 2012 and 2020. (https://www.archives.gov/electoral-college/allocation).





* Next, you need to apply the LASSO to the same regression, but add additional terms that you think can help forecasting presidential elections. Always keep real per capita GDP in the regression.

xtreg y_votes_percent fair_p_1-gdp_mt_1  z_mt_2-former_party_morethan_2 house_midterm-was_a_vice, fe vce(cluster state)

/* NAIVE POST*/
lasso linear y_votes_percent (fair_g_1) fair_p_1-gdp_mt_1  z_mt_2-former_party_morethan_2 house_midterm-was_a_vice, selection(plugin, heteroskedastic) nolog
lassocoef

/*DOUBLE SEL*/

dsregress y_votes_percent fair_g_1, controls((DS2-DS50 DY2-DY10) fair_p_1-def_mt_1 gdp_mt_2-gdp_mt_1  z_mt_2-former_party_morethan_2 house_midterm-was_a_vice) lasso(*, selection(cv, alllambdas))
est sto ds

lassocoef (.,for(fair_g_1)) (.,for(y_votes_percent))


/* VERY DS*/
* Variables from which lasso selects

* FE and time effects
tab state, gen(S)
tab year, gen(Y)


global X_effects DS2-DS50 DY2-DY10 
global X_lasso fair_p_1-def_mt_1 gdp_mt_2-gdp_mt_1  z_mt_2-former_party_morethan_2 house_midterm-was_a_vice

* DS lasso in two steps
gen s1 = e(sample) // save sample

* 1 Lasso for y, always include state and time effects
lasso linear y_votes_percent ($X_effects) $X_lasso if s1, selection(plugin, heteroskedastic) nolog
lassocoef

* 2 lasso for x
lasso linear fair_g_1 ($X_effects) $X_lasso if s1, selection(plugin, heteroskedastic) nolog
lassocoef

* 3 regression with selected features
reg y_votes_percent fair_g_1 house_midterm  gdp_mt_2 satias gdp_mt_2_pw2 $X_effects

est sto lasso_fe 


estimates table m3 m4 lasso_fe ds ds_cv, stats(N r2_a) star(.1 .05 .01) keep(beertax) b(%4.3f) varlabel

* Compare the performance of LASSO with the performance of the previous model.

* <<<<<<<<< Provide valid inferences for the variables selected by the LASSO and comment in relation to the OLS estimates.



* <<<<<< Explain why a double-post-model selection approach is needed and a naïve post-model selection approach that simply excludes GDP from the LASSO penalty is not appropriate.



********************************CHERN******************************

* XXXXXXXXXX
global X_lasso fair_p_1-satias gdp_mt_1_pw2 gdp_mt_2_pw2 lg_avg_inc_mt_2 lg_avg_inc_mt_2


* FE and time effects
tab state, gen(S)
tab year, gen(Y)
global X_effects S2-S48 Y2-Y7  // Alaska and 1982 as base cases


* 1 Lasso for y, always include state and time effects
lasso linear y_votes_percent ($X_effects) $X_lasso if s1, selection(plugin, heteroskedastic) nolog
lassocoef


* 2 lasso for x
lasso linear beertax ($X_effects) $X_lasso if s1, selection(plugin, heteroskedastic) nolog
lassocoef


dsregress vfrall beertax, controls(($X_effects) $X_lasso) selection(cv) // DS
lassocoef (.,for(beertax)) (.,for(vfrall)) // check selected variables










