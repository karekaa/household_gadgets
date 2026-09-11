// ============================================================================
//  Coffee spill tray for the internet connected coffee pot scale
//
//  A shallow open trough that catches the drips that run down the pot and out
//  across the plate. It rests on the free part of the teak plate in front of the
//  load cell holder and reaches plate_depth mm in towards the holder. The front
//  overhang mm stick out past the front edge of the plate, so drips that run all
//  the way over the edge are caught too instead of ending up on the table.
//
//  The load cell sits up inside the big grey cup the pot stands in, so the teak
//  plate and the table are both dead support below the measuring path. The tray
//  may therefore rest on the table as well, and that is what it does: the front
//  wall carries on down past the plate edge and stands on the table, which
//  stiffens the overhang.
//
//  TWO RIGS. What stands on the plate behind the tray is not the same everywhere,
//  and the parameter "base" picks which one this build is for. Everything else -
//  the trough, the ramp, the leg, the tongue, the text, the print orientation and
//  every fillet - is shared, which is why both live in one file.
//
//    base = "box"    the grey 3D printed box for the electronics, a square block
//                    socle_width mm wide standing socle_height mm up from the
//                    plate. The tray meets it with a flat rear face and straddles
//                    it with two arms, one along each side, as two thin fins set
//                    in arm_x0 mm from the sides at the width the socle needs
//                    rather than flush with them. The arms are a deliberate SLIP
//                    FIT, not a clamp: clamp_squeeze is negative, so the opening
//                    is a touch wider than the socle. They locate the tray
//                    sideways and keep it square, and the tongue plus the weight
//                    do the holding. A grip that has to be broken releases with a
//                    jerk, and a tray full of coffee residue being pulled forwards
//                    for emptying is the last place you want a jerk. Raise
//                    clamp_squeeze above 0 to get a real grip back.
//    base = "round"  a curved base under the weighing bowl, which is what most of
//                    the rigs turn out to have. No arms at all: the rear face is a
//                    concave arc of radius base_r + base_clear that nests into it.
//                    That arc is a better locator than the arms were - it centres
//                    the tray by itself, in both axes at once, and because the
//                    base curves away from the tray towards the sides the trough
//                    reaches a good 12 mm further back at the corners than on the
//                    centreline, which is capacity for nothing.
//
//  So what holds the tray on the rig is: the tongue behind the leg, hanging down
//  in front of the front face of the plate so the tray cannot slide backwards
//  towards the pot; the rear of the tray closing off against the base, by arms or
//  by arc; and its own weight on the plate.
//
//  PRINT ORIENTATION: on the front face (mode = "print"), so the print axis runs
//  backwards along the depth of the tray. That is what makes the arms possible.
//  Both gripping faces are planes at constant x; standing the part on a short end
//  would put the print axis along x, turning those planes into layer planes, and
//  the inner face of the upper arm into a ceiling hanging over nothing. Standing
//  the tray upright is worse: the whole underside would be a ceiling
//  plate_depth x tray_width mm in the air above the leg. The round base wants the
//  same orientation for a different reason: the concave arc faces backwards, so
//  laid on its front face it faces straight up and is never an overhang at all,
//  and being a surface of revolution about a vertical axis it is a prism along the
//  print axis wherever it is not being filleted.
//
//  Lying on the front face, every face that has to be vertical runs parallel to
//  the print axis, and the whole front face is the first layer - which is also
//  what makes it the right face to engrave the text into. Only two surfaces face
//  the bed:
//
//    * the inside of the rear wall - the floor rises to the rim over a fillet of
//      radius rear_fillet and then a straight run at rear_angle degrees. 45 is the
//      textbook limit and it printed rough, so this is 35: each layer steps only
//      0.7 of its own height sideways instead of a full height. It also makes the
//      trough deepest at the front, so a spill collects out over the table edge,
//      away from the rig. On the round base that ramp is the same profile revolved
//      about the axis of the arc, and revolving it helps: as it curves round
//      towards the sides its normal picks up an x component, so the steepest
//      overhang on the whole ramp is the rear_angle degrees on the centreline and
//      everything either side of that is shallower.
//    * the front face of the locating tongue - chamfered at 45 degrees
//
//  The short ends need no such treatment in this orientation - they are prisms
//  along the print axis - so their inside is a plain fillet and the flat floor
//  keeps its full width.
//
//  MATERIAL: PETG is the right choice and stays the recommendation - coffee from
//  the pot is 80-90 degrees and PLA softens just above 55. This one is printed in
//  eSUN PLA+ black anyway, because that is what was on the shelf, and it is
//  defensible: the drips hang on the dispenser a while before they let go, so they
//  land cool in an empty tray. PLA+ is stiffer than PETG (E about 2.5-3.5 GPa
//  against 2.0), so the box base arms come out roughly 1.5 times stiffer than the
//  figures below. Creep only matters under sustained strain, and there is none in
//  a slip fit or in an arc that only rests against the base - it would matter if
//  clamp_squeeze were raised above 0, and then the grip would fade over months.
//  See README.md.
//
//  The STL files are written like this - see README.md for the reasoning. The
//  round base files carry _round in the name, the box base ones are the originals
//  and keep the plain names:
//
//    openscad -o stl/coffee_spill_mug.stl -D 'mode="print"' -D 'base="box"' coffee_spill_mug.scad
//    openscad -o stl/coffee_spill_mug_gauge.stl       -D 'mode="gauge"'      -D 'base="box"' coffee_spill_mug.scad
//    openscad -o stl/coffee_spill_mug_gauge_clamp.stl -D 'mode="gauge_rear"' -D 'base="box"' coffee_spill_mug.scad
//    openscad -o stl/coffee_spill_mug_clip.stl        -D 'mode="clip"'       -D 'base="box"' coffee_spill_mug.scad
//
//    openscad -o stl/coffee_spill_mug_round.stl            -D 'mode="print"'      -D 'base="round"' coffee_spill_mug.scad
//    openscad -o stl/coffee_spill_mug_round_gauge.stl       -D 'mode="gauge"'      -D 'base="round"' coffee_spill_mug.scad
//    openscad -o stl/coffee_spill_mug_round_gauge_rear.stl  -D 'mode="gauge_rear"' -D 'base="round"' coffee_spill_mug.scad
//    openscad -o stl/coffee_spill_mug_round_clip.stl        -D 'mode="clip"'       -D 'base="round"' coffee_spill_mug.scad
//
//  Origin: x = 0 is the left side of the tray body, y = 0 is the front face (the
//  one out over the table), z = 0 is the top surface of the plate and
//  z = -plate_height is the table. All units in mm.
// ============================================================================

