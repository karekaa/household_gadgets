# Coffee spill tray

> Norsk versjon: [README.no.md](README.no.md)

A shallow trough that catches the coffee that runs down the outside of the pot and
out across the plate, instead of letting it end up on the table and in a paper
towel. It sits on the free front part of the teak plate under the internet
connected coffee scale, reaches out over the front edge of the plate, and locks
itself to the rig with two spring clamps when it is pushed on.

![The tray in place on the plate](img/coffee_spill_mug_on_plate.png)

The body is **80 × 40 × 20.5 mm** over the plate and holds **about 35 ml**. It
rests on the plate over the rear 30 mm, the front 10 mm reach out past the edge of
the plate, and the front wall carries on down to the table.

![The tray seen from above](img/coffee_spill_mug_iso.png)

## Main dimensions

| Dimension | Value | Where it comes from |
|---|---|---|
| Body width | 80 mm | the width of the socle on the front of the plate, measured to 80.10 mm |
| Widest point | 84.4 mm | the spring clamps stand 2.2 mm outside the body on each side |
| Depth on the plate | 30 mm | free plate from the front edge in to the sensor holder |
| Overhang | 10 mm | out past the front edge of the plate, so drips that run over the edge are caught too |
| Total depth | 40 mm | 10 + 30 |
| Rim height over the plate | 20.5 mm | **maximum** – leaves air up to the underside of the big grey cup the pot stands in. Fitted with the 2 mm gauge. |
| Height of the plate over the table | 20.6 mm | how far the leg reaches down (`plate_height`), also fitted with the gauge |
| Total height | 40.8 mm | from the table to the rim |
| Walls / floor | 2.4 / 2.0 mm | |
| Trough | 18.5 mm deep, 35 ml to the rim | measured from `mode = "cavity"` |

## It may rest on the table

The load cell sits up inside the grey cup the pot stands in, so both the teak
plate and the table are dead support **below** the measuring path. Whatever the
tray leans on therefore has no effect on the weight reading, and standing on the
table is a plain advantage: the overhang gets carried instead of cantilevered.

That is what the front wall does – it continues down past the edge of the plate
and stands on the table:

![The outer cross section - the same profile as the 2 mm test gauge](img/coffee_spill_mug_profile.png)

From the front backwards in the section: the **leg** (4 mm thick, down to the
table), the **locating tongue** that hangs down in front of the front face of the
plate and keeps the tray from sliding backwards towards the pot, and then the flat
underside that rests on the plate.

Three details in the section that are there on purpose:

- **`foot_clear = 0.3` shortens the leg.** The tray pivots on the front edge of
  the plate, and the leg stands 10 mm in front of that edge while the rear edge is
  30 mm behind it. A leg that is *e* mm too long therefore lifts the rear edge by
  *3 e* mm and eats into the clearance under the grey cup. 0.3 mm is little enough
  that the leg takes over as soon as anything presses on the overhang, and enough
  that the tray never rocks. Set it to 0 for firm contact.
- **A 45° chamfer on the front face of the tongue**, from the back of the leg down
  to the bottom front corner of the tongue. That face would otherwise be a ceiling
  in the print – see below. It fills the gap between the leg and the tongue with a
  wedge, which is harmless because it all sits in front of the plate edge.
- **`hook_relief = 1.0`** cuts a 45° relief in the inner corner where the
  underside meets the tongue, so a rounded or slightly chamfered plate edge still
  lets the tray seat flat.

The tray weighs about 50 g, which becomes a fixed offset – **tare the scale** with
the empty tray in place.

## The side spring clamps

Each side carries a leaf spring that grips the side of the socle, so the tray
locks itself to the rig when it is pushed on from the front and lifts off with a
firm pull. Read the section with the rim at the top and the plate surface where
the floor of the trough is:

![Cross section through one clamp](img/coffee_spill_mug_clamp.png)

From the top down: a **bridge** ties the clamp to the side wall 12 mm above the
plate, an **arm** 1.6 mm thick runs down the outside of that wall separated from
it by a 0.6 mm **slot**, and at the bottom the arm turns in under the tray into a
**jaw** that reaches 5 mm down past the top of the plate and presses on the side
of the socle. The clamp is 26 mm long.

The bending happens over the whole 12 mm of the arm, not in a short root, which is
what makes the grip springy instead of brittle: the numbers above give roughly
**6 N per side** at 0.2 mm deflection, with a peak stress around 7 MPa – about a
seventh of what PETG takes. `clamp_squeeze` (0.4 mm total over both sides) is the
number to tune if the grip is too weak or the tray is too hard to push on.

The gripping face is relieved `clamp_lead` = 1.0 mm at the front and closes in on
the socle over the first 10 mm, so the front edge of the socle wedges the jaws
apart instead of hitting them head on.

**Two things to measure before printing the whole tray:**

- `clamp_depth` = 5 mm must stay inside the thickness of the socle at its front
  edge, or the jaws will foul whatever is under it.
