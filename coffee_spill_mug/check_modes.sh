#!/bin/bash
# Check every mode x base combination of coffee_spill_mug.scad.
#
# There are two levels, because they answer different questions and differ in cost
# by a factor of several thousand:
#
#   ./check_modes.sh          fast - parameters and asserts only, ~0.2 s
#   ./check_modes.sh --full   slow - full CGAL geometry, ~2 min
#
# The fast level exports to .echo instead of .stl. OpenSCAD then evaluates the whole
# parameter set and the whole CSG tree, so every assert() and every echo() fires and
# every bad parameter is caught, but it never hands the tree to CGAL - which is where
# essentially all the time goes. That catches the mistakes actually worth catching on
# every edit: an assert that now trips, a variable used before it is declared, a mode
# name that fell out of the dispatch.
#
# GOTCHA: with -o something.echo, OpenSCAD writes its errors INTO the .echo file and
# still exits 0. So the exit code says nothing and the file has to be grepped.
#
# The full level is what to run before committing STLs. It is parallel across all
# cores, so the wall clock is the slowest single combination rather than the sum:
# base="round" costs about 60 s more than base="box" in every mode, because the rear
# arc is two rotate_extrude() calls at base_fn = 240 facets, and "two_tone" builds
# both halves of the label so it pays the text CSG twice. Measured on 16 cores: 20 min
# 47 s of CPU, 2 min 46 s of wall clock - i.e. the whole sweep costs about what its
# slowest single combination, round/two_tone at 120 s, costs on its own.
#
# For a quick look at the round base while iterating, -D base_fn=48 cuts a round
# render from 74 s to 22 s. Never export an STL that way - 48 facets leaves visible
# flat spots on an R 87 mm arc. See the base_fn comment in the .scad.

set -u
cd "$(dirname "$0")"

MODES=(use check print print_body print_white print_text two_tone text_measure
       gauge gauge_rear gauge_label gauge_text clip cavity)
BASES=(box round)

full=0
[ "${1:-}" = "--full" ] && full=1

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

for b in "${BASES[@]}"; do
    for m in "${MODES[@]}"; do
        echo "$b $m"
    done
done > "$tmp/jobs"

n=$(wc -l < "$tmp/jobs")

if [ "$full" = 0 ]; then
    ext=echo
    echo "checking $n combinations - parameters and asserts only"
else
    ext=stl
    echo "checking $n combinations - full geometry, this takes a couple of minutes"
fi

# two_tone and check are preview only: they use color() and %, which CGAL discards,
# so an .stl export of them is still a valid geometry check but not a valid file.
xargs -P "$(nproc)" -n2 sh -c \
    'openscad -o "'"$tmp"'/$0.$1.'"$ext"'" -D "base=\"$0\"" -D "mode=\"$1\"" \
        coffee_spill_mug.scad > "'"$tmp"'/$0.$1.out" 2>&1' \
    < "$tmp/jobs"

fail=0
for b in "${BASES[@]}"; do
    for m in "${MODES[@]}"; do
        hits=$(grep -h 'ERROR\|WARNING' "$tmp/$b.$m.$ext" "$tmp/$b.$m.out" 2>/dev/null)
        if [ -n "$hits" ]; then
            fail=1
            echo "FAIL base=$b mode=$m"
            echo "$hits" | head -3 | sed 's/^/    /'
        fi
    done
done

if [ "$fail" = 0 ]; then
    echo "all $n combinations clean"
else
    echo "$n combinations checked, failures above"
fi
exit "$fail"
