// ============================================================================
//  Living room threshold ramp – modular wedge ramp for the double door
//
//  Same construction as threshold_ramp.scad (right-angled triangle profile,
//  modules that click together with a dovetail tenon), with two additions for
//  the living room doorway:
//
//    1. A lip ("overhang") of lip_out mm at the top of the tall side. The top
//       surface continues flat past the tall face and hangs in the air over the
//       threshold, in the recess between the edge of the threshold and the
//       closed door leaf. The underside of the lip is chamfered at 45 degrees
//       (lip_drop = lip_out) so it prints without support, flat bottom down.
//       Set lip_enable = false / lip_out = 0 for the plain triangle profile.
//
//    2. A sideways ramp at the left end (y = 0, seen from the adjacent room
//       looking into the living room). The left door leaf is almost always
//       closed, so the robot cannot drive over the ramp there – instead the
//       whole profile is cut down to the floor over side_run mm, so the robot
//       can drive up onto the ramp from the side, or along it, without hitting
//       an end wall.
//
//  y = 0 is the left end (module 1). All dimensions in mm.
// ============================================================================

/* [Main dimensions] */
// Ramp height along the doorway: [distance from left edge, height].
// Equal values => the same height all the way across. To make the top follow a
// threshold that varies in height, measure for example every 100 mm and enter
// all the points – the top surface is then lofted through every measuring
// point. y = 0 is the left end (module 1).
height_profile = [[0, 27], [620, 27]];

ramp_run    = 150;   // length of the inclined plane in the floor plane (horizontal leg)
total_width = 620;   // total width of the finished, assembled ramp

/* [Lip over the threshold] */
// The top surface continues lip_out mm past the tall face and hangs in the air
// over the threshold. lip_tip is the thickness at the outer edge; below that the
// face falls back to the tall side over lip_drop mm. lip_drop = lip_out gives a
// 45 degree overhang, which prints without support. Increase lip_drop for a
// gentler underside, reduce it if the recess under the door leaf is shallow
// (steeper overhang – may need support).
lip_enable = true;
lip_out    = 15;
lip_tip    = 3;
lip_drop   = 15;

/* [Sideways ramp at the left end] */
// The left end is cut down to the floor by a single plane, so the end becomes a
// ramp in the width direction instead of a vertical wall. Keep side_run smaller
// than the module length, so the taper stays inside module 1 and does not touch
// the first joint.
side_enable = true;
side_run    = 120;   // how far in from y = 0 the end reaches full height

/* [Subdivision] */
n_modules   = 5;     // number of modules (must be >= 1)

/* [Printer build volume] */
bed_x       = 200;   // FlashForge Creator Pro 2
bed_y       = 148;
bed_z       = 150;

/* [Joint / click coupling] */
joint_depth   = 14;   // how far the tenon protrudes (along the width)
joint_neck    = 14;   // width of the tenon at the root
joint_head    = 24;   // width of the tenon at the tip (> neck => dovetail, locks widthwise)
joint_x       = 22;   // center of the tenon measured from the tall edge (x = 0)
joint_clear   = 0.25; // clearance in the socket (up = looser, down = tighter)
joint_fillet  = 1.5;  // rounding of the tenon corners

/* [Snap bumps] */
snap_enable = true;
snap_r      = 2.5;    // radius of the sphere that forms the bump (large = gentle lead-in)
snap_proud  = 0.6;    // how far the bump protrudes from the flank
                      // effective clamping grip = snap_proud - joint_clear
snap_z      = 6;      // height above the floor where the bump sits
snap_frac   = 0.62;   // position along the tenon (0 = root, 1 = tip)
snap_engage = 2;      // mm of full wall thickness the bump has to be pressed
                      // through at the end of insertion (the rest of the way is free)

/* [Anti-slip] */
// Transverse grooves running along the width. The default values are matched to
// the lug pattern on the robot's drive wheels (approx. 8 mm between the lugs) so
// that the lugs grip the grooves instead of spinning on a smooth surface.
grip_enable  = true;
grip_r       = 1.0;              // radius of the grooves => approx. 1 mm deep
grip_pitch   = 8;                // distance between grooves measured along x
grip_x_start = 6;                // first groove (from the tall edge)
grip_x_end   = ramp_run * 0.85;  // last groove – keep clear of the thin tip