- `clamp_len` = 26 mm must stay inside the length over which the socle really is
  80.1 mm wide, before it widens out towards the sensor holder.

## Printed on the front face – and why that changed

The part is printed **lying on its front face**, so the print axis runs backwards
along the depth of the tray.

![Lying on the front face, ready for the slicer](img/coffee_spill_mug_print.png)

An earlier version stood on one short end, which is the obvious choice for the
trough on its own. The clamps make that impossible: a clamp can only grow 45° per
layer, so a jaw reaching 5 mm down under the tray would have to stand 5 mm out
from the side with a 45° inner face – and a 45° face cannot grip a vertical side.

Lying on the front face, every surface that has to be vertical – the gripping
faces, the slot, the arms – runs parallel to the print axis and comes out exactly
as drawn. The whole front face becomes the first layer, 80 × 40.8 mm of solid
contact with the bed, and the floor and the walls of the trough are printed as one
continuous outline in every single layer, so the corner where they meet is not a
layer boundary the coffee can seep through.

Only two surfaces face the bed in this orientation, and both are dealt with at
45°, the steepest overhang that prints without support:

1. **The inside of the rear wall.** The floor of the trough rises to the rim over
   a fillet of radius `rear_fillet` = 12 mm, from horizontal up to 45°, and then a
   straight 45° run. The run costs
   `(tray_height - floor_t) + 0.41 · rear_fillet` = 23.5 mm of the 35.2 mm inner
   depth, leaving a flat floor 65 × 6.7 mm at the front. That is a feature as much
   as a cost: the trough is deepest at the front, so a spill collects out over the
   table edge and away from the rig.
2. **The front face of the locating tongue**, chamfered as described above.

The two short ends need no such treatment here – they are prisms along the print
axis – so their inside is a plain `inner_fillet` = 5 mm rounding and the flat floor
keeps its full width.

## Test pieces

Three cheap prints, in the order they are worth making:

| `mode` | Cost | What it tells you |
|---|---|---|
| `"gauge"` | 2 g | The whole cross section as a 2 mm slice, lying flat. Hook it on the front edge of the plate: does the leg reach the table, does the tongue clear whatever is under the plate, is there air left up to the grey cup? |
| `"gauge_clamp"` | 1 g | A 1.5 mm slice across both clamps, lying flat. Do the jaws land on the sides of the socle, and does it slide on? Note that the spring force scales with the length of the clamp, so a 1.5 mm slice pinches roughly 1/17 as hard as the finished tray – judge the fit here, not the friction. |
| `"clip"` | 28 g | The front 26 mm of the tray in print orientation: leg, tongue and both complete clamps. This is the real friction test, but it costs half a tray, so it is only worth it if `"gauge_clamp"` leaves you unsure about `clamp_squeeze`. |

## Printing

| | |
|---|---|
| Print size | 84.4 × 40.8 mm footprint, 40 mm tall, lying on the front face (FlashForge Creator Pro 2: 200 × 148 × 150 mm) |
| Material | 40 cm³, approx. 50 g |
| Support | none |
| Brim | not needed – the first layer is the whole front face |
| Walls | at least 3 perimeters, so the 2.4 mm walls and the 1.6 mm clamp arms come out solid |

**Choose PETG rather than PLA.** Coffee straight from the pot is 80–90 °C, and PLA
starts to soften just above 55 °C. PETG (or ASA/PP) keeps its shape when a full
cup lands in the tray, and it makes a better spring than PLA.

## Rebuilding it yourself

```sh
# the tray, lying on the front face, ready for the slicer
openscad -o stl/coffee_spill_mug.stl -D 'mode="print"' coffee_spill_mug.scad

# the test pieces
openscad -o stl/coffee_spill_mug_gauge.stl       -D 'mode="gauge"'       coffee_spill_mug.scad
openscad -o stl/coffee_spill_mug_gauge_clamp.stl -D 'mode="gauge_clamp"' coffee_spill_mug.scad
openscad -o stl/coffee_spill_mug_clip.stl        -D 'mode="clip"'        coffee_spill_mug.scad
```

Open `coffee_spill_mug.scad` to look at it instead. `mode` decides what is drawn:

| `mode` | |
|---|---|
| `"use"` | as it sits on the plate. z = 0 is the top of the plate, y = 0 is the front face, x = 0 is the left side of the body |
| `"check"` | as `"use"`, with the socle and the table drawn as ghosts for a visual fit check |
| `"print"` | lying on the front face, ready for the slicer |
| `"gauge"`, `"gauge_clamp"`, `"clip"` | the test pieces above, all ready for the slicer |
| `"cavity"` | the trough volume as a solid, for measuring the capacity |

All the parameters sit at the top of the file. `echo` prints the outer dimensions,
the flat floor, the position of the gripping faces and the print footprint;
`assert` stops the rendering if the rear ramp does not fit in the depth, if the
tongue collides with the leg or reaches below the foot, if a clamp reaches past the
rear face or below the foot, or if the mouth of the clamps ends up narrower than
the socle.
