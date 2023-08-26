/*
 * main.cc 
 */

// C/C++
#include <iostream>
#include <algorithm>
#include <string>
#include <cassert>
#include <cmath>
#include <vector>

// VgaDemo
#include <canvas.h>
#include <platform.h>
#include <vga_controller.h>

#include <koala.h>
#include <penguins.h>
#include <tulips.h>
#include <chrysant.h>
#include <desert.h>

std::string wait_key;

void Wait(const unsigned int blanks) {
	for (int i = 0; i < blanks; ++i)
		VgaController::WaitAfterVBlank();
} // func

class ThreeD {
public:

	typedef void (*callback_t)();
	callback_t callback;

	ThreeD();
	void run();	

private:

	enum {
		CANVAS_WIDTH = 368,
		CANVAS_HEIGHT = 340
	};
	
	void f0();
	void f1(const int x, const int y, const int z, int &bx, int &by);
	
	int vx;
	int vy;
	int vz;
	int ob;
	int g;
	float ar, br, gr;
	float ca, cb, cc;
	float sa, sb, sc;
	
	enum {
		EP = 53, // aantal hoekpunten
		AD = 22  // aantal data-punten voor de lijnen
	};
	
	struct Hoekpunt {
		int x, y, z;
	};
	
	struct Lijn {
		int aantal_punten;
		int * punten;
	};
	
	static Hoekpunt hoekpunten[EP];
	static Lijn lijnen[AD];

	const float mR;
	float		mAlpha;
	float		mBeta;
	float		mGamma;
	Canvas 		mCanvas0;
	Canvas 		mCanvas1;
	bool   		mToggle;
	
}; // class

ThreeD::ThreeD()
	: mCanvas0( CANVAS_WIDTH, CANVAS_HEIGHT ),
	  mCanvas1( CANVAS_WIDTH, CANVAS_HEIGHT ),
	  mR(57.29578),
	  mAlpha(0.0),
	  mBeta(0.0),
	  mGamma(0.0),
	  mToggle(false),
	  callback(NULL)
{
	mCanvas0.Clear(0x8000);
	mCanvas1.Clear(0x8000);
	mCanvas0.SetPenColour(0x7FFF);
	mCanvas1.SetPenColour(0x7FFF);

	VgaController::Canvas1::Address(mCanvas1.Buffer());
	VgaController::Canvas1::Width(mCanvas1.Width());
	VgaController::Canvas1::Height(mCanvas1.Height());
	
	VgaController::ViewPort1::Width( mCanvas1.Width() );
	VgaController::ViewPort1::Height( mCanvas1.Height() );
	VgaController::ViewPort1::Alpha(0x1F);
	VgaController::ViewPort1::ScreenX( (640 - CANVAS_WIDTH) / 2 );
	VgaController::ViewPort1::ScreenY( (480 - CANVAS_HEIGHT) / 2 );
	VgaController::ViewPort1::Enable();
	
	vx = 1;
	vy = 350;
	vz = 1;
	ob = 7;
	g = 100;
} // func

void ThreeD::run() {
	mAlpha = 90.0;
	mBeta = 180.0;
	mGamma = 0.0;
	for (int c = 0; c < 360; c += 2) {
		mAlpha += 2.0;
		mBeta += 2.0;
		mGamma -= 2.0;
		f0();		
		int x[EP];
		int y[EP];
		for (int i = 0; i < EP; ++i) {
			f1(hoekpunten[i].x, hoekpunten[i].y, hoekpunten[i].z, x[i], y[i]);
		} // for
		for (int i = 0; i < AD; ++i) {
			for (int j = 0; j < lijnen[i].aantal_punten - 1; ++j) {
				int p1 = x[ lijnen[i].punten[j] - 1 ];
				int p2 = y[ lijnen[i].punten[j] - 1 ];
				int p3 = x[ lijnen[i].punten[j+1] - 1 ];
				int p4 = y[ lijnen[i].punten[j+1] - 1 ];
				if (mToggle) {
					mCanvas1.FastDrawLine(p1, p2, p3, p4);
				} // if
				else {
					mCanvas0.FastDrawLine(p1, p2, p3, p4);
				} // else
			} // for			
		} // for
		if (callback) callback();
		
		if (mToggle) {
			VgaController::Canvas1::Address(mCanvas1.Buffer());
			VgaController::WaitAfterVBlank();
			mCanvas0.Clear(0x8000);
		} // if
		else {
			VgaController::Canvas1::Address(mCanvas0.Buffer());
			VgaController::WaitAfterVBlank();
			mCanvas1.Clear(0x8000);
		} // else
		mToggle = !mToggle;
	} // for
} // func