/* [Marking] */
// Engraves the module number in the back face (the one facing the threshold).
// Only needed when height_profile is not flat – the modules are then different
// and have to be assembled in the right order.
label_enable = false;
label_size   = 12;
label_depth  = 0.6;
label_z      = 9;     // height above the floor

// Engraves the ramp dimensions (width x depth x height) in the socket end – the
// short end that is hidden inside the joint when the ramp is assembled. Module 1
// has no socket and therefore gets no text.
dim_enable = true;
dim_size   = 4;
dim_x      = 42;      // start of the text, measured from the tall edge (clear of the joint)
dim_z      = 2;       // height above the floor

/* [View] */
// "assembly"  = the whole ramp put together (preview)
// "plate"     = one module, moved to the origin for printing (see part_index)
// "all_parts" = all modules side by side
mode       = "assembly";
part_index = 0;       // used by mode = "plate" (0 .. n_modules-1)

$fn = 48;

// ---------------------------------------------------------------------------
//  Derived values + checks
// ---------------------------------------------------------------------------
module_len   = total_width / n_modules;   // center distance between the joints
print_len    = module_len + joint_depth;  // actual length of one print
n_stations   = len(height_profile);
h_max        = max([for (p = height_profile) p[1]]);
h_min        = min([for (p = height_profile) p[1]]);

lip          = lip_enable ? lip_out : 0;  // how far the profile reaches past x = 0
prof_depth   = ramp_run + lip;            // total depth of the profile

// threshold height at position y (straight line between the measuring points,
// flat outside them)
function h_seg(y, i) =
    let (a = height_profile[i], b = height_profile[i + 1])
    y <= b[0] ? a[1] + (b[1] - a[1]) * (y - a[0]) / (b[0] - a[0])
              : h_seg(y, i + 1);

function h_at(y) =
    y <= height_profile[0][0]              ? height_profile[0][1] :
    y >= height_profile[n_stations - 1][0] ? height_profile[n_stations - 1][1] :
    h_seg(y, 0);

// the height of the inclined surface at point (x, y). x <= 0 is the flat lip.
function surf_z(x, y) = h_at(y) * (1 - max(x, 0) / ramp_run);

// the text that is engraved in the short end
dim_text  = str(total_width, "x", prof_depth, "x",
                h_min == h_max ? str(h_max) : str(h_min, "-", h_max), " mm");
dim_width = len(dim_text) * dim_size * 0.65;   // rough estimate of the text width

// does the module fit on the bed in one of the two orientations?
fits_along_x = (print_len <= bed_x && prof_depth <= bed_y);
fits_along_y = (print_len <= bed_y && prof_depth <= bed_x);

echo(str("Threshold height: ", h_min, " – ", h_max, " mm"));
echo(str("Angle of the inclined plane: ", atan(h_min / ramp_run), " – ",
         atan(h_max / ramp_run), " degrees"));
echo(str("Module length (assembled): ", module_len, " mm"));
echo(str("Print size per module: ", print_len, " x ", prof_depth, " x ", h_max, " mm"));
echo(str("Lay the length direction along the ", fits_along_x ? "X" : "Y",
         " axis on the bed"));
if (side_enable)
    echo(str("Sideways ramp at the left end: ", side_run, " mm => ",
             atan(h_at(0) / side_run), " degrees"));

assert(n_modules >= 1, "n_modules must be at least 1");
assert(n_stations >= 2, "height_profile needs at least two points");
assert(height_profile[0][0] <= 0 && height_profile[n_stations - 1][0] >= total_width,
       "height_profile must cover the whole width 0 .. total_width");
assert(fits_along_x || fits_along_y,
       "The module does not fit on the build plate – increase n_modules or reduce ramp_run");
assert(h_max <= bed_z, "The ramp is too tall for the build volume");
// the lip has to fit inside the height of the profile
assert(!lip_enable || h_min - lip_tip - lip_drop >= 0,
       "The lip is taller than the profile – reduce lip_tip/lip_drop");
// the sideways ramp must not eat into the first joint
assert(!side_enable || side_run < module_len,
       "side_run is longer than the module length – increase n_modules or reduce side_run");
