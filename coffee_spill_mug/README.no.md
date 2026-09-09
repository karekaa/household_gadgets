# Kaffesøl-kopp

> English version: [README.md](README.md)

Et lavt trau som fanger opp kaffen som renner ned langs kannen og utover platen, i
stedet for at det ender på bordet og i et tørkepapir. Den står på den frie
forkanten av teakplaten under den internett-tilkoblede kaffevekten, og strekker seg
ut over ytterkanten av platen.

![Koppen på plass på platen](img/coffee_spill_mug_on_plate.png)

Koppen er **80 × 40 × 19 mm** over platen og holder **ca. 32 ml**. Den hviler på
platen over de bakre 30 mm, de forreste 10 mm stikker ut forbi platekanten, og
frontveggen fortsetter ned til bordet.

![Koppen sett ovenfra](img/coffee_spill_mug_iso.png)

## Hovedmål

| Mål | Verdi | Hvor det kommer fra |
|---|---|---|
| Bredde | 80 mm | bredden på tunga foran på platen, målt til 80,10 mm |
| Dybde på platen | 30 mm | fri plate fra forkanten inn mot sensorholderen |
| Utstikk | 10 mm | ut forbi forkanten av platen, så drypp som renner over kanten også fanges |
| Total dybde | 40 mm | 10 + 30 |
| Rimhøyde over platen | 19 mm | **maksimum** – gir luftrom opp til undersiden av den store grå koppen kannen står i |
| Platens høyde over bordet | 20 mm | hvor langt beinet må ned – **mål denne** (`plate_height`) |
| Vegger / bunn | 2,4 / 2,0 mm | |
| Kapasitet til rimet | ca. 32 ml | skrives ut av `echo` når fila rendres |

## Den kan gjerne hvile på bordet

Lastcellen sitter oppe i den grå koppen kannen står i, så både teakplaten og bordet
er dødlast **nedenfor** målekjeden. Hva koppen hviler på har derfor ingen virkning
på vektavlesningen, og kontakt med bordet er en rein fordel: utstikket blir båret
i stedet for utkraget.

Det er nettopp det frontveggen gjør – den fortsetter ned forbi platekanten og står
på bordet:

![Tverrsnitt: bein, låsetunge og rimet 19 mm over platen](img/coffee_spill_mug_profile.png)

Fra venstre mot høyre i snittet: **beinet** (4 mm tykt, ned til bordet), åpen luft,
**låsetunga** som henger ned foran forkanten av platen og hindrer at koppen sklir
bakover mot kannen, og så den flate undersiden som hviler på platen.

Tre detaljer i snittet som er der med hensikt:

- **`foot_clear = 0,3` gjør beinet litt kort.** Koppen vipper om forkanten av
  platen, og beinet står 10 mm foran den kanten mens bakkanten ligger 30 mm bak.
  Et bein som er *e* mm for langt løfter derfor bakkanten *3 e* mm og spiser av
  klaringen under den grå koppen. 0,3 mm er lite nok at beinet overtar så snart noe
  presser på utstikket, og nok til at koppen aldri vipper. Sett den til 0 for fast
  kontakt når `plate_height` er målt nøyaktig.
- **3 mm åpen luft mellom beinet og tunga**, slik at et bord under teakplaten som
  stikker et par mm fram ikke er i veien.
- **`hook_relief = 1,0`** skjærer en 45°-avlastning i det innvendige hjørnet der
  undersiden møter tunga, så en avrundet eller lett fasa platekant likevel lar
  koppen sette seg helt ned.

Koppen veier ca. 42 g, som blir et fast tillegg – **tarér vekta** med tom kopp på
plass.

## Buede kortender, og hvorfor

Delen printes **stående på en kortende**. Da går lagene langs trauet, hver vegg
printes som en ubrutt perimeter uten en vannrett lagfuge i hjørnet mellom bunn og
vegg der kaffen kan sive ut, og den tynne bunnen blir ikke et førstelag.

![Stående på enden, klar for sliceren](img/coffee_spill_mug_print.png)

Hele utsiden av koppen er et prisme langs printaksen, så den har ikke overheng i
det hele tatt. Innsiden av den *øvre* kortenden er unntaket: en flat vegg der ville
blitt et ustøttet tak på 35 × 17 mm. Derfor stiger innsiden av begge kortendene fra
traubunnen opp til rimet over

1. en radius `end_fillet` = 12 mm, fra vannrett opp til 45°, og deretter
2. en rett 45°-strekning opp til rimet.

45° er det bratteste overhenget som printer uten støtte, og radien gir overgangen
en form som er lett å tørke ut. Strekningen koster
`(tray_height - floor_t) + 0,41 · end_fillet` = 22 mm trau i hver ende, som lar
**31 mm flat bunn** stå igjen i midten. Øk `end_fillet` for mykere innside, senk
den for mer volum, 0 gir en rein 45°-rampe.

Å printe liggende går også bra og trenger heller ikke støtte, men gir nettopp den
vannrette lagfugen der bunnen møter veggene.

## Testmal

`mode = "gauge"` gir en massiv 2 mm tykk skive av tverrsnittet, liggende flatt. Den
koster 2 g og et par minutter:

```sh
openscad -o stl/coffee_spill_mug_gauge.stl -D 'mode="gauge"' coffee_spill_mug.scad
```

Ta den bort til kannen, hekt den på forkanten av platen og sjekk at beinet rekker
ned til bordet, at tunga går klar av det som er under platen, og at det er luft
igjen opp til den grå koppen – før du printer hele koppen.

## Printing

| | |
|---|---|
| Printmål | 38,7 × 40 × 80 mm, stående på enden (FlashForge Creator Pro 2: 200 × 148 × 150 mm) |
| Materialforbruk | 34 cm³, ca. 42 g |
| Støtte | ingen |
| Brim | ja – fotavtrykket er 38,7 × 40 mm under en 80 mm høy del |
| Vegger | minst 3 perimetre, så de 2,4 mm veggene blir massive og tette |

**Velg PETG framfor PLA.** Kaffe rett fra kannen er 80–90 °C, og PLA begynner å bli
mykt like over 55 °C. PETG (eller ASA/PP) holder formen når en full kopp havner i
trauet.

## Bygge den om selv

```sh
# koppen, stående på enden, klar for sliceren
openscad -o stl/coffee_spill_mug.stl -D 'mode="print"' coffee_spill_mug.scad

# 2 mm testmal
openscad -o stl/coffee_spill_mug_gauge.stl -D 'mode="gauge"' coffee_spill_mug.scad
```

Åpne `coffee_spill_mug.scad` for å se på den i stedet. `mode` bestemmer hva som
tegnes:

| `mode` | |
|---|---|
| `"use"` | som den står på platen. z = 0 er platetoppen, y = 0 er frontflaten, x = 0 er venstre kortende |
| `"check"` | som `"use"`, med platen og bordet tegnet som spøkelser for visuell passkontroll |
| `"print"` | stående på venstre kortende, klar for sliceren |
| `"gauge"` | 2 mm-skiva av tverrsnittet, liggende flatt |

Alle parametrene ligger øverst i fila. `echo` skriver ut ytre mål, lengden på den
flate bunnen og kapasiteten; `assert` stopper renderingen hvis `end_fillet` er for
stor for trauet, hvis tunga kolliderer med beinet, eller hvis tunga rekker lenger
ned enn foten på beinet.
