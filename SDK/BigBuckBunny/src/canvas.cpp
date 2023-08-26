/*
 * canvas.cpp 
 */

#include <canvas.h>

// C/C++
#include <assert.h>
#include <cstdlib>
#include <algorithm>

/**
 * Canvas
 */

Canvas::Canvas(size_t aWidth, size_t aHeight)
	: mWidth(aWidth), mHeight(aHeight),
	  mOwnsBuffer(false), mBuffer(NULL), mPixels(NULL), mScanLine(NULL) {
	mBuffer = new unsigned short[aWidth * aHeight + 64];
	if (mOwnsBuffer = mBuffer != NULL ? true : false) {
		unsigned long address = reinterpret_cast<unsigned long>(mBuffer);
		if (address % 128 != 0) {
			address += 128 - (address % 128);
		} // if
		mPixels = reinterpret_cast<Pixel*>(address);
		mScanLine = new Pixel* [aHeight];
		for (int i = 0; i < aHeight; ++i) {
			mScanLine[i] = mPixels + i * aWidth;
		} // for
	} // if	
} // func

Canvas::Canvas(unsigned short * aBuffer, size_t aWidth, size_t aHeight)
	: mWidth(aWidth), mHeight(aHeight),
	  mOwnsBuffer(false), mBuffer(aBuffer), mPixels(NULL)  {
	assert(aBuffer != NULL);
	assert(reinterpret_cast<unsigned int>(aBuffer) % 128 == 0);
	mPixels = reinterpret_cast<Pixel*>(aBuffer);
	mScanLine = new Pixel* [aHeight];
	for (int i = 0; i < aHeight; ++i) {
		mScanLine[i] = mPixels + i * aWidth;
	} // for
} // func

Canvas::~Canvas() throw () {
	if (mOwnsBuffer) delete[] mBuffer;
	delete[] mScanLine;
} // func

void Canvas::Clear(unsigned short aColour) {
	assert(sizeof(unsigned long long) == 8);
	const size_t size = mWidth * mHeight * sizeof(unsigned short) / sizeof(unsigned long long);
	unsigned long long lColour = aColour;
	lColour = (lColour << 48) | (lColour << 32) | (lColour << 16) | lColour;
	unsigned long long * ptr = reinterpret_cast<unsigned long long *>(mPixels);
	unsigned long long * ptr_end = ptr + size;
	while (ptr < ptr_end) *ptr++ = lColour;
} // func

void Canvas::DrawLine(int x0, int y0, int x1, int y1) {
	bool steep = std::abs(y1 - y0) > std::abs(x1 - x0);
	if (steep) {
		std::swap(x0, y0);
		std::swap(x1, y1);
	} // if
	if (x0 > x1) {
		std::swap(x0, x1);
		std::swap(y0, y1);
	} // if
	int deltax = x1 - x0;
    int deltay = abs(y1 - y0);
    int error  = deltax / 2;
    int y = y0;
    int ystep;
    if (y0 < y1) ystep = 1; else ystep = -1;
    
    if (steep) {
    	for (int x = x0; x <= x1; x++) {
    		DrawPixel(y, x);
    		error -= deltay;
    		if (error < 0) {
    			y += ystep;
    			error += deltax;
    		} // if
    	} // for
    } else {
    	for (int x = x0; x <= x1; x++) {
    		DrawPixel(x, y);
    		error -= deltay;
    		if (error < 0) {
    			y += ystep;
    			error += deltax;
    		} // if
    	} // for
    } // else
} // func

void Canvas::DrawHLine(int x0, int x1, int y) {
	assert(sizeof(unsigned long) == sizeof(unsigned short*));
	//* swap
	if (x1 < x0) {
		int tmp = x0;
		x0 = x1;
		x1 = tmp;
	} // if
	//* boundry check
	if (y < 0 or y >= Height()) return;
	if (x0 < 0) x0 = 0;
	if (x1 >= Width()) x1 = Width() - 1;
	FastDrawHLine(x0, x1, y);
} // func