void ThreeD::f0() {
	ar = mAlpha / mR;
	br = mBeta / mR;
	gr = mGamma / mR;
	ca = cos(ar);
	cb = cos(br);
	cc = cos(gr);
	sa = sin(ar);
	sb = sin(br);
	sc = sin(gr);
} // func

void ThreeD::f1(const int x, const int y, const int z, int &bx, int &by) {
	float x1, x2, x3, x4, y1, y2, y3, y4, z1, z2, z3, z4;
	x1 = x;  y1 = ca * y - sa * z;  z1 = sa * y + ca * z;
	x2 = cb * x1 - sb * z1;  y2 = y1;  z2 = sb * x1 + cb * z1;
	x3 = cc * x2 - sc * y2;  y3 = sc * x2 + cc * y2;  z3 = z2;
	x4 = x3 + vx;  y4 = y3 + vy;  z4 = z3 + vz;
	
	float u = -x4 / y4 * g;
	float v = -z4 / y4 * g;
	
	bx = (int)( (CANVAS_WIDTH/2) + float(ob) * u);
	by = (int)( (CANVAS_HEIGHT/2) - float(ob) * v);
} // func

ThreeD::Hoekpunt ThreeD::hoekpunten[] = {
	{-65, -40, 17}, {-65, 40, 17}, {65, 40, 17}, {65, -40, 17}, {-60, -35, 17},
	{-60, 35, 17}, {60, 35, 17}, {60, -35, 17}, {-65, -40, -17}, {-65, 40, -17},
	{65, 40, -17}, {65, -40, -17}, {-60, -35, -17}, {-60, 35, -17}, {60, 35, -17},
	{60, -35, -17}, {-50, 10, 7}, {-50, 20, 7}, {-45, 25, 7}, {-20, 25, 7},
	{-15, 20, 7}, {-15, 5, 7}, {-20, 0, 7}, {-15, -5, 7}, {-15, -20, 7}, {-20, -25, 7},
	{-45, -25, 7}, {-50, -20, 7}, {-50, -10, 7}, {-35, -10, 7}, {-35, -15, 7},
	{-30, -15, 7}, {-30, -5, 7}, {-42, -5, 7}, {-42, 5, 7}, {-30, 5, 7}, {-30, 15, 7},
	{-35, 15, 7}, {-35, 10, 7}, {-10, -5, 7}, {-10, 5, 7}, {10, 5, 7}, {10, -5, 7},
	{15, -25, 7}, {15, 25, 7}, {45, 25, 7}, {50, 20, 7}, {50, -20, 7}, {45, -25, 7},
	{30, -15, 7}, {30, 15, 7}, {35, 15, 7}, {35, -15, 7}
};

int l0[5] = {1, 2, 3, 4, 1};
int l1[5] = {5, 6, 7, 8, 5};
int l2[5] = {9, 10, 11, 12, 9};
int l3[5] = {13, 14, 15, 16, 13};
int l4[2] = {9, 1};
int l5[2] = {13, 5};
int l6[2] = {14, 6};
int l7[2] = {10, 2};
int l8[2] = {11, 3};
int l9[2] = {15, 7};
int l10[2] = {16, 8};
int l11[2] = {12, 4};
int l12[5] = {17, 18, 19, 20, 21};
int l13[5] = {21, 22, 23, 24, 25};
int l14[5] = {25, 26, 27, 28, 29};
int l15[5] = {29, 30, 31, 32, 33};
int l16[5] = {33, 34, 35, 36, 37};
int l17[4] = {37, 38, 39, 17};
int l18[5] = {40, 41, 42, 43, 40};
int l19[5] = {44, 45, 46, 47, 48};
int l20[3] = {48, 49, 44};
int l21[5] = {50, 51, 52, 53, 50};

