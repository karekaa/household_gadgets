// ============================================================================
//  Terskelrampe – modulbasert kilerampe for høy dørterskel
//
//  Profilen er en rettvinklet trekant: ramp_run i gulvplan, og en høyde som
//  følger den målte terskelhøyden langs døråpningen (height_profile). Toppen
//  av rampa møter derfor terskelen i riktig høyde hele veien, selv om
//  terskelen er høyere i den ene enden.
//
//  Rampa deles i n_modules moduler som klikkes sammen med svalehale-tapp og
//  snap-knotter. Alle mål i mm.
// ============================================================================

/* [Hovedmål] */
// Rampehøyden langs døråpningen: [avstand fra venstre kant, høyde].
// Like verdier => samme høyde hele veien. Skal toppen følge en terskel som
// varierer i høyde, mål for eksempel hver 100 mm og legg inn alle punktene –
// toppflaten loftes da gjennom hvert målepunkt. y = 0 er venstre ende (modul 1).
height_profile = [[0, 27], [810, 27]];

ramp_run    = 150;   // lengden på skråplanet i gulvplan (horisontal katet)
total_width = 810;   // total bredde på ferdig montert rampe

/* [Oppdeling] */
n_modules   = 7;     // antall moduler (må være >= 1)

/* [Skriverens byggevolum] */
bed_x       = 200;   // FlashForge Creator Pro 2
bed_y       = 148;
bed_z       = 150;

/* [Skjøt / klikk-kobling] */
joint_depth   = 14;   // hvor langt tappen stikker ut (langs bredden)
joint_neck    = 14;   // bredde på tappen ved rota
joint_head    = 24;   // bredde på tappen ytterst (> neck => svalehale, låser i bredderetning)
joint_x       = 22;   // senter for tappen målt fra høy kant (x = 0)
joint_clear   = 0.25; // spillerom i sokkelen (opp = løsere, ned = strammere)
joint_fillet  = 1.5;  // avrunding av tappens hjørner

/* [Snap-knotter] */
snap_enable = true;
snap_r      = 2.5;    // radius på kula som former knotten (stor = slak innkjøring)
snap_proud  = 0.6;    // hvor mye knotten stikker ut av flanken
                      // effektivt klemgrep = snap_proud - joint_clear
snap_z      = 6;      // høyde over gulvet der knotten sitter
snap_frac   = 0.62;   // plassering langs tappen (0 = rot, 1 = tupp)
snap_engage = 2;      // mm full veggtykkelse knotten må presses gjennom på
                      // slutten av innsettingen (resten av veien er fri)

/* [Sklisikring] */
// Tverriller på langs av bredden. Standardverdiene er tilpasset knottemønsteret
// på robotens drivhjul (ca. 8 mm mellom knottene) slik at knottene griper i
// rillene i stedet for å spinne på en glatt flate.
grip_enable  = true;
grip_r       = 1.0;              // radius på rillene => ca. 1 mm dype
grip_pitch   = 8;                // avstand mellom riller målt langs x
grip_x_start = 6;                // første rille (fra høy kant)
grip_x_end   = ramp_run * 0.85;  // siste rille – hold unna den tynne tuppen

/* [Merking] */
// Graverer modulnummeret i bakflaten (den som står mot terskelen). Trengs bare
// når height_profile ikke er flat – da er modulene forskjellige og må monteres
// i riktig rekkefølge.
label_enable = false;
label_size   = 12;
label_depth  = 0.6;
label_z      = 9;     // høyde over gulvet

// Graverer rampas mål (bredde x dybde x høyde) i sokkelenden – kortenden som
// er skjult inne i skjøten når rampa er montert. Modul 1 har ingen sokkel og
// får derfor ingen tekst.
dim_enable = true;
dim_size   = 4;
dim_x      = 42;      // start for teksten, målt fra høy kant (klar av skjøten)
dim_z      = 2;       // høyde over gulvet

/* [Visning] */
// "assembly"  = hele rampen satt sammen (forhåndsvisning)
// "plate"     = én modul, flyttet til origo for utskrift (se part_index)
// "all_parts" = alle moduler side ved side
mode       = "assembly";
part_index = 0;       // brukes av mode = "plate" (0 .. n_modules-1)

$fn = 48;

// ---------------------------------------------------------------------------
//  Avledede verdier + sjekker
// ---------------------------------------------------------------------------
module_len   = total_width / n_modules;   // senteravstand mellom skjøtene
print_len    = module_len + joint_depth;  // faktisk lengde på en utskrift
n_stations   = len(height_profile);
h_max        = max([for (p = height_profile) p[1]]);
h_min        = min([for (p = height_profile) p[1]]);

