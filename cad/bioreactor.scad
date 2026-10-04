// Lab-grade bioreactor: top-level assembly.

use <iso4796-bottle-scad/iso4796.scad>
use <din168-thread-scad/din168.scad>

// Draw the thread on the bottle neck; off is a plain envelope and renders faster.
bottle_thread = true;

// The vessel: a Boro 3.3 5000 mL bottle with a GLS 80 neck, DURAN's three-start wide-mouth thread,
// not DIN 168 GL80. ISO 4796-1 and the library's DURAN row carry GL45 at 5 L, so this is the ISO
// 5 L body with a GLS 80 finish swapped in. [name, thread d, core d1, pitch, bore]; d, d1 and P are
// GL80's, which din168-thread-scad uses for GLS 80. CHOICE: the 68 mm bore is a placeholder until
// a real bottle is measured.
gls80_finish = ["GLS80", 80, 77, 5, 68];
iso_5000 = iso4796_by_capacity(5000);
vessel = [
  "Boro 3.3 5000 mL GLS 80", 5000, iso4796_height(iso_5000), iso4796_shoulder_height(iso_5000),
  iso4796_diameter(iso_5000), iso4796_wall(iso_5000), iso4796_neck_diameter_min(iso_5000),
  gls80_finish,
];

// The lid: a GLS 80 screw cap, seated so the inside of its top sits on the rim.
lid_gl = din168_by_name("GLS80");

color("lightblue", 0.4) iso4796_bottle(vessel, thread=bottle_thread);

color("dimgray")
  translate([0, 0, iso4796_height(vessel)])
    din168_cap(lid_gl, ribs=48);
