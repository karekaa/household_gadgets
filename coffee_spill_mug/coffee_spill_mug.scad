// ============================================================================
//  Coffee spill tray for the internet connected coffee pot scale
//
//  A shallow open trough that catches the drips that run down the pot and out
//  across the plate. It rests on the free part of the plate - the 80 mm wide
//  socle in front of the load cell holder - and reaches plate_depth mm in
//  towards the holder. The front overhang mm stick out past the front edge of
//  the plate, so drips that run all the way over the edge are caught too
//  instead of ending up on the table.
//
//  The load cell sits up inside the big grey cup the pot stands in, so the teak
//  plate and the table are both dead support below the measuring path. The tray
//  may therefore rest on the table as well, and that is what it does: the front
//  wall carries on down past the plate edge and stands on the table, which
//  stiffens the overhang. Three things hold the tray on the rig:
//
//    * a tongue behind the leg, hanging down in front of the front face of the
//      plate, so the tray cannot slide backwards towards the pot
//    * two spring clamps, one on each side, that grip the sides of the socle by
//      friction when the tray is pushed on from the front
//    * its own weight on the plate
//
//  PRINT ORIENTATION: on the front face (mode = "print"), so the print axis runs
//  backwards along the depth of the tray. That is what makes the clamps possible.
//  Standing on a short end - the obvious choice for the trough alone - the upper
//  clamp would have to grow inwards under the tray out of thin air: a clamp can
//  only grow 45 degrees per layer, so a jaw reaching 5 mm down would have to
//  stand 5 mm out with a 45 degree inner face that cannot grip a vertical side.
//
//  Lying on the front face, every clamp surface that has to be vertical runs
//  parallel to the print axis, and the whole front face is the first layer. Only
//  two surfaces face the bed, and both are dealt with at 45 degrees, the steepest
//  overhang that prints without support:
//
//    * the inside of the rear wall - the floor rises to the rim over a fillet of
//      radius rear_fillet, from horizontal up to 45 degrees, and then a straight
//      45 degree run. This also makes the trough deepest at the front, so a spill
//      collects out over the table edge, away from the rig.
//    * the front face of the locating tongue - chamfered at 45 degrees
//
//  The short ends need no such treatment in this orientation - they are prisms
//  along the print axis - so their inside is a plain fillet and the flat floor
//  keeps its full width.
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
tray_width  = 80;   // body width, along the front edge of the plate. The spring
                    // clamps stand clamp_t + clamp_gap mm outside this on each
                    // side, so the widest point of the part is a little more.
plate_depth = 30;   // how far in on the plate the tray reaches, measured from
                    // the front edge of the plate towards the sensor holder
overhang    = 10;   // how far the tray sticks out past the front edge of the plate
tray_height = 20.5; // height of the rim above the plate surface. Fitted with the
                    // 2 mm gauge: leaves air up to the underside of the big grey
                    // cup the pot stands in.

/* [Wall thickness] */
wall_t  = 2.4;      // side, front and rear walls
floor_t = 2.0;      // floor of the trough (the part lying on the plate)

/* [Inside of the trough] */
// The inside of the rear wall faces the bed when printed, so the floor rises to
// the rim there over rear_fillet plus a straight 45 degree run. That costs
// (tray_height - floor_t) + 0.41 * rear_fillet mm of the depth. The front wall
// and the two short ends only get inner_fillet, a plain rounding that makes the
// trough easy to wipe out - no 45 degree run needed, none of those surfaces
// faces the bed.
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
leg_enable   = true;
plate_height = 20.6;  // fitted with the gauge: 0.6 mm more than first measured
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
// One on each side. Each clamp is a leaf spring: a bridge across the top ties it
// to the side wall, an arm runs down the outside of that wall separated by a
// clamp_gap slot, and at the bottom the arm turns in under the tray into a jaw
// that grips the side of the socle. Bending happens over the whole clamp_rise mm
// of the arm, not in a short root, so the grip is springy instead of brittle:
// about 6 N per side at the numbers below.
//
// clamp_squeeze is the total interference over both sides and is the number to
// tune if the grip is too weak or the tray is too hard to push on. The gripping
// face is relieved clamp_lead mm at the front and closes in on the socle over
// clamp_lead_y mm, so the socle wedges the jaws open as the tray is pushed on.
//
// MEASURE BEFORE PRINTING: clamp_depth must stay inside the thickness of the
// socle at its front edge, and clamp_len inside the length over which the socle
// really is socle_width wide, before it widens out towards the sensor holder.
clamp_enable  = true;
socle_width   = 80.1;  // measured across the socle with the caliper
clamp_squeeze = 0.4;   // total, i.e. clamp_squeeze / 2 per side
clamp_t       = 1.6;   // thickness of the arm - this is the spring
clamp_gap     = 0.6;   // slot between the arm and the side wall
clamp_rise    = 12;    // how far up the outside of the wall the arm reaches
clamp_bridge  = 2.4;   // height of the bridge that ties the arm to the wall
clamp_depth   = 5;     // how far down the jaw reaches past the top of the plate
clamp_len     = 26;    // length of the clamp, from the front face backwards
clamp_lead    = 1.0;   // relief of the gripping face at the front
clamp_lead_y  = 10;    // ... closing in on the socle over this length
clamp_slack   = 0.4;   // clearance between the jaw and the underside of the
                       // tray, so the spring is free to move
