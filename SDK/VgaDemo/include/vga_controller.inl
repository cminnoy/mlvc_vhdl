#ifndef VGA_CONTROLLER_H_
#error "Please insert <vga_controller.h> instead!"
#endif

// VgaController
//--------------

inline void VgaController::EnableScreen() {
	*((volatile unsigned long *)SCREEN_CONTROL) |= 0x00000040U;
} // func

inline void VgaController::DisableScreen() {
	*((volatile unsigned long *)SCREEN_CONTROL) &= 0xFFFFFFBFU;
 } // func

inline void VgaController::EnableTimeBasedDithering() {
	*((volatile unsigned long *)SCREEN_CONTROL) |= 0x00000020U;
} // func

inline void VgaController::DisableTimeBasedDithering() {
	*((volatile unsigned long *)SCREEN_CONTROL) &= 0xFFFFFFDFU;
} // func

inline void VgaController::EnableTransactional() {
	*((volatile unsigned long *)SCREEN_CONTROL) |= 0x40000000U;
} // func

inline void VgaController::DisableTransactional() {
	*((volatile unsigned long *)SCREEN_CONTROL) &= 0xBFFFFFFFU;
} // func

inline bool VgaController::IsTransactional() {
	return *((volatile unsigned long *)SCREEN_CONTROL) & 0x40000000U;
} // func

inline bool VgaController::PollVerticalBlank() {
	return *((volatile unsigned long *)SCREEN_CONTROL) & 0x80000000U;
} // func

// VgaController::BackGround
//--------------------------

inline void VgaController::BackGround::Colour(unsigned short aColour) {
	*((unsigned long *)BACKGROUND_COLOUR) = aColour;
} // func

inline unsigned short VgaController::BackGround::Colour() {
	return *((unsigned long *)BACKGROUND_COLOUR);
} // func

// VgaController::CopperPage
//--------------------------

inline unsigned short * VgaController::CopperPage::Data() {
	return mData;
} // func

inline const unsigned short * VgaController::CopperPage::Data() const {
	return mData;
} // func

inline VgaController::CopperPage * VgaController::CopperPage::Next() {
	return mNext;
} // func

inline const VgaController::CopperPage * VgaController::CopperPage::Next() const {
	return mNext;
} // func

inline VgaController::CopperEntry VgaController::CopperPage::operator[](int aIndex) {
	return CopperEntry(mData, aIndex);
} // func

inline const VgaController::CopperEntry VgaController::CopperPage::operator[](int aIndex) const {
	return CopperEntry(mData, aIndex);
} // func

// VgaController::CopperEntry
//---------------------------

inline VgaController::CopperEntry::CopperEntry(unsigned short * aData, int aIndex)
	: mData(aData), mIndex(aIndex) {
} // func

// VgaController::Copper
//----------------------

inline void VgaController::Copper::Enable() {
	*((volatile unsigned long *)SCREEN_CONTROL) |= 0x00000002U;
} // func

inline void VgaController::Copper::Disable() {
	*((volatile unsigned long *)SCREEN_CONTROL) &= 0xFFFFFFFDU;
} // func

inline void VgaController::Copper::Address(void * aAddress) {
	*((void **)COPPER_LIST_ADDRESS) = aAddress;
} // func

inline void * VgaController::Copper::Address() {
	return *((void **)COPPER_LIST_ADDRESS);
} // func

// VgaController::Canvas0
//-----------------------

inline void * VgaController::Canvas0::Address() {
	return mAddress;
} // func

inline void VgaController::Canvas0::Width(unsigned long aWidth) {
	*((volatile unsigned long *)CANVAS0_WIDTH) = aWidth;
} // func

inline unsigned long VgaController::Canvas0::Width() {
	return *((volatile unsigned long *)CANVAS0_WIDTH);
} // func

inline void VgaController::Canvas0::Height(unsigned long aHeight) {
	*((volatile unsigned long *)CANVAS0_HEIGHT) = aHeight;
} // func

inline unsigned long VgaController::Canvas0::Height() {
	return *((volatile unsigned long *)CANVAS0_HEIGHT);
} // func

// VgaController::Canvas1
//-----------------------

inline void * VgaController::Canvas1::Address() {
	return mAddress;
} // func

inline void VgaController::Canvas1::Width(unsigned long aWidth) {
	*((volatile unsigned long *)CANVAS1_WIDTH) = aWidth;
} // func

