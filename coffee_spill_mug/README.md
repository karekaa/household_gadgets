# Coffee spill tray

> Norsk versjon: [README.no.md](README.no.md)

A shallow trough that catches the coffee that runs down the outside of the pot and
out across the plate, instead of letting it end up on the table and in a paper
towel. It sits on the free front part of the teak plate under the internet
connected coffee scale, reaches out over the front edge of the plate, and grips
the grey socle behind it with two spring arms when it is pushed on.

![The tray in place on the plate](img/coffee_spill_mug_on_plate.png)

The body is **80 × 40 × 20.5 mm** over the plate and holds **about 35 ml**. It
rests on the plate over the rear 30 mm, the front 10 mm reach out past the edge of
the plate, and the front wall carries on down to the table.

![The tray seen from above](img/coffee_spill_mug_iso.png)

## Main dimensions

| Dimension | Value | Where it comes from |
|---|---|---|
| Body width | 80 mm | the width of the tongue on the front of the plate, measured to 80.10 mm. This is also the widest point of the part – the spring arms are set *inside* the sides, not outside them. |
| Depth on the plate | 30 mm | free plate from the front edge in to the grey socle |
| Overhang | 10 mm | out past the front edge of the plate, so drips that run over the edge are caught too |
| Body depth | 40 mm | 10 + 30 |
| Total depth | 58 mm | the right spring arm reaches 18 mm further back, alongside the grey socle. The left one is cut to 14 mm to clear a connector on the rig. |
| Rim height over the plate | 20.5 mm | the grey socle is 22 mm, and there are several mm of air from its top up to the big grey cup, so the rim has room to spare. Fitted with the 2 mm gauge. |
| Height of the plate over the table | 20.6 mm | how far the leg reaches down (`plate_height`), fitted with the gauge |
| Total height | 40.8 mm | from the table to the rim |
| Walls / floor | 2.4 / 2.0 mm | |
| Trough | 18.5 mm deep, 35 ml to the rim | measured from `mode = "cavity"` |

The rig itself, measured with the caliper – these are the numbers the clamping is
derived from:

| The rig | Value |
|---|---|
| Grey printed socle, width | 76 mm |
| Grey printed socle, height above the teak plate | 22 mm |
| Grey printed socle, depth backwards | not measured, "a lot", around 76 mm |
| Teak plate, thickness | 19 mm |
| Teak plate, top surface over the table | 20.6 mm (`plate_height`, fitted with the gauge) |
| Teak plate, plan | 200 × 200 mm with all four corners cut at 45°, leaving a short edge of about 37 mm – an octagon. The tray sits centred on the middle of the front edge, which stays flat for about 148 mm, so the corner cuts are nowhere near it. Only the ghost in `mode = "check"` cares. |

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

The tray weighs about 49 g, which becomes a fixed offset – **tare the scale** with
the empty tray in place.

## The two spring arms

The thing worth gripping is the **grey printed socle** that carries the sensor: a
block 76 mm wide standing 22 mm up from the teak plate, right behind the tray. So
each side wall simply carries on backwards past the rear face as a leaf spring
2.05 mm thick, and the pair of them straddles that block.

The two arms are **not the same length**. The right one runs the full 18 mm, but
the left one butts into a connector on the rig a little way back, so it is cut to
14 mm (`clamp_len_l` / `clamp_len_r`; left and right are seen from the front,
standing where the overhang points at you, so the left arm is the one at x = 0).

Seen from above, with the rim at the bottom and the arms reaching back:

![The two arms seen from above](img/coffee_spill_mug_clamp.png)

Because the socle is 4 mm narrower than the tray, the arms are set in 2.05 mm from
the sides – their outer faces are flush with the sides of the tray and the tray
stays exactly **80 mm wide**, which the old design (jaws hooking down around the
plate, 84.4 mm across) did not.

| | |
|---|---|
| Gripping faces | x = 2.05 and 77.95, i.e. an opening of 75.9 mm: `clamp_squeeze` = 0.1 mm total interference on the 76 mm socle |
| Arm | 2.05 mm thick, 17.5 mm tall, 18 mm free length on the right, 14 mm on the left |
| Mouth at the free end | 77.9 mm, relieved `clamp_lead` = 1.0 mm per side so the front corners of the socle wedge the arms apart instead of hitting them head on, closing in over the last 6 mm |
| Bottom of the arm | 1.5 mm above the plate (`clamp_z0`), to clear any fillet or elephant foot at the base of the socle |
| Top of the arm | 19 mm = `tray_height - edge_r`; any higher and the rounding of the rim would thin the arm to a knife edge |
| Force | about 0.7 N at 0.05 mm deflection on the 18 mm arm, peak stress about 1 MPa. Stiffness goes as 1/length³, so the short 14 mm arm pushes roughly twice as hard, near 1.4 N and 1.6 MPa; the tray simply seats a hair off centre because of it. |

The bending happens over the whole free length, not in a short root, which
is what makes the grip springy instead of brittle. `clamp_squeeze` is the number
to tune if the grip is too weak or the tray is too hard to push on. It started at
0.4 mm; the first printed `gauge_clamp` did go on to the socle but splayed out and
could not be pushed all the way home, so it went to 0.2 and then to 0.1 mm. That
last step is worth knowing about: 0.1 mm total is 0.05 mm per side, which is
inside the dimensional accuracy of the printer, so what is left of the grip rests
on the roughness of the two surfaces rather than on the interference. If the tray
comes out loose on the socle, put `clamp_squeeze` back up rather than looking for
something else. Keep `clamp_t` equal to
`(tray_width - socle_width + clamp_squeeze) / 2` when tuning it and the outer face
of the arm stays flush with the side of the tray – an `assert` says so if it does
not.

