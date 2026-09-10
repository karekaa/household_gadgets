# Kaffesøl-kopp

> English version: [README.md](README.md)

Et lavt trau som fanger opp kaffen som renner ned langs kannen og utover platen, i
stedet for at det ender på bordet og i et tørkepapir. Den står på den frie
forkanten av teakplaten under den internett-tilkoblede kaffevekten, strekker seg ut
over ytterkanten av platen, og låser seg til riggen med to fjærklemmer når man
skyver den på.

![Koppen på plass på platen](img/coffee_spill_mug_on_plate.png)

Selve koppen er **80 × 40 × 20,5 mm** over platen og holder **ca. 35 ml**. Den
hviler på platen over de bakre 30 mm, de forreste 10 mm stikker ut forbi
platekanten, og frontveggen fortsetter ned til bordet.

![Koppen sett ovenfra](img/coffee_spill_mug_iso.png)

## Hovedmål

| Mål | Verdi | Hvor det kommer fra |
|---|---|---|
| Bredde på selve koppen | 80 mm | bredden på sokkelen foran på platen, målt til 80,10 mm |
| Bredeste punkt | 84,4 mm | fjærklemmene står 2,2 mm utenfor koppen på hver side |
| Dybde på platen | 30 mm | fri plate fra forkanten inn mot sensorholderen |
| Utstikk | 10 mm | ut forbi forkanten av platen, så drypp som renner over kanten også fanges |
| Total dybde | 40 mm | 10 + 30 |
| Rimhøyde over platen | 20,5 mm | **maksimum** – gir luftrom opp til undersiden av den store grå koppen kannen står i. Tilpasset med 2 mm-malen. |
| Platens høyde over bordet | 20,6 mm | hvor langt beinet rekker ned (`plate_height`), også tilpasset med malen |
| Total høyde | 40,8 mm | fra bordet til rimet |
| Vegger / bunn | 2,4 / 2,0 mm | |
| Trau | 18,5 mm dypt, 35 ml til rimet | målt fra `mode = "cavity"` |

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
  platen, og beinet står 10 mm foran den kanten mens bakkanten ligger 30 mm bak.
  Et bein som er *e* mm for langt løfter derfor bakkanten *3 e* mm og spiser av
  klaringen under den grå koppen. 0,3 mm er lite nok at beinet overtar så snart noe
  presser på utstikket, og nok til at koppen aldri vipper. Sett den til 0 for fast
  kontakt.
- **En 45°-fas på forsiden av tunga**, fra baksiden av beinet ned til det nedre
  fremre hjørnet på tunga. Den flaten ville ellers blitt et tak i printet – se
  under. Fasen fyller mellomrommet mellom beinet og tunga med en kile, og det er
  harmløst siden alt sammen ligger foran platekanten.
- **`hook_relief = 1,0`** skjærer en 45°-avlastning i det innvendige hjørnet der
  undersiden møter tunga, så en avrundet eller lett fasa platekant likevel lar
  koppen sette seg helt ned.

Koppen veier ca. 50 g, som blir et fast tillegg – **tarér vekta** med tom kopp på
plass.

## Fjærklemmene på sidene

Hver side har en bladfjær som griper om siden av sokkelen, så koppen låser seg til
riggen når man skyver den på forfra, og løsner med et bestemt løft. Les snittet med
rimet øverst og platens overflate der bunnen av trauet er:

![Tverrsnitt gjennom en klemme](img/coffee_spill_mug_clamp.png)

Ovenfra og ned: en **bro** binder klemma til sideveggen 12 mm over platen, en
**arm** på 1,6 mm går ned langs utsiden av den veggen, skilt fra den med en 0,6 mm
**spalte**, og nederst svinger armen inn under koppen til en **klo** som rekker
5 mm ned forbi platetoppen og presser mot siden av sokkelen. Klemma er 26 mm lang.

Bøyningen skjer over hele de 12 mm av armen, ikke i en kort rot, og det er det som
gjør grepet fjærende i stedet for sprøtt: tallene over gir omtrent **6 N per side**
ved 0,2 mm utbøying, med et spenningstopp rundt 7 MPa – cirka en sjuendedel av hva
PETG tåler. `clamp_squeeze` (0,4 mm totalt over begge sider) er tallet du justerer
hvis grepet er for svakt eller koppen er for tung å skyve på.

Gripeflaten er avlastet `clamp_lead` = 1,0 mm helt foran og nærmer seg sokkelen
over de første 10 mm, slik at forkanten av sokkelen kiler klørne ut i stedet for å
gå rett i dem.

**To mål du bør ta før du printer hele koppen:**

- `clamp_depth` = 5 mm må holde seg innenfor tykkelsen på sokkelen ved forkanten,
  ellers kommer klørne i konflikt med det som er under.
- `clamp_len` = 26 mm må holde seg innenfor lengden der sokkelen faktisk er
  80,1 mm bred, før den utvider seg innover mot sensorholderen.

## Printet på frontflaten – og hvorfor det ble endret

Delen printes **liggende på frontflaten**, slik at printaksen går bakover langs
dybden av koppen.

![Liggende på frontflaten, klar for sliceren](img/coffee_spill_mug_print.png)

