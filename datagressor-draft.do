import delimited "\\wsl.localhost\bastianin\home\tosho\bastianin-2022\datasets-clean\xxx-final-dataset.csv"

encode state, gen(tmp)
drop state
rename tmp state
xtset state year, delta(4)

forvalues j = 1/4 {
replace def_`j'= def_`j'*incumbent
replace z_`j'= z_`j'*incumbent
replace gdp_`j'= gdp_`j'*incumbent
replace unemp_`j'= unemp_`j'*incumbent
replace avg_inc_`j'= avg_inc_`j'*incumbent
}

gen z_0 = z_1+z_2 +z_3+z_4
gen p_0 = z_1+z_2 +z_3+z_4

* solo FAIR
xtreg y_votes_percent z_0 gdp_1 incumbent-former_party_morethan_2, fe vce(cluster state)



* ANCHE nostre

* stata classic

xtreg y_votes_percent def_4-unemp_1, fe vce(cluster state)
est store FEstata
testparm i.state 
testparm i.year


* fe dummy
reg y_votes_percent def_4-unemp_1 i.state
est store FEdummies

* Test if entity FE are significantly different from zero
testparm i.state 
testparm i.year


estimates table FE*, star(.05)  varlabel

