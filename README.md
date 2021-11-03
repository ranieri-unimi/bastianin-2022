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