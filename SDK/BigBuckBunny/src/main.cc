/*
 * main.cc 
 */

// C/C++
#include <iostream>
#include <algorithm>
#include <string>
#include <assert.h>

#include <platform.h>
#include <vga_controller.h>
#include <canvas.h>

#include <buck_01200.h>
#include <buck_01201.h>
#include <buck_01202.h>
#include <buck_01203.h>
#include <buck_01204.h>
#include <buck_01205.h>
#include <buck_01206.h>
#include <buck_01207.h>
#include <buck_01208.h>
#include <buck_01209.h>
#include <buck_01210.h>
#include <buck_01211.h>
#include <buck_01212.h>
#include <buck_01213.h>
#include <buck_01214.h>
#include <buck_01215.h>
#include <buck_01216.h>
#include <buck_01217.h>
#include <buck_01218.h>
#include <buck_01219.h>
#include <buck_01220.h>
#include <buck_01221.h>
#include <buck_01222.h>
#include <buck_01223.h>
#include <buck_01224.h>
#include <buck_01225.h>
#include <buck_01226.h>
#include <buck_01227.h>
#include <buck_01228.h>
#include <buck_01229.h>
#include <buck_01230.h>
#include <buck_01231.h>
#include <buck_01232.h>
#include <buck_01233.h>
#include <buck_01234.h>
#include <buck_01235.h>
#include <buck_01236.h>
#include <buck_01237.h>
#include <buck_01238.h>
#include <buck_01239.h>
#include <buck_01240.h>
#include <buck_01241.h>
#include <buck_01242.h>
#include <buck_01243.h>
#include <buck_01244.h>
#include <buck_01245.h>
#include <buck_01246.h>
#include <buck_01247.h>
#include <buck_01248.h>
#include <buck_01249.h>
#include <buck_01250.h>
#include <buck_01251.h>
#include <buck_01252.h>
#include <buck_01253.h>
#include <buck_01254.h>
#include <buck_01255.h>
#include <buck_01256.h>
#include <buck_01257.h>
#include <buck_01258.h>
#include <buck_01259.h>

#define DO_RLE (1)

/**
 * main
 */

struct movie_t {
	const unsigned short         x;
	const unsigned short         y;
	const unsigned short         width;
	const unsigned short         height;
	const unsigned int			 length;
	const unsigned short * const data;
};

