# bastianin-2022
US election modelling &amp; forecasting 

## features di [bastianin](https://github.com/ranieri-unimi/bastianin-2022/blob/main/Empirical%20Project%202021.pdf)

- [x] dependent  variable  of  your  regressions,  that  is  the Democratic (D) share of the two party vote defined as 100*D/(D + R)
- [x] real  percapita  GDP  by  state
- [x] price  index  based  on  GDP  deflator  defined  as nominal (current dollar) GDP divided by real GDP
- [ ] a measure of strong  growth  following  the  approach  of  Fair
- [ ] for incumbency variables you can use the same variables used in the original paper

further variables such as:
- [ ] state demographic characteristics
- [ ] economic variables (such as  State  level  unemployment)
- [ ] vote-related variables (e.g.  the  party  of  the Governor)

## features nuove
- **Prezzo Benzina** | ultimo anno prezzi petrolio/gas/benzina

## featuires di [lichtman](https://www.infobae.com/america/eeuu/2020/09/20/el-historiador-y-guru-que-acerto-el-resultado-de-8-de-las-ultimas-9-elecciones-en-estados-unidos-vaticina-quien-sera-el-proximo-presidente/)

- **Seggi ai Deputati** | Mandato del partito:dopo le elezioni di medio termine, il partito al governo ha più seggi alla Camera dei Rappresentanti di quanti ne avesse dopo le precedenti elezioni di medio termine
- **Voti Primarie** | Competizione:non esiste una seria competizione per il candidato ufficiale alle primarie di partito
- **dummy** | Ufficialità: il candidato ufficiale è l'incumben general.
- **Percentuale Intenzioni di voto indipendente** | Terza parte: Mentre ci sono partiti minori che sono in corsa, come in tutte le elezioni, non ce ne sono che superano il 3% delle intenzioni di voto in qualsiasi sondaggio
- **GDP anno** | Economia a breve termine: l'economianon è inrecessione durante la campagna elettorale
- **GDP mandato** | Economia a lungo termine:lacrescita economica pro capite durante il mandato è uguale o superiore alla media degli ultimi due mandati presidenziali
- **delta-GDP** | 

## features vecchie

- short-term measures of economic performance:
  - **Gt** growth rate (at an annual rate) of real per capita GDP in the first three quarters of the election year
- long-term measures of economic performance:
  - **Pt** is the absolute value of the inflation rate (at an annual rate) in the first 15 quarters of the administration
  - **Zt** no. of quarters in the first 15 of admin. in which GDP growthexceeded 3.2% at an annual rate
- familiarity of candidate and preference for variety of party in power
  - **It** is 1 if the Democrats (D) are in the White House at the time of the election and –1 if the Republicans (R) are
  - **DPERt** is 1 if D president is running again (D incumbent), –1 if R incumbent and 0 otherwise
  - **DURt** 0 if the incumbent party has been in power for only 1 or 2 consecutive terms, 1 [–1] if D [R] party has been in power for three consecutive terms, 1.25 [–1.25] if the D [R] party in power for 4 consecutive terms, 1.5 [–1.5] if the D [R] party has been in power for 5 consecutive terms, and so on.
  - **WARt** 1 if election year = 1920, 1944, 1948 (0 otherwise)

***Vt = β0 + β1(Gt×It) + β2(Pt×It) + β3(Zt×It) + β4(It) + β5(DPERt) + β6(DURt) + ut***

Ideas for empirical projects
- Apply ML to Fair’s data to obtain better predictions and correct inferences (Belloni et al., 2014)
- Extend Fair’s work considering electoral votes by US State (also need State level G and P). Also in this case a ML approach that guarantees good predictions and correct inferences is needed (Athey, 2019; Athey and Imbens, 2019)
