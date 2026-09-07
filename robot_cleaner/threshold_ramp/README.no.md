# Terskelrampe (modulbasert)

> Oversettelse av [README.md](README.md) – ved avvik gjelder den engelske.

Kilerampe som skal la robotstøvsugeren kjøre over en høy dørterskel. Den ligger
på **utsiden** av terskelen (siden uten dørblad); på innsiden klarer roboten seg
på det trappelignende trinnet som alt er der.

![Den ferdige rampen, 810 mm](img/threshold_ramp_assembly.png)

Profilen er en rettvinklet trekant med kateter **27 mm** (høyde) × **150 mm**
(dybde) = **10,2° stigning**, total bredde **810 mm**. Rampen er delt i
**7 moduler à 115,7 mm** som klikkes sammen på stedet, siden 810 mm ikke går på
byggeplata til en FlashForge Creator Pro 2 (200 × 148 × 150 mm).

Terskelen varierer fra 27 til 42 mm i høyde. Rampa møter den på 27 mm; resten av
høydeforskjellen tar roboten selv (den klarer 20–25 mm uten rampe).

## Parametrisering

Alt ligger i toppen av `threshold_ramp.scad`:

| Parameter | Betydning |
|---|---|
| `height_profile` | `[[avstand fra venstre, høyde], ...]`. Like høyder = flat topp. Skal toppen følge en terskel som varierer, mål f.eks. hver 100 mm og legg inn alle punktene – toppflaten loftes gjennom hvert punkt. |
| `ramp_run` | dybden på skråplanet. 150 → 10,2°, 120 → 12,7°, 100 → 15,1° (ved 27 mm) |
| `total_width` | bredden på ferdig rampe |
| `n_modules` | antall moduler; modullengde = `total_width / n_modules` |
| `bed_x/y/z` | byggevolumet, brukt i `assert` |
| `label_enable` | graverer modulnummer i bakflaten. Slå på når `height_profile` ikke er flat, for da må modulene monteres i riktig rekkefølge |
| `dim_enable` | graverer rampas mål (`810x150x27 mm`, satt sammen av parameterne) i sokkelenden – kortenden som er skjult inne i skjøten. Modul 1 har ingen sokkel og får derfor ingen tekst |

`echo` skriver ut vinkel, modullengde, utskriftsmål og hvilken akse modulen skal
legges langs. `assert` stopper renderingen hvis modulen ikke passer på plata i
noen av de to orienteringene, eller hvis skjøten havner på for tynt materiale.

## Tilpasset roboten

- **Stigning 10,2°** – godt under de ca. 15–17° der robotstøvsugere begynner å
  spinne.
- **Rillene matcher drivhjulet.** `grip_pitch = 8` mm ligger på samme avstand som
  knottene i hjulmønsteret, og rillene er ca. 1 mm dype, så knottene får noe å
  gripe i istedenfor å spinne på glatt plast. `grip_enable = false` gir helt
  glatt flate.

## Skjøten

Svalehale-tapp (smal ved rota, bred ytterst) som går gjennom hele høyden i det
tykke området av profilen. Fordi den utvider seg utover, kan modulene ikke
trekkes fra hverandre i bredderetningen – de settes sammen ved å senke neste
modul rett ned over tappen. To små kuleknotter i tappens flanker (stikker
0,6 mm ut) går i matchende fordypninger i sokkelen og gir et hørbart klikk + tar
opp slark. Sokkelveggen har en fri innkjøringskanal over fordypningen, så
knotten glir uhindret ned til de siste 2 mm – da må den presses forbi full
veggtykkelse og klikker på plass.

![To moduler før de skjøtes – sokkelen i kortenden](img/livingroom_joint.png)

Justering:

| Parameter | Effekt |
|---|---|
| `joint_clear` | spillerom. Øk til 0,35–0,4 hvis skjøten er for stram, ned mot 0,15 hvis den er løs |
| `snap_proud` | klikk-kraften (effektivt grep = `snap_proud - joint_clear`). 0,45 = lett, 0,8 = stramt |
| `snap_engage` | hvor lang strekning knotten må presses gjennom på slutten |
| `snap_enable` | sett `false` for glatt skjøt uten klikk |
| `joint_depth`, `joint_neck`, `joint_head` | tappens størrelse |

## Utskrift

Med flat `height_profile` er det tre unike deler, ferdig i `stl/`:

| Fil | Antall | Beskrivelse |
|---|---|---|
| `ramp_start.stl` | 1 | endemodul (bare tapp) |
| `ramp_middle.stl` | 5 | midtmodul (tapp + sokkel) |
| `ramp_end.stl` | 1 | endemodul (bare sokkel) |

Fottrykk per utskrift: **129,7 × 150 × 27 mm** – legg modullengden langs
Y-aksen (148 mm) og skråplanets 150 mm langs X-aksen (200 mm). Andre veien går
ikke, siden 150 > 148.

- Flat bunn ned, **ingen støtte** nødvendig.
- Volumet er stort: ~1600 cm³ massivt for hele rampen, dvs. rundt 0,6–0,8 kg
  filament med normale innstillinger. Regn 4–8 timer per modul.
