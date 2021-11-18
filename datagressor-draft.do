import delimited "\\wsl.localhost\bastianin\home\tosho\bastianin-2022\datasets-clean\xxx-final-dataset.csv"

encode state, gen(tmp)
drop state
rename tmp state
xtset state year, yearly

xtreg y_votes_percent incumbent former_party_morethan_2 former_president_again sudden_vice lag_vice, fe

