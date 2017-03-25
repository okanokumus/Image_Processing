// Frame_differencing.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <iostream>
#include <iomanip>
#include <vector>
#include <cmath> // for abs funciton
// OpenCV library
#include <opencv2\highgui\highgui.hpp>
#include <opencv2\imgproc\imgproc.hpp>
#include <opencv2\videoio\videoio.hpp>
#include <opencv2\objdetect\objdetect.hpp>

using namespace std;
using namespace cv;

void getproperties(VideoCapture);// to get video and frame properties
void showvideo(VideoCapture); // shows video
void difference(vector<Mat>&); // takes differences

// main function
int main()
{
	VideoCapture cap("C:/Users/okan/Desktop/video.avi"); // put the address of the video
	if (!cap.isOpened())  // if not success, exit program
	{
		cout << "Cannot open the video file" << endl;
		return -1;
	}

	getproperties(cap);
	showvideo(cap);

	waitKey(0);
	return 0;
}

void showvideo(VideoCapture capp) {
	// shows the video
	
	vector<Mat>frames;// holds all images for difference 

	for (;;)
	{
		Mat frame;
		bool bSuccess = capp.read(frame); // read a new frame from video
										  //if not success, break loop								 
		if (!bSuccess) {
			break;
		}
		frames.push_back(frame); // all frames in a vector
	}

	difference(frames);
}
void difference(vector<Mat>&diffframes) {
	// this function takes differences of next frame and current frame
	vector<Mat>diff;
	namedWindow("difference", 1);
	for (int i = 0; i< diffframes.size() - 1; i++) {
		diff.push_back(abs(diffframes[i + 1] - diffframes[i]));
		imshow("difference", diff.at(i));
		if (waitKey(30) == 27) //wait for 'esc' key press for 30 ms. If 'esc' key is pressed, break loop
		{
			cout << "esc key is pressed by user" << endl;
			break;
		}
	}
}
void getproperties(VideoCapture cap) {
	// image properties
	double nof, fps;
	double height, width;
	fps = cap.get(CV_CAP_PROP_FPS); //get the frames per seconds of the video
	height = cap.get(CV_CAP_PROP_FRAME_HEIGHT); //get the frame height
	width = cap.get(CV_CAP_PROP_FRAME_WIDTH); //get the frame width
	nof = cap.get(CV_CAP_PROP_FRAME_COUNT);  // number of frames of the video						 
	cout << setw(30) << "Frame per seconds : " << fps << endl;
	cout << setw(30) << "Frame height : " << height << endl;
	cout << setw(30) << "Frame width : " << width << endl;
	cout << setw(30) << "Number of frames in video : " << nof << endl;
}