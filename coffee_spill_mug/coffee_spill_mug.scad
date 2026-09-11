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
//  stiffens the overhang. Three things hold the tray on the rig:
//
//    * a tongue behind the leg, hanging down in front of the front face of the
//      plate, so the tray cannot slide backwards towards the pot
//    * two arms reaching backwards from the rear face, one along each side of the
//      grey printed socle that carries the sensor, straddling it
//    * its own weight on the plate
//
//  THE GREY SOCLE is the fixed 3D printed block standing on the teak plate
//  behind the tray: socle_width mm wide, socle_height mm up from the plate and
//  deep. That is what the arms straddle - the sides of a block that stands up
//  above the plate - as two thin fins set in arm_x0 mm from the sides of the
//  tray, at the width the socle needs rather than flush with the sides.
//
//  The arms are a deliberate SLIP FIT, not a clamp: clamp_squeeze is negative, so
//  the opening is a touch wider than the socle. They locate the tray sideways and
//  keep it square, and the tongue plus the weight of the tray do the holding. That
//  is on purpose - a grip that has to be broken releases with a jerk, and a tray
//  full of coffee residue being pulled forwards for emptying is the last place you
//  want a jerk. Raise clamp_squeeze above 0 to get a real grip back.
//
//  PRINT ORIENTATION: on the front face (mode = "print"), so the print axis runs
//  backwards along the depth of the tray. That is what makes the arms possible.
//  Both gripping faces are planes at constant x; standing the part on a short end
//  would put the print axis along x, turning those planes into layer planes, and
//  the inner face of the upper arm into a ceiling hanging over nothing. Standing
//  the tray upright is worse: the whole underside would be a ceiling
//  plate_depth x tray_width mm in the air above the leg.
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
//      away from the rig.
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
//  against 2.0), so the spring arms come out roughly 1.5 times stiffer than the
//  figures below. What to watch is creep: the grip is a constant strain, and PLA
//  relaxes under it, so if the tray works loose after some months, raise
//  clamp_squeeze or print it again in PETG. See README.md.
//
//  The STL files are written like this - see README.md for the reasoning:
//
//    openscad -o stl/coffee_spill_mug.stl -D 'mode="print"' coffee_spill_mug.scad
//    openscad -o stl/coffee_spill_mug_gauge.stl       -D 'mode="gauge"'       coffee_spill_mug.scad
//    openscad -o stl/coffee_spill_mug_gauge_clamp.stl -D 'mode="gauge_clamp"' coffee_spill_mug.scad
//    openscad -o stl/coffee_spill_mug_clip.stl        -D 'mode="clip"'        coffee_spill_mug.scad
//
//  Origin: x = 0 is the left side of the tray body, y = 0 is the front face (the
//  one out over the table), z = 0 is the top surface of the plate and
//  z = -plate_height is the table. All units in mm.
// ============================================================================

/* [Main dimensions] */
tray_width  = 90;   // body width, along the front edge of the plate, and the
                    // widest point of the whole part: the spring arms are set in
                    // from the sides, they do not stand outside them. Was 80,
                    // which came from the width of the tongue on the plate; it is
                    // 90 now to give the text on the front face room to breathe.
plate_depth = 30;   // how far in on the plate the tray reaches, measured from
                    // the front edge of the plate towards the sensor holder.
                    // FIXED BY THE RIG: the grey socle stands this far in, so the
                    // body cannot get any deeper at the back. Extra depth has to
                    // come out of overhang, at the front.
tray_height = 20.5; // height of the rim above the plate surface. The grey socle
                    // is socle_height = 22 mm, and there are several mm of air
                    // from its top up to the big grey cup the pot stands in, so
                    // the rim has room to spare. Fitted with the 2 mm gauge.
overhang    = 18;   // how far the tray sticks out past the front edge of the
                    // plate. Was 10. The rear ramp had to get shallower than 45
                    // degrees to print cleanly (see rear_angle), which costs
                    // depth, and the back is up against the socle - so the extra
                    // 8 mm are added at the front. It costs nothing structurally:
                    // the leg stands on the table at the very front, so the
                    // overhang is carried, not cantilevered, and the pivot lever
                    // gets better rather than worse (see foot_clear).

/* [The rig we clamp on to] */
// The grey 3D printed socle that carries the sensor, standing on the teak plate
// right behind the tray. Measured with the caliper.
socle_width  = 76;  // across, at the front face of the socle
socle_height = 22;  // up from the top of the teak plate
socle_depth  = 76;  // backwards - not measured exactly, "a lot", about this

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
tray_depth = overhang + plate_depth;        // total depth of the tray body
cav_rise   = tray_height - floor_t;         // depth of the trough
table_z    = -(plate_height - foot_clear);  // where the foot of the leg ends up
hook_front = overhang - hook_t;             // front face of the locating tongue
hook_lead  = hook_front - hook_depth;       // where its 45 degree chamfer starts

cav_y0 = wall_t;                            // inside of the front wall
cav_y1 = tray_depth - wall_t;               // inside of the rear wall
cav_x0 = wall_t;                            // inside of the left short end
cav_x1 = tray_width - wall_t;               // inside of the right short end

