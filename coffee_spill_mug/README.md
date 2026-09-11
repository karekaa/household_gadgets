# Coffee spill tray

> Norsk versjon: [README.no.md](README.no.md)

A shallow trough that catches the coffee that runs down the outside of the pot and
out across the plate, instead of letting it end up on the table and in a paper
towel. It sits on the free front part of the teak plate under the internet
connected coffee scale, reaches out over the front edge of the plate, and
straddles the grey socle behind it with two arms.

![The tray in place on the plate](img/coffee_spill_mug_on_plate.png)

The body is **90 × 48 × 20.5 mm** over the plate and holds **about 46 ml**. It
rests on the plate over the rear 30 mm, the front 18 mm reach out past the edge of
the plate, and the front wall carries on down to the table – with two lines
engraved in it:

![The front face, which is also the first layer of the print](img/coffee_spill_mug_front.png)

![The tray seen from above](img/coffee_spill_mug_iso.png)

## Main dimensions

| Dimension | Value | Where it comes from |
|---|---|---|
| Body width | 90 mm | started at 80, the width of the tongue on the front of the plate. It is 90 now to give the text on the front face room to breathe. Still the widest point of the part – the arms are set *inside* the sides, not outside them. |
| Depth on the plate | 30 mm | free plate from the front edge in to the grey socle. Fixed by the rig: the body cannot get any deeper at the back. |
| Overhang | 18 mm | out past the front edge of the plate, so drips that run over the edge are caught too. Was 10; the shallower rear ramp (see below) needs 7 mm more depth than a 45° one, and since the back is up against the socle, the extra depth is added here. It is free: the leg stands on the table at the very front, so the overhang is carried rather than cantilevered, and the pivot lever gets better (see `foot_clear`). |
| Body depth | 48 mm | 18 + 30 |
| Total depth | 66 mm | the right arm reaches 18 mm further back, alongside the grey socle. The left one is cut to 14 mm to clear a connector on the rig. |
| Rim height over the plate | 20.5 mm | the grey socle is 22 mm, and there are several mm of air from its top up to the big grey cup, so the rim has room to spare. Fitted with the 2 mm gauge. |
| Height of the plate over the table | 20.6 mm | how far the leg reaches down (`plate_height`), fitted with the gauge |
| Total height | 40.8 mm | from the table to the rim |
| Walls / floor | 2.4 / 2.0 mm | |
| Trough | 18.5 mm deep, 46 ml to the rim | measured from `mode = "cavity"` |
| Text on the front face | two lines, 4.2 mm, engraved 0.6 mm | `text_line1` / `text_line2`, see below |

The rig itself, measured with the caliper – these are the numbers the fit is
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
  the plate, and the leg stands 18 mm in front of that edge while the rear edge is
  30 mm behind it. A leg that is *e* mm too long therefore lifts the rear edge by
  *1.7 e* mm and eats into the clearance under the grey cup – the longer overhang
  helps here, it used to be *3 e*. 0.3 mm is little enough
  that the leg takes over as soon as anything presses on the overhang, and enough
  that the tray never rocks. Set it to 0 for firm contact.
- **A 45° chamfer on the front face of the tongue**, from the back of the leg down
  to the bottom front corner of the tongue. That face would otherwise be a ceiling
  in the print – see below. It fills the gap between the leg and the tongue with a
  wedge, which is harmless because it all sits in front of the plate edge.
- **`hook_relief = 1.0`** cuts a 45° relief in the inner corner where the
  underside meets the tongue, so a rounded or slightly chamfered plate edge still
  lets the tray seat flat.

The tray weighs about 65 g, which becomes a fixed offset – **tare the scale** with
the empty tray in place.

## The two arms – a slip fit, on purpose

The thing worth reaching around is the **grey printed socle** that carries the
sensor: a block 76 mm wide standing 22 mm up from the teak plate, right behind the
tray. Two fins 2.05 mm thick reach backwards from the rear face, one along each
side of it.

