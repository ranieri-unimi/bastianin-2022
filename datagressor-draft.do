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
*replace z_mt_`j'= z_mt_`j'*incumbent

replace avg_inc_mt_`j'= avg_inc_mt_`j'*incumbent
*replace unemp_mt_`j' = unemp_mt_`j'*incumbent
}

replace unemp_rn = unemp_rn*incumbent
gen fair_z_1 = z_1 + z_2 + z_3 + z_4

gen gdp_mt_1_pw2 = gdp_mt_1^2
gen gdp_mt_2_pw2 = gdp_mt_2^2
gen avg_inc_mt_1_pw2 = avg_inc_mt_1^2
gen avg_inc_mt_2_pw2 = avg_inc_mt_2^2

gen was_a_vice = sudden_vice + lag_vice

tab state, gen(DS)
tab year, gen(DY)

encode state, gen(tmp)
drop state
rename tmp state
xtset state year, delta(4)


**** Start from the estimation of a fixed effects model that contains the same variables used by Fair. 

xtreg y_votes_percent fair_g_1 fair_p_1 fair_z_1 incumbent-former_party_morethan_2, fe vce(cluster state)

/*

Fixed-effects (within) regression               Number of obs     =        500
Group variable: state                           Number of groups  =         50

R-squared:                                      Obs per group:
     Within  = 0.4261                                         min =         10
     Between = 0.0313                                         avg =       10.0
     Overall = 0.1571                                         max =         10

                                                F(6,49)           =     125.48
corr(u_i, Xb) = 0.0139                          Prob > F          =     0.0000

                                            (Std. err. adjusted for 50 clusters in state)
-----------------------------------------------------------------------------------------
                        |               Robust
        y_votes_percent | Coefficient  std. err.      t    P>|t|     [95% conf. interval]
------------------------+----------------------------------------------------------------
               fair_g_1 |   .3928937   .0850688     4.62   0.000     .2219415    .5638459
               fair_p_1 |   .1457051   .0252645     5.77   0.000     .0949341     .196476
                    z_0 |   .5790598   .2141512     2.70   0.009      .148707    1.009413
              incumbent |   3.077715   .5531069     5.56   0.000     1.966205    4.189225
 former_president_again |  -3.287845   .4169329    -7.89   0.000    -4.125703   -2.449987
former_party_morethan_2 |  -5.790664   .5096837   -11.36   0.000    -6.814912   -4.766416
                  _cons |   48.67943    .212178   229.43   0.000     48.25305    49.10582
------------------------+----------------------------------------------------------------
                sigma_u |  7.6880424
                sigma_e |  4.4641543
                    rho |  .74784896   (fraction of variance due to u_i)
-----------------------------------------------------------------------------------------

*/

**** <<< Discuss coefficient estimates and inferences.





**** Perform a test for the joint significance of economic variables in the model.

test fair_g_1 fair_p_1 fair_z_1

/*

 ( 1)  fair_g_1 = 0
 ( 2)  fair_p_1 = 0
 ( 3)  fair_z_1 = 0

       F(  3,    49) =   28.56
            Prob > F =    0.0000

*/

 
**** Check if the panel dataset can be pooled by testing the joint significance of state-level fixed effects.


xtreg y_votes_percent fair_g_1 fair_p_1 fair_z_1 incumbent-former_party_morethan_2, fe

/*

F test that all u_i=0: F(49, 444) = 29.64                    Prob > F = 0.0000

*/

reg y_votes_percent fair_g_1 fair_p_1 fair_z_1 incumbent-former_party_morethan_2 i.state