// terskelhøyde i posisjon y (rettlinjet mellom målepunktene, flat utenfor)
function h_seg(y, i) =
    let (a = height_profile[i], b = height_profile[i + 1])
    y <= b[0] ? a[1] + (b[1] - a[1]) * (y - a[0]) / (b[0] - a[0])
              : h_seg(y, i + 1);

function h_at(y) =
    y <= height_profile[0][0]              ? height_profile[0][1] :
    y >= height_profile[n_stations - 1][0] ? height_profile[n_stations - 1][1] :
    h_seg(y, 0);

// høyden på skråflaten i punkt (x, y)
function surf_z(x, y) = h_at(y) * (1 - x / ramp_run);

// teksten som graveres i kortenden
dim_text  = str(total_width, "x", ramp_run, "x",
                h_min == h_max ? str(h_max) : str(h_min, "-", h_max), " mm");
dim_width = len(dim_text) * dim_size * 0.65;   // grovt anslag på tekstbredden

// passer modulen på plata i en av de to orienteringene?
fits_along_x = (print_len <= bed_x && ramp_run <= bed_y);
fits_along_y = (print_len <= bed_y && ramp_run <= bed_x);

echo(str("Terskelhøyde: ", h_min, " – ", h_max, " mm"));
echo(str("Skråplanets vinkel: ", atan(h_min / ramp_run), " – ",
         atan(h_max / ramp_run), " grader"));
echo(str("Modullengde (montert): ", module_len, " mm"));
echo(str("Utskriftsmål per modul: ", print_len, " x ", ramp_run, " x ", h_max, " mm"));
echo(str("Legg lengderetningen langs ", fits_along_x ? "X" : "Y", "-aksen på plata"));

assert(n_modules >= 1, "n_modules må være minst 1");
assert(n_stations >= 2, "height_profile trenger minst to punkter");
assert(height_profile[0][0] <= 0 && height_profile[n_stations - 1][0] >= total_width,
       "height_profile må dekke hele bredden 0 .. total_width");
assert(fits_along_x || fits_along_y,
       "Modulen passer ikke på byggeplata – øk n_modules eller reduser ramp_run");
assert(h_max <= bed_z, "Rampen er for høy for byggevolumet");
// tappen må ligge der profilen er tykk nok
assert(joint_x + joint_head / 2 < ramp_run * 0.8,
       "Tappen ligger for langt ute på den tynne delen – reduser joint_x/joint_head");
// det må være kjøtt nok over knotten på den tynneste delen av skjøten
assert(surf_z(joint_x + joint_head / 2, 0) > snap_z + snap_r + snap_engage,
       "For lite materiale over snap-knotten – senk snap_z eller flytt tappen innover");
// målteksten må holde seg innenfor den skrå flaten
assert(!dim_enable || dim_x > joint_x + joint_head / 2 + joint_clear + 2,
       "Målteksten kolliderer med skjøten – øk dim_x");
assert(!dim_enable || dim_z + dim_size < h_min * (1 - (dim_x + dim_width) / ramp_run),
       "Målteksten stikker ut av skråflaten – reduser dim_size/dim_z eller dim_x");

// ---------------------------------------------------------------------------
//  Grunnform. Alt bygges i globale koordinater (y = 0 ved venstre kant), slik
//  at hver modul får riktig høyde fra height_profile.
// ---------------------------------------------------------------------------

// Papirtynn trekant-skive ved y, brukt som endeflate i loftet. back = true
// legger skiva på innsiden av y, slik at kroppen ender eksakt på y.
module slab(y, back = false) {
    translate([0, y + (back ? 0 : 0.002), 0]) rotate([90, 0, 0])
        linear_extrude(height = 0.002)
            polygon([[0, 0], [ramp_run, 0], [0, h_at(y)]]);
}

// Kilekropp mellom ya og yb, delt opp ved målepunktene slik at toppflaten
// blir en eksakt rett flate mellom hver måling.
module wedge(ya, yb) {
    ys = concat([ya],
                [for (p = height_profile) if (p[0] > ya && p[0] < yb) p[0]],
                [yb]);
    for (i = [0 : len(ys) - 2])
        hull() { slab(ys[i]); slab(ys[i + 1], back = true); }
}