/* [Which rig] */
// There are two kinds of sensor rig out there, and the only thing that differs
// between them is what stands on the teak plate behind the tray - i.e. how the
// rear of the tray has to be closed off:
//
//   "box"   the grey 3D printed box for the electronics: a square block. The tray
//           meets it with a flat rear face and reaches past it with two arms, one
//           along each side. This is the original rig, the one the first tray was
//           printed for.
//   "round" a curved base under the weighing bowl, which turns out to be what most
//           of the rigs have. The tray has no arms at all: the rear face is a
//           concave arc of the same radius that nests into it, and that arc is a
//           better locator than the arms ever were - it centres the tray by
//           itself, and the trough gets deeper at the corners into the bargain.
//
// Everything else - the trough, the ramp, the leg, the tongue, the text, the print
// orientation, all the rounding - is shared, which is why this is one file with a
// switch rather than two files that would have to be edited twice.
base = "round";

/* [Main dimensions] */
tray_width  = 90;   // body width, along the front edge of the plate, and the
                    // widest point of the whole part: neither the arms (base =
                    // "box") nor the arc (base = "round") stands outside the
                    // sides. Was 80, which came from the width of the tongue on
                    // the plate; it is 90 now to give the text on the front face
                    // room to breathe.

// How far in on the plate the tray reaches, measured from the front edge of the
// plate to the nearest point of whatever stands behind it. FIXED BY THE RIG: the
// body cannot get any deeper at the back, so extra depth has to come out of
// overhang, at the front. One value per rig, because the two are not the same
// distance in.
plate_depth_box   = 30;
plate_depth_round = 30; // MEASURE THIS on a round rig: plate edge to the nearest
                        // point of the curved base. 30 is a placeholder copied
                        // from the box rig. Check it with mode = "gauge" before
                        // printing a whole tray - the 2 mm profile shows exactly
                        // whether the tongue seats before the arc touches.
tray_height = 20.5; // height of the rim above the plate surface. On the box rig
                    // the socle is socle_height = 22 mm, and there are several mm
                    // of air from its top up to the big grey cup the pot stands
                    // in, so the rim has room to spare. Fitted with the 2 mm
                    // gauge. On a round rig the weighing bowl overhangs the base,
                    // so check disc_z instead - an assert does it for you.
overhang    = 18;   // how far the tray sticks out past the front edge of the
                    // plate. Was 10. The rear ramp had to get shallower than 45
                    // degrees to print cleanly (see rear_angle), which costs
                    // depth, and the back is up against the socle - so the extra
                    // 8 mm are added at the front. It costs nothing structurally:
                    // the leg stands on the table at the very front, so the
                    // overhang is carried, not cantilevered, and the pivot lever
                    // gets better rather than worse (see foot_clear).

/* [The box rig] */
// The grey 3D printed socle that carries the sensor, standing on the teak plate
// right behind the tray. Measured with the caliper. Only used when base = "box".
socle_width  = 76;  // across, at the front face of the socle
socle_height = 22;  // up from the top of the teak plate
socle_depth  = 76;  // backwards - not measured exactly, "a lot", about this

/* [The round rig] */
// The curved base under the weighing bowl. Only used when base = "round".
//
// base_r is straight out of the CAD file for the base: the measured edge has
// radius 87.00 mm and length 182.25 mm, and 182.25 / 87 = 2.094 rad = 120.0
// degrees, so it is a designed 120 degree arc, 150.7 mm across the chord. Our
// 90 mm tray sits well inside that: it spans +/- 31 degrees of it.
base_r     = 87;    // radius of the curved face we nest into
base_arc   = 120;   // how much of the circle the base actually is (ghost only)
base_h     = 20;    // MEASURE THIS: height of the curved base above the teak
                    // plate. Only used for the ghost and for the assert below.
base_clear = 0.4;   // radial gap between the arc and the base. Small on purpose:
                    // the tongue at the plate edge is what sets the position, so
                    // this only has to swallow the error in plate_depth_round.
                    // Too big and it is a visible slot for a drip to run into.
base_fn    = 240;   // facets on the full circle for the arc. 240 puts the chord
                    // error at 87 * (1 - cos(0.75 deg)) = 0.007 mm, which is
                    // nothing; $fn = 64 would leave 0.10 mm of flat spots.
rear_corner_r = 3;  // rounding of the two rear corners in plan, where the sides
                    // of the tray run into the arc. Those are the deepest points
                    // of the part and they end up at the very top of the print,
                    // where a rounding is free - it is a prism along the print
                    // axis, not an overhang.

// The weighing bowl sits on top of the curved base and overhangs it, so the rim of
// the tray has to pass under that overhang. Both of these are for the ghost in
// mode = "check" and for the assert that the rim clears the bowl.
disc_r     = 95;    // MEASURE THIS: radius of the overhanging weighing bowl
disc_z     = 24;    // MEASURE THIS: height of the *underside* of the bowl above
                    // the teak plate
disc_clear = 1.5;   // air we want to leave between the rim and that underside

// The teak plate itself. Only drawn as a ghost in mode = "check", so these two
// affect nothing but the picture: the tray is held by the front edge of the plate
// and by the socle, and both of those are square to the tray wherever the corners
// of the plate happen to be.
plate_size   = 200; // 200 x 200 mm square...
plate_corner = 37;  // ... with all four corners cut at 45 degrees, leaving a
                    // short edge about this long: an octagon

/* [Wall thickness] */
wall_t  = 2.4;      // side, front and rear walls
floor_t = 2.0;      // floor of the trough (the part lying on the plate)