const size_t movie_len = 60;
const movie_t movie[movie_len] = {
	{buck_01200_x, buck_01200_y, buck_01200_width, buck_01200_height, buck_01200_length, buck_01200_data},
	{buck_01201_x, buck_01201_y, buck_01201_width, buck_01201_height, buck_01201_length, buck_01201_data},
	{buck_01202_x, buck_01202_y, buck_01202_width, buck_01202_height, buck_01202_length, buck_01202_data},
	{buck_01203_x, buck_01203_y, buck_01203_width, buck_01203_height, buck_01203_length, buck_01203_data},
	{buck_01204_x, buck_01204_y, buck_01204_width, buck_01204_height, buck_01204_length, buck_01204_data},
	{buck_01205_x, buck_01205_y, buck_01205_width, buck_01205_height, buck_01205_length, buck_01205_data},
	{buck_01206_x, buck_01206_y, buck_01206_width, buck_01206_height, buck_01206_length, buck_01206_data},
	{buck_01207_x, buck_01207_y, buck_01207_width, buck_01207_height, buck_01207_length, buck_01207_data},
	{buck_01208_x, buck_01208_y, buck_01208_width, buck_01208_height, buck_01208_length, buck_01208_data},
	{buck_01209_x, buck_01209_y, buck_01209_width, buck_01209_height, buck_01209_length, buck_01209_data},
	{buck_01210_x, buck_01210_y, buck_01210_width, buck_01210_height, buck_01210_length, buck_01210_data},
	{buck_01211_x, buck_01211_y, buck_01211_width, buck_01211_height, buck_01211_length, buck_01211_data},
	{buck_01212_x, buck_01212_y, buck_01212_width, buck_01212_height, buck_01212_length, buck_01212_data},
	{buck_01213_x, buck_01213_y, buck_01213_width, buck_01213_height, buck_01213_length, buck_01213_data},
	{buck_01214_x, buck_01214_y, buck_01214_width, buck_01214_height, buck_01214_length, buck_01214_data},
	{buck_01215_x, buck_01215_y, buck_01215_width, buck_01215_height, buck_01215_length, buck_01215_data},
	{buck_01216_x, buck_01216_y, buck_01216_width, buck_01216_height, buck_01216_length, buck_01216_data},
	{buck_01217_x, buck_01217_y, buck_01217_width, buck_01217_height, buck_01217_length, buck_01217_data},
	{buck_01218_x, buck_01218_y, buck_01218_width, buck_01218_height, buck_01218_length, buck_01218_data},
	{buck_01219_x, buck_01219_y, buck_01219_width, buck_01219_height, buck_01219_length, buck_01219_data},
	{buck_01220_x, buck_01220_y, buck_01220_width, buck_01220_height, buck_01220_length, buck_01220_data},
	{buck_01221_x, buck_01221_y, buck_01221_width, buck_01221_height, buck_01221_length, buck_01221_data},
	{buck_01222_x, buck_01222_y, buck_01222_width, buck_01222_height, buck_01222_length, buck_01222_data},
	{buck_01223_x, buck_01223_y, buck_01223_width, buck_01223_height, buck_01223_length, buck_01223_data},
	{buck_01224_x, buck_01224_y, buck_01224_width, buck_01224_height, buck_01224_length, buck_01224_data},
	{buck_01225_x, buck_01225_y, buck_01225_width, buck_01225_height, buck_01225_length, buck_01225_data},
	{buck_01226_x, buck_01226_y, buck_01226_width, buck_01226_height, buck_01226_length, buck_01226_data},
	{buck_01227_x, buck_01227_y, buck_01227_width, buck_01227_height, buck_01227_length, buck_01227_data},
	{buck_01228_x, buck_01228_y, buck_01228_width, buck_01228_height, buck_01228_length, buck_01228_data},
	{buck_01229_x, buck_01229_y, buck_01229_width, buck_01229_height, buck_01229_length, buck_01229_data},
	{buck_01230_x, buck_01230_y, buck_01230_width, buck_01230_height, buck_01230_length, buck_01230_data},
	{buck_01231_x, buck_01231_y, buck_01231_width, buck_01231_height, buck_01231_length, buck_01231_data},
	{buck_01232_x, buck_01232_y, buck_01232_width, buck_01232_height, buck_01232_length, buck_01232_data},
	{buck_01233_x, buck_01233_y, buck_01233_width, buck_01233_height, buck_01233_length, buck_01233_data},
	{buck_01234_x, buck_01234_y, buck_01234_width, buck_01234_height, buck_01234_length, buck_01234_data},
	{buck_01235_x, buck_01235_y, buck_01235_width, buck_01235_height, buck_01235_length, buck_01235_data},
	{buck_01236_x, buck_01236_y, buck_01236_width, buck_01236_height, buck_01236_length, buck_01236_data},
	{buck_01237_x, buck_01237_y, buck_01237_width, buck_01237_height, buck_01237_length, buck_01237_data},
	{buck_01238_x, buck_01238_y, buck_01238_width, buck_01238_height, buck_01238_length, buck_01238_data},
	{buck_01239_x, buck_01239_y, buck_01239_width, buck_01239_height, buck_01239_length, buck_01239_data},
	{buck_01240_x, buck_01240_y, buck_01240_width, buck_01240_height, buck_01240_length, buck_01240_data},
	{buck_01241_x, buck_01241_y, buck_01241_width, buck_01241_height, buck_01241_length, buck_01241_data},
	{buck_01242_x, buck_01242_y, buck_01242_width, buck_01242_height, buck_01242_length, buck_01242_data},
	{buck_01243_x, buck_01243_y, buck_01243_width, buck_01243_height, buck_01243_length, buck_01243_data},
	{buck_01244_x, buck_01244_y, buck_01244_width, buck_01244_height, buck_01244_length, buck_01244_data},
	{buck_01245_x, buck_01245_y, buck_01245_width, buck_01245_height, buck_01245_length, buck_01245_data},
	{buck_01246_x, buck_01246_y, buck_01246_width, buck_01246_height, buck_01246_length, buck_01246_data},
	{buck_01247_x, buck_01247_y, buck_01247_width, buck_01247_height, buck_01247_length, buck_01247_data},
	{buck_01248_x, buck_01248_y, buck_01248_width, buck_01248_height, buck_01248_length, buck_01248_data},
	{buck_01249_x, buck_01249_y, buck_01249_width, buck_01249_height, buck_01249_length, buck_01249_data},
	{buck_01250_x, buck_01250_y, buck_01250_width, buck_01250_height, buck_01250_length, buck_01250_data},
	{buck_01251_x, buck_01251_y, buck_01251_width, buck_01251_height, buck_01251_length, buck_01251_data},
	{buck_01252_x, buck_01252_y, buck_01252_width, buck_01252_height, buck_01252_length, buck_01252_data},
	{buck_01253_x, buck_01253_y, buck_01253_width, buck_01253_height, buck_01253_length, buck_01253_data},
	{buck_01254_x, buck_01254_y, buck_01254_width, buck_01254_height, buck_01254_length, buck_01254_data},
	{buck_01255_x, buck_01255_y, buck_01255_width, buck_01255_height, buck_01255_length, buck_01255_data},
	{buck_01256_x, buck_01256_y, buck_01256_width, buck_01256_height, buck_01256_length, buck_01256_data},
	{buck_01257_x, buck_01257_y, buck_01257_width, buck_01257_height, buck_01257_length, buck_01257_data},
	{buck_01258_x, buck_01258_y, buck_01258_width, buck_01258_height, buck_01258_length, buck_01258_data},
	{buck_01259_x, buck_01259_y, buck_01259_width, buck_01259_height, buck_01259_length, buck_01259_data}
};

