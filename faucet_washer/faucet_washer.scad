// File:        household_gadgets/faucet_washer/faucet_washer.scad
//
// Function:    Flat solid washer for a faucet, 56 mm across with a 30 mm hole.
//
// Usage:       openscad -o stl/faucet_washer.stl faucet_washer.scad
//
// Author:      Kjell Arne Rekaa, 2026-11-03
///////////////////////////////////////////////////////////////////////////////

washer_height        = 5;
outer_diameter       = 69;
hole_diameter        = 31;
cut_through_overlap  = 1;

$fn = 180;

difference() {
    cylinder(h = washer_height, d = outer_diameter);
    translate([0, 0, -cut_through_overlap])
        cylinder(h = washer_height + 2 * cut_through_overlap, d = hole_diameter);
}