- Anbefalt: PETG eller PLA+, 0,2 mm lag, 3–4 perimetre, 20–25 % gyroid. Roboten
  veier bare noen kilo, men rampen bør tåle at noen tråkker på den.
- Brim hjelper mot at den tynne tuppen løsner.
- Den tynne enden ender i en knivskarp kant. Skriveren gir den en tupp på
  ~0,4 mm; slip eller varm av de siste millimeterne hvis den flerrer opp.

### Ferdig printet

Bilder av `ramp_start.stl` og `ramp_middle.stl` fra 810 mm-rampen, printet i hvit
PETG med 0,2 mm lag:

![ramp_start (til venstre, bare tapp) og ramp_middle (til høyre, sokkel i kortenden) før de skjøtes](img/two_parts.jpg)

![De samme to modulene klikket sammen – rillene fortsetter over skjøten og fugen ligger i flukt](img/two_connected.jpg)

![Nærbilde av skjøten: sokkelen til venstre, og teksten 810x150x27 mm som `dim_enable` graverer i sokkelenden](img/middle_closeup.jpg)

## Stuedøra – `livingroom_threshold_ramp.scad`

Variant for dobbeltdøra til stua. Samme konstruksjon, men **620 mm** bred i
**5 moduler à 124 mm**, og med to tillegg:

![Den ferdige stuerampen – venstre ende renner ut i gulvet](img/livingroom_assembly.png)

- **En 15 mm leppe over terskelen.** Toppflaten fortsetter flatt 15 mm forbi den
  høye siden og henger i lufta over terskelen, i sporet mellom terskelkanten og
  det lukkede dørbladet. Undersiden av leppa er avfaset 45° (`lip_drop =
  lip_out`), så den skrives fremdeles med flat bunn ned uten støtte. `lip_out` =
  hvor langt ut, `lip_tip` = tykkelsen ytterst, `lip_drop` = lengden på fasen.
  Reduser `lip_drop` hvis sporet under dørbladet er lavt (brattere overheng – kan
  trenge støtte), eller sett `lip_enable = false` for ren trekantprofil.

  ![Profilen sett fra kortenden – leppa ut mot venstre, sokkelen i gult](img/livingroom_profile.png)

- **Sideveis rampe i venstre ende.** Det venstre dørbladet står nesten alltid
  lukket, så roboten kan ikke kjøre over rampa der. Venstre ende (y = 0, sett fra
  naborommet) er derfor kuttet ned til gulvet av ett plan over `side_run` =
  120 mm ≈ 12,7°, så roboten kan kjøre opp på rampa fra siden istedenfor å dunke
  i en endevegg. Hold `side_run` **kortere enn modullengden**, så avfasingen blir
  liggende inne i modul 1 og ikke rører den første skjøten – det er en `assert`
  på det.

  ![Modul 1 – den sideveis rampen til venstre, tappen i motsatt ende](img/livingroom_start_module.png)

Fottrykk per utskrift: **138 × 165 × 27 mm** – lengden langs Y (148 mm),
profilen langs X (200 mm). Tre unike deler, ferdig i `stl/`:

| Fil | Antall | Beskrivelse |
|---|---|---|
| `livingroom_ramp_start.stl` | 1 | venstre endemodul – sideveis rampe, bare tapp |
| `livingroom_ramp_middle.stl` | 3 | midtmodul (tapp + sokkel) |
| `livingroom_ramp_end.stl` | 1 | høyre endemodul (bare sokkel) |

Fjærkanten i venstre ende er like tynn som tuppen på skråplanet – slip eller varm
den av hvis den flerrer opp.

## Bygge om selv

```bash
# forhåndsvisning av hele rampen
openscad threshold_ramp.scad

# eksporter én modul (0 .. n_modules-1)
openscad -o stl/ramp_middle.stl -D 'mode="plate"' -D 'part_index=3' threshold_ramp.scad
```

`mode` kan være `assembly` (montert), `plate` (én modul for utskrift) eller
`all_parts` (alle moduler side ved side).

`.png`-bildene i `img/` er rendret på samme måte, med `--render` (F6) slik at de
viser ferdig geometri og ikke forhåndsvisningen (`.jpg`-filene er fotografier av
de printede delene):

```bash
openscad -o img/livingroom_assembly.png --render --imgsize=1400,900 \
         --camera=0,0,0,58,0,38,0 --viewall --autocenter \
         --colorscheme=Tomorrow livingroom_threshold_ramp.scad
magick img/livingroom_assembly.png -trim +repage \
       -bordercolor '#f7f7f7' -border 24 img/livingroom_assembly.png
```

De to fargene er OpenSCADs skyggelegging av for- og baksideflater, ikke en feil i
modellen – alle STL-ene er lukkede, konsistent orienterte manifolder.

## Montering

Legg modulene mot terskelen fra én side, senk hver ny modul rett ned over
tappen til den klikker. Fest gjerne hele rampen mot gulvet med dobbeltsidig
teppetape hvis den vandrer når roboten dunker i den.