/* [Inside of the trough] */
// The inside of the rear wall faces the bed when printed, so the floor rises to
// the rim there over rear_fillet plus a straight run at rear_angle. The front wall
// and the two short ends only get inner_fillet, a plain rounding that makes the
// trough easy to wipe out - no ramp needed, none of those surfaces faces the bed.
//
// rear_angle is the overhang angle from the build direction: every layer steps
// tan(rear_angle) * layer_height sideways from the one below. 45 degrees is the
// textbook limit and it did print, but on the first tray in PLA it came out rough
// and drooping, so it is 35 degrees now - each layer only steps 0.7 of its height
// instead of a full one. The cost is depth: the ramp eats
// rear_fillet * sin(a) + (tray_height - floor_t - rear_fillet * (1 - cos a)) / tan(a)
// which is 30.2 mm at 35 degrees against 23.5 mm at 45. Run the part cooling fan
// flat out over these layers as well.
rear_angle   = 35;
rear_fillet  = 12;
inner_fillet = 5;
arc_steps    = 24;  // facets in the fillets

/* [Leg down to the table] */
// The front wall carries on down past the front edge of the plate and stands on
// the table, so the overhang is supported instead of cantilevered. plate_height
// is measured from the table up to the top surface of the teak plate. foot_clear
// shortens the leg a little: the tray pivots on the plate edge, so a leg that is
// e mm too long lifts the rear edge by 3 e mm and eats into the clearance under
// the grey cup. 0.3 mm is enough that the leg still takes over as soon as
// anything presses on the overhang.
//
// NOTE: the teak plate itself measures 19 mm thick. plate_height is 1.6 mm more
// than that because it was fitted with the printed gauge - the plate does not
// lie flat on the table. If the new gauge shows the leg standing the tray on its
// heel, set plate_height = 19.3.
leg_enable   = true;
plate_height = 20.6;
foot_clear   = 0.3;
leg_t        = 4;   // thickness of the leg below the plate. Thicker than the
                    // front wall on purpose: with edge_r = 1.5 a 2.4 mm leg
                    // would be rounded away to a knife edge against the table,
                    // 4 mm leaves a flat foot to bear on.

/* [Locating tongue at the plate edge] */
// A short tongue behind the leg, hanging down in front of the front face of the
// plate, so the tray cannot slide backwards towards the pot. Its front face
// would be a ceiling in the print, so it is chamfered at 45 degrees. The chamfer
// starts at the back of the leg, which caps hook_depth at hook_front - leg_t.
hook_enable = true;
hook_depth  = 3;
hook_t      = 3;    // thickness of the tongue
hook_relief = 1.0;  // 45 degree relief in the inner corner, so a rounded or
                    // slightly chamfered plate edge still seats fully

/* [Side spring clamps] */
// One on each side: the side wall carried on backwards past the rear face as a
// leaf spring clamp_len_l/clamp_len_r mm long, clamp_t mm thick, along the side of the
// grey socle. The outer face is flush with the side of the tray and the inner
// face is the gripping face, so the pair of them is clamp_squeeze mm narrower
// than the socle and has to spread to let it in.
//
// With clamp_squeeze negative the arms never touch the socle in the relaxed state
// and no force is involved. They are still springs, so raising clamp_squeeze above
// zero brings the grip back: bending happens over the whole free length, which is
// what makes it springy instead of brittle, and it takes about 13 N per mm of
// deflection per side on the 18 mm arm in PETG, half again as much in PLA+.
// Stiffness goes as 1 / length^3, so the short 14 mm arm is about twice that.
//
// The gripping face is relieved clamp_lead mm at the free end and closes in on
// the socle over clamp_lead_y mm, so the front corners of the socle wedge the
// arms apart instead of hitting them head on.
clamp_enable  = true;
clamp_squeeze = -0.1;   // total interference, i.e. clamp_squeeze / 2 per side.
                        // NEGATIVE ON PURPOSE: this is now a slip fit, 0.05 mm of
                        // air per side, so the arms are lateral guides rather than
                        // a friction clamp. It went 0.4 -> 0.2 -> 0.1 -> -0.1: the
                        // 0.4 mm gauge splayed out and would not seat, and a tray
                        // that grips also lets go all at once, which slops the
                        // coffee about when it is pulled out to be emptied. What
                        // holds the tray now is the locating tongue against the
                        // plate edge plus its own weight, and the arms keep it
                        // square to within 0.05 mm. Raise this above 0 to get the
                        // friction grip back.
clamp_t       = 2.05;   // thickness of the arm. Up to tray_width = 80 this was
                        // also (tray_width - socle_width + clamp_squeeze) / 2, so
                        // the outer face came out flush with the side of the tray.
                        // At tray_width = 90 that would mean a 7 mm slab, so the
                        // arms are thin fins standing on the rear face instead,
                        // set in arm_x0 mm from the sides.
// The two arms are NOT the same length. The right one may be as long as it likes,
// but the left one butts into a connector on the rig a little way back, so it is
// cut short. Left and right are seen from the front, standing where the overhang
// points at you: the left arm is the one at x = 0. Swap the two numbers if it
// turns out to be the other side.
clamp_len_l   = 14;     // free length backwards from the rear face, left arm
clamp_len_r   = 18;     // ... and the right one
clamp_z0      = 1.5;    // the arm starts this far above the plate, to clear any
                        // fillet or elephant foot at the base of the socle
clamp_h       = 19;     // top of the arm above the plate = tray_height - edge_r.
                        // Any higher and the rounding of the rim would thin the
                        // top of the arm down to a knife edge.
clamp_lead    = 1.0;    // relief of the gripping face at the free end
clamp_lead_y  = 6;      // ... closing in on the socle over this length
clamp_r       = 0.4;    // rounding of the free end of the arm

/* [Rounded edges] */
// Everything that meets the print bed - the whole perimeter of the front face,
// and the two front corners seen from above - is broken with a 45 degree chamfer
// rather than a fillet. A fillet there is tangent to the bed, so the first layer
// would be inset and the next one would hang 0.8 mm out over nothing: it prints
// as a rough drooping lip. 45 degrees is the steepest overhang that comes out
// clean, and a chamfered edge is no longer a sharp edge to the hand.
//
// Everything else is a true fillet, and free: the four long edges are prisms
// along the print axis, and the fillets on the rear face and the underside only
// shrink the cross section as the print grows upwards.
//
// minkowski() with a sphere would round the lot in one line, but it grows every
// outward face by the radius - the mouth between the spring arms would close by
// 2 r and the leg down to the table would grow r longer, i.e. exactly the two
// dimensions that must not move. (The usual correction is to build the source
// solid r smaller first, but there is no single scalar to shrink here.) offset()
// and fillet arcs only ever remove material, so the critical dimensions stay
// exactly as measured.
edge_r   = 1.5;     // the four long outer edges, running along the depth
front_c  = 1.0;     // 45 degree chamfer round the whole front face
corner_c = 3;       // 45 degree cut across the two front corners, in plan
rear_r   = 1.5;     // rear edge of the rim
under_r  = 0.8;     // rear edge of the underside
foot_r   = 0.6;     // inner edge of the foot and the edges of the tongue
arm_r    = 0.8;     // top and bottom edges of the spring arms, outer side only:
                    // the gripping faces keep their full height
