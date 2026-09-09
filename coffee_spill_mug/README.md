# Coffee spill tray

> Norsk versjon: [README.no.md](README.no.md)

A shallow trough that catches the coffee that runs down the outside of the pot and
out across the plate, instead of letting it end up on the table and in a paper
towel. It sits on the free front part of the teak plate under the internet
connected coffee scale, and reaches out over the front edge of the plate.

![The tray in place on the plate](img/coffee_spill_mug_on_plate.png)

The tray is **80 × 40 × 19 mm** over the plate and holds **about 32 ml**. It rests
on the plate over the rear 30 mm, the front 10 mm reach out past the edge of the
plate, and the front wall carries on down to the table.

![The tray seen from above](img/coffee_spill_mug_iso.png)

## Main dimensions

| Dimension | Value | Where it comes from |
|---|---|---|
| Width | 80 mm | the width of the tongue on the front of the plate, measured to 80.10 mm |
| Depth on the plate | 30 mm | free plate from the front edge in to the sensor holder |
| Overhang | 10 mm | out past the front edge of the plate, so drips that run over the edge are caught too |
| Total depth | 40 mm | 10 + 30 |
| Rim height over the plate | 19 mm | **maximum** – leaves air up to the underside of the big grey cup the pot stands in |
| Height of the plate over the table | 20 mm | how far the leg has to reach down – **measure this** (`plate_height`) |
| Walls / floor | 2.4 / 2.0 mm | |
| Capacity to the rim | approx. 32 ml | printed by `echo` when the file is rendered |

## It may rest on the table

The load cell sits up inside the grey cup the pot stands in, so both the teak
plate and the table are dead support **below** the measuring path. Whatever the
tray leans on therefore has no effect on the weight reading, and standing on the
table is a plain advantage: the overhang gets carried instead of cantilevered.

That is what the front wall does – it continues down past the edge of the plate
and stands on the table:

![Cross section: leg, locating tongue and the rim 19 mm over the plate](img/coffee_spill_mug_profile.png)

From left to right in the section: the **leg** (4 mm thick, down to the table),
open air, the **locating tongue** that hangs down in front of the front face of
the plate and keeps the tray from sliding backwards towards the pot, and then the
flat underside that rests on the plate.

Three details in the section that are there on purpose:

- **`foot_clear = 0.3` shortens the leg.** The tray pivots on the front edge of
  the plate, and the leg stands 10 mm in front of that edge while the rear edge is
  30 mm behind it. A leg that is *e* mm too long therefore lifts the rear edge by
  *3 e* mm and eats into the clearance under the grey cup. 0.3 mm is little enough
  that the leg takes over as soon as anything presses on the overhang, and enough
  that the tray never rocks. Set it to 0 for firm contact once `plate_height` is
  known exactly.
- **3 mm of open air between the leg and the tongue**, so a board under the teak
  plate that sticks out a few mm does not get in the way.
- **`hook_relief = 1.0`** cuts a 45° relief in the inner corner where the
  underside meets the tongue, so a rounded or slightly chamfered plate edge still
  lets the tray seat flat.

The tray weighs about 42 g, which becomes a fixed offset – **tare the scale** with
the empty tray in place.

## Curved short ends, and why

The part is printed **standing on one short end**. Then the layers run along the
trough, every wall is printed as an unbroken perimeter with no horizontal layer
boundary in the corner between floor and wall for the coffee to seep through, and
the thin floor is not a first layer.

![Standing on end, ready for the slicer](img/coffee_spill_mug_print.png)

The whole outside of the tray is a prism along the print axis, so it has no
overhang at all. The inside of the *upper* short end is the exception: a flat wall
there would be an unsupported 35 × 17 mm ceiling. So the inside of both short ends
rises from the floor of the trough up to the rim over

1. a fillet of radius `end_fillet` = 12 mm, from horizontal up to 45°, and then
2. a straight 45° run up to the rim.

45° is the steepest overhang that prints without support, and the fillet gives the
transition a shape that is easy to wipe out. The run costs
`(tray_height - floor_t) + 0.41 · end_fillet` = 22 mm of trough at each end, which
leaves a **31 mm flat floor** in the middle. Increase `end_fillet` for a softer
inside, decrease it for more capacity, 0 gives a plain 45° ramp.

Printing flat also works and needs no support either, but gives that horizontal
layer boundary right where the floor meets the walls.

## Test gauge

`mode = "gauge"` gives a solid 2 mm thick slice of the cross section, lying flat.
It costs 2 g and a couple of minutes:

```sh
openscad -o stl/coffee_spill_mug_gauge.stl -D 'mode="gauge"' coffee_spill_mug.scad
```

Take it over to the pot, hook it on the front edge of the plate and check that the
leg reaches the table, that the tongue clears whatever is under the plate, and
that there is air left up to the grey cup – before printing the whole tray.

## Printing

| | |
|---|---|
| Print size | 38.7 × 40 × 80 mm, standing on end (FlashForge Creator Pro 2: 200 × 148 × 150 mm) |
| Material | 34 cm³, approx. 42 g |
| Support | none |
| Brim | yes – the footprint is 38.7 × 40 mm under an 80 mm tall part |
| Walls | at least 3 perimeters, so the 2.4 mm walls come out solid and tight |

**Choose PETG rather than PLA.** Coffee straight from the pot is 80–90 °C, and PLA
starts to soften just above 55 °C. PETG (or ASA/PP) keeps its shape when a full
cup lands in the tray.

## Rebuilding it yourself

```sh
# the tray, standing on end, ready for the slicer
openscad -o stl/coffee_spill_mug.stl -D 'mode="print"' coffee_spill_mug.scad

# the 2 mm test gauge
openscad -o stl/coffee_spill_mug_gauge.stl -D 'mode="gauge"' coffee_spill_mug.scad
```

Open `coffee_spill_mug.scad` to look at it instead. `mode` decides what is drawn:

| `mode` | |
|---|---|
| `"use"` | as it sits on the plate. z = 0 is the top of the plate, y = 0 is the front face, x = 0 is the left short end |
| `"check"` | as `"use"`, with the plate and the table drawn as ghosts for a visual fit check |
| `"print"` | standing on the left short end, ready for the slicer |
| `"gauge"` | the 2 mm slice of the cross section, lying flat |

All the parameters sit at the top of the file. `echo` prints the outer dimensions,
the length of the flat floor and the capacity; `assert` stops the rendering if
`end_fillet` is too large for the trough, if the tongue collides with the leg, or
if the tongue reaches below the foot of the leg.
