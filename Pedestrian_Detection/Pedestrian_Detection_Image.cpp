// Pedestrian_Detection_Image.cpp : Defines the entry point for the console application.
//
// OpenCV 3.1.0
// Visual Studio 2015
// Precompiled header file
/*

the initial goal of the code is to detect human from an image and after that 
detect upright person form live stream from WEBCAM or any additional camera
Rectangle will be plotted on the uprþght person and puts '*' onto the center

*/

#include "stdafx.h"
#include <iostream>
#include <opencv2\highgui\highgui.hpp>
#include <opencv2\imgproc\imgproc.hpp>
#include <opencv2\objdetect\objdetect.hpp>
#include <opencv2\plot.hpp> 

using namespace std ;
using namespace cv ;
//using namespace gpu;

int main()
{
	Mat img; // load an image to the img matrix
	Mat gray_img; // converts grayscale
	vector<Rect> people; // stores founded locations

	img = imread("C:/Users/okan/Desktop/human.jpg", 1);
	cvtColor(img, gray_img, CV_RGB2GRAY); // converts grayscale

	HOGDescriptor person_detector; // define person_detector HOGDescriptor
	
	person_detector.setSVMDetector(HOGDescriptor::getDefaultPeopleDetector());
	// Sets coefficients for the linear SVM classifier.
	// Returns coefficients of the classifier trained for people detection (for default window size).

	person_detector.detectMultiScale(img, people, 0, Size(8, 8), Size(4, 4), 1.05, 2);
	cout << "Number of people in the image that are detected : "<<people.size()<<endl;

	string star = "*"; // for putText

	for (int i = 0; i < people.size(); i++) {
		Rect r = people.at(i);
		cout << r << endl;
		// how to draw rectangle;
		//[52 x 52 from (280, 265)]

		// draws the rectangle
		// color of the rectangle is up to you.(CV_RGB(r,g,b,) or Scalar(255,0,0))
		rectangle(img, r, CV_RGB(255, 0, 0), 2, 8, 0);

		// computes and prints the center of the rectangle
		int x_center = r.x + ceil(r.width / 2);
		int y_center = r.y + ceil(r.height / 2);
		cout << x_center << " , " << y_center<<endl;
	
		putText(img, star, Point(x_center, y_center), FONT_HERSHEY_SIMPLEX,1, CV_RGB(0, 255, 0), 1.0);
	}

	namedWindow("Person Detection", 1);
	imshow("Person Detection", img);

	waitKey(0);
    return 0;
}

