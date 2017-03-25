// resizing.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <iostream>
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/core/core.hpp"

using namespace std;
using namespace cv;

// this function represents the size of the image for comparing 
void printsize(Mat &,Mat &);  

int main()
{
	
	// firstly read and show an image
	Mat image,resized;
	image = imread(".../mirror.jpg",1); // address of the image in you computer
	
	namedWindow("Display image",1);
	imshow("Display image",image);
	
	// resizing the input image
	resize(image, resized, Size(), 0.5, 0.5, 1); // third parameter represents the output size
	
	namedWindow("Display resized image", 1);
	imshow("Display resized image", resized);

	// to check the resizing
	printsize(image,resized);

	waitKey(0);
    return 0;
}

void printsize(Mat &image, Mat &resized) {
	int r1, c1, r2, c2;
	r1 = image.rows;
	c1 = image.cols;
	r2 = resized.rows;
	c2 = resized.cols;
	cout << r1 << " " << c1 << endl;
	cout << r2 << " " << c2 << endl;
}