// Tappens tverrsnitt sett ovenfra, plassert ved y. grow > 0 gir sokkelvarianten.
module joint_2d(y, grow = 0) {
    translate([joint_x, y])
        offset(delta = grow)
            offset(r = joint_fillet) offset(delta = -joint_fillet)
                polygon([[-joint_neck / 2, -1], [joint_neck / 2, -1],
                         [ joint_head / 2, joint_depth],
                         [-joint_head / 2, joint_depth]]);
}

// Tappen som 3D-volum, klippet mot kilekroppen slik at toppflaten følger
// skråplanet.
module joint_solid(y) {
    intersection() {
        wedge(y, y + joint_depth);
        linear_extrude(height = h_max + 1) joint_2d(y);
    }
}

// Senter for knotten i flanken s = -1 / +1, som [x, y] relativt skjøtplanet.
// Kula senkes ned i flanken slik at bare snap_proud stikker ut.
function snap_ctr(s) =
    let (flare = (joint_head - joint_neck) / 2,
         len   = sqrt(joint_depth * joint_depth + flare * flare),
         nx    =  joint_depth / len,      // flankens ytre normal
         ny    = -flare / len,
         inset = snap_r - snap_proud,
         dx    = joint_neck / 2 + flare * snap_frac)
    [joint_x + s * (dx - nx * inset), snap_frac * joint_depth - ny * inset];

// Knottene på tappen (r = snap_r) / fordypningene i sokkelen (r litt større).
module snaps(y, r) {
    for (s = [-1, 1])
        translate([snap_ctr(s)[0], y + snap_ctr(s)[1], snap_z]) sphere(r = r);
}

// Fri kanal i sokkelveggen over fordypningen, slik at knotten glir uhindret
// ned til de siste snap_engage millimeterne.
module snap_leadin(y) {
    for (s = [-1, 1])
        hull()
            for (z = [snap_z + snap_r + snap_engage, h_max + 2])
                translate([snap_ctr(s)[0], y + snap_ctr(s)[1], z])
                    sphere(r = snap_r + joint_clear);
}

// Riller på skråflaten. Hver rille er en kapsel som følger den skrå flaten,
// delt opp ved målepunktene slik at den ligger riktig også når høyden endrer
// seg. Overlapper modulendene litt slik at rillene henger sammen over skjøten.
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

// Modulnummer gravert i bakflaten (den mot terskelen)
module label(idx, ya, yb) {
    // leses riktig vei når man ser rett på bakflaten (fra -x)
    translate([label_depth, (ya + yb) / 2, label_z])
        rotate([90, 0, -90])
            linear_extrude(height = label_depth + 0.2)
                text(str(idx + 1), size = label_size,
                     halign = "center", valign = "center");
}

// Rampas mål gravert i sokkelenden ved y. Leses riktig vei når man ser rett på
// kortenden (fra -y).
module dim_label(y) {
    translate([dim_x, y + label_depth, dim_z])
        rotate([90, 0, 0])
            linear_extrude(height = label_depth + 0.2)
                text(dim_text, size = dim_size, halign = "left", valign = "baseline");
}

// ---------------------------------------------------------------------------
//  Én modul. idx = 0 ligger ved y = 0, idx = n_modules-1 ved y = total_width.
//  Bygges i globale koordinater.
// ---------------------------------------------------------------------------
module ramp_module(idx) {
    ya = idx * module_len;
    yb = ya + module_len;
    has_tenon  = (idx < n_modules - 1);   // tapp i enden mot yb
    has_socket = (idx > 0);               // sokkel i enden mot ya

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
                snaps(ya, snap_r + joint_clear);   // fordypning
                snap_leadin(ya);                   // innkjøringskanal
            }
            if (dim_enable) dim_label(ya);
        }
        if (grip_enable) grip(ya, has_tenon ? yb + joint_depth : yb);
        if (label_enable) label(idx, ya, yb);
    }
}

// ---------------------------------------------------------------------------
//  Visninger
// ---------------------------------------------------------------------------

// Ferdig montert rampe
module assembly() {
    for (i = [0 : n_modules - 1]) ramp_module(i);
}

// Én modul flyttet til origo, klar for utskrift (flat bunn ned, ingen support)
module plate(idx) {
    translate([0, -idx * module_len, 0]) ramp_module(idx);
}

// Alle moduler side ved side
module all_parts() {
    for (i = [0 : n_modules - 1])
        translate([i * (ramp_run + 15), -i * module_len, 0]) ramp_module(i);
}

if      (mode == "assembly")  assembly();
else if (mode == "plate")     plate(part_index);
else if (mode == "all_parts") all_parts();
else                          assembly();
