// SIFT.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <iostream>
#include <opencv2\xfeatures2d\nonfree.hpp> //cv::xfeatures2d::SIFT Class Reference
#include <opencv2\highgui\highgui.hpp>
#include <opencv2\imgproc\imgproc.hpp>
#include <opencv2\core\version.hpp>

using namespace std;
using namespace cv;
//using namespace cv::xfeatures2d;

// main function
int main()
{
	// prints the version of OpenCV
	cout << "OpenCV Version: " << CV_MAJOR_VERSION << "." << CV_MINOR_VERSION << endl;
	Mat img, g_img;
	
	// reads an image from current file
	img	= imread("C:/Users/okan/Desktop/BerkeleyTower.png",1);
	
	// opens a new window to show image
	namedWindow("Berkeley Tower/SIFT descriptor", 1);
	

	// converts gray scale
	cvtColor(img,g_img,CV_RGB2GRAY);

	Ptr<Feature2D> feature_detector = xfeatures2d::SIFT::create(0,3,0.04,10,1.6);
	vector<KeyPoint> keypoints;
	feature_detector->detect(g_img, keypoints); // finds the keypoint in the images.
	cout << "Number of keypoints in the image : " << keypoints.size()<<endl;
	
	drawKeypoints(g_img, keypoints,img, Scalar::all(-1), DrawMatchesFlags::DEFAULT);

	// show keypoints on the image
	imshow("Berkeley Tower/SIFT descriptor", img); //  imshow("Berkeley Tower",img);

	waitKey(0);
	//cin.get();
	return 0;
}

