// Pedestrian_Detection_WEBCAM.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <iostream>
#include <vector>
#include <opencv2\objdetect\objdetect.hpp>
#include <opencv2\highgui\highgui.hpp>
#include <opencv2\imgproc\imgproc.hpp>


using namespace std;
using namespace cv;

int main(int, char**)
{
	VideoCapture cap(0); // open the webcam
	vector<Rect>people;
	string star = "*"; // for putText
	
	if (!cap.isOpened())  // check if we succeeded
		return -1;

	HOGDescriptor person_detector; // define person_detector HOGDescriptor

	person_detector.setSVMDetector(HOGDescriptor::getDefaultPeopleDetector());
	// Sets coefficients for the linear SVM classifier.
	// Returns coefficients of the classifier trained for people detection (for default window size).
	
	
	while(1)
	{
		Mat img, gray_img;
		cap >> img; // get a new frame from camera
		cvtColor(img, gray_img, COLOR_BGR2GRAY); // converts gray frame
		person_detector.detectMultiScale(img, people, 0, Size(8, 8), Size(4,4), 1.05, 2);
		
		if (people.size() != 0) {
			cout << "Number of people in the image that are detected : " << people.size() << endl;
			for (int i = 0; i < people.size(); i++) {
				Rect r = people.at(i);
				cout << r << endl;

				// draws the rectangle
				// color of the rectangle is up to you.(CV_RGB(r,g,b,) or Scalar(255,0,0))
				rectangle(img, r, CV_RGB(255, 0, 0), 2, 8, 0);

				// computes and prints the center of the rectangle
				int x_center = r.x + ceil(r.width / 2);
				int y_center = r.y + ceil(r.height / 2);
				cout << x_center << " , " << y_center << endl;

				putText(img, star, Point(x_center, y_center), FONT_HERSHEY_SIMPLEX, 1, CV_RGB(0, 255, 0), 1.0);

			}

		}
		namedWindow("PEDESTRIAN DETECTION", 1);
		imshow("PEDESTRIAN DETECTION", img);
		if (waitKey(30) >= 0) break;
	}
	waitKey(0);
	return 0;
}
