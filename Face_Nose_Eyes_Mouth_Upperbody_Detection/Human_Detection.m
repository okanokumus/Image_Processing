clc
close all
clear all
% upright people detection using HOG features
% upright people will be detected and a rectangle and its center point wil be drawn
% on it

% From Mathwork: 
% The people detector object detects people in an input image using the 
% Histogram of Oriented Gradient (HOG) features
% and a trained Support Vector Machine (SVM) classifier. 
% The object detects unoccluded people in an upright position.

% reads image
I=imread('human.jpg');

% Creta a people detector
detector_human = vision.PeopleDetector;

% Step:	Detect upright people using HOG features
[Bounding_Box_person,SCORE] = step(detector_human,I);
% SCORE values represent the confidence of detection

% BBOX = step(detector,I) returns BBOX, an M-by-4 matrix defining
% M bounding boxes containing the detected objects

% BBOX, contains a four-element vector, [x y width height]
[number_of_person , vector_elements_person] = size(Bounding_Box_person(:,:));

%shows image and draw rectangle on the people
%shows image and draw rectangle on the people
imshow(I); 
hold on
for i = 1:number_of_person
            % compute the center points of the detected person
            x = Bounding_Box_person(i,1);
            y = Bounding_Box_person(i,2);
            width = Bounding_Box_person(i,3);
            height = Bounding_Box_person(i,4);
            x_center = x + ceil(width/2);
            y_center = y + ceil(height/2);
            % draws rectangle
            rectangle('Position',Bounding_Box_person(i,:),'LineWidth',2,'EdgeColor','r');
            % puts a '*' to the center
            plot(x_center, y_center, '*','LineWidth',2)
end
hold off
title('PEOPLE DETECTION')