void Canvas::FastDrawHLine(int x0, int x1, int y) {
	//* draw
	unsigned short *us_p = Buffer() + y * Width();
	unsigned short *us_e = us_p + x1;
	us_p += x0;
	unsigned short sc = mPenColour;

	if ( us_p == us_e ) { *us_p = sc; return; }
	if ( (reinterpret_cast<unsigned long>(us_p) & 0x2) ) *us_p++ = sc;
	if ( !(reinterpret_cast<unsigned long>(us_e) & 0x2) ) *us_e-- = sc;
	if ( us_p == us_e ) *us_p++ = sc;
	if ( us_p > us_e ) return;
	unsigned long lc = (sc << 16) | sc;
	unsigned long *ul_p = reinterpret_cast<unsigned long*>(us_p);
	unsigned long *ul_e = reinterpret_cast<unsigned long*>(us_e);
	do { *ul_p++ = lc; } while (ul_p < ul_e);
} // func
	
void Canvas::FastDrawLine(int x0, int y0, int x1, int y1) {
	bool steep = abs(y1 - y0) > abs(x1 - x0);
	if (steep) {
		std::swap(x0, y0);
		std::swap(x1, y1);
	} // if
	if (x0 > x1) {
		std::swap(x0, x1);
		std::swap(y0, y1);
	} // if
	int deltax = x1 - x0;
    int deltay = abs(y1 - y0);
    int error  = deltax / 2;
    int y = y0;
    int ystep;
    if (y0 < y1) ystep = 1; else ystep = -1;
    
    if (steep) {
    	for (int x = x0; x <= x1; x++) {
    		FastDrawPixel(y, x);
    		error -= deltay;
    		if (error < 0) {
    			y += ystep;
    			error += deltax;
    		} // if
    	} // for
    } else {
    	for (int x = x0; x <= x1; x++) {
    		FastDrawPixel(x, y);
    		error -= deltay;
    		if (error < 0) {
    			y += ystep;
    			error += deltax;
    		} // if
    	} // for
    } // else
} // func

void Canvas::DrawCircle(int xCenter, int yCenter, int radius) {
	int x = 0;
	int y = radius;
	int p = 1 - radius;
		
	DrawPixel(xCenter /*+ x*/, yCenter + y);
//	DrawPixel(xCenter - x, yCenter + y);
	DrawPixel(xCenter /*+ x*/, yCenter - y);
//	DrawPixel(xCenter - x, yCenter - y);
	DrawPixel(xCenter + y, yCenter /*+ x*/);
	DrawPixel(xCenter - y, yCenter /*+ x*/);
	DrawPixel(xCenter + y, yCenter /*- x*/);
	DrawPixel(xCenter - y, yCenter /*- x*/);

	while (x < y) {
		x++;
		if (p >= 0) { y--; p = p + 2 * (x - y) + 1; }
		else p = p + 2 * x + 1;
		DrawPixel(xCenter + x, yCenter + y);
		DrawPixel(xCenter - x, yCenter + y);
		DrawPixel(xCenter + x, yCenter - y);
		DrawPixel(xCenter - x, yCenter - y);		
		DrawPixel(xCenter + y, yCenter + x);
		DrawPixel(xCenter - y, yCenter + x);
		DrawPixel(xCenter + y, yCenter - x);
		DrawPixel(xCenter - y, yCenter - x);
	} // while
} // func

void Canvas::FastDrawCircle(int xCenter, int yCenter, int radius) {
	int x = 0;
	int y = radius;
	int p = 1 - radius;
		
	FastDrawPixel(xCenter /*+ x*/, yCenter + y);
//	FastDrawPixel(xCenter - x, yCenter + y);
	FastDrawPixel(xCenter /*+ x*/, yCenter - y);
//	FastDrawPixel(xCenter - x, yCenter - y);
	FastDrawPixel(xCenter + y, yCenter /*+ x*/);
	FastDrawPixel(xCenter - y, yCenter /*+ x*/);
	FastDrawPixel(xCenter + y, yCenter /*- x*/);
	FastDrawPixel(xCenter - y, yCenter /*- x*/);

	while (x < y) {
		x++;
		if (p >= 0) { y--; p = p + 2 * (x - y) + 1; }
		else p = p + 2 * x + 1;
		FastDrawPixel(xCenter + x, yCenter + y);
		FastDrawPixel(xCenter - x, yCenter + y);
		FastDrawPixel(xCenter + x, yCenter - y);
		FastDrawPixel(xCenter - x, yCenter - y);
		FastDrawPixel(xCenter + y, yCenter + x);
		FastDrawPixel(xCenter - y, yCenter + x);
		FastDrawPixel(xCenter + y, yCenter - x);
		FastDrawPixel(xCenter - y, yCenter - x);
	} // while
} // func

