// panaroma_using_class.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <iostream>
#include <opencv2\stitching.hpp>
#include <opencv2\highgui\highgui.hpp>
#include <opencv2\imgproc\imgproc.hpp>

using namespace std;
using namespace cv;

// main function
int main()
{
	// prints the version of OpenCV
	cout << "OpenCV Version: " << CV_MAJOR_VERSION << "." << CV_MINOR_VERSION << endl;
	Mat img1, img2, img3, img4, img5;
	vector<Mat> images; // grayscaled images
	// read images as in grayscale  
	img1 = imread(".../img1.jpg",1);
	images.push_back(img1);
	img2 = imread(".../img2.jpg",1);
	images.push_back(img2);
	img3 = imread(".../img3.jpg",1);
	images.push_back(img3);
	img4 = imread(".../img4.jpg",1);
	images.push_back(img4);
	img5 = imread(".../img5.jpg",1);
	images.push_back(img5);

	if (!img1.data || !img2.data || !img3.data || !img4.data || !img5.data){
		cout << "Error reading images " << endl; return -1;
	}
	// show all images
	for (int i = 0; i < images.size();i++) {
		string winname = "images " + to_string(i+1);
		imshow(winname, images.at(i));
	}
	Mat pan;
	Stitcher stitcher = Stitcher::createDefault();
	// processing time
	unsigned long Atime = 0, Btime = 0; 
	Atime = getTickCount(); 
	Stitcher::Status status = stitcher.stitch(images, pan);
	Btime = getTickCount(); 
	cout<< (Btime - Atime) / getTickFrequency()<< " sec \n"; 
	
	if (Stitcher::OK == status) {
		char filename[200];
		sprintf_s(filename, ".../result.jpg");
		imwrite(filename, pan);
		imshow("Stitching Result", pan);
	}
	else
		cout <<"Stitching fail.\n";

	waitKey(0);
	return 0;
}
