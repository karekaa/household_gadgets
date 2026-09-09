// ============================================================================
//  Coffee spill tray for the internet connected coffee pot scale
//
//  A shallow open trough that catches the drips that run down the pot and out
//  across the plate. It rests on the free part of the plate - the 80 mm wide
//  tongue in front of the load cell holder - and reaches plate_depth mm in
//  towards the holder. The front overhang mm stick out past the front edge of
//  the plate, so drips that run all the way over the edge are caught too
//  instead of ending up on the table.
//
//  The load cell sits up inside the big grey cup the pot stands in, so the teak
//  plate and the table are both dead support below the measuring path. The tray
//  may therefore rest on the table as well, and that is what it does: the front
//  wall carries on down past the plate edge and stands on the table, which
//  stiffens the overhang. A short hook behind the leg grips the front edge of the
//  plate and keeps the tray from sliding backwards into the pot.
//
//  Print orientation: standing on one short end (mode = "print"), so the layers
//  run along the trough and every wall is printed as an unbroken perimeter -
//  no layer seam for the coffee to seep through, and the thin floor is not a
//  first layer. Standing on end makes the inside of the upper short end a
//  ceiling, so the inside of both short ends rises from the floor to the rim
//  over a fillet followed by a straight 45 degree run, which is the steepest
//  overhang that prints without support. Printing flat (mode = "use") works as
//  well and needs no support either, but gives a horizontal layer boundary
//  right where the floor meets the walls.
//
//  The two STL files are written like this - see README.md for the reasoning:
//
//    openscad -o stl/coffee_spill_mug.stl       -D 'mode="print"' coffee_spill_mug.scad
//    openscad -o stl/coffee_spill_mug_gauge.stl -D 'mode="gauge"' coffee_spill_mug.scad
//
//  Origin: x = 0 is the left short end, y = 0 is the front face (the one out
//  over the table), z = 0 is the top surface of the plate and z = -plate_height
//  is the table. All units in mm.
// ============================================================================

/* [Main dimensions] */
tray_width  = 80;   // along the front edge of the plate (the width of the tongue)
plate_depth = 30;   // how far in on the plate the tray reaches, measured from
                    // the front edge of the plate towards the sensor holder
overhang    = 10;   // how far the tray sticks out past the front edge of the plate
tray_height = 19;   // height of the rim above the plate surface. This is a
                    // maximum: it leaves air up to the underside of the big grey
                    // cup the pot stands in.

/* [Wall thickness] */
wall_t  = 2.4;      // side, front and rear walls
floor_t = 2.0;      // floor of the trough (the part lying on the plate)

/* [Curved short ends] */
// The inside of the short ends rises from the floor of the trough up to the rim:
// first a fillet of radius end_fillet, then a straight 45 degree run. The run
// therefore costs (tray_height - floor_t) + 0.41 * end_fillet mm of trough
// length at each end. Increase end_fillet for a softer, easier to wipe inside,
// decrease it for more capacity. 0 gives a plain 45 degree ramp.
end_fillet = 12;
arc_steps  = 24;    // facets in the fillet

/* [Leg down to the table] */
// The front wall carries on down past the front edge of the plate and stands on
// the table, so the overhang is supported instead of cantilevered. plate_height
// is measured from the table up to the top surface of the teak plate - MEASURE
// IT, the tray rests on the plate and the leg only has to reach down to the
// table. foot_clear shortens the leg a little: the tray pivots on the plate
// edge, so a leg that is e mm too long lifts the rear edge by 3 e mm and eats
// into the clearance under the grey cup. 0.3 mm is enough that the leg still
// takes over as soon as anything presses on the overhang. Set foot_clear = 0 for
// firm contact once plate_height is known exactly.
leg_enable   = true;
plate_height = 20;
foot_clear   = 0.3;
leg_t        = 4;   // thickness of the leg below the plate. Thicker than the
                    // front wall on purpose: with edge_r = 1.5 a 2.4 mm leg
                    // would be rounded away to a knife edge against the table,
                    // 4 mm leaves a flat foot to bear on.

/* [Locating hook at the plate edge] */
// A short tongue right behind the leg, hanging down in front of the front face
// of the plate, so the tray cannot slide backwards towards the pot. There is
// open air between the leg and the hook, so a lower board that sticks out a few
// mm past the teak plate does not get in the way.
hook_enable = true;
hook_depth  = 4;
hook_t      = 3;    // thickness of the tongue
hook_relief = 1.0;  // 45 degree relief in the inner corner, so a rounded or
                    // slightly chamfered plate edge still seats fully

/* [Rim] */
edge_r = 1.5;       // rounding of the outer edges

/* [View] */
// "use"   = as it sits on the plate (z = 0 is the plate surface)
// "print" = standing on the left short end, ready for the slicer
// "check" = as "use", with the plate and the table drawn as ghosts
// "gauge" = a thin slice of the cross section, lying flat, ready for the slicer
mode = "use";

// mode = "gauge" gives a solid gauge_t mm thick slice of the cross section. It
// prints in a couple of minutes: take it over to the pot, hook it on the front
// edge of the plate and check that the leg reaches the table, that the tongue
// clears whatever is under the plate, and that there is air left up to the grey
// cup - before printing the whole tray.
gauge_t = 2;

$fn = 64;