fillet_steps = 8;   // facets per fillet arc

/* [Text on the front face] */
// Two lines engraved in the front face - the face that lies on the print bed, so
// it comes out as the smoothest surface on the whole part. It has to be engraved
// and not raised: raised letters on that face would need to be printed below the
// first layer. A recess instead leaves the letters as small bridges text_depth mm
// up, which any printer handles, and the shadow in them reads well in black.
//
// The face is tray_width x (tray_height + plate_height - foot_clear) mm, i.e.
// 90 x 40.8 mm, and all of it is visible: it stands overhang mm out in front of
// the plate edge, down to the table.
//
// OpenSCAD cannot measure a rendered string, so the sizes below are set by hand
// from the width of the longer line, which has to stay inside
// tray_width - 2 * text_margin = 80 mm. Measured at size 6 in this font,
// text_line1 comes out 108.3 mm wide, so it scales to 75.8 mm at size 4.2. If you
// edit either string, render it on its own and scale the size the same way.
text_enable = true;
text_line1  = "SpareBank 1 kaffesølsamler";
text_line2  = "Trekk ut for tømming";
text_size1  = 4.2;
text_size2  = 4.2;
text_font   = "Liberation Sans:style=Bold";
text_depth  = 0.6;  // deep enough to read, shallow enough to leave 1.8 mm of wall
text_gap    = 2.0;  // between the two lines
text_z      = 1.0;  // centre of the two-line block above the plate surface
text_margin = 5;    // least distance from the letters to the sides

/* [View] */
// "use"    = as it sits on the plate (z = 0 is the plate surface)
// "print"  = lying on the front face, ready for the slicer
// "check"  = as "use", with the plate, the grey socle and the table as ghosts
// "gauge"  = a thin slice of the cross section, lying flat, ready for the slicer
// "gauge_clamp" = the top clamp_gauge_t mm of the tray, i.e. the rim and the two
//            arms: the cheap check that the arms straddle the socle
// "clip"   = the rear clip_back mm of the tray plus both complete arms, in print
//            orientation: the real friction test - see README.md
// "cavity" = the trough volume up to the rim, as a solid (for measuring it)
mode = "use";

gauge_t   = 2;   // thickness of the mode = "gauge" slice
clip_back = 12;  // how much of the tray the mode = "clip" test piece takes along

// mode = "gauge_clamp" keeps a clamp_gauge_t mm slice of the tray at the top of
// the arms. That is a ring of wall all the way round plus the top slice of both
// arms, held apart at the right spacing, and it is already flat - the cheapest
// possible check that the arms straddle the socle.
//
// The stiffness of a leaf spring is proportional to its height, so the slice is
// clamp_gauge_t / (clamp_h - clamp_z0) as stiff as the finished arm: 1/7 at
// 2.5 mm, 1/12 at 1.5 mm. The first 1.5 mm gauge was too floppy to say anything
// about the friction - it just splayed out - so it is 2.5 mm now. Even so, the
// finished tray will feel much tighter than the gauge does. Judge the position
// and the entry here, and the friction from mode = "clip".
clamp_gauge_t = 2.5;

$fn = 64;

// ---------------------------------------------------------------------------
//  Derived values
// ---------------------------------------------------------------------------
round_base = (base == "round");
clamps_on  = clamp_enable && !round_base;   // no arms on a round rig: the arc does
                                            // the locating all by itself
plate_depth = round_base ? plate_depth_round : plate_depth_box;

// The two radii of the arc, and where its centre sits. base_x is the centreline of
// the tray, base_y is measured from the front face of the tray: plate edge, plus
// the free plate, plus the radius. arc_out is the outer face of the tray and
// arc_in the inner face of the same wall, so the rear wall is exactly wall_t thick
// measured radially, all the way round.
base_x  = tray_width / 2;
base_y  = overhang + plate_depth + base_r;
arc_out = base_r + base_clear;
arc_in  = arc_out + wall_t;

// How far back the tray reaches. On the box rig that is the flat rear face; on a
// round rig the sides of the tray run on until they meet the arc, which is
// base_r - sqrt(base_r^2 - (tray_width/2)^2) further back than the centreline is.
// That depth is a gift: it is trough, not wall.
function arc_y(r, dx) = base_y - sqrt(r * r - dx * dx);
tray_depth = round_base ? arc_y(arc_out, tray_width / 2)
                        : overhang + plate_depth;
cav_rise   = tray_height - floor_t;         // depth of the trough
table_z    = -(plate_height - foot_clear);  // where the foot of the leg ends up
hook_front = overhang - hook_t;             // front face of the locating tongue
hook_lead  = hook_front - hook_depth;       // where its 45 degree chamfer starts

cav_y0 = wall_t;                            // inside of the front wall
cav_y1 = tray_depth - wall_t;               // inside of the rear wall, box rig
cav_x0 = wall_t;                            // inside of the left short end
cav_x1 = tray_width - wall_t;               // inside of the right short end

// How far back the inside of the trough goes, i.e. how far the profile across the
// width has to be extruded before the rear wall closes it off
cav_y_end = round_base ? arc_y(arc_in, tray_width / 2 - wall_t) : cav_y1;

// Depth eaten by the rear ramp: a fillet from horizontal up to rear_angle, then a
// straight run at rear_angle that hits the rim exactly at the inside of the wall.
// On the box rig it is measured back from cav_y1; on a round rig it is a radius,
// measured out from arc_in, and the ramp is a surface of revolution about the same
// axis as the arc - so it hits the rim exactly at arc_in, all the way round.
rear_run  = rear_fillet * sin(rear_angle)
          + (cav_rise - rear_fillet * (1 - cos(rear_angle))) / tan(rear_angle);