ThreeD::Lijn ThreeD::lijnen[ThreeD::AD] = {
	{5, l0},
	{5, l1},
	{5, l2},
	{5, l3},
	{2, l4},
	{2, l5},
	{2, l6},
	{2, l7},
	{2, l8},
	{2, l9},
	{2, l10},
	{2, l11},
	{5, l12},
	{5, l13},
	{5, l14},
	{5, l15},
	{5, l16},
	{4, l17},
	{5, l18},
	{5, l19},
	{3, l20},
	{5, l21}
};

void sinewave() {
	static float rx = 0.0;
	static float ry = 0.0;
	static float ra = 40.0;
	static int baseX = 320 - VgaController::ViewPort1::Width() / 2;
	static int baseY = 240 - VgaController::ViewPort1::Height() / 2;
	VgaController::ViewPort1::ScreenX(baseX + int(ra * sin(rx)));
	VgaController::ViewPort1::ScreenY(baseY + int(ra * sin(ry)));
	rx += 0.055;
	ry += 0.110;
} // func

static unsigned short copper_anim[300 * 512] __attribute__((aligned(128)));

void create_copper_anim() {
	std::vector<VgaController::CopperPage*> pages;

	for (int i = 0; i < 240; ++i) {
		pages.push_back(new VgaController::CopperPage(&copper_anim[i * 512]));
	} // for
	
	enum {
		BAR_HEIGHT = 8
	};
	unsigned short background[512];

	//* render background stripes
	{
		int colour = 0x0000;
		bool up = true;
		int c = 0;
		unsigned short value = 0x0420;
		for (int i = 0; i < 480; ++i) {
			background[i] = colour;
			if (up) {
				colour += value;
				if ((c == 0 and colour == 0x6300) or
				    (c == 1 and colour == 0x0210)) up = false;
			} else {
				colour -= value;
				if (colour == 0) {
					if (c == 0) {
						c = 1;
						value = 0x0021;
					} else {
						c = 0;
						value = 0x0420;
					} // if
					up = true;
				} // if
			} // if
		} // for
		for (int i = 480; i < 510; ++i) background[i] = 0xFFFF;
	} // block

	//* set link address
	background[510] = 0x0000;
	background[511] = 0x0000;
	
	//* copy background over all copper pages and scroll meanwhile
	int z = 0;
	for (int i = 0; i < 240; ++i) {
		memcpy( &copper_anim[i * 512 +   z], &background[  0], 960 - z * 2);
		memcpy( &copper_anim[i * 512 +   0], &background[480-z], z * 2 );
		memcpy( &copper_anim[i * 512 + 480], &background[480],  64 );
		z += 1;
		z %= 480;
	} // for

	//* link pages in loop
	for (int i = 0; i < 240 - 1; ++i) {
		pages[i]->Next( pages[i+1] );
	} // for
	pages[239]->Next( pages[0] );
	
	//* render rolling bars
	float rg = 0.30;
	float gg = 0.24;
	float bg = 0.18;
	float yg = 0.12;
	float cg = 0.06;
	float mg = 0.00;

	const float p0 = (480.0 / 2.0) - (float(BAR_HEIGHT) / 2.0);

	VgaController::CopperEffect effect = VgaController::COPPER_LINE;
	float increase = (2.0 * 3.141592653589793238462642795) / 240.0;
	
	for (int p = 0; p < 240; ++p) {
		VgaController::CopperPage &page = *pages[p];
	
		rg += increase;
		gg += increase;
		bg += increase;
		yg += increase;
		cg += increase;
		mg += increase;

		float p1 = p0 + p0 * sin(rg);
		float p2 = p0 + p0 * sin(gg);
		float p3 = p0 + p0 * sin(bg);
		float p4 = p0 + p0 * sin(yg);
		float p5 = p0 + p0 * sin(cg);
		float p6 = p0 + p0 * sin(mg);
		
		int red_bar_pos = int(p1);
		int green_bar_pos = int(p2);
		int blue_bar_pos = int(p3);
		int yellow_bar_pos = int(p4);
		int cyan_bar_pos = int(p5);
		int magenta_bar_pos = int(p6);
		
		// swap effects	
		if (effect == VgaController::COPPER_LINE and red_bar_pos <= 40)
			effect = VgaController::COPPER_TOPFRONT;
		else if (effect == VgaController::COPPER_TOPFRONT and red_bar_pos >= 440)
			effect = VgaController::COPPER_LINE;

		if (effect == VgaController::COPPER_LINE) goto LR;

		// do magenta bar
LM:		page[magenta_bar_pos + 0].Set(effect, 0x5EF7);
		page[magenta_bar_pos + 1].Set(effect, 0x3C0F);
		page[magenta_bar_pos + 2].Set(effect, 0x5C17);
		page[magenta_bar_pos + 3].Set(effect, 0x7C1F);
		page[magenta_bar_pos + 4].Set(effect, 0x7C1F);
		page[magenta_bar_pos + 5].Set(effect, 0x5C17);
		page[magenta_bar_pos + 6].Set(effect, 0x3C0F);
		page[magenta_bar_pos + 7].Set(effect, 0x5EF7);
		if (effect == VgaController::COPPER_LINE)
			goto END;
			
		// do cyan bar
LC:		page[cyan_bar_pos + 0].Set(effect, 0x5EF7);
		page[cyan_bar_pos + 1].Set(effect, 0x01EF);
		page[cyan_bar_pos + 2].Set(effect, 0x02F7);
		page[cyan_bar_pos + 3].Set(effect, 0x03FF);
		page[cyan_bar_pos + 4].Set(effect, 0x03FF);
		page[cyan_bar_pos + 5].Set(effect, 0x02F7);
		page[cyan_bar_pos + 6].Set(effect, 0x01EF);
		page[cyan_bar_pos + 7].Set(effect, 0x5EF7);
		if (effect == VgaController::COPPER_LINE)
			goto LM;
		
		// do yellow bar
LY:		page[yellow_bar_pos + 0].Set(effect, 0x5EF7);
		page[yellow_bar_pos + 1].Set(effect, 0x3DE0);
		page[yellow_bar_pos + 2].Set(effect, 0x5EE0);
		page[yellow_bar_pos + 3].Set(effect, 0x7FE0);
		page[yellow_bar_pos + 4].Set(effect, 0x7FE0);
		page[yellow_bar_pos + 5].Set(effect, 0x5EE0);
		page[yellow_bar_pos + 6].Set(effect, 0x3DE0);
		page[yellow_bar_pos + 7].Set(effect, 0x5EF7);
		if (effect == VgaController::COPPER_LINE)
			goto LC;

		// do blue bar
LB:		page[blue_bar_pos + 0].Set(effect, 0x5EF7);
		page[blue_bar_pos + 1].Set(effect, 0x000F);
		page[blue_bar_pos + 2].Set(effect, 0x0017);
		page[blue_bar_pos + 3].Set(effect, 0x001F);
		page[blue_bar_pos + 4].Set(effect, 0x001F);
		page[blue_bar_pos + 5].Set(effect, 0x0017);
		page[blue_bar_pos + 6].Set(effect, 0x000F);
		page[blue_bar_pos + 7].Set(effect, 0x5EF7);
		if (effect == VgaController::COPPER_LINE)
			goto LY;
		
		// do green bar
LG:		page[green_bar_pos + 0].Set(effect, 0x5EF7);
		page[green_bar_pos + 1].Set(effect, 0x01E0);
		page[green_bar_pos + 2].Set(effect, 0x02E0);
		page[green_bar_pos + 3].Set(effect, 0x03E0);
		page[green_bar_pos + 4].Set(effect, 0x03E0);
		page[green_bar_pos + 5].Set(effect, 0x02E0);
		page[green_bar_pos + 6].Set(effect, 0x01E0);
		page[green_bar_pos + 7].Set(effect, 0x5EF7);
		if (effect == VgaController::COPPER_LINE)
			goto LB;
		
		// do red bar
LR:		page[red_bar_pos + 0].Set(effect, 0x5EF7);
		page[red_bar_pos + 1].Set(effect, 0x3C00);
		page[red_bar_pos + 2].Set(effect, 0x5C00);
		page[red_bar_pos + 3].Set(effect, 0x7C00);
		page[red_bar_pos + 4].Set(effect, 0x7C00);
		page[red_bar_pos + 5].Set(effect, 0x5C00);
		page[red_bar_pos + 6].Set(effect, 0x3C00);
		page[red_bar_pos + 7].Set(effect, 0x5EF7);
		if (effect == VgaController::COPPER_LINE)
			goto LG;

END:	continue;
	} // for

	//* delete pages
	for (int i = 0; i < 240; ++i) {
		delete pages[i];
	} // for
	
} // func

