/*
 * vga_controller.cpp 
 */
 
#include <vga_controller.h>

// C/C++
#include <assert.h>
#include <cstdlib>
#include <algorithm>
#include <iostream>

// VgaController
//--------------

void VgaController::WaitAfterVBlank() {
	if (VgaController::PollVerticalBlank()) {
		while (VgaController::PollVerticalBlank());
		while (!VgaController::PollVerticalBlank());
		while (VgaController::PollVerticalBlank());
	} else {
		while (!VgaController::PollVerticalBlank());
		while (VgaController::PollVerticalBlank());
	}
} // func

// VgaController::CopperEntry
//---------------------------

void VgaController::CopperEntry::Set(VgaController::CopperEffect effect, unsigned short value) {
	assert(mData != NULL);
	unsigned short * mp = mData + mIndex;
	unsigned char * ep = reinterpret_cast<unsigned char *>(mData) + 960 + (mIndex >> 3);
	int index = mIndex % 8;
	unsigned char e = *ep;
	switch (effect) {
		case COPPER_LINE:
			value &= 0x7FFF;
			e &= ~(1 << (7 - index));
			break;
		case COPPER_TRANSPARENT:
			value = 0x8000;
			e &= ~(1 << (7 - index));
			break;
		case COPPER_BACKGROUND:
			value &= 0x7FFF;
			e |= (1 << (7 - index));
			break;
		case COPPER_TOPFRONT:
			value = 0x8000 | (value & 0x7FFF);
			e |= (1 << (7 - index));
			break;			
		case COPPER_ALPHA_RELATIVE:
			value = 0xC000 | (value & 0x1F);
			e &= ~(1 << (7 - index));
			break;
		case COPPER_ALPHA_ABSOLUTE:
			value = 0xE000 | (value & 0x1F);
			e &= ~(1 << (7 - index));
			break;
		default:
			return;
	} // switch
	*ep = e;
	*mp = value;
} // func

VgaController::CopperEffect VgaController::CopperEntry::GetEffect() const {
	assert(mData != NULL);
	unsigned short * mp = mData + mIndex;
	unsigned char * ep = reinterpret_cast<unsigned char *>(mData) + 960 + (mIndex >> 3);
	int index = mIndex % 8;
	unsigned char e = *ep;		
	e >>= (7 - index);
	e &= 0x1;
	unsigned short value = *mp;
	if ( value == 0x8000 and !e) return COPPER_TRANSPARENT;
	if ( !(value & 0x8000) and !e) return COPPER_LINE;
	if ( !(value & 0x8000) and e) return COPPER_BACKGROUND;
	if ( (value & 0x8000) and e) return COPPER_TOPFRONT;
	if ( (value & 0xE000) == 0xC000 and !e) return COPPER_ALPHA_RELATIVE;
	if ( (value & 0xE000) == 0xE000 and !e) return COPPER_ALPHA_ABSOLUTE;
	assert(false); // should not get here
	return COPPER_LINE;
} // func

unsigned short VgaController::CopperEntry::GetValue() const {
	assert(mData != NULL);
	unsigned short value = mData[mIndex] & 0x7FFF;
	CopperEffect effect = GetEffect();
	if (effect == COPPER_ALPHA_RELATIVE || effect == COPPER_ALPHA_ABSOLUTE)
		value &= 0x1F;
	return value;
} // func

// VgaController::CopperPage
//--------------------------

VgaController::CopperPage::CopperPage()
	: mOwnsBuffer(false), mNext(NULL), mData(NULL) {
	mBuffer = new unsigned short [512+64];
	if (mOwnsBuffer = mBuffer != NULL ? true : false) {
		unsigned long address = reinterpret_cast<unsigned long>(mBuffer);
		if (address % 128 != 0) {
			address += 128 - (address % 128);
		} // if
		mData = reinterpret_cast<unsigned short *>(address);
		clear();
	} // if
} // func

VgaController::CopperPage::CopperPage(void * aBuffer)
	: mOwnsBuffer(false), mNext(NULL) {
	mBuffer = reinterpret_cast<unsigned short *>(aBuffer);
	mData = reinterpret_cast<unsigned short *>(aBuffer);
	assert(aBuffer != NULL);
	assert(reinterpret_cast<unsigned int>(aBuffer) % 128 == 0);
	clear();
} // if

VgaController::CopperPage::~CopperPage() throw() {
	if (mOwnsBuffer) delete[] mBuffer;
} // func

void VgaController::CopperPage::Next(VgaController::CopperPage * aNext) {
	mNext = aNext;
	unsigned short * v = NULL;
	if (aNext) v = aNext->mData;
	unsigned short ** p = reinterpret_cast<unsigned short **>(&(mData[510]));
	*p = v;
} // func

void VgaController::CopperPage::clear() {
	//* wipe colours
	for (int i = 0; i < 480; ++i) {
		mData[i] = 0x8000;
	} // for
	//* wipe effects
	for (int i = 480; i < 510; ++i) {
		mData[i] = 0;
	} // for
	//* wipe next address
	mData[510] = 0;
	mData[511] = 0;
} // func

// VgaController::Canvas0
//-----------------------

void * VgaController::Canvas0::mAddress;

void VgaController::Canvas0::Address(void * aAddress) {
	mAddress = aAddress;
	Update();
} // func

void VgaController::Canvas0::Update() {
	*((void **)CANVAS0_ADDRESS) = static_cast<unsigned short *>(mAddress) +
								  Width() * VgaController::ViewPort0::CanvasY() +
								  VgaController::ViewPort0::CanvasX();
} // func

// VgaController::Canvas1
//-----------------------

void * VgaController::Canvas1::mAddress;

void VgaController::Canvas1::Address(void * aAddress) {
	mAddress = aAddress;
	Update();
} // func

void VgaController::Canvas1::Update() {
	*((void **)CANVAS1_ADDRESS) = static_cast<unsigned short *>(mAddress) +
								  Width() * VgaController::ViewPort1::CanvasY() +
								  VgaController::ViewPort1::CanvasX();
} // func

// VgaController::ViewPort0
//-------------------------

long VgaController::ViewPort0::mCanvasX;
long VgaController::ViewPort0::mCanvasY;

void VgaController::ViewPort0::CanvasX(unsigned long aX) {
	mCanvasX = aX;
	VgaController::Canvas0::Update();
} // func

void VgaController::ViewPort0::CanvasY(unsigned long aY) {
	mCanvasY = aY;
	VgaController::Canvas0::Update();
} // func

// VgaController::ViewPort1
//-------------------------

long VgaController::ViewPort1::mCanvasX;
long VgaController::ViewPort1::mCanvasY;

void VgaController::ViewPort1::CanvasX(unsigned long aX) {
	mCanvasX = aX;
	VgaController::Canvas1::Update();
} // func

void VgaController::ViewPort1::CanvasY(unsigned long aY) {
	mCanvasY = aY;
	VgaController::Canvas1::Update();
} // func
