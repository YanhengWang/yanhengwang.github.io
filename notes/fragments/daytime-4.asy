size(8cm);

real delta = 15;
real phi = 49;
pair normal = (Sin(delta), Cos(delta));
pair o = (0, 0);
pair p = (1, 0);
pair q = (Cos(delta), -Sin(delta));
pair c = (Cos(phi-delta), Sin(phi-delta));
pair cMirror = (-Cos(phi+delta), Sin(phi+delta));

draw(unitcircle);  //earth
draw((2,0)--(1,0), arrow=Arrow(Relative(0.5)), orange);  //sunlight
draw((2,1)--(0,1), arrow=Arrow(Relative(0.5)), orange);
draw((2,-1)--(0,-1), arrow=Arrow(Relative(0.5)), orange);
fill((-1,0)..(0,-1)--(0,1)..cycle, grey);  //shade
draw(-1.2*normal -- 1.2*normal, dashed);  //axis
draw(rotate(-delta) * ellipse((0,0), 1, 0.1), brown+linetype("2 3"));  //equator
draw(-q -- q, brown);
dot(o, linewidth(2));
dot(p, linewidth(2));
dot(c, linewidth(2));
dot(cMirror, linewidth(2));
label("$o$", o, NW);
label("$p(t)$", p, NE);
label("$c$", c, E);

draw(o--p, orange);
draw(o--c);
draw(arc(o, 0.3*q, 0.3*p), orange);
draw(arc(o, 0.2*q, 0.2*c), brown);
label("$\delta(t)$", (0.4, -0.06), orange+fontsize(8));
label("$\phi$", (0.3, 0.1), brown);

path cc = c--cMirror;
draw(cc);

pair d = point(cc, intersect(cc, (0,0)--(0,1))[0]);
pair e = point(cc, intersect(cc, (0,0)--normal)[0]);
dot(d, linewidth(2));
dot(e, linewidth(2));
label("$d$", d, SW);
label("$e$", e, SW);