// the tenon has to sit where the profile is thick enough
assert(joint_x + joint_head / 2 < ramp_run * 0.8,
       "The tenon sits too far out on the thin part – reduce joint_x/joint_head");
// there has to be enough material above the bump at the thinnest part of the joint
assert(surf_z(joint_x + joint_head / 2, 0) > snap_z + snap_r + snap_engage,
       "Too little material above the snap bump – lower snap_z or move the tenon inwards");
// the dimension text has to stay inside the inclined surface
assert(!dim_enable || dim_x > joint_x + joint_head / 2 + joint_clear + 2,
       "The dimension text collides with the joint – increase dim_x");
assert(!dim_enable || dim_z + dim_size < h_min * (1 - (dim_x + dim_width) / ramp_run),
       "The dimension text sticks out of the inclined surface – reduce dim_size/dim_z or dim_x");

// ---------------------------------------------------------------------------
//  Basic shape. Everything is built in global coordinates (y = 0 at the left
//  edge), so that each module gets the right height from height_profile.
// ---------------------------------------------------------------------------

// The cross section of the ramp: right-angled triangle with the tall side at
// x = 0, plus the lip that hangs out over the threshold at x < 0.
module profile_2d(h) {
    if (lip_enable && lip_out > 0)
        polygon([[0, 0], [ramp_run, 0], [0, h],
                 [-lip_out, h], [-lip_out, h - lip_tip],
                 [0, h - lip_tip - lip_drop]]);
    else
        polygon([[0, 0], [ramp_run, 0], [0, h]]);
}

// Paper-thin slice at y, used as an end face in the loft. back = true puts the
// slice on the inside of y, so that the body ends exactly at y.
module slab(y, back = false) {
    translate([0, y + (back ? 0 : 0.002), 0]) rotate([90, 0, 0])
        linear_extrude(height = 0.002)
            profile_2d(h_at(y));
}

// Wedge body between ya and yb, split up at the measuring points so that the
// top surface becomes an exactly straight surface between each measurement.
module wedge(ya, yb) {
    ys = concat([ya],
                [for (p = height_profile) if (p[0] > ya && p[0] < yb) p[0]],
                [yb]);
    for (i = [0 : len(ys) - 2])
        hull() { slab(ys[i]); slab(ys[i + 1], back = true); }
}

// Everything above the plane that runs from the floor at y = 0 up to full
// height at y = side_run. Subtracted from the body, this turns the left end
// into a ramp in the width direction.
module side_cut() {
    if (side_enable) {
        h0   = h_at(0);
        big  = h_max + 5;
        yend = side_run * big / h0;   // where the plane leaves the body
        translate([-(lip + 1), 0, 0])
            rotate([90, 0, 90])
                linear_extrude(height = prof_depth + 2)
                    polygon([[0, 0], [yend, big], [0, big]]);   // (y, z)
    }
}

// Cross section of the tenon seen from above, placed at y. grow > 0 gives the
// socket variant.
module joint_2d(y, grow = 0) {
    translate([joint_x, y])
        offset(delta = grow)
            offset(r = joint_fillet) offset(delta = -joint_fillet)
                polygon([[-joint_neck / 2, -1], [joint_neck / 2, -1],
                         [ joint_head / 2, joint_depth],
                         [-joint_head / 2, joint_depth]]);
}

// The tenon as a 3D volume, clipped against the wedge body so that the top
// surface follows the inclined plane.
module joint_solid(y) {
    intersection() {
        wedge(y, y + joint_depth);
        linear_extrude(height = h_max + 1) joint_2d(y);
    }
}

// Center of the bump in flank s = -1 / +1, as [x, y] relative to the joint
// plane. The sphere is sunk into the flank so that only snap_proud protrudes.
function snap_ctr(s) =
    let (flare = (joint_head - joint_neck) / 2,
         len   = sqrt(joint_depth * joint_depth + flare * flare),
         nx    =  joint_depth / len,      // outer normal of the flank
         ny    = -flare / len,
         inset = snap_r - snap_proud,
         dx    = joint_neck / 2 + flare * snap_frac)
    [joint_x + s * (dx - nx * inset), snap_frac * joint_depth - ny * inset];

