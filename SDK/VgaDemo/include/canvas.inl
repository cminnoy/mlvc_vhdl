/*
 * canvas.inl 
 */

#ifndef INCLUDED_CANVAS_INL
#define INCLUDED_CANVAS_INL

#ifndef INCLUDED_CANVAS_H
#error "Do not include " __FILE__ " direct!"
#endif

/**
 * Canvas
 */

inline unsigned short * Canvas::Buffer() {
	return (unsigned short *)mPixels;
} // func

inline const unsigned short * Canvas::Buffer() const {
	return (unsigned short *)mPixels;
} // func

inline size_t Canvas::Width() const {
	return mWidth;
} // func

inline size_t Canvas::Height() const {
	return mHeight;
} // func

inline void Canvas::SetPenColour(unsigned short aColour) {
	mPenColour = aColour;
} // func

inline unsigned short Canvas::GetPenColour() const {
	return mPenColour;
} // func

inline void Canvas::DrawPixel(int x, int y) {
	if (x < 0 || x >= mWidth | y < 0 | y >= mHeight) return;
	FastDrawPixel(x, y);
} // func

inline void Canvas::FastDrawPixel(int x, int y) {
	mScanLine[y][x].colour = mPenColour;
} // func

#endif /* INCLUDED_CANVAS_INL */