clamp_r       = 0.5;   // rounding of the clamp edges

/* [Rim] */
edge_r = 1.5;       // rounding of the four long outer edges. The front and rear
                    // faces are left sharp on purpose: the front face is the
                    // first layer and wants full contact with the bed.

/* [View] */
// "use"    = as it sits on the plate (z = 0 is the plate surface)
// "print"  = lying on the front face, ready for the slicer
// "check"  = as "use", with the socle and the table drawn as ghosts
// "gauge"  = a thin slice of the cross section, lying flat, ready for the slicer
// "gauge_clamp" = a thin slice across both clamps, lying flat: the cheap check
//            that the jaws land on the sides of the socle
// "clip"   = the front clip_len mm of the tray, in print orientation. Contains
//            the leg, the tongue and both complete clamps, so it is the real fit
//            and friction test - see README.md.
// "cavity" = the trough volume up to the rim, as a solid (for measuring it)
mode = "use";

gauge_t  = 2;   // thickness of the mode = "gauge" slice
clip_len = 26;  // length of the mode = "clip" test piece

// mode = "gauge_clamp" cuts a clamp_gauge_t mm thick slice at y = clamp_gauge_y,
// well inside the gripping length, and lays it flat. It costs a couple of grams
// and shows whether the jaws sit where they should on the sides of the socle -
// but note that the spring force scales with the length of the clamp, so a
// 1.5 mm slice pinches roughly clamp_gauge_t / clamp_len = 1/17 as hard as the
// finished tray. Judge the fit here and the friction from mode = "clip".
clamp_gauge_t = 1.5;
clamp_gauge_y = 18;

$fn = 64;

// ---------------------------------------------------------------------------
//  Derived values
// ---------------------------------------------------------------------------
tray_depth = overhang + plate_depth;        // total depth of the tray
cav_rise   = tray_height - floor_t;         // depth of the trough
table_z    = -(plate_height - foot_clear);  // where the foot of the leg ends up
hook_front = overhang - hook_t;             // front face of the locating tongue
hook_lead  = hook_front - hook_depth;       // where its 45 degree chamfer starts

cav_y0 = wall_t;                            // inside of the front wall
cav_y1 = tray_depth - wall_t;               // inside of the rear wall
cav_x0 = wall_t;                            // inside of the left short end
cav_x1 = tray_width - wall_t;               // inside of the right short end

// Depth eaten by the rear ramp: a fillet from horizontal up to 45 degrees, then
// a straight 45 degree line that hits the rim exactly at the inside of the wall
rear_run  = rear_fillet * sin(45) + (cav_rise - rear_fillet * (1 - cos(45)));
flat_rear = cav_y1 - rear_run;              // where the rear ramp leaves the floor

grip_x  = (tray_width - socle_width + clamp_squeeze) / 2;  // gripping face, left
arm_x1  = -clamp_gap;                       // inner face of the arm
arm_x0  = -clamp_gap - clamp_t;             // outer face of the arm
part_w  = tray_width - 2 * arm_x0;          // widest point of the whole part

assert(cav_rise > rear_fillet * (1 - cos(45)),
       "rear_fillet too large for the depth of the trough");
assert(flat_rear > cav_y0 + inner_fillet,
       "no flat floor left - reduce rear_fillet, inner_fillet or plate_depth");
assert(2 * inner_fillet < cav_x1 - cav_x0, "inner_fillet too large for the width");
assert(!hook_enable || hook_lead >= leg_t,
       "the 45 degree chamfer on the tongue starts inside the leg - reduce hook_depth");
assert(!hook_enable || !leg_enable || hook_depth < plate_height - foot_clear,
       "the locating tongue reaches below the foot of the leg - reduce hook_depth");
assert(!clamp_enable || clamp_len <= tray_depth,
       "the clamps reach past the rear face - reduce clamp_len");
assert(!clamp_enable || clamp_depth < plate_height - foot_clear,
       "the clamps reach below the foot of the leg - reduce clamp_depth");
assert(!clamp_enable || clamp_rise + clamp_bridge < tray_height,
       "the clamp bridge reaches above the rim - reduce clamp_rise");
assert(!clamp_enable || 2 * clamp_r < clamp_t, "clamp_r too large for clamp_t");
assert(!clamp_enable || grip_x - clamp_lead < (tray_width - socle_width) / 2,
       "the mouth of the clamps is narrower than the socle - increase clamp_lead");

echo(str("Tray ", tray_width, " x ", tray_depth, " x ", tray_height,
         " mm over the plate, ", tray_height - table_z, " mm over the table"));
