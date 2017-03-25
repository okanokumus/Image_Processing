// Disparty_Map.cpp : Defines the entry point for the console application.
//
// Working on disparty map 
// 
#include "stdafx.h"
#include <iostream>
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"// cvtColor is included
#include <opencv2/calib3d/calib3d.hpp>
#include "opencv2/stereo/stereo.hpp"
#include <opencv2/core/cuda.hpp>


using namespace std;
using namespace cv;

int main()
{
	// creating image container
	Mat right, right_g, left, left_g;
	Mat disp, disp8;

	// read the left and right images
	right = imread("E:\\visual stduio codes\\image processing codes\\disparity_images\\scene_r.png",1);
	left = imread("E:\\visual stduio codes\\image processing codes\\disparity_images\\scene_l.png", 1);
	
	// convert the colored image to grayscale 
	cvtColor(right, right_g, CV_RGB2GRAY);
	cvtColor(left, left_g, CV_RGB2GRAY);

	// create StereoBM object 
	Ptr< StereoBM > sbm = StereoBM::create(32,21);

	// compute the disparity
	sbm->compute(left_g, right_g, disp);

	// normalized the disp matrix for showing
	normalize(disp, disp8, 0, 255, CV_MINMAX, CV_8U);

	imshow("right image", right_g);
	imshow("left image", left_g);
	imshow("disparity image", disp8);
	waitKey(0);
    return 0;
}