// Depth eaten by the rear ramp: a fillet from horizontal up to rear_angle, then a
// straight run at rear_angle that hits the rim exactly at the inside of the wall
rear_run  = rear_fillet * sin(rear_angle)
          + (cav_rise - rear_fillet * (1 - cos(rear_angle))) / tan(rear_angle);
flat_rear = cav_y1 - rear_run;              // where the rear ramp leaves the floor

socle_x0 = (tray_width - socle_width) / 2;  // left side of the grey socle
grip_x   = socle_x0 + clamp_squeeze / 2;    // gripping face of the left arm
arm_x0   = grip_x - clamp_t;                // outer face of the left arm
arm_end_l = tray_depth + clamp_len_l;       // free end of the left arm
arm_end_r = tray_depth + clamp_len_r;       // ... and of the right one
arm_end   = max(arm_end_l, arm_end_r);      // the deepest point of the part
part_w   = tray_width - 2 * min(arm_x0, 0); // widest point of the whole part
part_d   = clamp_enable ? arm_end : tray_depth;
clip_y0  = tray_depth - clip_back;          // cut plane of the mode = "clip" piece

assert(cav_rise > rear_fillet * (1 - cos(45)),
       "rear_fillet too large for the depth of the trough");
assert(flat_rear > cav_y0 + inner_fillet,
       "no flat floor left - reduce rear_fillet, inner_fillet or plate_depth");
assert(2 * inner_fillet < cav_x1 - cav_x0, "inner_fillet too large for the width");
assert(!hook_enable || hook_lead >= leg_t,
       "the 45 degree chamfer on the tongue starts inside the leg - reduce hook_depth");
assert(!hook_enable || !leg_enable || hook_depth < plate_height - foot_clear,
       "the locating tongue reaches below the foot of the leg - reduce hook_depth");
assert(socle_width < tray_width,
       "the socle is wider than the tray - the arms cannot reach around it");
assert(!clamp_enable || arm_x0 >= -0.01,
       "the arms stand outside the sides of the tray - reduce clamp_t");
assert(!text_enable || text_depth < wall_t - 1.2,
       "the text recess leaves less than 1.2 mm of front wall - reduce text_depth");
assert(!clamp_enable || clamp_t > 1.6,
       "clamp_t below 1.6 mm is thinner than two perimeters - the spring is too weak");
assert(!clamp_enable || clamp_h <= socle_height + 1,
       "the arms stand taller than the socle - reduce clamp_h");
assert(!clamp_enable || clamp_h <= tray_height - edge_r,
       "the rim rounding would thin the top of the arms - reduce clamp_h");
assert(!clamp_enable || clamp_z0 + 5 < clamp_h, "no arm left - reduce clamp_z0");
assert(!clamp_enable || max(clamp_len_l, clamp_len_r) <= socle_depth,
       "the arms reach past the back of the socle - reduce clamp_len_l/clamp_len_r");
assert(!clamp_enable || clamp_lead_y < min(clamp_len_l, clamp_len_r),
       "clamp_lead_y longer than the shorter arm");
assert(!clamp_enable || 2 * clamp_r < clamp_t - clamp_lead,
       "clamp_r too large for the tip of the arm");
assert(!clamp_enable || grip_x - clamp_lead < socle_x0,
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
assert(!clamp_enable || (arm_r < clamp_t && 2 * arm_r < clamp_h - clamp_z0),
       "arm_r too large for the spring arms");

echo(str("Tray ", tray_width, " x ", tray_depth, " x ", tray_height,
         " mm over the plate, ", tray_height - table_z, " mm over the table"));
echo(str("Flat floor ", cav_x1 - cav_x0 - 2 * inner_fillet, " x ",
         flat_rear - cav_y0 - inner_fillet, " mm, trough ", cav_rise, " mm deep"));
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
//  The trough. Two profiles intersected: one across the width, with a plain
//  fillet at each short end, and one along the depth, with the 45 degree rear
//  ramp. Both are left open above the rim.
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

function rear_profile() = concat(
    [[cav_y0, tray_height + 1]],
    fillet_up(cav_y0, +1, inner_fillet, floor_t),
    rear_ramp());

module trough() {
    intersection() {
        extrude_y(cav_y0, cav_y1 - cav_y0) polygon(end_profile());
        extrude_x(-1, tray_width + 2) polygon(rear_profile());
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
                if (clamp_enable) intersection() { clamps(); arm_mask(); }
            }
            rounded_bounds();
            plan_mask();
            front_chamfer_mask();
        }
        trough();
        if (text_enable) front_text();
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

// The teak plate, the grey socle and the table, drawn only in mode = "check"
module ghost_rig() {
    %ghost_plate();
    %translate([socle_x0, tray_depth, 0])                  // the grey socle
        cube([socle_width, socle_depth, socle_height]);
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
else if (mode == "gauge_clamp")
    // A slice at the top of the arms - wall ring plus both arms - already flat,
    // just dropped down onto the bed
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
