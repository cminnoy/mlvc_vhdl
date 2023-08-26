#ifndef VGA_CONTROLLER_H_
#define VGA_CONTROLLER_H_

class VgaController {
public:

	class BackGround;
	class CopperEntry;
	class CopperPage;
	class Copper;
	class Canvas0;
	class Canvas1;
	class ViewPort0;
	class ViewPort1;
	
	// Only under C++0x
	//static_assert(sizeof(unsigned long) == sizeof(void*),
	//              "sizeof(unsigned long) must be equal to sizeof(void *)");

	static void	EnableScreen();
	static void	DisableScreen();

	static void	EnableTimeBasedDithering();
	static void	DisableTimeBasedDithering();
	
	static void EnableTransactional();
	static void DisableTransactional();
	static bool IsTransactional();
	
	static bool PollVerticalBlank();

	static void WaitAfterVBlank();

	class BackGround {
	public:
		static void				Colour(unsigned short aColour);
		static unsigned short	Colour();
	}; // class

	enum CopperEffect {
		COPPER_LINE,
		COPPER_TRANSPARENT,
		COPPER_BACKGROUND,
		COPPER_TOPFRONT,
		COPPER_ALPHA_RELATIVE,
		COPPER_ALPHA_ABSOLUTE
	};

	class CopperEntry {
		friend class CopperPage;
		public:
			void 			Set(CopperEffect effect, unsigned short value);
			CopperEffect	GetEffect() const;
			unsigned short	GetValue() const;			
		private:
			CopperEntry(unsigned short * aData, int index);
			unsigned short * mData;
			int mIndex;
		}; // class
	
	class CopperPage {
	public:
		CopperPage();
		CopperPage(void * aBuffer);
		~CopperPage() throw();
	
		unsigned short * Data();
		const unsigned short * Data() const;

		void Next(CopperPage * aNext);
		CopperPage * Next();
		const CopperPage * Next() const;
		
		CopperEntry operator[](int aIndex);
		const CopperEntry operator[](int aIndex) const;
		
	private:
		CopperPage(const CopperPage &);
		void clear();
		unsigned short * mBuffer; // non page aligned
		unsigned short * mData;   // page aligned
		CopperPage * mNext;		  // next page
		bool mOwnsBuffer;		  // auto-deallocate
	};
	
	class Copper {
	public:
		static void 	Enable();
		static void 	Disable();
		
		static void		Address(void * aAddress);
		static void *	Address();
	}; // class
	
	class Canvas0 {
		friend class VgaController::ViewPort0;
	public:
		static void				Address(void * aAddress);
		static void *			Address();
		static void				Width(unsigned long aWidth);
		static unsigned long	Width();
		static void				Height(unsigned long aHeight);
		static unsigned long	Height();
	private:
		static void * 			mAddress;
		static void				Update();
	}; // class

	class Canvas1 {
		friend class ViewPort1;
	public:	
		static void				Address(void * aAddress);
		static void *			Address();
		static void				Width(unsigned long aWidth);
		static unsigned long	Width();
		static void				Height(unsigned long aHeight);
		static unsigned long	Height();
	private:
		static void * 			mAddress;
		static void				Update();
	}; // class

	class ViewPort0 {
	public:
		static void				Enable();
		static void				Disable();
		static void				Width(unsigned short aWidth);
		static unsigned short	Width();	
		static void				Height(unsigned short aWidth);
		static unsigned short	Height();
		static void				ScreenX(unsigned short aX);
		static unsigned short	ScreenX();
		static void				ScreenY(unsigned short aY);
		static unsigned short	ScreenY();
		static void				CanvasX(unsigned long aX);
		static unsigned long	CanvasX();
		static void				CanvasY(unsigned long aY);
		static unsigned long	CanvasY();
	private:
		static long				mCanvasX;
		static long				mCanvasY;
	}; // class
	
	class ViewPort1 {
	public:
		static void				Enable();
		static void				Disable();
		static void				Width(unsigned short aWidth);
		static unsigned short	Width();	
		static void				Height(unsigned short aWidth);
		static unsigned short	Height();
		static void				ScreenX(unsigned short aX);
		static unsigned short	ScreenX();
		static void				ScreenY(unsigned short aY);
		static unsigned short	ScreenY();
		static void				CanvasX(unsigned long aX);
		static unsigned long	CanvasX();
		static void				CanvasY(unsigned long aY);
		static unsigned long	CanvasY();
		static void				Alpha(unsigned char aAlpha);
		static unsigned char	Alpha();
	private:
		static long				mCanvasX;
		static long				mCanvasY;
	}; // class

	enum {
		BASE_ADDRESS 			= 0xC3200000UL,
		SCREEN_CONTROL			= BASE_ADDRESS + 0,
		BACKGROUND_COLOUR		= BASE_ADDRESS + 4,
		CANVAS0_ADDRESS			= BASE_ADDRESS + 8,
		CANVAS0_WIDTH			= BASE_ADDRESS + 12,
		CANVAS0_HEIGHT			= BASE_ADDRESS + 16,
		COPPER_LIST_ADDRESS		= BASE_ADDRESS + 20,
		CANVAS1_ADDRESS			= BASE_ADDRESS + 24,
		CANVAS1_WIDTH			= BASE_ADDRESS + 28,
		CANVAS1_HEIGHT			= BASE_ADDRESS + 32,
		VIEWPORT0_WIDTH			= BASE_ADDRESS + 36,
		VIEWPORT0_HEIGHT		= BASE_ADDRESS + 40,
		VIEWPORT0_SX			= BASE_ADDRESS + 44,
		VIEWPORT0_SY			= BASE_ADDRESS + 48,
		VIEWPORT1_WIDTH			= BASE_ADDRESS + 52,
		VIEWPORT1_HEIGHT		= BASE_ADDRESS + 56,
		VIEWPORT1_SX			= BASE_ADDRESS + 60,
		VIEWPORT1_SY			= BASE_ADDRESS + 64,
		VIEWPORT1_ALPHA			= BASE_ADDRESS + 68,
	}; // enum

}; // class

#include <vga_controller.inl>

#endif /*VGA_CONTROLLER_H_*/