inline unsigned long VgaController::Canvas1::Width() {
	return *((volatile unsigned long *)CANVAS1_WIDTH);
} // func

inline void VgaController::Canvas1::Height(unsigned long aHeight) {
	*((volatile unsigned long *)CANVAS1_HEIGHT) = aHeight;
} // func

inline unsigned long VgaController::Canvas1::Height() {
	return *((volatile unsigned long *)CANVAS1_HEIGHT);
} // func

// VgaController::ViewPort0
//-------------------------

inline void VgaController::ViewPort0::Enable() {
	*((volatile unsigned long *)SCREEN_CONTROL) |= 0x00000001U;
} // func

inline void VgaController::ViewPort0::Disable() {
	*((volatile unsigned long *)SCREEN_CONTROL) &= 0xFFFFFFFEU;
} // func

inline void VgaController::ViewPort0::Width(unsigned short aWidth) {
	*((unsigned long *)VIEWPORT0_WIDTH) = aWidth;
} // func

inline unsigned short VgaController::ViewPort0::Width() {
	return *((unsigned long *)VIEWPORT0_WIDTH);
} // func

inline void VgaController::ViewPort0::Height(unsigned short aHeight) {
	*((unsigned long *)VIEWPORT0_HEIGHT) = aHeight;
} // func

inline unsigned short VgaController::ViewPort0::Height() {
	return *((unsigned long *)VIEWPORT0_HEIGHT);
} // func

inline void VgaController::ViewPort0::ScreenX(unsigned short aX) {
	*((unsigned long *)VIEWPORT0_SX) = aX;
} // func

inline unsigned short VgaController::ViewPort0::ScreenX() {
	return *((unsigned long *)VIEWPORT0_SX);
} // func

inline void VgaController::ViewPort0::ScreenY(unsigned short aY) {
	*((unsigned long *)VIEWPORT0_SY) = aY;
} // func

inline unsigned short VgaController::ViewPort0::ScreenY() {
	return *((unsigned long *)VIEWPORT0_SY);
} // func

inline unsigned long VgaController::ViewPort0::CanvasX() {
	return mCanvasX;
} // func

inline unsigned long VgaController::ViewPort0::CanvasY() {
	return mCanvasY;
} // func

// VgaController::ViewPort1
//-------------------------

inline void VgaController::ViewPort1::Enable() {
	*((volatile unsigned long *)SCREEN_CONTROL) |= 0x00000004U;
} // func

inline void VgaController::ViewPort1::Disable() {
	*((volatile unsigned long *)SCREEN_CONTROL) &= 0xFFFFFFFBU;
} // func

inline void VgaController::ViewPort1::Width(unsigned short aWidth) {
	*((volatile unsigned long *)VIEWPORT1_WIDTH) = aWidth;
} // func

inline unsigned short VgaController::ViewPort1::Width() {
	return *((volatile unsigned long *)VIEWPORT1_WIDTH);
} // func

inline void VgaController::ViewPort1::Height(unsigned short aHeight) {
	*((volatile unsigned long *)VIEWPORT1_HEIGHT) = aHeight;
} // func

inline unsigned short VgaController::ViewPort1::Height() {
	return *((volatile unsigned long *)VIEWPORT1_HEIGHT);
} // func

inline void VgaController::ViewPort1::ScreenX(unsigned short aX) {
	*((volatile unsigned long *)VIEWPORT1_SX) = aX;
} // func

inline unsigned short VgaController::ViewPort1::ScreenX() {
	return *((volatile unsigned long *)VIEWPORT1_SX);
} // func

inline void VgaController::ViewPort1::ScreenY(unsigned short aY) {
	*((volatile unsigned long *)VIEWPORT1_SY) = aY;
} // func

inline unsigned short VgaController::ViewPort1::ScreenY() {
	return *((volatile unsigned long *)VIEWPORT1_SY);
} // func

inline unsigned long VgaController::ViewPort1::CanvasX() {
	return mCanvasX;
} // func

inline unsigned long VgaController::ViewPort1::CanvasY() {
	return mCanvasY;
} // func

inline void VgaController::ViewPort1::Alpha(unsigned char aAlpha) {
	*((volatile unsigned long *)VIEWPORT1_ALPHA) = aAlpha;
} // func

inline unsigned char VgaController::ViewPort1::Alpha() {
	return *((volatile unsigned long *)VIEWPORT1_ALPHA);
} // func