void Canvas::DrawFilledCircle(int xCenter, int yCenter, int radius) {
	int x = 0;
	int y = radius;
	int p = 1 - radius;
	DrawHLine(xCenter - x, xCenter + x, yCenter + y);
	DrawHLine(xCenter - x, xCenter + x, yCenter - y);
	DrawHLine(xCenter - y, xCenter + y, yCenter + x);
	DrawHLine(xCenter - y, xCenter + y, yCenter - x);
	while (x < y) {
		x++;
		if (p >= 0) { y--; p = p + 2 * (x - y) + 1; }
		else p = p + 2 * x + 1;
		DrawHLine(xCenter - x, xCenter + x, yCenter + y);
		DrawHLine(xCenter - x, xCenter + x, yCenter - y);
		DrawHLine(xCenter - y, xCenter + y, yCenter + x);
		DrawHLine(xCenter - y, xCenter + y, yCenter - x);
	} // while
} // func

void Canvas::FastDrawFilledCircle(int xCenter, int yCenter, int radius) {
	int x = 0;
	int y = radius;
	int p = 1 - radius;
	FastDrawHLine(xCenter - x, xCenter + x, yCenter + y);
	FastDrawHLine(xCenter - x, xCenter + x, yCenter - y);
	FastDrawHLine(xCenter - y, xCenter + y, yCenter + x);
	FastDrawHLine(xCenter - y, xCenter + y, yCenter - x);
	while (x < y) {
		x++;
		if (p >= 0) { y--; p = p + 2 * (x - y) + 1; }
		else p = p + 2 * x + 1;
		FastDrawHLine(xCenter - x, xCenter + x, yCenter + y);
		FastDrawHLine(xCenter - x, xCenter + x, yCenter - y);
		FastDrawHLine(xCenter - y, xCenter + y, yCenter + x);
		FastDrawHLine(xCenter - y, xCenter + y, yCenter - x);
	} // while
} // func

void Canvas::DrawRectangle(int x0, int y0, int x1, int y1) {
	if (x1 < x0) {
		int tmp = x1;
		x1 = x0;
		x0 = tmp;
	}
	if (x0 >= Width() or x1 < 0) return;
	if (y1 < y0) {
		int tmp = y1;
		y1 = y0;
		y0 = tmp;
	}
	if (y0 >= Height() or y1 < 0) return;
	if (x0 < 0) x0 = 0;
	if (y0 < 0) y0 = 0;
	if (x1 >= Width()) x1 = Width() - 1;
	if (y1 >= Height()) y1 = Height() - 1;
	FastDrawRectangle(x0, y0, x1, y1);
} // func

void Canvas::DrawFilledRectangle(int x0, int y0, int x1, int y1) {
	if (x1 < x0) {
		int tmp = x1;
		x1 = x0;
		x0 = tmp;
	}
	if (x0 >= Width() or x1 < 0) return;
	if (y1 < y0) {
		int tmp = y1;
		y1 = y0;
		y0 = tmp;
	}
	if (y0 >= Height() or y1 < 0) return;
	if (x0 < 0) x0 = 0;
	if (y0 < 0) y0 = 0;
	if (x1 >= Width()) x1 = Width() - 1;
	if (y1 >= Height()) y1 = Height() - 1;
	FastDrawFilledRectangle(x0, y0, x1, y1);
} // func

void Canvas::FastDrawRectangle(int x0, int y0, int x1, int y1) {
	FastDrawHLine(x0, x1, y0);
	FastDrawHLine(x0, x1, y1);
	FastDrawLine(x0, y0, x0, y1);
	FastDrawLine(x1, y0, x1, y1);
} // func

void Canvas::FastDrawFilledRectangle(int x0, int y0, int x1, int y1) {
	while (y0 < y1) FastDrawHLine(x0, x1, y0++);
} // func