/*

      Source |       SS           df       MS      Number of obs   =       500
-------------+----------------------------------   F(55, 444)      =     32.84
       Model |  36000.5742        55  654.555895   Prob > F        =    0.0000
    Residual |  8848.33123       444  19.9286739   R-squared       =    0.8027
-------------+----------------------------------   Adj R-squared   =    0.7783
       Total |  44848.9054       499   89.877566   Root MSE        =    4.4642

-----------------------------------------------------------------------------------------
        y_votes_percent | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
------------------------+----------------------------------------------------------------
               fair_g_1 |   .3928937   .0720192     5.46   0.000     .2513529    .5344345
               fair_p_1 |   .1457051   .0229686     6.34   0.000     .1005644    .1908457
                    z_0 |   .5790598    .207845     2.79   0.006     .1705777     .987542
              incumbent |   3.077715   .7441528     4.14   0.000     1.615216    4.540214
 former_president_again |  -3.287845   .6511359    -5.05   0.000    -4.567536   -2.008154
former_party_morethan_2 |  -5.790664    .580886    -9.97   0.000    -6.932292   -4.649036
                        |
                  state |
                ALASKA  |  -.8995014   2.010612    -0.45   0.655    -4.850999    3.051996
               ARIZONA  |   5.477761   1.999962     2.74   0.006     1.547192     9.40833
              ARKANSAS  |   4.462644   1.997571     2.23   0.026     .5367758    8.388512
            CALIFORNIA  |   16.84447    2.00314     8.41   0.000     12.90766    20.78129
              COLORADO  |   8.596911   1.998165     4.30   0.000     4.669875    12.52395
           CONNECTICUT  |   15.24059   1.998852     7.62   0.000      11.3122    19.16898
              DELAWARE  |   14.55234   1.996505     7.29   0.000     10.62856    18.47611
               FLORIDA  |   7.132979    1.99866     3.57   0.000      3.20497    11.06099
               GEORGIA  |   5.063903   1.996749     2.54   0.012     1.139649    8.988157
                HAWAII  |   21.45718   2.006677    10.69   0.000     17.51342    25.40095
                 IDAHO  |  -6.685604   1.996848    -3.35   0.001    -10.61005   -2.761156
              ILLINOIS  |   15.50656   1.997556     7.76   0.000     11.58072     19.4324
               INDIANA  |   2.646755   1.996782     1.33   0.186    -1.277563    6.571073
                  IOWA  |   10.50862   1.996604     5.26   0.000      6.58465    14.43259
                KANSAS  |  -.5023328   1.997413    -0.25   0.802    -4.427892    3.423226
              KENTUCKY  |    1.91139   1.999043     0.96   0.340    -2.017372    5.840152
             LOUISIANA  |   4.173307   1.996861     2.09   0.037     .2488337     8.09778
                 MAINE  |    13.1449   1.997038     6.58   0.000     9.220075    17.06972
              MARYLAND  |   18.41152    1.99685     9.22   0.000     14.48707    22.33598
         MASSACHUSETTS  |   20.94721   1.997575    10.49   0.000     17.02134    24.87309
              MICHIGAN  |   10.83191   1.997449     5.42   0.000     6.906284    14.75754
             MINNESOTA  |   13.30609   1.996674     6.66   0.000      9.38198    17.23019
           MISSISSIPPI  |   2.013323   1.996456     1.01   0.314    -1.910354    5.937001
              MISSOURI  |   6.779717   1.996975     3.39   0.001     2.855019    10.70441
               MONTANA  |   3.294479   1.997183     1.65   0.100    -.6306265    7.219584
              NEBRASKA  |  -2.950454   1.996448    -1.48   0.140    -6.874116    .9732069
                NEVADA  |   8.652585   2.003667     4.32   0.000     4.714736    12.59043
         NEW HAMPSHIRE  |   8.217312   1.996981     4.11   0.000     4.292602    12.14202
            NEW JERSEY  |   13.44258   1.997293     6.73   0.000     9.517254     17.3679
            NEW MEXICO  |   12.04841    1.99665     6.03   0.000     8.124348    15.97247
              NEW YORK  |   20.09096   1.998941    10.05   0.000      16.1624    24.01952
        NORTH CAROLINA  |   6.367393   1.997086     3.19   0.002     2.442478    10.29231
          NORTH DAKOTA  |  -2.695118   2.008806    -1.34   0.180    -6.643067     1.25283
                  OHIO  |   7.706239   1.998002     3.86   0.000     3.779523    11.63296
              OKLAHOMA  |  -3.465088   1.997546    -1.73   0.083    -7.390908     .460733
                OREGON  |   12.94367   1.999241     6.47   0.000     9.014523    16.87283
          PENNSYLVANIA  |   11.49838   1.996623     5.76   0.000     7.574377    15.42239
          RHODE ISLAND  |   20.74362   1.997188    10.39   0.000      16.8185    24.66873
        SOUTH CAROLINA  |   2.712897   1.997701     1.36   0.175    -1.213228    6.639022
          SOUTH DAKOTA  |   1.205552   1.997085     0.60   0.546    -2.719362    5.130465
             TENNESSEE  |   3.304729   1.996597     1.66   0.099    -.6192252    7.228683
                 TEXAS  |   2.699303   1.997231     1.35   0.177    -1.225897    6.624504
                  UTAH  |  -7.778568   1.997679    -3.89   0.000    -11.70465   -3.852487
               VERMONT  |   20.13415   1.999688    10.07   0.000     16.20412    24.06417
              VIRGINIA  |   7.860537   1.998303     3.93   0.000      3.93323    11.78784
            WASHINGTON  |   14.84796   1.997857     7.43   0.000     10.92153    18.77439
         WEST VIRGINIA  |   4.197525   1.997514     2.10   0.036     .2717678    8.123282
             WISCONSIN  |   11.06898   1.997232     5.54   0.000     7.143773    14.99418
               WYOMING  |  -6.009366   2.003638    -3.00   0.003    -9.947157   -2.071574
                        |
                  _cons |   41.05821   1.420559    28.90   0.000     38.26635    43.85006
-----------------------------------------------------------------------------------------

*/

testparm i.state

/*

 ( 1)  2.state = 0
 ( 2)  3.state = 0
 ( 3)  4.state = 0
 ( 4)  5.state = 0
 ( 5)  6.state = 0
 ( 6)  7.state = 0
 ( 7)  8.state = 0
 ( 8)  9.state = 0
 ( 9)  10.state = 0
 (10)  11.state = 0
 (11)  12.state = 0
 (12)  13.state = 0
 (13)  14.state = 0
 (14)  15.state = 0
 (15)  16.state = 0
 (16)  17.state = 0
 (17)  18.state = 0
 (18)  19.state = 0
 (19)  20.state = 0
 (20)  21.state = 0
 (21)  22.state = 0
 (22)  23.state = 0
 (23)  24.state = 0
 (24)  25.state = 0
 (25)  26.state = 0
 (26)  27.state = 0
 (27)  28.state = 0
 (28)  29.state = 0
 (29)  30.state = 0
 (30)  31.state = 0
 (31)  32.state = 0
 (32)  33.state = 0
 (33)  34.state = 0
 (34)  35.state = 0
 (35)  36.state = 0
 (36)  37.state = 0
 (37)  38.state = 0
 (38)  39.state = 0
 (39)  40.state = 0
 (40)  41.state = 0
 (41)  42.state = 0
 (42)  43.state = 0
 (43)  44.state = 0
 (44)  45.state = 0
 (45)  46.state = 0
 (46)  47.state = 0
 (47)  48.state = 0
 (48)  49.state = 0
 (49)  50.state = 0

       F( 49,   444) =   29.64
            Prob > F =    0.0000
			
*/


* Now compute fitted values and assign the State to the candidate with the majority of votes.

predict y_hat_vote


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