echo(str("Flat floor ", cav_x1 - cav_x0 - 2 * inner_fillet, " x ",
         flat_rear - cav_y0 - inner_fillet, " mm, trough ", cav_rise, " mm deep"));
echo(str("Gripping faces at x = ", grip_x, " and ", tray_width - grip_x,
         ", i.e. ", clamp_squeeze, " mm total interference on a ",
         socle_width, " mm socle"));
echo(str("Print footprint ", part_w, " x ", tray_height - table_z,
         " mm, ", tray_depth, " mm tall"));

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
function body_section() = concat(
    leg_enable
    ? [[0, table_z],                        // outer bottom corner of the leg
       [leg_t, table_z],                    // inner bottom corner of the leg
       [leg_t, 0]]                          // up the back of the leg
    : [[0, 0]],
    hook_enable
    ? concat(hook_lead > leg_t ? [[hook_lead, 0]] : [],
             [[hook_front, -hook_depth],    // bottom front corner of the tongue,
                                            // reached at 45 degrees from the leg
              [overhang, -hook_depth],      // bottom of the tongue
              [overhang, -hook_relief],     // inside of the tongue, on the plate edge
              [overhang + hook_relief, 0]]) // relief in the inner corner
    : [],
    [[tray_depth, 0],                       // underside, resting on the plate
     [tray_depth, tray_height],             // rear face
     [0, tray_height]]);                    // rim, back to the front face

// The four long outer edges, rounded. A prism along the print axis, so the
// rounding is free; the front and rear faces stay sharp.
module rounded_bounds() {
    extrude_y(-1, tray_depth + 2) round2d(edge_r)
        translate([0, table_z]) square([tray_width, tray_height - table_z]);
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

// The rear ramp: tangent to the floor at flat_rear, curving up to 45 degrees
// over rear_fillet, then straight at 45 degrees through the rim
function rear_ramp() = concat(
    [for (i = [0 : arc_steps])
        let (a = 45 * i / arc_steps)
        [flat_rear + rear_fillet * sin(a), floor_t + rear_fillet * (1 - cos(a))]],
    [[cav_y1 + 1, tray_height + 1]]);

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
//  The side spring clamps. The whole clamp is one profile in (x, z) extruded
//  along y, i.e. a prism along the print axis, so it has no overhang anywhere.
//  Drawn for the left side; the right one is mirrored.
// ---------------------------------------------------------------------------
function clamp_profile() = [
    [arm_x0, -clamp_depth],             // outer bottom corner of the jaw
    [grip_x, -clamp_depth],             // inner bottom corner of the jaw
    [grip_x, -clamp_slack],             // the gripping face
    [arm_x1, -clamp_slack],             // top of the jaw, clear of the tray
    [arm_x1, clamp_rise],               // inner face of the arm, along the slot
    [wall_t / 2, clamp_rise],           // underside of the bridge, into the wall
    [wall_t / 2, clamp_rise + clamp_bridge],
    [arm_x0, clamp_rise + clamp_bridge] // outer face, back down to the jaw
];

// Relieves the gripping face clamp_lead mm at the front, closing in on the socle
// over clamp_lead_y mm. Cuts nothing above the jaw.
module clamp_mouth() {
    translate([0, 0, -clamp_depth - 1])
        linear_extrude(height = clamp_depth + 1 - clamp_slack)
            polygon([[grip_x - clamp_lead, -1],
                     [grip_x - clamp_lead, 0],
                     [grip_x, clamp_lead_y],
                     [grip_x + 10, clamp_lead_y],
                     [grip_x + 10, -1]]);
}

module clamp() {
    difference() {
        extrude_y(0, clamp_len) round2d(clamp_r) polygon(clamp_profile());
        clamp_mouth();
    }
}

module clamps() {
    for (m = [0, 1])
        translate([m * tray_width, 0, 0]) scale([m ? -1 : 1, 1, 1]) clamp();
}

// ---------------------------------------------------------------------------
//  The tray
// ---------------------------------------------------------------------------
module coffee_spill_tray() {
    difference() {
        union() {
            intersection() {
                extrude_x(0, tray_width) polygon(body_section());
                rounded_bounds();
            }
            if (clamp_enable) clamps();
        }
        trough();
    }
}

// The socle and the table, drawn only as a reference in mode = "check"
module ghost_rig() {
    %translate([(tray_width - socle_width) / 2, overhang, -plate_height])
        cube([socle_width, plate_depth + 60, plate_height]);
    %translate([-40, -30, -plate_height - 2])
        cube([tray_width + 80, plate_depth + 120, 2]);
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
    // A thin slice across the clamps, laid flat: x is the width of the tray,
    // y is the height (upside down), z is the thickness of the slice
    translate([0, 0, -clamp_gauge_y]) on_front_face() intersection() {
        coffee_spill_tray();
        translate([-50, clamp_gauge_y, -50])
            cube([tray_width + 100, clamp_gauge_t, 100]);
    }
else if (mode == "clip")
    on_front_face() intersection() {
        coffee_spill_tray();
        translate([-50, 0, -50]) cube([tray_width + 100, clip_len, 100]);
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