They started life as spring arms that clamped the socle, and they are **not that
any more**. `clamp_squeeze` is **−0.1 mm**, i.e. the opening is 0.1 mm *wider*
than the socle rather than narrower. The arms locate the tray sideways and keep it
square to the rig; the locating tongue and the weight of the tray do the holding.
A grip that has to be broken releases with a jerk, and a tray with coffee residue
in it being pulled forwards for emptying is the last place you want a jerk. Raise
`clamp_squeeze` above 0 to get a real grip back – the shape is unchanged, the
number is the whole difference.

Getting there took three printed tests: 0.4 mm total interference, which splayed
the `gauge_clamp` out so it would not seat, then 0.2, then 0.1, and finally past
zero to −0.1. Below about 0.1 mm the numbers are academic anyway: 0.05 mm per side
is inside the dimensional accuracy of the printer.

The two arms are **not the same length**. The right one runs the full 18 mm, but
the left one butts into a connector on the rig a little way back, so it is cut to
14 mm (`clamp_len_l` / `clamp_len_r`; left and right are seen from the front,
standing where the overhang points at you, so the left arm is the one at x = 0 –
swap the two numbers if it turns out to be the other side on your rig).

Seen from above, with the rim at the bottom and the arms reaching back:

![The two arms seen from above](img/coffee_spill_mug_clamp.png)

The arms are **no longer flush with the sides**. They were, back when the body was
80 mm and the socle 76: 2.05 mm of thickness landed exactly in the 2 mm step on
each side. At 90 mm the same rule would demand a 7 mm slab, so the two are
decoupled – `clamp_t` is the thickness the fin needs, and the arms sit 4.9 mm in
from the sides of the body wherever the socle puts them.

| | |
|---|---|
| Guiding faces | x = 6.95 and 83.05, i.e. an opening of 76.1 mm on the 76 mm socle: 0.05 mm of clearance per side |
| Arm | 2.05 mm thick, 17.5 mm tall, 18 mm free length on the right, 14 mm on the left |
| Mouth at the free end | 78.1 mm, relieved `clamp_lead` = 1.0 mm per side so the front corners of the socle guide the tray in instead of catching on the arm tips, closing in over the last 6 mm |
| Bottom of the arm | 1.5 mm above the plate (`clamp_z0`), to clear any fillet or elephant foot at the base of the socle |
| Top of the arm | 19 mm = `tray_height - edge_r`; any higher and the rounding of the rim would thin the arm to a knife edge |
| If you do put interference back | the arm is a leaf spring: `k = 3EI/L³` with `I = b·t³/12` gives about 13 N/mm on the 18 mm arm in PETG, half again as much in PLA+. Stiffness goes as 1/length³, so the short 14 mm arm is 2.1 times stiffer and the tray seats a hair off centre. |

## Rounded edges, and why not `minkowski()`

| Edge | Treatment |
|---|---|
| The four long outer edges, running along the depth | fillet `edge_r` = 1.5 mm |
| The whole perimeter of the front face | 45° chamfer `front_c` = 1.0 mm |
| The two front corners, seen from above | 45° cut `corner_c` = 3 mm |
| Rear edge of the rim | fillet `rear_r` = 1.5 mm |
| Rear edge of the underside | fillet `under_r` = 0.8 mm |
| Inner edge of the foot, edges of the locating tongue | fillet `foot_r` = 0.6 mm |
| Top and bottom of the arms, outer side | fillet `arm_r` = 0.8 mm |
| Free end of the arms, seen from above | fillet `clamp_r` = 0.4 mm |
| The rear corners seen from above, and the guiding faces | left square – they face the socle, and the arms are rooted in those corners |

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
close the mouth between the arms by 2 *r* and make the leg down to the
table *r* longer – exactly the two dimensions that must not move. `offset()` and
tangent fillet arcs only ever remove material, so the arm spacing (76.1/76 mm)
and the leg (20.3 mm) come out exactly as measured. Rounding one named corner at
a time also keeps the concave corners square, which `minkowski()` would do too but
`offset(r) offset(-r)` would not.

## Printed on the front face – and why

The part is printed **lying on its front face**, so the print axis runs backwards
along the depth of the tray.

