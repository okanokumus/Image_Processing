// Image_Stitching.cpp : Defines the entry point for the console application.
//
/* 
sources:
http://docs.opencv.org/2.4/modules/features2d/doc/common_interfaces_of_descriptor_extractors.html
http://docs.opencv.org/2.4/modules/features2d/doc/common_interfaces_of_descriptor_matchers.html
http://docs.opencv.org/2.4/doc/tutorials/features2d/feature_homography/feature_homography.html
https://ramsrigoutham.com/2012/11/22/panorama-image-stitching-in-opencv/

*/
/*
steps:
1. find SIFT descriptors in two images
2. matching the descriptors between images
3. using  RANSAC to estimate the homography matrix using the matched SIFT descriptors.
4. Warping the images based on the homography matrix
*/

#include "stdafx.h"
#include <iostream>
#include <vector>
#include <opencv2\xfeatures2d\nonfree.hpp> //cv::xfeatures2d::SIFT Class Reference
#include <opencv2\features2d\features2d.hpp> // cv::Feature2D::detectAndCompute
#include <opencv2\calib3d\calib3d.hpp>
#include <opencv2\highgui\highgui.hpp>
#include <opencv2\imgproc\imgproc.hpp>
#include <opencv2\core\version.hpp>


using namespace std;
using namespace cv;


// main function
int main()
{
	// prints the version of OpenCV
	cout << "OpenCV Version: " << CV_MAJOR_VERSION << "." << CV_MINOR_VERSION << endl;
	Mat img1, g_img1, img2, g_img2;

	// read images and convert them into grayscale  
	img1 = imread("E:/visual stduio codes/image processing codes/Panaroma/Panaroma_images/img1.jpg", 1);
	img2 = imread("E:/visual stduio codes/image processing codes/Panaroma/Panaroma_images/img2.jpg", 1);

	if (!img1.data || !img2.data){
		cout << "Error reading images " << endl; return -1;
	}
	cvtColor(img1, g_img1, CV_RGB2GRAY);
	cvtColor(img2, g_img2, CV_RGB2GRAY);

	
	// finds the keypoint in the first image.
	cout << "first step: find SIFT descriptors in two images\n";
	Ptr<Feature2D> feature_detector = xfeatures2d::SIFT::create(0, 3, 0.04, 10, 1.6);
	vector<KeyPoint> keypoints1, keypoints2;
	feature_detector->detect(g_img1, keypoints1); 
	feature_detector->detect(g_img2, keypoints2); 
	cout << "Number of keypoints in the first image : " << keypoints1.size() << endl;
	cout << "Number of keypoints in the second image : " << keypoints2.size() << endl;

	/* 
	draw the keypoints onto the images
	drawKeypoints(img1, keypoints1, img1, Scalar::all(-1), DrawMatchesFlags::DEFAULT);
	drawKeypoints(img2, keypoints2, img2, Scalar::all(-1), DrawMatchesFlags::DEFAULT);
	*/

	// show keypoints on the image
	imshow("Panorama image 1 ", img1);
	imshow("Panorama image 2 ", img2);
	cout << "first step is completed" << endl;
	cout << "----------\n";
	cout << "second step: matching the descriptors between images\n";
	/* Computes the descriptors for a set of keypoints detected
	in an image (first variant) or image set (second variant). */
	Mat descriptors_img1, descriptors_img2;
	feature_detector->compute(g_img1, keypoints1, descriptors_img1);
	feature_detector->compute(g_img2, keypoints2, descriptors_img2);
	//Descriptor Matchers
	FlannBasedMatcher matcher;
	vector< DMatch > matches;
	matcher.match(descriptors_img1, descriptors_img2, matches);
	double max_dist = 0, min_dist = 100;
	// to find the max and min distances between keypoints in matches
	for (int i = 0; i < descriptors_img1.rows; i++)
	{
		double dist = matches[i].distance;
		if (dist < min_dist) min_dist = dist;
		if (dist > max_dist) max_dist = dist;
	}
	cout << "Max distance : " << max_dist << endl;
	cout << "Min distance : " << min_dist << endl;
	//-- Use only "good" matches (i.e. whose distance is less than 3*min_dist )
	std::vector< DMatch > good_matches;
	for (int i = 0; i < descriptors_img1.rows; i++){
		if (matches[i].distance < 3 * min_dist)
		{
			good_matches.push_back(matches[i]);
		}
	}
	//Localize the object
	vector< Point2f > img1_obj;
	vector< Point2f > img2_scene;
	for (int i = 0; i < good_matches.size(); i++)
	{
		// Get the keypoints from the good matches
		img1_obj.push_back(keypoints1[good_matches[i].queryIdx].pt);
		img2_scene.push_back(keypoints2[good_matches[i].trainIdx].pt);
	}
	cout << "second step is completed" << endl;
	cout << "third step: find the Homography Matrix\n";
	Mat H = findHomography(img2_scene, img1_obj, CV_RANSAC);
	cout << "third step is completed" << endl;
	cout << "fourth step: using the Homography Matrix to warp the images\n";
	Mat img2_warped, result;
	warpPerspective(img2, img2_warped, H, Size(img1.cols + img2.cols, img1.rows));
	result = img2_warped.clone();
	// Overwrite img2 on right end of final panorma image
	Mat roi(result, Rect(0, 0, img1.cols, img1.rows));
	img1.copyTo(roi);
	cout << "fourth step is completed" << endl;
	// show the result image
	char filename[200];
	sprintf_s(filename,"E:/visual stduio codes/image processing codes/Panaroma/Panaroma_images/result.jpg");
	imwrite(filename, result);

	imshow("Result", result);
	waitKey(0);
	return 0;
}