## Rounded edges, and why not `minkowski()`

| Edge | Treatment |
|---|---|
| The four long outer edges, running along the depth | fillet `edge_r` = 1.5 mm |
| The whole perimeter of the front face | 45° chamfer `front_c` = 1.0 mm |
| The two front corners, seen from above | 45° cut `corner_c` = 3 mm |
| Rear edge of the rim | fillet `rear_r` = 1.5 mm |
| Rear edge of the underside | fillet `under_r` = 0.8 mm |
| Inner edge of the foot, edges of the locating tongue | fillet `foot_r` = 0.6 mm |
| Top and bottom of the spring arms, outer side | fillet `arm_r` = 0.8 mm |
| Free end of the arms, seen from above | fillet `clamp_r` = 0.4 mm |
| The rear corners seen from above, and the gripping faces | left square – they butt against the socle, and the arms are rooted in those corners |

**Everything that meets the print bed is chamfered at 45°, not filleted.** A fillet
along the bottom edge is tangent to the bed, so the first layer comes out inset
and the second one hangs about 0.8 mm out over nothing; it prints as a rough
drooping lip. 45° is the steepest overhang that comes out clean, and a chamfered
edge is no longer sharp to the hand. Everything else is a true fillet, and costs
nothing in the print: the long edges are prisms along the print axis, and the
fillets on the rear face and the underside only shrink the cross section as the
print grows upwards. Measured on the finished STL, no surface in the part faces
the bed at more than exactly 45°.

`minkowski()` with a sphere would round the lot in one line, and it is the right
tool on a plain box. Not here: a Minkowski sum replaces every point of the solid
with a ball of radius *r*, so **every outward face grows by *r*** – that is the
definition, not a quirk. The usual correction is to build the source solid *r*
smaller first (`cube([w-2*r, d-2*r, h-2*r])` plus `sphere(r)` gives exactly
w × d × h), but there is no single scalar to shrink here, and worse: it would
close the mouth between the spring arms by 2 *r* and make the leg down to the
table *r* longer – exactly the two dimensions that must not move. `offset()` and
tangent fillet arcs only ever remove material, so the arm spacing (75.9/76 mm)
and the leg (20.3 mm) come out exactly as measured. Rounding one named corner at
a time also keeps the concave corners square, which `minkowski()` would do too but
`offset(r) offset(-r)` would not.

## Printed on the front face – and why

The part is printed **lying on its front face**, so the print axis runs backwards
along the depth of the tray.

![Lying on the front face, ready for the slicer](img/coffee_spill_mug_print.png)

An earlier version stood on one short end, which is the obvious choice for the
trough on its own. The arms make that impossible: both gripping faces are planes
at constant x, and standing the part on end puts the print axis along x, which
turns those planes into layer planes – the inner face of the upper arm becomes a
ceiling hanging over nothing. Standing the tray upright is worse: the whole
underside would be a 30 × 80 mm ceiling in the air above the leg.

Lying on the front face, every surface that has to be vertical – the gripping
faces, the sides of the arms – runs parallel to the print axis and comes out
exactly as drawn. The whole front face becomes the first layer, 80 × 40.8 mm of
solid contact with the bed, and the floor and the walls of the trough are printed
as one continuous outline in every single layer, so the corner where they meet is
not a layer boundary the coffee can seep through. The two arms end up as the last
14 and 18 mm of the print: two fins standing on the rear face, each with a
2.05 × 17.5 mm footprint. They print fine, but slow the last layers down if your slicer does not
do it by itself.

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
| `"gauge_clamp"` | 2.6 g | A 2.5 mm slice at the top of the arms – a ring of wall plus both arms, held apart at the right spacing, already flat. Do the arms straddle the socle, does the mouth find it, and is there room beside the socle for a 2.05 mm arm? Note that the stiffness of a leaf spring is proportional to its height, so the slice pinches only about 1/7 as hard as the finished tray – judge the position and the entry here, not the friction. It was 1.5 mm at first (1/12), which was too floppy to say anything at all: it simply splayed out. |
| `"clip"` | 22 g | The rear 12 mm of the tray plus both complete arms, standing on the cut face. This is the real friction test, but it costs nearly half a tray, so it is only worth it if `"gauge_clamp"` leaves you unsure about `clamp_squeeze`. |

## Printing

| | |
|---|---|
| Print size | 80 × 40.8 mm footprint, 58 mm tall, lying on the front face (FlashForge Creator Pro 2: 200 × 148 × 150 mm) |
| Material | 38.4 cm³, approx. 49 g |
| Support | none |
| Brim | not needed – the first layer is the whole front face |
| Walls | at least 3 perimeters, so the 2.4 mm walls and the 2.05 mm arms come out solid |

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
| `"check"` | as `"use"`, with the teak plate, the grey socle and the table drawn as ghosts for a visual fit check |
| `"print"` | lying on the front face, ready for the slicer |
| `"gauge"`, `"gauge_clamp"`, `"clip"` | the test pieces above, all ready for the slicer |
| `"cavity"` | the trough volume as a solid, for measuring the capacity |

All the parameters sit at the top of the file. `echo` prints the outer dimensions,
the flat floor, the arms with the position of their gripping faces, and the print
footprint; `assert` stops the rendering if the rear ramp does not fit in the depth,
if the tongue collides with the leg or reaches below the foot, if an arm ends up
outside the side of the tray, taller than the socle, into the rounding of the rim
or past the back of the socle, if the mouth of the arms ends up narrower than the
socle, or if a fillet or chamfer is too large for the feature it is supposed to
break.
