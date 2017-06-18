// frame_diff_and_background_sub_live.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <iostream>

#include <opencv2\highgui.hpp>
#include <opencv2\videoio.hpp>
#include <opencv2\core.hpp>
#include <opencv2\imgproc.hpp>

using namespace std;
using namespace cv;

int main()
{
	Mat back_frame, next_frame, prev_frame, output; // next, previous, backwars and output image
	char c; // to control the background image

	cv::VideoCapture cap(0); // open the webcam
	
	if (!cap.isOpened())
		return -1;

	cout << "to tap 't' for taking background: ";
	cin >> c; 
	// take background image
	if (c == 't') {
		for (int i = 0; i < 1; i++) {
			cap >> back_frame;
			if (back_frame.empty())
				break;
			cvtColor(back_frame, back_frame, CV_RGB2GRAY); // convery grayscale
		}
	}
	else {
		return -1;
	}

	// binarization trackbar for both type of differencing
	int Thresh_back = 0; // threshold value for backward differ
 	int Thresh_frame = 0; // threshold value for frame differ
	//Create trackbars in "Control" window
	namedWindow("Control", CV_WINDOW_AUTOSIZE); //create a window called "Control"
	createTrackbar("BackwardThresh", "Control", &Thresh_back, 255);
	createTrackbar("FrameThresh", "Control", &Thresh_frame, 255);

	while (1) {
		cap >> prev_frame;
		if (prev_frame.empty())
			break;
		cvtColor(prev_frame, prev_frame, CV_RGB2GRAY); // convery grayscale
		cap >> next_frame;
		if (next_frame.empty())
			break;
		cvtColor(next_frame, next_frame, CV_RGB2GRAY); // convery grayscale
		// frame differencing (next-prev)
		cv::absdiff(next_frame, prev_frame, output);
		threshold(output, output, Thresh_frame, 255, THRESH_BINARY);
		imshow("frame difference", output);
		// backward subtraction (currentframe-back)
		cv::absdiff(back_frame, prev_frame, output);
		threshold(output, output, Thresh_back, 255, THRESH_BINARY);
		imshow("background difference", output);
		//cout << output.channels() << endl;

		if (waitKey(30) >= 0) break;
	}
    return 0;
}