std::string wait_key;

int main()
{
    init_platform();

	std::cout << "Running..." << std::endl;

	// Big Buck Bunny Animation

	VgaController::BackGround::Colour(0x0000);
	VgaController::ViewPort1::Disable();
	VgaController::EnableScreen();

	VgaController::ViewPort1::Width( 640 );
	VgaController::ViewPort1::Height( 360 );
	VgaController::ViewPort1::ScreenX( 0 );
	VgaController::ViewPort1::ScreenY( 60 );
	
	static unsigned short firstimg_bitmap[640 * 360] __attribute__((aligned (128)));
	static unsigned short canvas0_bitmap[640 * 360] __attribute__((aligned (128)));
	static unsigned short canvas1_bitmap[640 * 360] __attribute__((aligned (128)));
	
	Canvas canvas0(canvas0_bitmap, 640, 360);
	Canvas canvas1(canvas1_bitmap, 640, 360);
	
	VgaController::EnableTimeBasedDithering();
	VgaController::Canvas1::Address( canvas0.Buffer() );
	VgaController::Canvas1::Width( canvas0.Width() );
	VgaController::Canvas1::Height( canvas0.Height() );
	VgaController::ViewPort1::Alpha(0x1F);
	VgaController::ViewPort1::Enable();

	//* Loop animation			
	while (true) {
	  	canvas0.Clear(0);
	  	canvas1.Clear(0);
	  	bool toggle = true;
		bool first_image = true;
		  	
#if !DO_RLE
		for (int frame_count = 0; frame_count < movie_len; ++frame_count) {
			//* copy screen
			const unsigned short * rp = movie[frame_count].data;
			if (toggle) {
				unsigned short * wy = canvas1.Buffer() + movie[frame_count].y * canvas1.Width();
				for (unsigned short iy = 0; iy < movie[frame_count].height; ++iy) {
					for (unsigned short ix = 0; ix < movie[frame_count].width; ++ix) {
						*(wy + movie[frame_count].x + ix) -= *rp;
						++rp;
					} // for
					wy += canvas1.Width();
				} // for
				WaitAfterVBlank();
				VgaController::Canvas1::Address(canvas1_bitmap);
			} else {
				unsigned short * wy = canvas0.Buffer() + movie[frame_count].y * canvas0.Width();
				for (unsigned short iy = 0; iy < movie[frame_count].height; ++iy) {
					for (unsigned short ix = 0; ix < movie[frame_count].width; ++ix) {
						*(wy + movie[frame_count].x + ix) -= *rp;
						++rp;
					} // for
					wy += canvas0.Width();				
				} // for
				WaitAfterVBlank();
				VgaController::Canvas1::Address(canvas0_bitmap);
			} // if
			toggle = !toggle;
		} // for
#else
		for (int frame_count = 0; frame_count < movie_len; ++frame_count) {
			std::cout << "Decoding frame " << frame_count << std::endl;
//			std::cout << "X: " << movie[frame_count].x << std::endl;
//			std::cout << "Y: " << movie[frame_count].y << std::endl;
//			std::cout << "Width: " << movie[frame_count].width << std::endl;
//			std::cout << "Height: " << movie[frame_count].height << std::endl;
			
//			std::cin >> wait_key;

			//* Run Length Decode
			unsigned short * wp;
			unsigned int gap;
			const unsigned short * rp = movie[frame_count].data;
			const unsigned short width = movie[frame_count].width;
			const unsigned short * const re = movie[frame_count].data + movie[frame_count].length;
		
			if (toggle) {
				wp = canvas1.Buffer() + movie[frame_count].y * canvas1.Width() + movie[frame_count].x;
				gap = canvas1.Width() - width;
			} else {
				wp = canvas0.Buffer() + movie[frame_count].y * canvas0.Width() + movie[frame_count].x;
				gap = canvas0.Width() - width;
			} // if
			
//			std::cout << "Toggle: " << toggle << std::endl;
//			std::cout << "wp: " << wp << std::endl;
//			std::cout << "gap: " << gap << std::endl;
//			std::cout << "rp: " << rp << std::endl;
//			std::cout << "width: " << width << std::endl;
//			std::cout << "re: " << re << std::endl;

			const unsigned short * we = wp + movie[frame_count].width;
			int last = 0;

//			std::cout << "we: " << we << std::endl;
#if 1
			while (rp < re) {
//				std::cout << "rp: " << rp << "  re: " << re << std::endl;
				unsigned short c = *rp++;
//				std::cout << "c: " << c << std::endl;
//				std::cout << "last: " << last << std::endl;
				*wp -= c;
				wp++;
				if (wp == we) {
					wp += gap;
					we = wp + width;
//					std::cout << "Next line..." << std::endl;
//					std::cout << "wp: " << wp << std::endl;
//					std::cout << "we: " << we << std::endl;
				} // if
				if (c == last) {
					int count = *rp++;
//					std::cout << "count: " << count << std::endl;
					while (count-- > 0) {
						*wp -= c;
						wp++;
						if (wp == we) {
							wp += gap;
							we = wp + width;
						} // if
					} // while	
				} // if
				last = c;
			} // while
#endif
			if (first_image) {
				memcpy(firstimg_bitmap, canvas1_bitmap, 640 * 360 * 2);
				first_image = false;
			} // if
			
			VgaController::WaitAfterVBlank();
			
			if (toggle) {
				VgaController::Canvas1::Address(canvas1_bitmap);
			} else {
				VgaController::Canvas1::Address(canvas0_bitmap);
			} // if

			toggle = !toggle;
		} // for
		
		VgaController::WaitAfterVBlank();
		VgaController::Canvas1::Address(firstimg_bitmap);
		VgaController::WaitAfterVBlank();
#endif
	} // while

	std::cout << "Stopped..." << std::endl;

    cleanup_platform();

    return 0;
}
