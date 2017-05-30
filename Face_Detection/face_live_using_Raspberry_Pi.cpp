#include <iostream>
#include <vector>
#include <opencv2/objdetect/objdetect.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>

using namespace std;
using namespace cv;

vector <Mat> crop;

int main(){
VideoCapture cap(0); // open the webcam
	if (!cap.isOpened())  // check if we succeeded
		return -1;
	vector<Rect>face; // keeps the rect information to draw
	CascadeClassifier cascade;
	// address of the cascade classifier (...data/haarcascades/haarcascade_frontalcatface.xml)
	cascade.load("/home/pi/opencv-3.1.0/data/haarcascades/haarcascade_frontalface_alt.xml");
	
		namedWindow("FACE DETECTION", 1);
	for (;;)
	{
		Mat frame,grayframe;
		cap >> frame; // get a new frame from camera
		cvtColor(frame, grayframe, COLOR_BGR2GRAY); // converts gray frame
		cascade.detectMultiScale(grayframe, face, 1.1, 3, 0, Size(50, 50), Size(300, 300));

		for (int i = 0; i < face.size(); i++) {
			Rect r = face.at(i);
			cout << r << endl;
			rectangle(frame, r, CV_RGB(150, 185, 215), 2, 8, 0);
			Mat crop_img = frame(r);
			resize(crop_img, crop_img, Size(), 2, 2, 1); // third parameter represents the output size
			crop.push_back(crop_img);  // all images are stored in a vector
			imshow("crop", crop_img);
		}
		imshow("FACE DETECTION", frame);
		if (waitKey(30) >= 0) break;
	}
	// the camera will be deinitialized automatically in VideoCapture destructor

	return 0;


}