En tidligere versjon sto på en kortende, som er det åpenbare valget for trauet
alene. Klemmene gjør det umulig: en klemme kan bare vokse 45° per lag, så en klo
som skal 5 mm ned under koppen måtte stått 5 mm ut fra siden med en 45° innside –
og en 45°-flate kan ikke klemme mot en loddrett side.

Liggende på frontflaten går alle flater som *må* være loddrette – gripeflatene,
spalten, armene – parallelt med printaksen og kommer ut nøyaktig som tegnet. Hele
frontflaten blir førstelaget, 80 × 40,8 mm massiv kontakt med bordet, og bunnen og
veggene i trauet printes som én sammenhengende kontur i hvert enkelt lag, så
hjørnet der de møtes ikke er en lagfuge kaffen kan sive gjennom.

Bare to flater vender mot printbordet i denne orienteringen, og begge er løst med
45°, det bratteste overhenget som printer uten støtte:

1. **Innsiden av bakveggen.** Bunnen av trauet stiger opp til rimet over en radius
   `rear_fillet` = 12 mm, fra vannrett opp til 45°, og deretter en rett
   45°-strekning. Strekningen koster
   `(tray_height - floor_t) + 0,41 · rear_fillet` = 23,5 mm av de 35,2 mm
   innvendige dybden, og lar en flat bunn på 65 × 6,7 mm stå igjen fremst. Det er
   like mye en fordel som en kostnad: trauet er dypest foran, så et søl samler seg
   ut over bordkanten og bort fra riggen.
2. **Forsiden av låsetunga**, fasa som beskrevet over.

De to kortendene trenger ingen slik behandling her – de er prismer langs
printaksen – så innsiden av dem er en rein `inner_fillet` = 5 mm avrunding, og den
flate bunnen beholder full bredde.

## Testbiter

Tre billige print, i den rekkefølgen det er verdt å lage dem:

| `mode` | Kostnad | Hva den forteller |
|---|---|---|
| `"gauge"` | 2 g | Hele tverrsnittet som en 2 mm skive, liggende flatt. Hekt den på forkanten av platen: rekker beinet ned til bordet, går tunga klar av det som er under platen, er det luft igjen opp til den grå koppen? |
| `"gauge_clamp"` | 1 g | En 1,5 mm skive på tvers av begge klemmene, liggende flatt. Lander klørne på sidene av sokkelen, og glir den på? Merk at fjærkraften skalerer med lengden på klemma, så en 1,5 mm skive klemmer bare ca. 1/17 så hardt som den ferdige koppen – bedøm passformen her, ikke friksjonen. |
| `"clip"` | 28 g | De forreste 26 mm av koppen i printorientering: bein, tunge og begge klemmene komplett. Dette er den virkelige friksjonstesten, men den koster en halv kopp, så den er bare verdt det hvis `"gauge_clamp"` gjør deg usikker på `clamp_squeeze`. |

## Printing

| | |
|---|---|
| Printmål | 84,4 × 40,8 mm fotavtrykk, 40 mm høy, liggende på frontflaten (FlashForge Creator Pro 2: 200 × 148 × 150 mm) |
| Materialforbruk | 40 cm³, ca. 50 g |
| Støtte | ingen |
| Brim | trengs ikke – førstelaget er hele frontflaten |
| Vegger | minst 3 perimetre, så de 2,4 mm veggene og de 1,6 mm klemmearmene blir massive |

**Velg PETG framfor PLA.** Kaffe rett fra kannen er 80–90 °C, og PLA begynner å bli
mykt like over 55 °C. PETG (eller ASA/PP) holder formen når en full kopp havner i
trauet, og er en bedre fjær enn PLA.

## Bygge den om selv

```sh
# koppen, liggende på frontflaten, klar for sliceren
openscad -o stl/coffee_spill_mug.stl -D 'mode="print"' coffee_spill_mug.scad

# testbitene
openscad -o stl/coffee_spill_mug_gauge.stl       -D 'mode="gauge"'       coffee_spill_mug.scad
openscad -o stl/coffee_spill_mug_gauge_clamp.stl -D 'mode="gauge_clamp"' coffee_spill_mug.scad
openscad -o stl/coffee_spill_mug_clip.stl        -D 'mode="clip"'        coffee_spill_mug.scad
```

Åpne `coffee_spill_mug.scad` for å se på den i stedet. `mode` bestemmer hva som
tegnes:

| `mode` | |
|---|---|
| `"use"` | som den står på platen. z = 0 er platetoppen, y = 0 er frontflaten, x = 0 er venstre side av koppen |
| `"check"` | som `"use"`, med sokkelen og bordet tegnet som spøkelser for visuell passkontroll |
| `"print"` | liggende på frontflaten, klar for sliceren |
| `"gauge"`, `"gauge_clamp"`, `"clip"` | testbitene over, alle klare for sliceren |
| `"cavity"` | traurommet som et massivt volum, for å måle kapasiteten |

Alle parametrene ligger øverst i fila. `echo` skriver ut ytre mål, den flate
bunnen, hvor gripeflatene ligger og fotavtrykket i printet; `assert` stopper
renderingen hvis bakrampen ikke får plass i dybden, hvis tunga kolliderer med
beinet eller rekker under foten, hvis en klemme rekker forbi bakflaten eller under
foten, eller hvis munnen på klemmene blir smalere enn sokkelen.