![Lying on the front face, ready for the slicer](img/coffee_spill_mug_print.png)

An earlier version stood on one short end, which is the obvious choice for the
trough on its own. The arms make that impossible: both guiding faces are planes
at constant x, and standing the part on end puts the print axis along x, which
turns those planes into layer planes – the inner face of the upper arm becomes a
ceiling hanging over nothing. Standing the tray upright is worse: the whole
underside would be a 30 × 90 mm ceiling in the air above the leg.

Lying on the front face, every surface that has to be vertical – the guiding
faces, the sides of the arms – runs parallel to the print axis and comes out
exactly as drawn. The whole front face becomes the first layer, 90 × 40.8 mm of
solid contact with the bed, and the floor and the walls of the trough are printed
as one continuous outline in every single layer, so the corner where they meet is
not a layer boundary the coffee can seep through. The two arms end up as the last
14 and 18 mm of the print: two fins standing on the rear face, each with a
2.05 × 17.5 mm footprint. They print fine, but slow the last layers down if your slicer does not
do it by itself.

Only two surfaces face the bed in this orientation:

1. **The inside of the rear wall.** The floor of the trough rises to the rim over
   a fillet of radius `rear_fillet` = 12 mm and then a straight run at
   `rear_angle` = **35°**. It was 45° – the textbook limit for an unsupported
   overhang – and the first print came out visibly rough and drooping along that
   whole face in PLA. 45° means each layer steps a full layer height sideways, so
   every bead is laid half in the air; at 35° it steps only 0.7 of a layer height
   and there is real material under each bead. Run the part cooling fan flat out
   over those layers.

   The shallower ramp costs depth: `rear_fillet · sin a + (cav_rise −
   rear_fillet · (1 − cos a)) / tan a` is **30.2 mm** at 35° against 23.5 mm at
   45°. Since the socle fixes the back, those 7 mm came out of the front as
   `overhang` 10 → 18. What is left is a fully flat floor of 75.2 × 8.0 mm at the
   front, and the ramp is as much a feature as a cost. The trough is deepest at
   the front, so a spill collects out over the table edge and away from the rig.
   And the long shallow slope is where the drips actually land: a drop hitting it
   spreads into a thin film over a much larger area than the 2 mm puddle it would
   make on a flat floor, and that film has cooled well down by the time it reaches
   the bottom. More area, less depth, less heat – all three in the right
   direction, and in PLA the last one is the one that matters.
2. **The front face of the locating tongue**, chamfered at 45° as described above.

Measured on the finished STL, 2423 mm² of surface faces the bed at 35° (the ramp)
and 943 mm² at exactly 45° (the chamfers). Nothing is steeper.

The two short ends need no such treatment here – they are prisms along the print
axis – so their inside is a plain `inner_fillet` = 5 mm rounding and the flat floor
keeps its full width.

## The text on the front face

Because the front face is the first layer, it comes out as the smoothest surface
on the whole part – which makes it the right place for a label, and dictates how
the label has to be made. It is **engraved, not raised**: raised letters on that
face would have to be printed *below* the first layer, which is not a thing.
`text_depth` = 0.6 mm of recess prints as a small bridge over the letter shapes,
which any printer handles, and in black filament the shadow in the recess reads
better than raised letters would.

| | |
|---|---|
| Lines | `text_line1` = "SpareBank 1 kaffesølsamler", `text_line2` = "Trekk ut for tømming" |
| Size | 4.2 mm both lines, `text_gap` = 2.0 mm between them, `text_font` = Liberation Sans Bold |
| Depth | 0.6 mm, leaving 1.8 mm of the 2.4 mm wall – an `assert` keeps at least 1.2 mm |
| Position | centred on the width, block centre `text_z` = 1.0 mm above the plate surface |

OpenSCAD cannot measure a rendered string, so the sizes are set by hand: line 1 is
108.3 mm wide at size 6 in this font, so it scales to 75.8 mm at 4.2, inside the
`tray_width - 2 · text_margin` = 80 mm available. If you edit either string, render
it on its own and scale the size the same way. Note that the source says
*kaffesølsamler* with the e; drop it in `text_line1` if you want *kaffsølsamler*.

