// video1.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <iostream>
#include "opencv2/highgui/highgui.hpp"
#include <iomanip>
#include <opencv2/imgproc/imgproc.hpp> // cvtColor is included


using namespace std;
using namespace cv;



int main(int argc, char* argv[])
{
	VideoCapture cap("C:/Users/Okan/Desktop/video.avi"); // open the video file for reading

	if (!cap.isOpened())  // if not success, exit program
	{
		cout << "Cannot open the video file" << endl;
		return -1;
	}


	namedWindow("MyVideo", CV_WINDOW_AUTOSIZE); //create a window called "MyVideo"
	while (1)
	{
		Mat frame,grayframe;

		bool bSuccess = cap.read(frame); // read a new frame from video

		if (!bSuccess) //if not success, break loop
		{
			cout << "Cannot read the frame from video file" << endl;
			break;
		}
		cvtColor(frame, grayframe, CV_RGB2GRAY); // conert all frame to the grayscale
		imshow("MyVideo", grayframe); //show the frame in "MyVideo" window

		if (waitKey(30) == 27) //wait for 'esc' key press for 30 ms. If 'esc' key is pressed, break loop
		{
			cout << "esc key is pressed by user" << endl;
			break;
		}
	}
    return 0;
}
