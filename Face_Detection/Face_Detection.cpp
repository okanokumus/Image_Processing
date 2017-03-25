// Face_Detection.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <iostream>
#include <vector>
#include <cstring>
#include <opencv2\highgui\highgui.hpp>
#include <opencv2\imgproc\imgproc.hpp>
#include <opencv2\objdetect\objdetect.hpp>

using namespace std;
using namespace cv;

int main()
{
	string count; // optinal
	Mat image; // input colored image
	Mat g_image; // grayscale of the input image
	// reads image
	image = imread(".../face.jpg",1);// puts the address of image

	vector<Rect>face; // keeps the rect information to draw
	CascadeClassifier cascade;
	// address of the cascade classifier (...data/haarcascades/haarcascade_frontalcatface.xml)
	cascade.load(".../data/haarcascades/haarcascade_frontalface_alt.xml"); 
	cvtColor(image, g_image, CV_RGB2GRAY);
	
	cascade.detectMultiScale(g_image, face, 1.1, 3, 0, Size(30, 30), Size(100, 100));

	for (int i = 0; i < face.size(); i++) {
		Rect r = face.at(i);
		cout << r << endl;
		// how to draw rectangle;
		//[52 x 52 from (280, 265)]

		// draws the rectangle
		// color of the rectangle is up to you.(CV_RGB(r,g,b,) or Scalar(255,0,0))
		rectangle(image, r , CV_RGB(150, 185, 215), 2,8, 0);
		/*optionally put number of face in the each rectangle
		// put text on the rectangle
		// convert the int to string
		count = to_string(i+1);

		// Bottom-left corner of the text string in the image.
		int pos_x = max(r.tl().x + 10, 0);
		int pos_y = max(r.tl().y + 10, 0);
		// puts text 
		putText(image, count, Point(pos_x, pos_y), FONT_HERSHEY_SIMPLEX,0.5, CV_RGB(0, 255, 0), 1.0);*/
	}
	// puts text on the bottom of the image that shows haw many faces are in the şmage
	string c1 = "number of faces in the image : ";
	string c2 = c1 +  to_string(face.size());
	putText(image, c2, Point(50,450), FONT_HERSHEY_SIMPLEX, 1.0, CV_RGB(255, 0, 0), 1.0);
	//create a window to show image
	namedWindow("face image", 1);
	imshow("face image", image);
	waitKey(0);
	return 0;
}