No mirroring is needed anywhere: the letters are drawn in the (x, z) plane and
extruded along +y into the part, and the front view looks along +y, so what you
read in the render is what comes off the bed.

## Test pieces

Three cheap prints, in the order they are worth making:

| `mode` | Cost | What it tells you |
|---|---|---|
| `"gauge"` | 3 g | The whole cross section as a 2 mm slice, lying flat. Hook it on the front edge of the plate: does the leg reach the table, does the tongue clear whatever is under the plate, is there air left up to the grey cup? |
| `"gauge_clamp"` | 3 g | A 2.5 mm slice at the top of the arms – a ring of wall plus both arms, held apart at the right spacing, already flat. Do the arms straddle the socle, does the mouth find it, and is there room beside the socle for a 2.05 mm arm? It was 1.5 mm at first, which was too floppy to say anything at all: it simply splayed out. Now that the fit is a slip fit there is nothing to judge about the friction here anyway – judge the position and the entry. |
| `"clip"` | 26 g | The rear 12 mm of the tray plus both complete arms, standing on the cut face. The only test that shows how the tray really goes on and comes off, but it costs a third of a tray, so it is only worth it if `"gauge_clamp"` leaves you unsure about `clamp_squeeze`. |

## Printing

| | |
|---|---|
| Print size | 90 × 40.8 mm footprint, 66 mm tall, lying on the front face (FlashForge Creator Pro 2: 200 × 148 × 150 mm) |
| Material | 51.0 cm³, approx. 65 g |
| Support | none |
| Brim | not needed – the first layer is the whole front face |
| Walls | at least 3 perimeters, so the 2.4 mm walls and the 2.05 mm arms come out solid |
| Cooling | fan flat out over the 35° rear ramp – that is the one surface that cares |

**PETG is the right material, and remains the recommendation.** Coffee straight
from the pot is 80–90 °C, and PLA starts to soften just above 55 °C. PETG (or
ASA/PP) keeps its shape even if a full cup lands in the tray.

**This one is printed in what was on the shelf: eSUN PLA+ black, 1.75 mm,
205–225 °C.** That is a defensible choice here, and worth writing down rather than
pretending otherwise:

- The drips are few, and they hang on the dispenser for a while before they let
  go, so they are nowhere near pot temperature when they land in a tray that is at
  room temperature and empty. It is a spill catcher, not a cup.
- They land on the 35° ramp, not in a puddle. A drop spreads into a thin film on
  the way down and gives up its heat to a large area of wall as it goes, so the
  plastic never sees anything like the temperature of the drop itself.
- PLA+ is *stiffer* than PETG (E ≈ 2.5–3.5 GPa against about 2.0). With a slip fit
  that no longer matters much, but it does mean the arms stay where they are put.
- PLA also holds its dimensions better than PETG: less shrinkage, less die swell
  at the corners, which is what keeps a 0.05 mm-per-side clearance a clearance.

Two things to keep an eye on with PLA, both about *sustained* load rather than the
drips:

- **Creep.** PLA relaxes under constant strain far more readily than PETG does.
  There is no constant strain in the arms any more, now that they do not clamp, so
  this only matters if you raise `clamp_squeeze` back above 0 – in which case the
  grip will fade over some months and want a reprint.
- **Do not empty a hot cup into it,** and wipe a spill out rather than letting a
  pool of near boiling coffee stand in a 2 mm floor. That is the one case where
  PLA would actually go soft.

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
the flat floor, the arms with the position of their guiding faces, and the print
footprint; `assert` stops the rendering if the rear ramp does not fit in the depth,
if the tongue collides with the leg or reaches below the foot, if an arm ends up
outside the side of the tray, taller than the socle, into the rounding of the rim
or past the back of the socle, if the mouth of the arms ends up narrower than the
socle, if the text recess leaves less than 1.2 mm of front wall, or if a fillet or
chamfer is too large for the feature it is supposed to break.
