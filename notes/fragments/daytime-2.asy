import three;

triple circlePoint(real deg){
	return (-Cos(deg), -Sin(deg), 0);
}

size(10cm);
currentlight = light(dir(1,2));
currentprojection = perspective(-2, 2, 1.5);

int r = 8;
int increment = 45;

/* Earth */
material mEarth = material(RGB(102,153,255)+opacity(0.6), RGB(0,20,150)+opacity(0.6));
draw(unitsphere, mEarth);
draw((0.8,0,-1.6) -- (-0.8,0,1.6));  //axis
draw(circle(c=O, r=1, normal=(-0.43,0,1)), brown);  //equator
draw(circle(c=O, r=1, normal=(0,0,1)), orange);  //ecliptic intersects earth's surface

/* Sun and ecliptic */
material mSun = material(RGB(255,204,0), RGB(230,120,0));
draw(arc(c=O, r*circlePoint(-30), r*circlePoint(120), normal=Z), RGB(180,180,180)+linewidth(1));
for(int i=0; i<3; ++i){
	triple centre = r*circlePoint(i*increment);
	draw(shift(centre) * scale3(2) * unitsphere, mSun);

	triple p = circlePoint(i*increment);
	draw(centre--p, orange, Arrow3(Relative(0.7)));
	dot(p, linewidth(2)+orange);
	label("$p$", p, p+0.7*Z);
}