// ---------------------------------------------------------------------------
//  Derived values
// ---------------------------------------------------------------------------
tray_depth = overhang + plate_depth;        // total depth of the tray
cav_rise   = tray_height - floor_t;         // depth of the trough
table_z    = -(plate_height - foot_clear);  // where the foot of the leg ends up
hook_front = overhang - hook_t;             // front face of the locating tongue
// x run consumed by one curved end: fillet from horizontal to 45 degrees,
// then a straight 45 degree line up to the rim
end_run    = end_fillet * sin(45) + (cav_rise - end_fillet * (1 - cos(45)));
flat_left  = wall_t + end_run;              // where the flat floor starts
flat_right = tray_width - wall_t - end_run; // where the flat floor ends

assert(flat_right > flat_left,
       "end_fillet / tray_height too large for tray_width - no flat floor left");
assert(cav_rise > end_fillet * (1 - cos(45)),
       "end_fillet too large for the depth of the trough");
assert(!hook_enable || hook_front > (leg_enable ? leg_t : wall_t) + edge_r,
       "no room between the leg and the locating tongue - reduce hook_t or leg_t");
assert(!hook_enable || !leg_enable || hook_depth < plate_height - foot_clear,
       "the locating tongue reaches below the foot of the leg - reduce hook_depth");

// Capacity up to the rim, trapezoid approximation (the fillet adds a little)
capacity_ml = ((tray_width - 2 * wall_t) + (flat_right - flat_left)) / 2
              * cav_rise * (tray_depth - 2 * wall_t) / 1000;
echo(str("Tray ", tray_width, " x ", tray_depth, " x ", tray_height,
         " mm, flat floor ", flat_right - flat_left,
         " mm, capacity approx ", capacity_ml, " ml"));

// ---------------------------------------------------------------------------
//  Helpers
// ---------------------------------------------------------------------------

// Rounds every convex corner of a 2D shape with radius r, leaves the concave
// ones sharp (the inner corner at the plate edge has to stay square).
module round2d(r) {
    if (r > 0) offset(r = -r) offset(r = r) children();
    else children();
}

// Places a 2D shape drawn in (y, z) and extrudes it along x
module extrude_x(len) {
    rotate([0, 0, 90]) rotate([90, 0, 0]) linear_extrude(height = len) children();
}

// Places a 2D shape drawn in (x, z) and extrudes it along y, from y0 to y0 + len
module extrude_y(y0, len) {
    translate([0, y0 + len, 0]) rotate([90, 0, 0]) linear_extrude(height = len)
        children();
}

// ---------------------------------------------------------------------------
//  Cross section of the body, in (y, z). y = 0 is the front face, y = overhang
//  is the front face of the plate, z = 0 is the top of the plate and
//  z = table_z is the table. Traversed from the foot of the leg, forwards along
//  the table, up in front of the plate, over the plate and back along the rim.
// ---------------------------------------------------------------------------
function body_section() = concat(
    leg_enable
    ? [[0, table_z],                        // outer bottom corner of the leg
       [leg_t, table_z],                    // inner bottom corner of the leg
       [leg_t, 0],                          // up the inside of the leg
       [hook_front, 0]]                     // underside of the overhang
    : [[0, 0], [hook_front, 0]],
    hook_enable
    ? [[hook_front, -hook_depth],           // front of the tongue
       [overhang, -hook_depth],             // bottom of the tongue
       [overhang, -hook_relief],            // inside of the tongue, on the plate edge
       [overhang + hook_relief, 0]]         // relief in the inner corner
    : [],
    [[tray_depth, 0],                       // underside, resting on the plate
     [tray_depth, tray_height],             // rear face
     [0, tray_height]]);                    // rim, back to the front face

// ---------------------------------------------------------------------------
//  Profile of the trough, in (x, z). Flat floor in the middle, and at each
//  short end a fillet plus a straight 45 degree run up to the rim, so the part
//  prints standing on end without support. Left open above the rim.
// ---------------------------------------------------------------------------
function reverse(v) = [for (i = [len(v) - 1 : -1 : 0]) v[i]];

function end_arc(x_tan, dir) =
    [for (i = [0 : arc_steps])
        let (a = 45 * i / arc_steps)
        [x_tan + dir * end_fillet * sin(a), floor_t + end_fillet * (1 - cos(a))]];

function cavity_profile() = concat(
    [[wall_t, tray_height]],                        // inner edge of the left rim
    reverse(end_arc(flat_left, -1)),
    end_arc(flat_right, +1),
    [[tray_width - wall_t, tray_height],            // inner edge of the right rim
     [tray_width - wall_t, tray_height + 1],        // open above the rim
     [wall_t, tray_height + 1]]);

// ---------------------------------------------------------------------------
//  The tray
// ---------------------------------------------------------------------------
module coffee_spill_tray() {
    difference() {
        extrude_x(tray_width) round2d(edge_r) polygon(body_section());
        extrude_y(wall_t, tray_depth - 2 * wall_t) polygon(cavity_profile());
    }
}

// The teak plate and the table, drawn only as a reference in mode = "check"
module ghost_plate() {
    %translate([-20, overhang, -plate_height])
        cube([tray_width + 40, plate_depth + 60, plate_height]);
    %translate([-40, -30, -plate_height - 2])
        cube([tray_width + 80, plate_depth + 120, 2]);
}

if (mode == "print")
    translate([tray_height, 0, 0]) rotate([0, -90, 0]) coffee_spill_tray();
else if (mode == "gauge")
    // The cross section laid down in the xy plane: x is the depth of the tray,
    // y is the height, so it prints flat without support
    translate([0, plate_height, 0]) linear_extrude(height = gauge_t)
        round2d(edge_r) polygon(body_section());
else {
    coffee_spill_tray();
    if (mode == "check") ghost_plate();
}