flat_rear = cav_y1 - rear_run;              // where the rear ramp leaves the floor
ramp_foot = arc_in + rear_run;              // ... as a radius, on a round rig

socle_x0 = (tray_width - socle_width) / 2;  // left side of the grey socle
grip_x   = socle_x0 + clamp_squeeze / 2;    // gripping face of the left arm
arm_x0   = grip_x - clamp_t;                // outer face of the left arm
arm_end_l = tray_depth + clamp_len_l;       // free end of the left arm
arm_end_r = tray_depth + clamp_len_r;       // ... and of the right one
arm_end   = max(arm_end_l, arm_end_r);      // the deepest point of the part
part_w   = tray_width - 2 * min(arm_x0, 0); // widest point of the whole part
part_d   = clamps_on ? arm_end : tray_depth;
// Cut plane of the mode = "clip" test piece, clip_back mm in front of the rear
// wall. On the round base tray_depth is the depth at the corners, and the rear
// face on the centreline sits base_y - arc_out, i.e. a good 12 mm, in front of
// that - measuring from the corners would cut the centreline away and leave two
// wings. So measure from the nearest point of the arc, which makes the round
// clip piece deeper: it carries the whole arc, which is the thing to test.
clip_ref = round_base ? base_y - arc_out : tray_depth;
clip_y0  = clip_ref - clip_back;

// The fillet at the foot of the rear ramp eats rear_fillet * (1 - cos(rear_angle))
// of the rise before the straight run even starts, so there has to be more rise
// than that left. This used to say cos(45) from when the ramp was 45 degrees, which
// happened to be stricter than needed at 35 and would have been too lax above 45.
assert(cav_rise > rear_fillet * (1 - cos(rear_angle)),
       "rear_fillet too large for the depth of the trough");
assert(round_base || flat_rear > cav_y0 + inner_fillet,
       "no flat floor left - reduce rear_fillet, inner_fillet or plate_depth");
assert(!round_base || base_y - ramp_foot > cav_y0 + inner_fillet,
       "no flat floor left - reduce rear_fillet, inner_fillet or plate_depth_round");
