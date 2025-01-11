size(4cm);

real phi = 49;
real delta = 15;
pair e = (0, 0);
pair c = (Cos(phi), 0);
real x = Sin(phi)*Tan(delta);
real y = sqrt(Cos(phi)^2 - x^2);
pair d = (-x, 0);
pair f = (-x, y);
pair g = (-x, -y);

draw(scale(Cos(phi)) * unitcircle);
fill(f -- g .. -c .. cycle, grey);
dot(c^^d^^e^^f);
draw(d--e--c);
draw(e--f);

label("$c$", c, E);
label("$d$", d, W);
label("$e$", e, NE);
label("$f$", f, N);
