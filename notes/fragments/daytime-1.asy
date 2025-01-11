import three;

triple circlePoint(real deg){
	return (Cos(deg), Sin(deg), 0);
}

size(10cm);
currentlight = light(dir(1,2));
currentprojection = perspective(-1, 2, 1);

/* Sun and ecliptic */
int r = 8;
draw(arc(c=O, r*circlePoint(-20), r*circlePoint(120), normal=Z), RGB(180,180,180)+linewidth(1));
draw(scale3(2) * unitsphere, material(RGB(255,204,0), RGB(230,120,0)));

/* Earth */
material mEarth = material(RGB(102,153,255)+opacity(0.6), RGB(0,20,150)+opacity(0.6));
int increment = 45;
for(int i=0; i<3; ++i){
	triple centre = r*circlePoint(i*increment);
	draw(shift(centre)*unitsphere, mEarth);
	draw(centre-0.8*X+1.6*Z -- centre+0.8*X-1.6*Z);  //axis
	draw(circle(c=centre, r=1, normal=(-0.43,0,1)), brown);  //equator
	draw(circle(c=centre, r=1, normal=(0,0,1)), orange);  //ecliptic intersects earth's surface

	triple p = centre - circlePoint(i*increment);
	draw(O--p, orange, Arrow3(Relative(0.7)));
	dot(p, linewidth(2)+orange);
}