// The bumps on the tenon (r = snap_r) / the recesses in the socket (r slightly
// larger).
module snaps(y, r) {
    for (s = [-1, 1])
        translate([snap_ctr(s)[0], y + snap_ctr(s)[1], snap_z]) sphere(r = r);
}

// Free channel in the socket wall above the recess, so that the bump slides
// unobstructed down to the last snap_engage millimeters.
module snap_leadin(y) {
    for (s = [-1, 1])
        hull()
            for (z = [snap_z + snap_r + snap_engage, h_max + 2])
                translate([snap_ctr(s)[0], y + snap_ctr(s)[1], z])
                    sphere(r = snap_r + joint_clear);
}

// Grooves on the inclined surface. Each groove is a capsule that follows the
// inclined surface, split up at the measuring points so that it sits correctly
// also when the height changes. Overlaps the module ends slightly so that the
// grooves connect across the joint.
module grip(ya, yb) {
    y0 = ya - 2;
    y1 = yb + 2;
    ys = concat([y0],
                [for (p = height_profile) if (p[0] > y0 && p[0] < y1) p[0]],
                [y1]);
    for (x = [grip_x_start : grip_pitch : grip_x_end])
        for (i = [0 : len(ys) - 2])
            hull()
                for (y = [ys[i], ys[i + 1]])
                    translate([x, y, surf_z(x, y)]) sphere(r = grip_r, $fn = 24);
}

// Module number engraved in the back face (the one facing the threshold)
module label(idx, ya, yb) {
    // reads the right way round when looking straight at the back face (from -x)
    translate([-lip + label_depth, (ya + yb) / 2, label_z])
        rotate([90, 0, -90])
            linear_extrude(height = label_depth + 0.2)
                text(str(idx + 1), size = label_size,
                     halign = "center", valign = "center");
}

// The ramp dimensions engraved in the socket end at y. Reads the right way
// round when looking straight at the short end (from -y).
module dim_label(y) {
    translate([dim_x, y + label_depth, dim_z])
        rotate([90, 0, 0])
            linear_extrude(height = label_depth + 0.2)
                text(dim_text, size = dim_size, halign = "left", valign = "baseline");
}

// ---------------------------------------------------------------------------
//  One module. idx = 0 sits at y = 0, idx = n_modules-1 at y = total_width.
//  Built in global coordinates.
// ---------------------------------------------------------------------------
module ramp_module(idx) {
    ya = idx * module_len;
    yb = ya + module_len;
    has_tenon  = (idx < n_modules - 1);   // tenon in the end facing yb
    has_socket = (idx > 0);               // socket in the end facing ya

    difference() {
        union() {
            wedge(ya, yb);
            if (has_tenon) {
                joint_solid(yb);
                if (snap_enable)
                    intersection() {
                        snaps(yb, snap_r);
                        wedge(yb, yb + joint_depth);
                    }
            }
        }
        if (has_socket) {
            translate([0, 0, -0.5])
                linear_extrude(height = h_max + 1)
                    joint_2d(ya, grow = joint_clear);
            if (snap_enable) {
                snaps(ya, snap_r + joint_clear);   // recess
                snap_leadin(ya);                   // lead-in channel
            }
            if (dim_enable) dim_label(ya);
        }
        if (grip_enable) grip(ya, has_tenon ? yb + joint_depth : yb);
        if (label_enable) label(idx, ya, yb);
        if (idx == 0) side_cut();                  // only module 1 is tapered
    }
}

// ---------------------------------------------------------------------------
//  Views
// ---------------------------------------------------------------------------

// The finished, assembled ramp
module assembly() {
    for (i = [0 : n_modules - 1]) ramp_module(i);
}

// One module moved to the origin, ready for printing (flat bottom down, no
// support)
module plate(idx) {
    translate([0, -idx * module_len, 0]) ramp_module(idx);
}

// All modules side by side
module all_parts() {
    for (i = [0 : n_modules - 1])
        translate([i * (prof_depth + 15), -i * module_len, 0]) ramp_module(i);
}

if      (mode == "assembly")  assembly();
else if (mode == "plate")     plate(part_index);
else if (mode == "all_parts") all_parts();
else                          assembly();
