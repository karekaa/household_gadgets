# Kaffesøl-kopp

> English version: [README.md](README.md)

Et lavt trau som fanger opp kaffen som renner ned langs kannen og utover platen, i
stedet for at det ender på bordet og i et tørkepapir. Den står på den frie
forkanten av teakplaten under den internett-tilkoblede kaffevekten, strekker seg ut
over ytterkanten av platen, og lukker seg bak mot det riggen har stående der.

Det finnes **to slags rigger**, og parameteren `base` velger hvilken av dem
byggingen gjelder – `"box"` for den grå elektronikkboksen, `"round"` for et buet
fundament under vektskålen. Alt annet er felles. Begynn med
[To rigger, én fil](#to-rigger-én-fil) om du er usikker på hvilken du har.

![Koppen på plass på platen](img/coffee_spill_mug_on_plate.png)

Selve koppen er **90 × 48 × 20,5 mm** over platen og holder **ca. 46 ml** på
firkantbasen, 90 × 60 mm og ca. 51 ml på den runde. Den hviler på platen over de
bakre 30 mm, de forreste 18 mm stikker ut forbi platekanten, og frontveggen
fortsetter ned til bordet – og bærer en merking på fire linjer, senket ned i den
svarte kroppen og fylt med hvitt fra den andre ekstruderen:

![Frontflaten, som også er førstelaget i printet](img/coffee_spill_mug_front.png)

![Koppen sett ovenfra](img/coffee_spill_mug_iso.png)

## To rigger, én fil

En runde til de andre kaffesensorene avdekket noe den første koppen ikke hadde tatt
høyde for: **de fleste riggene har ikke den grå firkantede elektronikkboksen i det
hele tatt.** De har et buet fundament under vektskålen, og der har en flat bakflate
med to armer ingenting å gripe i. Baksiden av koppen er derfor gjort valgbar:

| `base` | Hva som står bak koppen | Hvordan koppen lukker seg mot det |
|---|---|---|
| `"box"` | den grå 3D-printede elektronikkboksen, en firkantet kloss 76 mm bred og 22 mm høy | en flat bakflate pluss to armer, én langs hver side av den |
| `"round"` | et buet fundament, R 87 mm, tegnet som en bue på 120° | en konkav bue på R 87,4 mm som legger seg inntil det. Ingen armer i det hele tatt. |

Dette er én fil med en bryter og ikke to filer, fordi de to variantene deler
trauet, rampen, beinet, tunga, teksten, printorienteringen og hver eneste fillet.
Bakflaten er virkelig alt som skiller dem, og en fork ville doblet alt framtidig
arbeid – inkludert to README-er.

**Buen er en bedre styring enn armene noen gang var.** To buede flater med samme
radius som holdes mot hverandre styrer hverandre i *begge* akser samtidig: koppen
sentrerer seg selv sideveis og retter seg opp mens den skyves inn, uten en
passform-toleranse å gjette på, uten fjærarmer og uten noe som slipper med et rykk.
De 0,4 mm `base_clear` er der for at de to flatene skal ligge inntil hverandre langs
hele buen i stedet for å hake seg fast på en høy flekk i den ene printen.

![Koppen med rund base på plass](img/coffee_spill_mug_round_on_plate.png)

Den gir også gratis kapasitet. Fundamentet buer seg *bort* fra koppen ut mot sidene,
så der den flatbakete versjonen måtte stoppe ved det nærmeste punktet, fortsetter
buen:

| Rund base | Verdi |
|---|---|
| Dybde på senterlinjen | 47,6 mm |
| Dybde i hjørnene | 60,1 mm – 12,5 mm lenger bak, og alt av det er trau og ikke vegg |
| Kapasitet | 50,6 ml, mot 46,5 på firkantbasen |
| Total dybde på delen | 60,1 mm; firkantversjonen er 66 mm på grunn av armene |
| Materialforbruk | 52,6 cm³, ca. 67 g |
| Buen | R 87,4 mm utvendig, R 89,8 mm innvendig, sentrum 135 mm bak frontflaten, `base_fn` = 240 segmenter (kordefeil 0,007 mm) |
| Bakre hjørner i planet | avrundet `rear_corner_r` = 3 mm, noe firkantversjonen ikke kan – se under |

![Koppen med rund base sett ovenfra](img/coffee_spill_mug_round_iso.png)

Bunnen er en salflate: bakrampen er 35°-profilen rotert om aksen til buen, så den
svinger oppover mot baksiden og mot hjørnene på én gang, og den flate delen av
bunnen er dypest tvers over forkanten.

![Den konkave buen sett rett ovenfra](img/coffee_spill_mug_round_top.png)

Fire tall i den runde delen av fila er fortsatt **plassholdere som trenger et
skyvelær**, og de er merket `MEASURE THIS` i kilden:

| Parameter | Plassholder | Hva som skal måles |
|---|---|---|
| `plate_depth_round` | 30 mm, kopiert fra firkantriggen | fri plate fra forkanten inn til det *nærmeste* punktet på det buete fundamentet. Dette er tallet som flytter alt annet: det bestemmer hvor langt bak buen ligger. Print `mode = "gauge"` og hold den mot riggen. |
| `base_h` | 20 mm | høyden på det buete fundamentet over platen. Bare spøkelset i `mode = "check"` bruker den, men den er det som forteller om buen er høy nok til å være verdt noe. |
| `disc_r` | 95 mm | radius på vektskålen, som henger ut over fundamentet – godt synlig på bildene av riggene |
| `disc_z` | 24 mm | høyden på undersiden av den skålen over platen. Sammen med `disc_clear` = 1,5 mm er det den som begrenser `tray_height`, og en `assert` håndhever det. |

`base_r` = 87 mm er ikke gjettet: den er hentet fra CAD-tegningen av fundamentet,
som gir R 87,00, diameter 174,00 og buelengde 182,25 mm. 182,25 / 87 = 2,094 rad =
**120,0°**, så fundamentet er en tilsiktet bue på 120° med korde 150,7 mm, og den
90 mm brede koppen dekker ±31° av den – godt innenfor endene.

## Hovedmål

Dette er tallene for firkantbasen; den runde basen skiller seg bare på det som står
i tabellen over.

| Mål | Verdi | Hvor det kommer fra |
|---|---|---|
| Bredde på selve koppen | 90 mm | begynte på 80, som var bredden på tunga foran på platen. Den er 90 nå for å gi teksten på frontflaten plass til å puste. Fortsatt bredeste punkt på hele delen – armene ligger *innenfor* sidene, ikke utenfor. |
| Dybde på platen | 30 mm | fri plate fra forkanten inn mot den grå sokkelen. Låst av riggen: koppen kan ikke bli dypere bakover. |
| Utstikk | 18 mm | ut forbi forkanten av platen, så drypp som renner over kanten også fanges. Var 10; den slakere bakrampen (se under) trenger 7 mm mer dybde enn en på 45°, og siden baksiden står mot sokkelen, legges den ekstra dybden på her. Det er gratis: beinet står på bordet helt fremme, så utstikket blir båret og ikke utkraget, og vippearmen blir bedre (se `foot_clear`). |
| Dybde på koppen | 48 mm | 18 + 30 |
| Total dybde | 66 mm | den høyre armen rekker 18 mm lenger bakover, langs siden av den grå sokkelen. Den venstre er kuttet ned til 14 mm for å gå klar av en kontakt på riggen. |
| Rimhøyde over platen | 20,5 mm | den grå sokkelen er 22 mm, og det er flere mm luft fra toppen av den opp til den store grå koppen, så rimet har god margin. Tilpasset med 2 mm-malen. |
| Platens høyde over bordet | 20,6 mm | hvor langt beinet rekker ned (`plate_height`), tilpasset med malen |
| Total høyde | 40,8 mm | fra bordet til rimet |
| Vegger / bunn | 2,4 / 2,0 mm | |
| Trau | 18,5 mm dypt, 46 ml til rimet | målt fra `mode = "cavity"` |
| Tekst på frontflaten | fire linjer, 6,5 mm, forsenket 0,6 mm, hvitt innlegg | `text_lines` / `text_size`, se under |

Selve riggen, målt med skyvelær – det er disse tallene passformen er utledet fra:

| Riggen (firkantbasen) | Verdi |
|---|---|
| Grå 3D-printet sokkel, bredde | 76 mm |
| Grå 3D-printet sokkel, høyde over teakplaten | 22 mm |
| Grå 3D-printet sokkel, dybde innover | ikke målt, «mye», rundt 76 mm |
| Kanal mellom sokkelen og display-foten, til venstre | **3,38 mm** (`foot_gap_l`). Det trangeste målet på hele riggen – se [Display-foten](#display-foten-som-er-trangere-enn-noe-i-fila). |
| Teakplaten, tykkelse | 19 mm |
| Teakplaten, overflate over bordet | 20,6 mm (`plate_height`, tilpasset med malen) |
| Teakplaten, sett ovenfra | 200 × 200 mm med 45°-avkapp på alle fire hjørner, så den lille sidekanten blir ca. 37 mm – altså en åttekant. Koppen står midt på forkanten, som er rett over ca. 148 mm, så hjørneavkappene er ikke i nærheten. Det er bare spøkelset i `mode = "check"` som bryr seg. |

## Den kan gjerne hvile på bordet

Lastcellen sitter oppe i den grå koppen kannen står i, så både teakplaten og bordet
er dødlast **nedenfor** målekjeden. Hva koppen hviler på har derfor ingen virkning
på vektavlesningen, og kontakt med bordet er en rein fordel: utstikket blir båret
i stedet for utkraget.

Det er nettopp det frontveggen gjør – den fortsetter ned forbi platekanten og står
på bordet:

![Det ytre tverrsnittet - samme profil som 2 mm-testmalen](img/coffee_spill_mug_profile.png)

Forfra og bakover i snittet: **beinet** (4 mm tykt, ned til bordet), **låsetunga**
som henger ned foran forkanten av platen og hindrer at koppen sklir bakover mot
kannen, og så den flate undersiden som hviler på platen.

Tre detaljer i snittet som er der med hensikt:

- **`foot_clear = 0,3` gjør beinet litt kort.** Koppen vipper om forkanten av
  platen, og beinet står 18 mm foran den kanten mens bakkanten ligger 30 mm bak.
  Et bein som er *e* mm for langt løfter derfor bakkanten *1,7 e* mm og spiser av
  klaringen under den grå koppen – det lengre utstikket hjelper her, det var *3 e*
  før. 0,3 mm er lite nok at beinet overtar så snart noe
  presser på utstikket, og nok til at koppen aldri vipper. Sett den til 0 for fast
  kontakt. På den runde basen ligger de bakre hjørnene 42 mm bak vippepunktet i
  stedet for 30, så et for langt bein løfter dem *2,3 e* – det er det ene stedet den
  ekstra dybden koster noe, og grunnen til at `disc_z` er verdt å måle framfor å anta.
- **En 45°-fas på forsiden av tunga**, fra baksiden av beinet ned til det nedre
  fremre hjørnet på tunga. Den flaten ville ellers blitt et tak i printet – se
  under. Fasen fyller mellomrommet mellom beinet og tunga med en kile, og det er
  harmløst siden alt sammen ligger foran platekanten.
- **`hook_relief = 1,0`** skjærer en 45°-avlastning i det innvendige hjørnet der
  undersiden møter tunga, så en avrundet eller lett fasa platekant likevel lar
  koppen sette seg helt ned.

Koppen veier ca. 65 g – 67 g på den runde basen – som blir et fast tillegg uansett:
**tarér vekta** med tom kopp på plass.

## De to armene – en glidepassform, med vilje

*Gjelder bare firkantbasen. På den runde basen ses `clamp_enable` bort fra, det
finnes ingen armer, og buen gjør denne jobben bedre – se over.*

Det som er verdt å gripe rundt, er den **grå 3D-printede sokkelen** som bærer
sensoren: en kloss 76 mm bred som står 22 mm opp fra teakplaten, rett bak koppen.
To finner 2,8 mm tykke rekker bakover fra bakflaten, én langs hver side av den.

De begynte som fjærarmer som klemte om sokkelen, og det er de **ikke lenger**.
`clamp_squeeze` er **−0,4 mm**, altså er åpningen 0,4 mm *videre* enn sokkelen i
stedet for smalere. Armene styrer koppen sideveis og holder den i vinkel med
riggen; låsetunga og vekta av koppen står for holdet. Et grep som må brytes,
slipper med et rykk, og en kopp med kafferester i som trekkes fram for tømming er
det siste stedet du vil ha et rykk. Sett `clamp_squeeze` over 0 for å få et
virkelig grep tilbake – men les neste avsnitt først.

Dit kom vi over fire printede tester: 0,4 mm total overlapp, som spriket
`gauge_clamp` ut så den ikke lot seg skyve inn, så 0,2, så 0,1, så forbi null til
−0,1 – og så **brakk den ene armen på den ferdige koppen mens den ble satt på
plass**, så nå er den −0,4.

### Hvorfor en arm brakk, og de tre tingene som er endret

0,05 mm overlapp skal ikke være noe, og etter bjelkeformelen i tabellen under er
det heller ikke noe: en brøkdel av en newton. Formelen er ikke problemet.
**Lagretningen** er det.

Koppen printes på frontflaten, så armene vokser *langs printaksen* – hvert lag
legger på en skive arm, og laggrensene løper på tvers av armen fra utsiden til
styreflaten. Å bøye en arm sideveis, som er nøyaktig det som skjer når koppen
presses ned over en sokkel som er en anelse for bred for den, drar de laggrensene
fra hverandre i strekk. En laggrense i PLA+ er det svakeste planet i hele delen,
grovt regnet halvparten av styrken i massivt materiale, og den er ikke duktil: den
bøyer seg ikke og spretter tilbake, den flerrer opp. Det er det bjelkeformelen,
som forutsetter et isotropt materiale, ikke har noen mulighet til å fortelle deg.

Tre endringer følger av det, og fila gjør alle tre:

1. **Ta bort overlappen.** `clamp_squeeze` −0,1 → **−0,4**, de 0,3 mm ekstra som
   ble bedt om. En arm som aldri tar i noe, blir aldri påkjent, og 0,2 mm luft per
   side ligger fremdeles langt innenfor det sideveis sluret som ville betydd noe.
2. **Gjør armen tykkere.** `clamp_t` 2,05 → **2,8 mm**. Mot en *last* – et støt, en
   hånd, å komme skjevt ned over riggen – går spenningen som 1/tykkelse², så dette
   halverer den med god margin. Merk at det bare hjelper *fordi* (1) er gjort: hvis
   armen fortsatt ble tvunget ut en fast avstand, ville en tykkere arm fått **mer**
   spenning, ikke mindre, for ved påtvunget utbøying går spenningen som tykkelse ×
   utbøying. Tykkelse og klaring er ikke uavhengige knapper.
3. **Utvid roten.** `clamp_root_r` = **2,5 mm** legger på en 45° kile der armen går
   ut fra bakflaten – punktet med det største bøyemomentet, og tidligere et skarpt
   innvendig hjørne som konsentrerte det ytterligere. Den kan bare legges på
   *utsiden*, siden styreflaten må være plan i hele sin lengde, så armen er 5,3 mm
   tykk ved roten og tynnes til 2,8 mm over de første 2,5 mm. Den er gratis å
   printe: tegnet i planet er kilen en skråflate som ligger langs printaksen, ingen
   overheng og ingen støtte. **Bare den høyre armen får en** – se neste avsnitt for
   grunnen.

Printer du i PETG i stedet, er alt dette mindre presserende – PETG har mye bedre
lagbinding enn PLA+ – men geometrien koster ingenting uansett.

De to armene er **ikke like lange**. Den høyre går hele 18 mm, men den venstre
butter i en kontakt på riggen et stykke bakover, så den er kuttet ned til 14 mm
(`clamp_len_l` / `clamp_len_r`; venstre og høyre er sett forfra, der du står og
utstikket peker mot deg, så den venstre armen er den ved x = 0 – bytt om på de to
tallene hvis det viser seg å være den andre siden på riggen din).

Sett ovenfra, med rimet nederst og armene bakover:

![De to armene sett ovenfra](img/coffee_spill_mug_clamp.png)

Armene ligger **ikke lenger i flukt med sidene**. Det gjorde de da koppen var
80 mm og sokkelen 76: 2,05 mm tykkelse traff nøyaktig det 2 mm store trinnet på
hver side. Ved 90 mm ville den samme regelen krevd en 7 mm plate, så de to er
koblet fra hverandre – `clamp_t` er den tykkelsen finna trenger, og armene ligger
3,2 mm innenfor sidene, der sokkelen setter dem. Det innrykket er ett av takene på
armen: kilen må holde seg innenfor bredden på koppen, noe som begrenser
`clamp_t + clamp_root_r` til 7 mm. Men det er ikke lenger det som binder – se
display-foten, neste avsnitt.

### Display-foten, som er trangere enn noe i fila

Endringen mot brekkasje over gikk på riggen og **lot seg ikke sette på**. Grunnen
hadde ingenting med koppen å gjøre: til venstre for sokkelen, sett forfra, står foten
til displayet på teakplaten, og den venstre armen må tres mellom den og siden av
sokkelen. Den kanalen er **3,38 mm** bred, målt på riggen, og den er det trangeste
målet i hele designet.

| | |
|---|---|
| Kanal, sidflaten på sokkelen til display-foten | 3,38 mm (`foot_gap_l`, målt) |
| Den gamle 2,05 mm armen | 0,2 mm glideluft + 2,05 mm arm = 2,25 mm. Passet, med 1,13 mm til gode. |
| Den 3,2 mm tykke armen | 0,2 + 3,2 = **3,40 mm i et 3,38 mm gap.** 0,02 mm for mye – som er nøyaktig derfor den *nesten* gikk på. |
| … med den 2,5 mm kilen | 0,2 + 3,2 + 2,5 = **5,90 mm.** Ikke i nærheten. |
| Nå | 0,2 + 2,8 = 3,00 mm, som etterlater `foot_clear_l` = 0,3 mm luft |

To ting er endret, og `foot_gap_l` er nå en parameter med en `assert` bak, så nettopp
denne overraskelsen kan ikke skje to ganger:

- `clamp_t` 3,2 → **2,8 mm**. Fortsatt 37 % mer arm enn de 2,05 som brakk, og
  tykkelsen betyr mye mindre nå som endring (1) har fjernet overlappen helt – armen
  blir ikke holdt bøyd i det hele tatt.
- Kilen er **per side**: `clamp_root_l` = 0, `clamp_root_r` = 2,5. Den vokser på
  utsiden, og på venstre side er det den flaten som peker mot display-foten, så en
  kile der er 2,5 mm ren overlapp. Å miste den til venstre er et mindre tap enn det
  ser ut som – kilen var tiltak (3) av tre, og (1) er det som faktisk gjør at armen
  ikke blir påkjent.

**Selve koppen er ikke berørt, og var det aldri.** Den er 7 mm bredere enn sokkelen på
hver side, men den står i sin helhet *foran* sokkelen, og display-foten sperrer bare
stripa langs siden av den. Så `tray_width` blir stående på 90, og merkingen beholder
plassen sin.

Det finnes ingen tilsvarende hindring på høyre side, og det er derfor den høyre armen
beholder kilen sin. Flytter displayet seg, øk `clamp_root_l`, og asserten sier fra om
det går.

| | |
|---|---|
| Styreflater | x = 6,8 og 83,2, altså en åpning på 76,4 mm på den 76 mm brede sokkelen: 0,2 mm klaring per side |
| Arm | 2,8 mm tykk, 5,3 mm ved den utvidede roten til høyre og uten kile til venstre, 17,5 mm høy, 18 mm fri lengde til høyre, 14 mm til venstre |
| Munn ved frie enden | 78,4 mm, avlastet `clamp_lead` = 1,0 mm per side slik at forkantene på sokkelen leder koppen inn i stedet for å hake seg fast i armtippene, og lukker seg inn over de siste 6 mm |
| Undersiden av armen | 1,5 mm over platen (`clamp_z0`), for å gå klar av en eventuell fillet eller elefantfot ved foten av sokkelen |
| Toppen av armen | 19 mm = `tray_height - edge_r`; høyere enn det ville avrundingen av rimet tynnet armen ned til en knivsegg |
| Hvis du legger overlapp tilbake | som isotrop bladfjær gir `k = 3EI/L³` med `I = b·t³/12` ca. 33 N/mm på den 18 mm lange armen i PETG ved 2,8 mm tykkelse, halvparten mer i PLA+, og stivheten går som 1/lengde³, så den korte 14 mm-armen er 2,1 ganger stivere igjen. **Men armen er ikke isotrop** – se avsnittet over om hvorfor den ene flerret opp langs en laggrense. Se på disse tallene som en øvre grense for hva armen tåler, ikke som et designmål. |

## Avrundede kanter, og hvorfor ikke `minkowski()`

| Kant | Behandling |
|---|---|
| De fire lange ytterkantene, langs dybden | fillet `edge_r` = 1,5 mm |
| Hele omkretsen av frontflaten | 45°-fas `front_c` = 1,0 mm |
| De to fremre hjørnene, sett ovenfra | 45°-kutt `corner_c` = 3 mm |
| Bakkanten av rimet | fillet `rear_r` = 1,5 mm |
| Bakkanten av undersiden | fillet `under_r` = 0,8 mm |
| Innerkanten av foten, kantene på låsetunga | fillet `foot_r` = 0,6 mm |
| Topp og bunn av armene, yttersiden | fillet `arm_r` = 0,8 mm |
| Frie enden av armene, sett ovenfra | fillet `clamp_r` = 0,4 mm |
| De bakre hjørnene sett ovenfra | står skarpe på firkantbasen – de ligger mot sokkelen, og armene har rota si i de hjørnene. Avrundet `rear_corner_r` = 3 mm på den runde basen, der ingenting har rota si i dem og et hjørne ytterst på 60 mm rekkevidde er nøyaktig det du henger en erme fast i. Det er gratis i printet: en loddrett kant i modellen ligger *langs* printaksen, så å avrunde den i planet bare kurver konturen i hvert lag. De fremre hjørnene er unntaket og blir stående som 45°-faser, siden en fillet der ville tangert printbordet. |
| Styreflatene | står skarpe – det er de flatene som ligger mot sokkelen |
| Over- og underkanten av buen | samme `rear_r` = 1,5 mm og `under_r` = 0,8 mm som på den flate bakflaten, rotert rundt buen |

**Alt som møter printbordet er fasa 45°, ikke avrundet.** En fillet langs
underkanten er tangent til bordet, så førstelaget blir liggende innenfor og
andrelaget henger ca. 0,8 mm ut i lufta; det printer som en ru, hengende leppe.
45° er det bratteste overhenget som kommer rent ut, og en fasa kant er ikke lenger
skarp mot handa. Alt annet er ekte filleter, og de er gratis i printet: de lange
kantene er prismer langs printaksen, og filletene på bakflaten og undersiden bare
krymper tverrsnittet etter hvert som printet vokser oppover. Målt på den ferdige
STL-fila vender ingen flate i delen mot bordet med mer enn nøyaktig 45°.

`minkowski()` med en kule ville avrundet alt på én linje, og på en enkel kloss er
det riktig verktøy. Ikke her: en Minkowski-sum bytter hvert punkt i objektet med
en kule med radius *r*, så **alle utoverflater vokser *r*** – det er definisjonen,
ikke en tilpasning. Den vanlige korreksjonen er å bygge kildeobjektet *r* mindre
først (`cube([w-2*r, d-2*r, h-2*r])` pluss `sphere(r)` gir eksakt w × d × h), men
her finnes det ingen enkelt skalar å krympe – og verre: det ville lukket munnen
mellom armene 2 *r* og gjort beinet ned til bordet *r* for langt, altså
nøyaktig de to målene som ikke får flytte seg. `offset()` og tangerende
fillet-buer fjerner bare materiale, så armavstanden (76,4/76 mm) og beinet
(20,3 mm) kommer ut eksakt som målt. Å runde ett navngitt hjørne av gangen holder
også de innvendige hjørnene skarpe.

## Printet på frontflaten – og hvorfor

Delen printes **liggende på frontflaten**, slik at printaksen går bakover langs
dybden av koppen.

![Liggende på frontflaten, klar for sliceren](img/coffee_spill_mug_print.png)

En tidligere versjon sto på en kortende, som er det åpenbare valget for trauet
alene. Armene gjør det umulig: begge styreflatene er plan med konstant x, og står
delen på høykant går printaksen langs x – da blir de styreflatene lagplan, og
innsiden av den øverste armen blir et tak som henger over ingenting. Å stille
koppen opp ned eller rett opp er verre: da ville hele undersiden blitt et tak på
30 × 90 mm i lufta over beinet.

Den runde basen vil ha samme orientering, men av en annen grunn. Den konkave buen
vender bakover, så liggende på frontflaten vender den rett *opp* – den ene retningen
som aldri er et overheng – og som en rotasjonsflate om en loddrett akse er den et
prisme langs printaksen overalt der den ikke blir filletert. Den trenger heller
ingen støtte.

![Den runde basen liggende på frontflaten](img/coffee_spill_mug_round_print.png)

Liggende på frontflaten går alle flater som *må* være loddrette – styreflatene,
sidene på armene – parallelt med printaksen og kommer ut nøyaktig som tegnet. Hele
frontflaten blir førstelaget, 90 × 40,8 mm massiv kontakt med bordet, og bunnen og
veggene i trauet printes som én sammenhengende kontur i hvert enkelt lag, så
hjørnet der de møtes ikke er en lagfuge kaffen kan sive gjennom. De to armene blir
de siste 14 og 18 mm av printet: to finner som står på bakflaten, hver med et fotavtrykk
på 2,8 × 17,5 mm (5,3 mm ved den utvidede roten til høyre). De printer greit, men senk farten på de siste lagene hvis
sliceren ikke gjør det selv.

Bare to flater vender mot printbordet i denne orienteringen:

1. **Innsiden av bakveggen.** Bunnen av trauet stiger opp til rimet over en radius
   `rear_fillet` = 12 mm og deretter en rett strekning på `rear_angle` = **35°**.
   Den var 45° – teoretisk grense for et overheng uten støtte – og det første
   printet kom ut synlig ru og hengende langs hele den flata i PLA. 45° betyr at
   hvert lag flytter seg en hel laghøyde sideveis, så hver streng blir lagt halvt i
   løse lufta; ved 35° flytter det seg bare 0,7 laghøyder, og det ligger virkelig
   materiale under hver streng. Kjør delkjølingsvifta for full musikk over de
   lagene.

   Den slakere rampen koster dybde: `rear_fillet · sin a + (cav_rise −
   rear_fillet · (1 − cos a)) / tan a` blir **30,2 mm** ved 35° mot 23,5 mm ved
   45°. Siden sokkelen låser baksiden, ble de 7 mm hentet foran, som `overhang`
   10 → 18. Det som står igjen, er en helt flat bunn på 75,2 × 8,0 mm fremst, og
   rampen er like mye en fordel som en kostnad. Trauet er dypest foran, så et søl
   samler seg ut over bordkanten og bort fra riggen. Og den lange slake skråningen
   er der dryppene faktisk lander: en dråpe som treffer den, brer seg ut som en
   tynn film over et mye større område enn den 2 mm dype dammen den ville laget på
   en flat bunn, og den filmen er godt avkjølt når den kommer ned. Større flate,
   mindre dybde, mindre varme – alle tre i riktig retning, og i PLA er det siste
   det som betyr noe.
2. **Forsiden av låsetunga**, fasa 45° som beskrevet over.

Målt på den ferdige STL-fila vender 2423 mm² av flatene mot bordet med 35°
(rampen) og 943 mm² med nøyaktig 45° (fasene). Ingenting er brattere.

På den runde basen er rampen samme profil rotert om aksen til buen, og det å rotere
den *hjelper*: etter hvert som rampen svinger rundt ut mot sidene får normalen en
x-komponent, så det bratteste overhenget på hele rampen er de 35° på senterlinjen og
alt til side for det er slakere. Målt på `coffee_spill_mug_round.stl`: 907 mm² på
35°, ytterligere 1686 mm² fordelt fra 34° ned til 30° etter hvert som rampen svinger
rundt, resten slakere igjen, og 943 mm² på nøyaktig 45° – de samme fasene, uendret.
Ingenting brattere enn 45° noe sted i noen av variantene.

De to kortendene trenger ingen slik behandling her – de er prismer langs
printaksen – så innsiden av dem er en rein `inner_fillet` = 5 mm avrunding, og den
flate bunnen beholder full bredde.

## Teksten på frontflaten

Siden frontflaten er førstelaget, kommer den ut som den glatteste flata på hele
delen – som gjør den til rett sted for en merking, og som bestemmer hvordan
merkingen må lages. Den er **nedsenket, ikke hevet**: hevede bokstaver på den flata
måtte vært printet *under* førstelaget, og det går ikke.

![Merkingen, svart kropp og hvitt innlegg](img/coffee_spill_mug_text_two_tone.png)

### Første forsøk mislyktes, på to måter

Den første koppen ble printet i én farge med teksten senket 0,6 mm ned, og
merkingen ble så godt som uleselig – i beste fall lesbar med en lampe holdt i
riktig vinkel. To helt forskjellige feil, og det er verdt å skille dem, for de har
ulik løsning:

1. **Ingen kontrast.** En tidligere versjon av denne fila hevdet at i svart
   filament leser skyggen i fordypningen bedre enn hevede bokstaver ville gjort.
   Det var feil. En 0,6 mm fordypning i matt svart plast kaster nesten ingen
   skygge, og en merking du må lyse på i vinkel er ingen merking.
2. **For tynne streker til å printes.** I Liberation Sans Bold er stor *I* bare en
   stamme, så bredden på den *er* strekbredden. Målt med `mode="text_measure"` er
   den 2,000 mm ved `text_size` = 10, altså:

   > **strekbredde = 0,20 · `text_size`**

   Ved den gamle størrelsen 4,2 blir det **0,84 mm**, altså 2,1 ekstruderinger med
   en 0,4 mm dyse. To og litt ekstruderinger kan ikke holde en bokstavform:
   omkretsene smelter sammen, hullene i *e*, *a* og *ø* fylles igjen, og resultatet
   er grøt. Regelen nå er **minst tre dysebredder**, `0,20 · text_size ≥ 1,2 mm`,
   altså `text_size ≥ 6,0`. En `assert` nekter blankt alt under 0,8 mm strekbredde,
   og en `echo` advarer mellom 0,8 og 1,2.

### Slik er den nå

| | |
|---|---|
| Linjer | `text_lines` = «SpareBank 1» / «kaffesølsamler» / «Trekk ut» / «for tømming» |
| Størrelse | `text_size` = 6,5 mm → 1,30 mm strek = 3,25 ekstruderinger à 0,4 mm |
| Avstand | `text_gap` = 2,3 mm mellom linjene, ≈ 0,35 · `text_size` |
| Font | `text_font` = Liberation Sans Bold |
| Dybde | `text_depth` = 0,6 mm, så det står igjen 1,8 mm av den 2,4 mm tykke veggen – en `assert` holder minst 1,2 mm – og 3 lag à 0,2 mm, nok til at innlegget leser som heldekkende hvitt |
| Plassering | midtstilt i bredden, senter av blokka `text_z` = 0 (flata går fra −20,6 til +20,5, så 0 midtstiller den) |
| Blokk | 32,9 mm nominelt, 34,9 mm virkelig blekk, på en 40,8 mm høy flate; 61,1 mm bred av de 80 tillatte |

Å rette strekbredden tvang fram ny ombrekking. **Bredden, ikke høyden, er det som
begrenser:** bare `tray_width − 2 · text_margin` = 80 mm er tilgjengelig, og ved
størrelse 6,5 er de gamle lange linjene altfor brede. Så merkingen ble fire korte
linjer i stedet for to lange. Målte bredder ved størrelse 10 – del på 10 og gang
med den størrelsen du vil ha:

| Streng | Bredde ved størrelse 10 | Ved 6,5 |
|---|---|---|
| «SpareBank 1» | 81,6 mm | 53,0 mm |
| «kaffesølsamler» | 93,9 mm | 61,1 mm ← den bredeste linja |
| «Trekk ut» | 51,8 mm | 33,7 mm |
| «for tømming» | 78,1 mm | 50,8 mm |
| «SpareBank 1 kaffesølsamler» | 180,5 mm | 117,3 mm ✗ |
| «Trekk ut for tømming» | 134,0 mm | 87,1 mm ✗ |

Endrer du en streng, mål den på samme måte i stedet for å gjette:

```sh
openscad -o /tmp/t.png -D 'mode="text_measure"' coffee_spill_mug.scad
```

`mode="text_measure"` legger blokka flatt som en 1 mm plate i origo, så en STL av
den gir deg den virkelige omsluttende boksen – både den faktiske blekkhøyden, som
er omtrent 2 mm mer enn `text_block_h` når underlengden i *g* og streken over *ø*
er med, og bredden på den bredeste linja.

Merk at kilden sier *kaffesølsamler* med e; ta den bort i `text_lines` hvis du vil
ha *kaffsølsamler*.

Ingenting trenger å speilvendes: bokstavene tegnes i (x, z)-planet og ekstruderes
langs +y inn i delen, og frontvisningen ser langs +y, så det du leser i renderingen
er det som kommer av printbordet.

### To farger: svart kropp, hvite bokstaver

Kontrastproblemet har ingen geometrisk løsning – det vil ha en farge til.
FlashForge Creator Pro 2 har to skrivehoder, så merkingen printes som et
**innlegg**: kroppen i svart fra det ene hodet, bokstavene i hvitt fra det andre, i
flukt med frontflaten.

Det betyr to STL-filer, og hele trikset er at de er **nøyaktig komplementære**: det
volumet kroppen lar stå tomt er det volumet innlegget fyller, uten klaring og uten
overlapp. Kontrollert med volum, som må summere seg opp helt presist:

| | Rund base | Firkantbase |
|---|---|---|
| Kropp, med fordypningen (`mode="print"`) | 52,39 cm³ | 51,55 cm³ |
| Hvitt innlegg (`mode="print_white"`) | 0,32 cm³ | 0,32 cm³ |
| Kopp uten tekst i det hele tatt | 52,71 cm³ | 51,88 cm³ |

Innlegget er samme del på begge riggene – de to `_white.stl`-filene er identiske
byte for byte – men begge skrives ut, slik at hver rigg har et opplagt par.

To detaljer i koden må være slik for at dette skal fungere:

- Innlegget starter på **y = 0 helt nøyaktig**, ikke på de −0,1 mm som kuttekroppen
  bruker for å unngå en sammenfallende flate. Stakk innlegget fram foran flata,
  ville sliceren enten droppe førstelaget eller løfte hele printen 0,1 mm, og da
  slutter de to filene å stemme med hverandre.
- Innlegget `intersection()`-es med kroppen, så det kan aldri stikke ut gjennom en
  fasing eller et avrundet hjørne, selv om `text_z` eller `text_size` skyves helt
  ut til det `assert`-ene tillater.
- De to filene har **samme senter i sin omsluttende boks**, og det er det som gjør at
  sliceren laster dem inn i register. Se under – denne kostet en printet kopp å lære.

#### Blekksentrering: de to filene deler senter i den omsluttende boksen

Å være komplementære i modellen er ikke nok. **FlashPrint, og de fleste andre
slicere, sentrerer hvert objekt på platformen når det lastes inn.** To filer som
ligger i perfekt register i modellen, havner derfor på bordet forskjøvet med
nøyaktig differansen mellom senterpunktene i de to omsluttende boksene – og
sliceren har gjort det stille, før du har tatt på noe som helst.

For denne merkingen var differansen ikke ingenting:

| | X-senter | Y-senter |
|---|---|---|
| Kropp | 45,000 | 20,400 |
| Innlegg, som først skrevet | 45,288 | **21,436** |

1,04 mm er nesten hele en 1,3 mm strek, så det hvite ville landet halvveis utenfor
fordypningen. Filene var riktige, og innrettingen var likevel gal.

Grunnen er at oppsettet sentrerer det **nominelle** tekstfeltet – `text_size` per
linje pluss mellomrommene – mens det virkelige blekket ikke fyller den boksen
symmetrisk. Oppstavelser (`B`, `k`, `T`, `1`) rekker over det, nedstavelser (`p`,
`g`, `ø`-en i *tømming*) under, og sidemargene til `S` og `1` er heller ikke like.

Så `text_ink_dx` = **−0,288 mm** og `text_ink_dz` = **+1,036 mm** flytter feltet til
blekkboksen er sentrert på flaten:

| | X-senter | Y-senter |
|---|---|---|
| Kropp | 45,000 | 20,400 |
| Innlegg, korrigert | 45,000 | 20,400 |
| Testplate for merkingen (`gauge_label`) | 45,000 | 20,400 |

Nå er det å sentrere hvert objekt for seg en **nulloperasjon**, og slicerens
standardoppførsel innretter filene i stedet for å ødelegge dem. Det ga samtidig en
millimeter mer klaring opp til rimet: toppen av blekket lå 1,94 mm under toppen av
flaten, og av det spiser den 1,0 mm store `front_c`-fasingen mesteparten; nå er det
2,97 mm.

**Disse to tallene er målt, ikke utregnet.** OpenSCAD kan ikke spørres om hvor bred
eller hvor høy en rendret tekststreng er, så endrer du `text_lines`, `text_size`,
`text_gap` eller fonten, må de måles på nytt:

1. Sett begge til 0.
2. `openscad -o /tmp/t.stl -D 'mode="print_white"' coffee_spill_mug.scad`
3. Les den omsluttende boksen til `/tmp/t.stl`. Målet er
   (`tray_width`/2, `face_h`/2) = (45, 20,4), som `echo` også skriver ut.
4. `text_ink_dx` = 45 − (målt X-senter);
   `text_ink_dz` = (målt Y-senter) − 20,4. **Merk motsatt fortegn:** print-y går
   nedover flaten mens modell-z går oppover den.

**Hvordan du faktisk kjører den** – én jobb, to hoder, og det ene steget det ikke
finnes noen vei tilbake fra – har fått sitt eget avsnitt:
[Slik kjører du tofargeprinten, steg for steg](#slik-kjører-du-tofargeprinten-steg-for-steg).

**Bokstavene står ikke i fare for å løsne,** som var bekymringen bak tanken om å
printe de første lagene med hull og fylle dem i en andre runde. De er ikke
frittstående øyer: hver bokstav er omgitt av svart på alle sider *i samme lag*, PLA
sveiset til PLA, og hele frontflata på 90 × 40,8 mm ligger på bordet. En slicer med
to hoder gjør allerede nøyaktig sekvensen hull–fyll–fortsett, lag for lag, og det
er bedre enn å gjøre det i to runder for hånd – en andre runde måtte hjemsøke og
varme opp på nytt med en halvferdig print på bordet.

For å se på den før printing:

```sh
# IKKE --render: CGAL kaster farge, så denne må rendres som forhåndsvisning
openscad -o img/coffee_spill_mug_text_two_tone.png -D 'mode="two_tone"' \
  --colorscheme=Tomorrow --projection=o --imgsize=1000,500 \
  --camera=45,0,0,90,0,0,115 coffee_spill_mug.scad
```

`mode="two_tone"` er en modus for bilde og ingenting annet: den tegner innlegget
uklippet og skjøvet 0,02 mm fram, fordi klippe-`intersection()`-en forvirrer
forhåndsvisningen og fordi sammenfallende flater flimrer mot hverandre. Ingen av de
to tingene påvirker de eksporterte STL-ene.

Forhåndsvisningen er skjør på denne modellen på én måte til: den må også regne ut
`difference()`-en som skjærer trauet og fordypningen ut av kroppen, og ved visse
kameraavstander tegner den et falskt lyst bånd tvers over frontflata der beinet
møter koppen – geometri som en CGAL-rendering viser at ikke finnes. Skjer det, endre
avstanden, eller bygg bildet fra de to **eksporterte STL-ene** i stedet, rotert
tilbake ut av printstillingen. Det er kanskje det beste bildet uansett: importerer du
de ferdige meshene, ser du nøyaktig det paret av filer printeren får, og det er
samtidig kontrollen på at de stemmer med hverandre.

```sh
cat > /tmp/two_tone.scad <<'EOF'
module unprint() { rotate([-90, 0, 0]) translate([0, -20.5, 0]) children(); }
unprint() color("#1a1a1a") import("stl/coffee_spill_mug.stl");
unprint() color("white")   import("stl/coffee_spill_mug_white.stl");
EOF
openscad -o img/coffee_spill_mug_text_two_tone.png --colorscheme=Tomorrow \
  --projection=o --imgsize=1000,500 --camera=45,0,0,90,0,0,115 /tmp/two_tone.scad
```

(`translate([0, -20.5, 0])` er `-tray_height`; sammen med `-90°`-rotasjonen opphever
det `on_front_face()`, så merkingen leses riktig vei.)

**Print `mode="gauge_label"` først.** Det er de fremste 2,4 mm av koppen som en flat
plate, med hele merkingen i full størrelse i den samme veggen den sitter i på den
virkelige delen, og den slices med `print_white` uendret som hvit halvpart. 10 g og en
halvtime mot 65 g og flere timer, for å finne ut om det hvite lander i fordypningen og
om resultatet er leselig tvers over rommet. Se [Testbiter](#testbiter).

**Vil du helst ikke printe på nytt:** koppen som alt finnes har en 0,6 mm fordypning
i seg. Gni hvit akryl- eller emaljemaling inn i den med en fingertupp og tørk flata
rein med en klut før den tørker. Det er den tradisjonelle måten å fylle en
gravering, det koster ingenting, og det retter kontrasthalvdelen av problemet –
men ikke de utflytende bokstavene, de er støpt inn i den printen.

## Testbiter

Fire billige print, i den rekkefølgen det er verdt å lage dem:

| `mode` | Kostnad | Hva den forteller |
|---|---|---|
| `"gauge_label"` | 10 g for paret | De fremste 2,4 mm av koppen som en flat plate: hele merkingen i full størrelse, i samme veggtykkelse som den har på den virkelige delen. Printes med `"print_white"`, uendret, som den hvite halvparten – innlegget er bare 0,6 mm dypt, så det passer i testplaten like godt som i koppen. Dette er den man lager **før** man binder opp 65 g i en tofarget kopp: lander det hvite i fordypningen, klarer sliceren å tegne en 1,3 mm strek i det hele tatt, og er resultatet leselig tvers over rommet? |
| `"gauge"` | 3 g | Hele tverrsnittet som en 2 mm skive, liggende flatt. Hekt den på forkanten av platen: rekker beinet ned til bordet, går tunga klar av det som er under platen, er det luft igjen opp til den grå koppen? |
| `"gauge_rear"` | 3 g | En 2,5 mm skive i toppen av koppen – det som lukker baksiden, og allerede liggende flatt. På firkantbasen en ring av vegg pluss begge armene, holdt fra hverandre med riktig avstand: går de ned langs sokkelen, finner munnen den, er det plass til en 2,8 mm arm ved siden, og går den venstre klar av display-foten? Den var 1,5 mm først, for slapt til å si noe i det hele tatt – den bare spriket ut. På den runde basen er baksiden av ringen hele den konkave buen: legg den mot det buete fundamentet og se om radien stemmer, og om den ligger inntil hele veien i stedet for å vippe på midten. `"gauge_clamp"` virker fortsatt som navn på den. |
| `"clip"` | 26 g firkant, 31 g rund | Baksiden av koppen, `clip_back` = 12 mm foran bakveggen, stående på kuttflaten – på firkantbasen de bakre 12 mm pluss begge armene komplett, på den runde hele de 24,5 mm som buen dekker (å måle 12 mm bakover fra *hjørnene* ville kuttet bort senterlinjen og etterlatt to vinger). Den eneste testen som viser hvordan koppen virkelig går på og av, men den koster en tredjedel av en kopp, så den er bare verdt det hvis `"gauge_rear"` gjør deg usikker. |

## Printing

| | |
|---|---|
| Printmål | 90 × 40,8 mm fotavtrykk, liggende på frontflaten; 66 mm høy på firkantbasen, 60,1 mm på den runde (FlashForge Creator Pro 2: 200 × 148 × 150 mm) |
| Materialforbruk | svart: 51,6 cm³ ≈ 64 g på firkantbasen, 52,4 cm³ ≈ 65 g på den runde. Hvitt: 0,32 cm³ ≈ 0,4 g – et par dagers tørketårn koster mer enn bokstavene gjør |
| Skrivehoder | to: hvitt i venstre, svart i høyre. Begge STL-ene lastet inn sammen, ingenting flyttet |
| Støtte | ingen |
| Bord | **60 °C**, ikke slicerens standard 40 °C |
| Brim | trengs ikke – førstelaget er hele frontflaten |
| Vegger | minst 3 perimetre, så de 2,4 mm veggene og de 2,8 mm armene blir massive |
| Kjøling | vifta for full musikk over den 35° bakrampen – det er den ene flata som bryr seg |

### Slik kjører du tofargeprinten, steg for steg

**Det er én printjobb, ikke to.** De to STL-filene er ikke to utskrifter som skal
kjøres etter hverandre – de er de to halvdelene av én jobb. Maskinen skifter hode
selv i hvert lag som har bokstaver i seg: svart kontur og fyll, hodeskifte, hvite
bokstaver ned i hullene, hodeskifte, videre til neste lag. Hele grunnen til at
filene er nøyaktig komplementære og deler ett koordinatsystem, er at sliceren skal
kunne gjøre nøyaktig dette, og der de to fargene møtes blir det en PLA-mot-PLA-sveis
inne i laget i stedet for en limt skjøt.

Filene, for firkantriggen (bytt inn `_round`-navnene for en buet base):

| Fil | `mode` | Hode | Mengde |
|---|---|---|---|
| `stl/coffee_spill_mug.stl` | `"print"` / `"print_body"` | **høyre**, svart | 51,6 cm³ ≈ 64 g |
| `stl/coffee_spill_mug_white.stl` | `"print_white"` | **venstre**, hvit | 0,32 cm³ ≈ 0,4 g |

Innlegget ligger i sin helhet i de fremste 0,6 mm av koppen, der de to basene har
samme form, så `coffee_spill_mug_round_white.stl` blir **byte for byte identisk** med
`coffee_spill_mug_white.stl`. Begge navnene beholdes likevel, slik at hver rigg har et
par som hører sammen og som ikke kan forveksles, og slik at parringen fortsatt holder
hvis buen en gang skulle komme så langt fram at den klipper en bokstav.

**Fargen står i filnavnet med hensikt.** Disse filene het `_text.stl` og
`_gauge_text.stl` en stund, og de to navnene ligner nok på hverandre til at
testplaten for merkingen ble lastet inn i sliceren sammen med kroppen – to svarte
filer, altså en jobb helt uten merking, og med platen usynlig i forhåndsvisningen
fordi den ligger fullstendig inne i kroppen. Regelen nå: alt som kommer ut av det
svarte hodet har ikke noe fargeord i navnet, den ene hvite fila sier `white`, og
testplaten for merkingen sier `label`. De gamle modusnavnene `print_text` og
`gauge_text` godtas fortsatt, slik at gamle kommandoer virker som før.

1. **Print testplaten først.** `mode="gauge_label"` sammen med `mode="print_white"` er
   den samme jobben i miniatyr – 10 g og en halvtime, mot 64 g og flere timer. Den
   svarer på hvert spørsmål dette avsnittet reiser, på printbordet i stedet for i
   teorien. Se [Testbiter](#testbiter).
2. **Last inn begge filene i samme jobb.** Kroppen først, så teksten; ikke start en
   ny jobb for den andre fila.
3. **Ikke flytt, roter, skaler eller auto-arranger noen av dem.** Dette er det ene
   steget det ikke finnes noen vei tilbake fra. Begge filene kommer ut av OpenSCAD i
   samme koordinater, allerede liggende på frontflaten og allerede plassert riktig i
   forhold til hverandre. En auto-arrangering som flytter den ene en millimeter,
   legger de hvite bokstavene inn i massiv svart vegg og lar fordypningen stå tom –
   og printen ser ikke gal ut før den er ferdig. Tilbyr sliceren «behold relativ
   posisjon» eller «behandle som ett objekt med flere deler», er det den
   innstillingen du vil ha.

   *Sentrering* er trygt, og det er med vilje: de to filene er bygget slik at de
   deler senter i den omsluttende boksen, så en slicer som sentrerer hvert objekt på
   platformen når det lastes inn, plasserer dem nøyaktig riktig. Se
   [Blekksentrering](#blekksentrering-de-to-filene-deler-senter-i-den-omsluttende-boksen)
   – det var ikke sant før, og det er verdt å vite hvilken av de to oppførslene som
   er den farlige. **Auto-arrangering er den farlige**, for den plasserer med hensikt
   objekter ved siden av hverandre så de ikke berører hverandre, som er det motsatte
   av hva dette paret trenger.

   Kommer de likevel inn feiljustert, er dette tallene å sjekke mot – begge
   omsluttende bokser i printkoordinater, fra OpenSCAD:

   | | X | Y | Z |
   |---|---|---|---|
   | kropp | 0 → 90 | 0 → 40,8 | 0 → 66 (firkant) / 60,1 (rund) |
   | innlegg | 14,469 → 75,531 | 2,973 → 37,827 | 0 → 0,6 |

   Begge sentrerer på (45; 20,4). Viser sliceren to forskjellige sentre, er det som
   gjorde dem forskjellige, det som skal angres.
4. **Tildel et hode til hvert objekt,** hvit til bokstavene og svart til kroppen.
5. **Sjekk hvilket hode som faktisk har hvitt** før du starter – mat ut noen
   centimeter fra hvert og se. Får du dette omvendt, ender du med svart-på-svart
   merking og en hvit kopp, altså en hel kopp kastet bort. Merk at FlashPrints
   «venstre» og «høyre» er maskinens, sett forfra, og er lett å lese motsatt vei.
6. **Bord 60 °C, ikke slicerens standard 40 °C.** Samme overstyring som alltid på
   denne printeren.
7. **Slå på prime-/tørketårn og oozeskjerm.** Risikoen i en tofargeprint er ikke
   feste, men at et hode som har stått stille et lag sikler svart ned i de hvite
   bokstavene ved neste hodeskifte. Tårnet koster mer filament enn bokstavene selv
   gjør, og det er verdt det.
8. **Ingen støtte, ingen brem, minst 3 perimetre.** Første lag er hele frontflata på
   90 × 40,8 mm; det er ingenting for en brem å hjelpe med.
9. **0,2 mm lag** gjør den 0,6 mm dype fordypningen nøyaktig tre lag dyp, så det
   hvite blir dekkende uten at svart skinner gjennom. Enhver laghøyde som går opp i
   0,6 fungerer like godt; en som ikke gjør det, gir et siste hvitt lag i delvis
   dybde.
10. **Se på slicerens forhåndsvisning i første lag og igjen ved 0,6 mm.** I lag 1
    skal du se hvite bokstavformer omgitt av svart i samme lag. Over 0,6 mm skal alt
    hvitt være borte. Legges det fortsatt hvitt ved 1 mm, har noe blitt flyttet.

**Er to farger ikke et alternativ** – ett hode, eller det hvite er tomt – print
kroppen alene og fyll fordypningen med maling, som under. Kropps-STL-en er den samme
uansett: en fordypning er en fordypning enten det kommer noe i den eller ikke.

**PETG er det riktige materialet, og er fortsatt anbefalingen.** Kaffe rett fra
kannen er 80–90 °C, og PLA begynner å bli mykt like over 55 °C. PETG (eller
ASA/PP) holder formen selv om en full kopp havner i trauet.

**Denne er printet i det som sto på hylla: eSUN PLA+ svart, 1,75 mm,
205–225 °C.** Det er et forsvarlig valg her, og verdt å skrive ned framfor å late
som noe annet:

- Dryppene er få, og de henger en stund på dispenseren før de slipper, så de er
  langt fra kannetemperatur når de lander i et trau som står tomt og har
  romtemperatur. Dette er en søl-fanger, ikke en kaffekopp.
- De lander på den 35° skråningen, ikke i en dam. En dråpe brer seg ut til en tynn
  film på vei ned og gir fra seg varmen til en stor veggflate underveis, så
  plasten ser aldri noe i nærheten av temperaturen dråpen kom med.
- PLA+ er *stivere* enn PETG (E ≈ 2,5–3,5 GPa mot rundt 2,0). Med en
  glidepassform betyr ikke det så mye lenger, men det betyr at armene blir
  stående der de er satt.
- PLA holder også målene bedre enn PETG: mindre krymp og mindre utsvelling i
  hjørnene, og det er det som holder 0,2 mm klaring per side til en klaring.

To ting å holde et øye med ved PLA, og begge handler om *vedvarende* last, ikke om
dryppene:

- **Kryp.** PLA relakserer under konstant tøyning langt lettere enn PETG. Det er
  ingen konstant tøyning i armene lenger, nå som de ikke klemmer, så dette gjelder
  bare hvis du setter `clamp_squeeze` tilbake over 0 – da vil grepet svekkes over
  noen måneder og vil ha en ny print.
- **Ikke tøm en varm kopp i den,** og tørk opp et søl heller enn å la nykokt kaffe
  stå i en 2 mm bunn. Det er det ene tilfellet der PLA faktisk ville blitt mykt.

## Bygge den om selv

Filene for firkantbasen er de opprinnelige og beholder de enkle navnene; de for den
runde basen har `_round` i navnet:

```sh
# firkantbasen - koppen, liggende på frontflaten, klar for sliceren, og det
# hvite innlegget til merkingen i samme koordinater
openscad -o stl/coffee_spill_mug.stl      -D 'mode="print"'      -D 'base="box"' coffee_spill_mug.scad
openscad -o stl/coffee_spill_mug_white.stl -D 'mode="print_white"' -D 'base="box"' coffee_spill_mug.scad

# ... og testbitene for den
openscad -o stl/coffee_spill_mug_gauge.stl       -D 'mode="gauge"'      -D 'base="box"' coffee_spill_mug.scad
openscad -o stl/coffee_spill_mug_gauge_clamp.stl -D 'mode="gauge_rear"' -D 'base="box"' coffee_spill_mug.scad
openscad -o stl/coffee_spill_mug_clip.stl        -D 'mode="clip"'       -D 'base="box"' coffee_spill_mug.scad

# testplata for merkingen - samme fil for begge riggene, den er bare frontflaten
openscad -o stl/coffee_spill_mug_gauge_label.stl  -D 'mode="gauge_label"' -D 'base="box"' coffee_spill_mug.scad

# den runde basen
openscad -o stl/coffee_spill_mug_round.stl      -D 'mode="print"'      -D 'base="round"' coffee_spill_mug.scad
openscad -o stl/coffee_spill_mug_round_white.stl -D 'mode="print_white"' -D 'base="round"' coffee_spill_mug.scad

openscad -o stl/coffee_spill_mug_round_gauge.stl      -D 'mode="gauge"'      -D 'base="round"' coffee_spill_mug.scad
openscad -o stl/coffee_spill_mug_round_gauge_rear.stl -D 'mode="gauge_rear"' -D 'base="round"' coffee_spill_mug.scad
openscad -o stl/coffee_spill_mug_round_clip.stl       -D 'mode="clip"'       -D 'base="round"' coffee_spill_mug.scad
```

`base` står som `"round"` i fila, siden det er det de fleste riggene viser seg å ha
– send `-D 'base="box"'` for den opprinnelige, som over.

Åpne `coffee_spill_mug.scad` for å se på den i stedet. `mode` bestemmer hva som
tegnes:

| `mode` | |
|---|---|
| `"use"` | som den står på platen. z = 0 er platetoppen, y = 0 er frontflaten, x = 0 er venstre side av koppen |
| `"check"` | som `"use"`, med teakplaten, bordet og basen bak koppen tegnet som spøkelser for visuell passkontroll – den grå boksen eller det buete fundamentet pluss vektskålen som henger ut over det, alt etter hva `base` sier |
| `"print"` | liggende på frontflaten, klar for sliceren. Den svarte delen, med bokstavene senket ned. `"print_body"` er et synonym, for når det er greiere å si hvilken av de to det er |
| `"print_white"` | bare det hvite innlegget, i samme posisjon, klart for den andre ekstruderen |
| `"two_tone"` | begge, i filamentfargene sine, for å se på merkingen. Kun forhåndsvisning – CGAL kaster farge, så ikke `--render` |
| `"text_measure"` | tekstblokka lagt flatt som en 1 mm plate i origo, for å måle virkelig bredde og blekkhøyde |
| `"gauge"`, `"gauge_rear"`, `"gauge_label"`, `"clip"` | testbitene over, alle klare for sliceren |
| `"cavity"` | traurommet som et massivt volum, for å måle kapasiteten |

Alle parametrene ligger øverst i fila, med `base` først. `echo` skriver ut hvilken
base som er aktiv, ytre mål, den flate bunnen, fotavtrykket i printet, og så enten
armene med styreflatene sine eller de to radiene i buen med dybden den rekker på
senterlinjen og i hjørnene.

`assert` stopper renderingen hvis bakrampen ikke får plass i dybden, hvis tunga
kolliderer med beinet eller rekker under foten, hvis tekstfordypningen etterlater
mindre enn 1,2 mm frontvegg, eller hvis en fillet eller fas er for stor for kanten
den skal bryte. På firkantbasen sjekker den i tillegg at ingen arm havner utenfor
siden av koppen – heller ikke den utvidede roten, som er det bredeste punktet på den
– blir høyere enn sokkelen, kommer inn i avrundingen av rimet eller rekker forbi
baksiden av sokkelen, at ingen av kilene er lengre enn sin egen arm, at den venstre
armen går klar av display-foten, og at munnen på armene ikke blir smalere enn
sokkelen. På den runde basen sjekker den i stedet at buen har stor nok radius til å
rekke ut til sidene i det hele tatt, at koppen ikke er bredere enn den buete delen av
fundamentet, at den roterte rampen etterlater en flat bunn, og at rimet går klar av
undersiden av den utstikkende vektskålen.

### Slik sjekker du alle modusene på én gang

`./check_modes.sh` kjører alle 14 modusene mot begge basene – 28 kombinasjoner – og
melder om noen av dem gir feil eller trigger en `assert`. Den har to nivåer, og de
skiller seg i kostnad med en faktor på rundt tre tusen:

| | Hva den sjekker | Kostnad |
|---|---|---|
| `./check_modes.sh` | parametre, `echo`, hver `assert` | 0,3 s |
| `./check_modes.sh --full` | alt det, pluss full CGAL-geometri | 2 min 46 s |

Det raske nivået eksporterer til `.echo` i stedet for `.stl`. OpenSCAD evaluerer
fortsatt hele parametersettet og hele CSG-treet, så hver `assert` fyrer, men treet blir
aldri levert til CGAL – og det er der praktisk talt all tiden går. Det fanger de
feilene som er verdt å fange på hver endring: en `assert` som nå slår inn, en variabel
brukt før den er deklarert, et modusnavn som har falt ut av dispatchen. Det fanger
*ikke* geometrifeil, så kjør `--full` før du committer nye STL-er.

Én felle, hvis du skriver noe slikt selv: med `-o noe.echo` skriver OpenSCAD feilene
**inn i .echo-fila** og avslutter likevel med kode 0. Exit-koden sier ingenting; fila
må grep-es.

Det fulle nivået kjører parallelt over alle kjerner, og det er det som gjør det
utholdelig. Sveipen koster 20 min 47 s CPU-tid, men bare 2 min 46 s veggklokke – omtrent
det den tregeste enkeltkombinasjonen koster alene. `base="round"` er rundt 60 s dyrere
enn `base="box"` i hver modus, fordi bakbuen er to `rotate_extrude()`-kall med
`base_fn = 240`, og `"two_tone"` bygger begge halvdelene av merkingen og betaler derfor
tekst-CSG-en to ganger:

| | `box` | `round` |
|---|---|---|
| `"use"` | 7,9 s | 69,9 s |
| `"print"` | 9,7 s | 74,2 s |
| `"print_white"` | 15,4 s | 16,6 s |
| `"two_tone"` | 51,2 s | 119,9 s |

Mens du eksperimenterer med den runde basen kutter `-D base_fn=48` en render fra 74 s
til 22 s. Aldri eksporter en STL på den måten – 48 fasetter etterlater synlige flate
partier på en R 87 mm bue. Tallene er fra OpenSCAD 2021.01, som bare har den gamle
CGAL-motoren; 2022 og senere har Manifold-motoren, som typisk er en størrelsesorden
raskere på nettopp denne typen CSG.