assert(!round_base || arc_in > tray_width / 2 + 5,
       "the curved base is too small a radius for a tray this wide - the arc would
        close in on itself before it reached the sides");
assert(!round_base || base_arc / 2 > asin(tray_width / 2 / base_r) + 5,
       "the tray is wider than the curved part of the base - it would land on the
        corner where the arc ends");
assert(!round_base || tray_height + disc_clear <= disc_z || arc_out > disc_r,
       "the rim would foul the overhanging weighing bowl - reduce tray_height");
assert(!round_base || base_h > 8,
       "base_h looks unmeasured - the arc needs something to nest against");
assert(!round_base || 2 * rear_corner_r < tray_width / 2,
       "rear_corner_r too large for the rear corners");
assert(2 * inner_fillet < cav_x1 - cav_x0, "inner_fillet too large for the width");
assert(!hook_enable || hook_lead >= leg_t,
       "the 45 degree chamfer on the tongue starts inside the leg - reduce hook_depth");
assert(!hook_enable || !leg_enable || hook_depth < plate_height - foot_clear,
       "the locating tongue reaches below the foot of the leg - reduce hook_depth");
assert(round_base || socle_width < tray_width,
       "the socle is wider than the tray - the arms cannot reach around it");
assert(!clamps_on || arm_x0 >= -0.01,
       "the arms stand outside the sides of the tray - reduce clamp_t");
assert(!text_enable || text_depth < wall_t - 1.2,
       "the text recess leaves less than 1.2 mm of front wall - reduce text_depth");
assert(!clamps_on || clamp_t > 1.6,
       "clamp_t below 1.6 mm is thinner than two perimeters - the spring is too weak");
assert(!clamps_on || clamp_h <= socle_height + 1,
       "the arms stand taller than the socle - reduce clamp_h");
assert(!clamps_on || clamp_h <= tray_height - edge_r,
       "the rim rounding would thin the top of the arms - reduce clamp_h");
assert(!clamps_on || clamp_z0 + 5 < clamp_h, "no arm left - reduce clamp_z0");
assert(!clamps_on || max(clamp_len_l, clamp_len_r) <= socle_depth,
       "the arms reach past the back of the socle - reduce clamp_len_l/clamp_len_r");
assert(!clamps_on || clamp_lead_y < min(clamp_len_l, clamp_len_r),
       "clamp_lead_y longer than the shorter arm");
assert(!clamps_on || 2 * clamp_r < clamp_t - clamp_lead,
       "clamp_r too large for the tip of the arm");
assert(!clamps_on || grip_x - clamp_lead < socle_x0,
       "the mouth of the arms is narrower than the socle - increase clamp_lead");
assert(clip_back > wall_t, "clip_back must reach in front of the rear wall");
assert(!leg_enable || front_c + foot_r + 1 < leg_t,
       "no flat foot left to bear on - reduce front_c or foot_r");
assert(front_c < wall_t && rear_r < wall_t && front_c + edge_r < tray_width / 2,
       "front_c or rear_r larger than the wall they break");
assert(2 * corner_c < tray_width && corner_c < overhang,
       "corner_c too large - it would cut into the plate edge");
assert(under_r + rear_r < tray_height, "under_r and rear_r meet in the rear face");
assert(!hook_enable || 2 * foot_r < min(hook_t, hook_depth - hook_relief),
       "foot_r too large for the locating tongue");
assert(!clamps_on || (arm_r < clamp_t && 2 * arm_r < clamp_h - clamp_z0),
       "arm_r too large for the spring arms");

echo(str("=== base = \"", base, "\": ",
         round_base ? "no arms, concave arc of R " : "two arms alongside a box ",
         round_base ? str(arc_out, " mm at the rear") : "socle"));
echo(str("Tray ", tray_width, " x ", tray_depth, " x ", tray_height,
         " mm over the plate, ", tray_height - table_z, " mm over the table"));
echo(str("Flat floor ", cav_x1 - cav_x0 - 2 * inner_fillet, " x ",
         (round_base ? base_y - ramp_foot : flat_rear) - cav_y0 - inner_fillet,
         " mm on the centreline, trough ", cav_rise, " mm deep"));
if (round_base)
    echo(str("Rear arc: R ", arc_out, " outside and R ", arc_in, " inside, ",
             base_clear, " mm off the R ", base_r, " base. Rear face ",
             base_y - arc_out, " mm deep on the centreline and ", tray_depth,
             " mm at the corners, i.e. ", tray_depth - (base_y - arc_out),
             " mm of extra trough at the sides"));
else
    echo(str("Arms ", clamp_t, " x ", clamp_h - clamp_z0, " mm, left ", clamp_len_l,
         " mm and right ", clamp_len_r,
         " mm long, gripping at x = ", grip_x, " and ", tray_width - grip_x,
         ": ", clamp_squeeze, " mm total interference on the ", socle_width,
         " mm socle, mouth ", socle_width - clamp_squeeze + 2 * clamp_lead,
         " mm at the tip"));
echo(str("Print footprint ", part_w, " x ", tray_height - table_z,
         " mm, ", part_d, " mm tall"));

// ---------------------------------------------------------------------------
//  Helpers
// ---------------------------------------------------------------------------

// Rounds every convex corner of a 2D shape with radius r, leaves the concave
// ones sharp (the inner corner at the plate edge has to stay square).
module round2d(r) {
    if (r > 0) offset(r = -r) offset(r = r) children();
    else children();
}

// Places a 2D shape drawn in (y, z) and extrudes it along x, from x0 to x0 + len
module extrude_x(x0, len) {
    translate([x0, 0, 0]) rotate([0, 0, 90]) rotate([90, 0, 0])
        linear_extrude(height = len) children();
}

// Places a 2D shape drawn in (x, z) and extrudes it along y, from y0 to y0 + len.
// Anything built this way is a prism along the print axis: no overhang at all.
module extrude_y(y0, len) {
    translate([0, y0 + len, 0]) rotate([90, 0, 0]) linear_extrude(height = len)
        children();
}

function reverse(v) = [for (i = [len(v) - 1 : -1 : 0]) v[i]];

function unit(v) = v / norm(v);

// Replaces the corner p1 of a polyline p0-p1-p2 with a tangent arc of radius r,
// so a fillet can be asked for one named corner at a time instead of offsetting
// the whole outline. r = 0 leaves the corner as it is.
function corner_arc(p0, p1, p2, r) =
    r <= 0 ? [p1] :
    let (v1 = unit(p0 - p1),
         v2 = unit(p2 - p1),
         a  = acos(max(-1, min(1, v1 * v2))),   // angle at the corner
         t  = r / tan(a / 2),                   // tangent distance along the legs
         c  = p1 + unit(v1 + v2) * (r / sin(a / 2)),
         s1 = p1 + v1 * t,
         s2 = p1 + v2 * t,
         a1 = atan2(s1[1] - c[1], s1[0] - c[0]),
         a2 = atan2(s2[1] - c[1], s2[0] - c[0]),
         d  = ((a2 - a1) + 540) % 360 - 180)    // the short way round
    [for (i = [0 : fillet_steps])
        let (w = a1 + d * i / fillet_steps) c + r * [cos(w), sin(w)]];

// Takes a closed outline as [[point, radius], ...] and returns the points
function round_poly(pv) =
    let (n = len(pv))
    [for (i = [0 : n - 1])
        each corner_arc(pv[(i + n - 1) % n][0], pv[i][0], pv[(i + 1) % n][0],
                        pv[i][1])];

// A quarter fillet of radius r, tangent to the floor at distance r from the
// wall. Points run from the wall (top of the fillet) down to the floor.
function fillet_up(wall, dir, r, floor) =
    [for (i = [0 : arc_steps])
        let (a = 90 * i / arc_steps)
        [wall + dir * r * (1 - cos(a)), floor + r * (1 - sin(a))]];

// ---------------------------------------------------------------------------
//  Cross section of the body, in (y, z). y = 0 is the front face, y = overhang
//  is the front face of the plate, z = 0 is the top of the plate and
//  z = table_z is the table. Traversed from the foot of the leg, backwards along
//  the underside, up the rear face and forwards along the rim.
// ---------------------------------------------------------------------------
//  Each corner carries its own fillet radius; the two on the front face are 0,
//  they are chamfered by front_chamfer_mask() instead.
function body_pts() = concat(
    leg_enable
    ? [[[0, table_z], 0],                   // outer bottom corner of the leg
       [[leg_t, table_z], foot_r],          // inner bottom corner of the leg
       [[leg_t, 0], 0]]                     // up the back of the leg
    : [[[0, 0], 0]],
    hook_enable
    ? concat(hook_lead > leg_t ? [[[hook_lead, 0], 0]] : [],
             [[[hook_front, -hook_depth], foot_r],  // bottom front corner of the
                                            // tongue, reached at 45 degrees
              [[overhang, -hook_depth], foot_r],    // bottom of the tongue
              [[overhang, -hook_relief], 0],   // inside, on the plate edge
              [[overhang + hook_relief, 0], 0]])   // relief in the inner corner
    : [],
    [[[tray_depth, 0], under_r],            // underside, resting on the plate
     [[tray_depth, tray_height], rear_r],   // rear face
     [[0, tray_height], 0]]);               // rim, back to the front face

function body_section() = round_poly(body_pts());

// The outline of the front face, in (x, z), with the four long outer edges
// rounded. A prism along the print axis, so that rounding is free.
module front_outline() {
    round2d(edge_r) translate([0, table_z]) square([tray_width, tray_height - table_z]);
}

module rounded_bounds() {
    extrude_y(-1, part_d + 2) front_outline();
}

// Cuts the two front corners at 45 degrees, seen from above. A fillet here would
// be tangent to the bed; this rises from the first layer at exactly 45 degrees.
module plan_mask() {
    translate([0, 0, table_z - 1])
        linear_extrude(height = tray_height - table_z + 2)
            polygon([[corner_c, 0], [tray_width - corner_c, 0],
                     [tray_width, corner_c], [tray_width, part_d + 1],
                     [0, part_d + 1], [0, corner_c]]);
}

// A 45 degree chamfer all the way round the front face, i.e. round the first
// layer: the outline at y = 0 is inset front_c mm and opens out to full size
// front_c mm up.
module front_chamfer_mask() {
    union() {
        hull() {
            extrude_y(0, 0.01) offset(r = -front_c) front_outline();
            extrude_y(front_c, 0.01) front_outline();
        }
        translate([-1, front_c, table_z - 1])
            cube([tray_width + 2, part_d + 2, tray_height - table_z + 2]);
    }
}

// The two lines of text, drawn in (x, z) so they read the right way round seen
// from the front, and extruded backwards into the front wall. Subtracted, so what
// is left is a recess text_depth mm deep.
module front_text_2d() {
    h = text_size1 + text_gap + text_size2;     // height of the whole block
    translate([tray_width / 2, text_z + h / 2 - text_size1])
        text(text_line1, size = text_size1, font = text_font,
             halign = "center", valign = "baseline");
    translate([tray_width / 2, text_z - h / 2])
        text(text_line2, size = text_size2, font = text_font,
             halign = "center", valign = "baseline");
}

module front_text() {
    extrude_y(-0.1, text_depth + 0.1) front_text_2d();
}

// Rounds the top and bottom edges of the spring arms, on the outer side only -
// the mask spans the full width, so it never touches the gripping faces.
module arm_mask() {
    extrude_y(cav_y1, arm_end - cav_y1) round2d(arm_r)
        translate([0, clamp_z0]) square([tray_width, clamp_h - clamp_z0]);
}

// ---------------------------------------------------------------------------
//  The concave rear arc, for base = "round". Two masks, both about the vertical
//  axis through (base_x, base_y):
//
//    plan_round_mask()  an intersection mask - the plan outline, i.e. the sides of
//                       the tray running back until they meet the arc, with those
//                       two corners rounded. This one defines the arc face itself.
//    base_mask()        a difference mask - a surface of revolution that carries
//                       the under_r and rear_r fillets along the top and bottom
//                       edges of the arc, the same two radii the flat rear face
//                       gets on the box rig. Its straight section is set 0.05 mm
//                       inside the arc so it never forms the face itself; two
//                       coincident cylinders would only give CGAL something to
//                       argue about.
//
//  Neither is an overhang in the print. The arc faces backwards, which is upwards
//  once the part is lying on its front face, and the two rear corners are vertical
//  edges in the model, i.e. lines along the print axis: rounding them is free.
// ---------------------------------------------------------------------------
module plan_round_mask() {
    if (round_base)
        translate([0, 0, table_z - 1])
            linear_extrude(height = tray_height - table_z + 2)
                round2d(rear_corner_r) difference() {
                    translate([0, -5]) square([tray_width, tray_depth + 6]);
                    translate([base_x, base_y]) circle(r = arc_out, $fn = base_fn);
                }
    else                                        // a mask that masks nothing
        translate([-1, -1, table_z - 1])
            cube([tray_width + 2, part_d + 2, tray_height - table_z + 2]);
}

// The profile of the mask, in (radius, z). Bottom up: out along the plate, up over
// the under_r fillet, straight up the arc, out over the rear_r fillet at the rim,
// and away above it.
function base_mask_profile() =
    let (r0 = arc_out - 0.05)
    concat([[0, table_z - 1], [r0 + under_r, table_z - 1]],
           reverse(fillet_up(r0, +1, under_r, 0)),
           [for (i = [0 : arc_steps])                   // the fillet at the rim:
               let (a = 90 * i / arc_steps)             // fillet_up turned upside
               [r0 + rear_r * (1 - cos(a)),             // down
                tray_height - rear_r * (1 - sin(a))]],
           [[r0 + rear_r, tray_height + 10], [0, tray_height + 10]]);

module base_mask() {
    translate([base_x, base_y, 0])
        rotate_extrude($fn = base_fn) polygon(base_mask_profile());
}

// ---------------------------------------------------------------------------
//  The trough. Profiles intersected: one across the width, with a plain fillet at
//  each short end, one along the depth with the front wall and the floor, and the
//  rear ramp - which is a prism at constant y on the box rig, and a surface of
//  revolution about the same axis as the arc on a round rig. All of them are left
//  open above the rim.
// ---------------------------------------------------------------------------
function end_profile() = concat(
    [[cav_x0, tray_height + 1]],
    fillet_up(cav_x0, +1, inner_fillet, floor_t),
    reverse(fillet_up(cav_x1, -1, inner_fillet, floor_t)),
    [[cav_x1, tray_height + 1]]);

// The rear ramp: tangent to the floor at flat_rear, curving up to rear_angle over
// rear_fillet, then straight at rear_angle through the rim
function rear_ramp() = concat(
    [for (i = [0 : arc_steps])
        let (a = rear_angle * i / arc_steps)
        [flat_rear + rear_fillet * sin(a), floor_t + rear_fillet * (1 - cos(a))]],
    // the straight run reaches the rim exactly at cav_y1 by construction; carry it
    // 1 mm further at the same slope so the outline closes above the rim
    [[cav_y1 + 1, tray_height + tan(rear_angle)]]);

// The front wall and the floor, in (y, z): the inner_fillet rising out of the floor
// at the inside of the front wall, and then the floor running backwards past
// anything the rear can do with it. Open above the rim.
function front_profile() = concat(
    [[cav_y0, tray_height + 1]],
    fillet_up(cav_y0, +1, inner_fillet, floor_t),
    [[tray_depth + 1, floor_t], [tray_depth + 1, tray_height + 1]]);

// The rear ramp of the box rig as its own profile in (y, z), so it can be
// intersected with the one above rather than drawn as part of it
function rear_ramp_profile() = concat(
    [[cav_y0 - 1, tray_height + 1], [cav_y0 - 1, floor_t]],
    rear_ramp());

// The same ramp for a round rig, in (radius, z), revolved about the arc axis: out
// from the rim at arc_in, down the straight run at rear_angle, round the fillet on
// to the floor at ramp_foot, and then the floor carries on outwards. Every layer of
// the print is a constant y, and this surface only ever tips *away* from the print
// axis as it curves round, so it is a shade less of an overhang than the flat ramp
// on the box rig - never more.
function rear_bowl_profile() = concat(
    [[arc_in, tray_height + 1], [arc_in, tray_height]],
    [for (i = [arc_steps : -1 : 0])
        let (a = rear_angle * i / arc_steps)
        [ramp_foot - rear_fillet * sin(a), floor_t + rear_fillet * (1 - cos(a))]],
    [[ramp_foot + 2 * base_r, floor_t],
     [ramp_foot + 2 * base_r, tray_height + 1]]);

module rear_bowl() {
    translate([base_x, base_y, 0])
        rotate_extrude($fn = base_fn) polygon(rear_bowl_profile());
}

module trough() {
    intersection() {
        extrude_y(cav_y0, cav_y_end + 1 - cav_y0) polygon(end_profile());
        extrude_x(-1, tray_width + 2) polygon(front_profile());
        if (round_base) rear_bowl();
        else extrude_x(-1, tray_width + 2) polygon(rear_ramp_profile());
    }
}

// ---------------------------------------------------------------------------
//  The side spring clamps. One arm is a flat plate in the (x, y) plane extruded
//  in z, so every gripping face is parallel to the print axis and comes out
//  exactly as drawn. It starts inside the rear wall, at cav_y1, so the union
//  with the body is a solid overlap and not two faces meeting.
//  Drawn on the left side and mirrored to the right, but the two are not the same
//  length - the left one is cut short to clear a connector on the rig - so the
//  free end y is a parameter.
// ---------------------------------------------------------------------------
function arm_plan(y_end) = [
    [arm_x0, cav_y1],                       // buried in the rear wall
    [grip_x, cav_y1],
    [grip_x, y_end - clamp_lead_y],         // the gripping face
    [grip_x - clamp_lead, y_end],           // relieved towards the free end
    [arm_x0, y_end]                         // outer face, flush with the tray
];

module clamp(y_end) {
    translate([0, 0, clamp_z0])
        linear_extrude(height = clamp_h - clamp_z0)
            round2d(clamp_r) polygon(arm_plan(y_end));
}

module clamps() {
    clamp(arm_end_l);                                   // left, at x = 0
    translate([tray_width, 0, 0]) scale([-1, 1, 1])     // right, mirrored
        clamp(arm_end_r);
}

// ---------------------------------------------------------------------------
//  The tray
// ---------------------------------------------------------------------------
module coffee_spill_tray() {
    difference() {
        intersection() {
            union() {
                extrude_x(0, tray_width) polygon(body_section());
                if (clamps_on) intersection() { clamps(); arm_mask(); }
            }
            rounded_bounds();
            plan_mask();
            front_chamfer_mask();
            plan_round_mask();
        }
        trough();
        if (text_enable) front_text();
        if (round_base) base_mask();
    }
}

// The teak plate: a 200 x 200 mm square with all four corners cut off at 45
// degrees, leaving a short edge of plate_corner mm, i.e. a regular-looking but
// not regular octagon. The tray sits centred on the middle of its front edge.
function plate_plan() =
    let (c = plate_corner / sqrt(2), s = plate_size)     // leg of the corner cut
    [[c, 0], [s - c, 0], [s, c], [s, s - c],
     [s - c, s], [c, s], [0, s - c], [0, c]];

module ghost_plate() {
    translate([(tray_width - plate_size) / 2, overhang, -plate_height])
        linear_extrude(height = plate_height) polygon(plate_plan());
}

// The curved base of a round rig, as the circular segment it looks like in the
// photos: the base_arc degrees of the circle that face the tray, closed off by the
// chord behind. Only a ghost, so the back of it does not have to be right.
function base_plan() =
    [for (i = [0 : base_fn])
        let (a = -90 - base_arc / 2 + base_arc * i / base_fn)
        [base_r * cos(a), base_r * sin(a)]];

// The teak plate, whatever stands behind the tray, and the table: ghosts drawn only
// in mode = "check"
module ghost_rig() {
    %ghost_plate();
    if (round_base) {
        %translate([base_x, base_y, 0])                    // the curved base
            linear_extrude(height = base_h) polygon(base_plan());
        %translate([base_x, base_y, disc_z])               // the weighing bowl
            cylinder(r = disc_r, h = 8, $fn = base_fn);
    } else {
        %translate([socle_x0, tray_depth, 0])              // the grey socle
            cube([socle_width, socle_depth, socle_height]);
    }
    %translate([(tray_width - plate_size) / 2 - 40, -40, -plate_height - 2])
        cube([plate_size + 80, plate_size + overhang + 60, 2]);    // the table
}

// Lays the part down on its front face, the way it is printed
module on_front_face() {
    translate([0, tray_height, 0]) rotate([90, 0, 0]) children();
}

if (mode == "print")
    on_front_face() coffee_spill_tray();
else if (mode == "gauge")
    // The cross section laid flat in the xy plane: x is the depth of the tray,
    // y is the height over the table
    translate([0, -table_z, 0]) linear_extrude(height = gauge_t)
        polygon(body_section());
else if (mode == "gauge_rear" || mode == "gauge_clamp")
    // A slice at the top of the tray, already flat, just dropped down onto the
    // bed. It is the gauge for whatever closes the rear off: on the box base a
    // wall ring plus both arms, held at the right spacing; on the round base a
    // wall ring whose back is the full concave arc, to lay against the curved
    // base and see whether the radius is right. "gauge_clamp" is the old name
    // for it, from when the box base and its arms were all there was.
    translate([0, 0, clamp_gauge_t - clamp_h]) intersection() {
        coffee_spill_tray();
        translate([-50, -50, clamp_h - clamp_gauge_t])
            cube([tray_width + 100, part_d + 100, clamp_gauge_t]);
    }
else if (mode == "clip")
    // The rear clip_back mm of the tray plus both complete arms, standing on the
    // cut plane the same way the whole tray stands on its front face
    translate([0, 0, -clip_y0]) on_front_face() intersection() {
        coffee_spill_tray();
        translate([-50, clip_y0, -50])
            cube([tray_width + 100, part_d - clip_y0, 100]);
    }
else if (mode == "cavity")
    intersection() {
        trough();
        translate([-1, -1, -1]) cube([tray_width + 2, tray_depth + 2, tray_height + 1]);
    }
else {
    coffee_spill_tray();
    if (mode == "check") ghost_rig();
}
