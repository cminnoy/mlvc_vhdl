/*
 * canvas.h 
 */

#ifndef INCLUDED_CANVAS_H
#define INCLUDED_CANVAS_H

//* C/C++
#include <cstring>

/**
 * Canvas
 */
class Canvas {
public:
	Canvas(size_t aWidth, size_t aHeight);
	Canvas(unsigned short * aBuffer, size_t aWidth, size_t aHeight);
	~Canvas() throw();
	
	void Clear(unsigned short aColour = 0x0000);

	void SetPenColour(unsigned short aColour);
	unsigned short GetPenColour() const;

	void DrawPixel(int x, int y);
	void DrawLine(int x0, int y0, int x1, int y1);
	void DrawCircle(int xCenter, int yCenter, int radius);
	void DrawFilledCircle(int xCenter, int yCenter, int radius);
	void DrawRectangle(int x0, int y0, int x1, int y1);
	void DrawFilledRectangle(int x0, int y0, int x1, int y1);
	
	void FastDrawPixel(int x, int y);
	void FastDrawLine(int x0, int y0, int x1, int y1);
	void FastDrawCircle(int xCenter, int yCenter, int radius);
	void FastDrawFilledCircle(int xCenter, int yCenter, int radius);
	void FastDrawRectangle(int x0, int y0, int x1, int y1);
	void FastDrawFilledRectangle(int x0, int y0, int x1, int y1);
	
	unsigned short * Buffer();
	const unsigned short * Buffer() const;
	
	size_t Width() const;
	size_t Height() const;
	
private:

	union Pixel {
		struct {
			unsigned short transparent : 1;
			unsigned short red		   : 5;
			unsigned short green       : 5;
			unsigned short blue        : 5;
		} pixel;
		unsigned short colour;
	};
	
	const size_t		mWidth;
	const size_t		mHeight;
	Pixel * 			mPixels;
	unsigned short *	mBuffer;
	unsigned short		mPenColour;
	bool				mOwnsBuffer;
	Pixel **			mScanLine;

	void DrawHLine(int x0, int x1, int y);
	void FastDrawHLine(int x0, int x1, int y);
	
}; //class

#include <canvas.inl>

#endif /* INCLUDED_CANVAS_H */