/**
 * main
 */

int main()
{
    init_platform();

	std::cout << "Running..." << std::endl;

	VgaController::BackGround::Colour(0x2222);
	VgaController::EnableScreen();
	
	std::cin >> wait_key;

	Canvas canvas0( 640, 480 );
	canvas0.Clear(0x8000);
	VgaController::EnableTransactional();

	VgaController::Canvas0::Address( canvas0.Buffer() );
	VgaController::Canvas0::Width( canvas0.Width() );
	VgaController::Canvas0::Height( canvas0.Height() );

	VgaController::ViewPort0::Width( canvas0.Width() );
	VgaController::ViewPort0::Height( canvas0.Height() );
	VgaController::ViewPort0::ScreenX( 0 );
	VgaController::ViewPort0::ScreenY( 0 );
	VgaController::ViewPort0::CanvasX( 0 );
	VgaController::ViewPort0::CanvasY( 0 );
	VgaController::ViewPort0::Enable();

	VgaController::Canvas1::Address( canvas0.Buffer() );
	VgaController::Canvas1::Width( canvas0.Width() );
	VgaController::Canvas1::Height( canvas0.Height() );

	VgaController::ViewPort1::Width( canvas0.Width() );
	VgaController::ViewPort1::Height( canvas0.Height() );
	VgaController::ViewPort1::ScreenX( 0 );
	VgaController::ViewPort1::ScreenY( 0 );
	VgaController::ViewPort1::CanvasX( 0 );
	VgaController::ViewPort1::CanvasY( 0 );
	VgaController::ViewPort1::Alpha(0x1F);

	VgaController::DisableTransactional();
	
	// draw artistic
	{
		unsigned short cb = 0x001F;	
		unsigned short cr = 0x0000;
		for (int y = 0; y < canvas0.Height(); y++) {
			if (y != 0 && y % 15 == 0) { --cb; cr += 0x20; }
			canvas0.SetPenColour( cb );
			canvas0.FastDrawLine( 0, 0, 639, y );
			canvas0.SetPenColour( cr );
			canvas0.FastDrawLine( 0, y, 639, 479 );
		} // for
	} // block
	
	{
		unsigned short c = 0x0000;
		canvas0.SetPenColour( c );
		for (int r = 96; r > 0; r -= 3) {
			if (r != 96 && r % 3 == 0) {
				c += 0x400;
				canvas0.SetPenColour( c );
			} // if
			canvas0.FastDrawFilledCircle( 640/2, 480/2, r );
		} // for
	} // block

	{	
		unsigned short c = 0x0000;
		canvas0.SetPenColour( c );
		for (int r = 64; r > 0; r -= 2) {
			if (r != 64 && (r & 1) == 0) {
				c += 0x421;
				canvas0.SetPenColour( c );
			} // if
			canvas0.FastDrawFilledCircle( 640/4, 480/4, r );
		} // for
	} // block

	{
		unsigned short c = 0x0000;
		canvas0.SetPenColour( c );
		for (int r = 64; r > 0; r -= 2) {
			if (r != 64 && (r & 1) == 0) {
				c += 0x420;
				canvas0.SetPenColour( c );
			} // if
			canvas0.FastDrawFilledCircle( 640/4*3, 480/4, r );
		} // for
	} // block

	{
		unsigned short c = 0x0000;
		canvas0.SetPenColour( c );
		for (int r = 64; r > 0; r -= 2) {
			if (r != 64 && (r & 1) == 0) {
				c += 0x401;
				canvas0.SetPenColour( c );
			} // if
			canvas0.FastDrawFilledCircle( 640/4, 480/4*3, r );
		} // for
	} // block

	{
		unsigned short c = 0x0000;
		canvas0.SetPenColour( c );
		for (int r = 64; r > 0; r -= 2) {
			if (r != 64 && (r & 1) == 0) {
				c += 0x21;
				canvas0.SetPenColour( c );
			} // if
			canvas0.FastDrawFilledCircle( 640/4*3, 480/4*3, r );
		} // for
	} // block
	
	canvas0.SetPenColour( 0x7FFF );
	canvas0.FastDrawRectangle( 0, 0 , 639, 479 );
	
	std::cin >> wait_key;

	VgaController::EnableTimeBasedDithering();
	
	std::cin >> wait_key;
	
	canvas0.SetPenColour( 0x8000 );
	canvas0.FastDrawFilledCircle( 640 / 2, 480 / 2, 150 );
	
	create_copper_anim();
	
	std::cin >> wait_key;
	
	VgaController::Copper::Address( copper_anim );
	VgaController::Copper::Enable();
	
	std::cin >> wait_key;
	
	{
		ThreeD d3;
		d3.run();
		std::cin >> wait_key;
	} // block

	#if 1
	for (int i = canvas0.Height(); i > canvas0.Height() / 2; i -= 1) {
		sinewave();
		VgaController::ViewPort0::Height( i );
		VgaController::WaitAfterVBlank();
	} // for

	for (int i = VgaController::ViewPort0::Height(); i <= canvas0.Height(); i += 1) {
		sinewave();
		VgaController::ViewPort0::Height( i );
		VgaController::WaitAfterVBlank();
	} // for
	#endif
	
	#if 1
	for (int i = canvas0.Width(); i > canvas0.Width() / 2; i -= 2) {
		sinewave();
		VgaController::ViewPort0::Width( i );
		Wait(1);
		sinewave();
		Wait(1);
	} // for

	for (int i = VgaController::ViewPort0::Width(); i <= canvas0.Width(); i += 2) {
		sinewave();
		VgaController::ViewPort0::Width( i );
		Wait(1);
		sinewave();
		Wait(1);
	} // for
	#endif
	
	#if 1
	while (VgaController::ViewPort0::Height() != canvas0.Height() / 2 or
	       VgaController::ViewPort0::Width() != canvas0.Width() / 2) {
		if (VgaController::ViewPort0::Height() != canvas0.Height() / 2)
			VgaController::ViewPort0::Height( VgaController::ViewPort0::Height() - 1 );
		if (VgaController::ViewPort0::Width() != canvas0.Width() / 2 and
		    VgaController::ViewPort0::Width() % 2 == 0)
			VgaController::ViewPort0::Width( VgaController::ViewPort0::Width() - 2 );
		sinewave();
		VgaController::WaitAfterVBlank();
	} // while
	#endif
	
	short x, y;
	
	do {
		x = VgaController::ViewPort0::ScreenX() + 1;
		VgaController::ViewPort0::ScreenX( x );
		sinewave();
		VgaController::WaitAfterVBlank();
	} while (x + VgaController::ViewPort0::Width() != 640);
	
	do {
		y = VgaController::ViewPort0::ScreenY() + 1;
		sinewave();
		VgaController::ViewPort0::ScreenY( y );
		VgaController::WaitAfterVBlank();
	} while (y + VgaController::ViewPort0::Height() != 480);
	
	do {
		VgaController::EnableTransactional();
		sinewave();
		VgaController::ViewPort0::ScreenY( VgaController::ViewPort0::ScreenY() - 1 );
		VgaController::ViewPort0::ScreenX( VgaController::ViewPort0::ScreenX() - 1 );
		VgaController::DisableTransactional();
		VgaController::WaitAfterVBlank();
	} while (VgaController::ViewPort0::ScreenY() != 0 and VgaController::ViewPort0::ScreenX() != 0);
	
	std::cin >> wait_key;

	VgaController::Copper::Disable();
	VgaController::ViewPort0::Disable();
	VgaController::ViewPort1::Disable();
	VgaController::BackGround::Colour( 0x0000 );

PINGUINS:
	
#if 1

	VgaController::ViewPort0::ScreenX(0);
	VgaController::ViewPort0::ScreenY(0);
	VgaController::ViewPort0::Width( canvas0.Width() );
	VgaController::ViewPort0::Height( canvas0.Height() );
		
	VgaController::Canvas1::Address(penguins);
	VgaController::Canvas1::Width( 640 );
	VgaController::Canvas1::Height( 480 );

	VgaController::ViewPort1::ScreenX( 0 );
	VgaController::ViewPort1::ScreenY( 0 );
	VgaController::ViewPort1::Width( 640 );
	VgaController::ViewPort1::Height( 480 );
	VgaController::ViewPort1::Alpha( 0x1F );
	VgaController::ViewPort1::Enable();

	Wait(8*60);

	VgaController::Canvas0::Address( koala );
	VgaController::ViewPort0::Enable();	

	for (signed char alpha = 0x1F; alpha >= 0; --alpha) {
		VgaController::ViewPort1::Alpha(alpha);
		Wait(3);
	} // for
	
	Wait(8*60);
	
	VgaController::Canvas1::Address( tulips );
		
	for (signed char alpha = 0x0; alpha <= 0x1F; ++alpha) {
		VgaController::ViewPort1::Alpha(alpha);
		Wait(3);
	} // for
	
	Wait(8*60);
	VgaController::Canvas0::Address( chrysant );
	
	for (unsigned int i = 0; i < 480; ++i) {
		VgaController::EnableTransactional();
		VgaController::ViewPort1::ScreenY( i );
		VgaController::ViewPort1::Height( 480 - i );
		VgaController::DisableTransactional();
		Wait(1);
	} // for
	
	VgaController::ViewPort1::Disable();
	
	Wait(8*60);
	
	{
		float x = 0.0, y = 0.0, w = 640.0, h = 480.0;
		for (unsigned int i = 0; i < 240; ++i) {
			y += 1.0;
			w -= (640.0 / 480.0) * 2.0;
			h -= 2.0;
			
			if (int(h) == 0) break;
			VgaController::EnableTransactional();
			VgaController::ViewPort0::ScreenY(int(y));
			VgaController::ViewPort0::CanvasY(int(y));
			VgaController::ViewPort0::Height(int(h));
			VgaController::DisableTransactional();
			Wait(2);
		} // for
		VgaController::ViewPort0::Disable();
	} // block
#endif

#if 1
	{
		Canvas shade( 640, 480 );
		shade.Clear(0x0000);
		VgaController::Copper::Address(NULL);
		VgaController::ViewPort0::Disable();
		VgaController::ViewPort1::Disable();
		VgaController::Canvas0::Width( 640 );
		VgaController::Canvas0::Height( 480 );
		VgaController::Canvas1::Width( 640 );
		VgaController::Canvas1::Height( 480 );
		VgaController::ViewPort0::ScreenX( 0 );
		VgaController::ViewPort0::ScreenY( 0 );
		VgaController::ViewPort0::CanvasX( 0 );
		VgaController::ViewPort0::CanvasY( 0 );
		VgaController::ViewPort0::Width( 640 );
		VgaController::ViewPort0::Height( 480 );
		VgaController::ViewPort1::ScreenX( 0 );
		VgaController::ViewPort1::ScreenY( 0 );
		VgaController::ViewPort1::CanvasX( 0 );
		VgaController::ViewPort1::CanvasY( 0 );
		VgaController::ViewPort1::Width( 640 );
		VgaController::ViewPort1::Height( 480 );
		VgaController::ViewPort1::Alpha( 0x1F );
		VgaController::Canvas0::Address( desert );
		VgaController::Canvas1::Address( shade.Buffer() );
		
		std::vector<VgaController::CopperPage*> pages;
		for (int i = 0; i < 300; ++i) {
			pages.push_back(new VgaController::CopperPage(&copper_anim[i * 512]));
		} // for
		for (int i = 0; i < 300; ++i) {
			for (int y = 0; y < 480; ++y) {
				pages[i]->operator[](y).Set(VgaController::COPPER_ALPHA_ABSOLUTE, 0x1F);
			} // for
		} // for

		//* link pages
		for (int i = 0; i < 299 - 1; ++i) {
			pages[i]->Next( pages[i+1] );
		} // for
		pages[299]->Next( NULL );
			
		for (int i = 0; i < 300; ++i) {
			for (int y = 0; y <= i; ++y) {
				int a;
				if (i == 0) a = 0x1F;
				else a = pages[i-1]->operator[](y).GetValue() - 1;
				if (a < 0) a = 0;
				pages[i]->operator[](y).Set(VgaController::COPPER_ALPHA_ABSOLUTE, a);
				pages[i]->operator[](479-y).Set(VgaController::COPPER_ALPHA_ABSOLUTE, a);
			} // for
		} // for

		VgaController::ViewPort0::Enable();
		VgaController::ViewPort1::Enable();
		VgaController::Copper::Address(copper_anim);		
		Wait(1);
		VgaController::Copper::Enable();
		
		Wait(8*60);
	
		VgaController::Canvas1::Address(penguins);
		VgaController::ViewPort1::Alpha(0x0);
		VgaController::Copper::Address(NULL);
		VgaController::Copper::Disable();
		
		for (int i = 0; i < 300; ++i) {
			for (int y = 0; y < 480; ++y) {
				pages[i]->operator[](y).Set(VgaController::COPPER_TRANSPARENT, 0x0);
			} // for
		} // for
		
		pages[0]->operator[](159).Set(VgaController::COPPER_ALPHA_ABSOLUTE, 0x0);
		pages[0]->operator[](319).Set(VgaController::COPPER_ALPHA_ABSOLUTE, 0x0);
		pages[0]->operator[](479).Set(VgaController::COPPER_ALPHA_ABSOLUTE, 0x0);
		
		for (int i = 1; i < 300; ++i) {
			memcpy( pages[i]->Data(), pages[i-1]->Data(), 960 );
			VgaController::CopperEffect previous_effect = VgaController::COPPER_TRANSPARENT;
			for (int y = 0; y < 480; ++y) {
				VgaController::CopperEffect effect = pages[i]->operator[](y).GetEffect();
				//* if not last line
				if (y != 479 and effect == VgaController::COPPER_TRANSPARENT) {
					if (pages[i]->operator[](y+1).GetEffect() != VgaController::COPPER_TRANSPARENT) {
						pages[i]->operator[](y).Set(VgaController::COPPER_ALPHA_ABSOLUTE, 0x0);
					} // if
				} // if
				if (effect == VgaController::COPPER_ALPHA_ABSOLUTE) {
					int a = pages[i]->operator[](y).GetValue();
					if (a < 0x1F) {
						pages[i]->operator[](y).Set(VgaController::COPPER_ALPHA_ABSOLUTE, a + 1);
					} // if
				} // if
			} // for
		} // for

		VgaController::Copper::Address(copper_anim);		
		Wait(1);
		VgaController::Copper::Enable();
										
		for (int i = 0; i < 300; ++i) {
			delete pages[i];
		} // for

		Wait(8*60);

	} // block
	
	VgaController::ViewPort1::Alpha(0x00);
	VgaController::Copper::Address(NULL);
		
#endif

	goto PINGUINS;
	
	std::cout << "Stopped..." << std::endl;

    cleanup_platform();

    return 0;
} // func
