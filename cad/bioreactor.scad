// Lab-grade bioreactor: top-level assembly.

use <iso4796-bottle-scad/iso4796.scad>
use <din168-thread-scad/din168.scad>

// Draw the DIN 168 thread on the bottle neck; off is a plain envelope and renders faster.
bottle_thread = true;

// The vessel: a Boro 3.3 5000 mL bottle with a GL80 neck. ISO 4796-1 and the library's DURAN
// row carry GL45 at 5 L, so this is the ISO 5 L body with a GL80 finish swapped in.
// [GL name, thread d, core d1, pitch, bore]; d, d1 and P are DIN 168-1's GL80.
// CHOICE: the 68 mm bore is a placeholder until a real bottle is measured.
gl80_finish = ["GL80", 80, 77, 5, 68];
iso_5000 = iso4796_by_capacity(5000);
vessel = [
  "Boro 3.3 5000 mL GL80", 5000, iso4796_height(iso_5000), iso4796_shoulder_height(iso_5000),
  iso4796_diameter(iso_5000), iso4796_wall(iso_5000), iso4796_neck_diameter_min(iso_5000),
  gl80_finish,
];

// The lid: a GL80 screw cap, seated so the inside of its top sits on the rim.
lid_gl = din168_by_name("GL80");
lid_thread_length = 12;
lid_liner_space = 2;

color("lightblue", 0.4) iso4796_bottle(vessel, thread=bottle_thread);

color("dimgray")
  translate([0, 0, iso4796_height(vessel) - lid_thread_length - lid_liner_space])
    din168_cap(lid_gl, thread_length=lid_thread_length, liner_space=lid_liner_space, ribs=48);
