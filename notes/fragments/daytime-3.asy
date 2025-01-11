size(7cm);

real d = 0.7;
real delta0 = 23.43;
real deltat = aSin(d * Sin(delta0));
pair normal = (Sin(delta0), Cos(delta0));
pair o = (0, 0);
pair p0 = (1, 0);
pair q = (Cos(delta0), -Sin(delta0));
pair pt = (d, 0);
pair a = (-Cos(delta0+deltat), Sin(delta0+deltat));
pair b = (Cos(delta0-deltat), -Sin(delta0-deltat));

draw(unitcircle);  //earth
draw(-1.2*normal -- 1.2*normal, dashed);  //axis
draw(-q -- q, brown);  //equator
draw(-p0 -- p0, orange);
draw(a--b);
draw(o--b);
dot(o, linewidth(2));
dot(p0, linewidth(2));
dot(pt, linewidth(2));
dot(a, linewidth(2));
dot(b, linewidth(2));
label("$o$", o, NW);
label("$p(0)$", p0, NE);
label("$p(t)$", pt, N);
label("$a$", a, W);
label("$b$", b, E);

draw(arc((0,0), 0.2*q, 0.2*p0), orange);
label("$\delta(0)$", (0.4, -0.07), orange+fontsize(10));
draw(arc((0,0), 0.6*q, 0.6*b), purple);
label("$\delta(t)$", (0.7, -0.18), purple+fontsize(10));
