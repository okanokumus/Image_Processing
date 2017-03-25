clc
clear all
close all
% face detection using MATLAB built-in class and function
% MATLAB computer vision toolbox will be used
% Detect object using Viola-Jones algorithm
% vision.CascadeObjectDetector System object
% The cascade object detector uses the Viola-Jones algorithm
% to detect people's faces, noses, eyes, mouth, or upper body.

% read images
I_face = imread('face.jpg');
I_nose = imread('nose.jpg');
I_mouth = imread('mouth.jpg');
I_eyes = imread('eyes.jpg');
I_upperbody = imread('upperbody.jpg');
% The ClassificationModel property controls the type of object to detect.
% By default, the detector is configured to detect faces.
% detector = vision.CascadeObjectDetector(Model);
% Model can be  'FrontalFaceCART', 'UpperBody', and 'ProfileFace'.
% you can find model and syntax from here;
% < https://www.mathworks.com/help/vision/ref/vision.cascadeobjectdetector-class.html>

%% PART 1 : FACE DETECTION
% creates a System object, detector, that detects objects 
% using the Viola-Jones algorithm
% default: Face Detection
detector_face = vision.CascadeObjectDetector; 

% BBOX = step(detector,I) returns BBOX, an M-by-4 matrix defining
% M bounding boxes containing the detected objects
Bounding_Box_face = step(detector_face,I_face);
% BBOX, contains a four-element vector, [x y width height]
[number_of_faces , vector_elements_face] = size(Bounding_Box_face(:,:));

% draw rectangle on the faces
figure(1)
imshow(I_face); 
hold on
for i = 1:number_of_faces
    rectangle('Position',Bounding_Box_face(i,:),'LineWidth',2,'EdgeColor','r');
end
hold off
title('FACE DETECTION')

%% PART 2 : NOSE DETECTION
% nose detection
detector_nose = vision.CascadeObjectDetector('Nose','MergeThreshold',16);
% ('MergeThreshold',16) is used to suppress false detection
% default value for 'MergeThreshold' is 4 and when this value is used an
% error is occured. to try to comment line 45 and run PART 2 with below comment
% detector_nose = vision.CascadeObjectDetector('Nose');

Bounding_Box_nose = step(detector_nose,I_nose);
% BBOX, contains a four-element vector, [x y width height]
[number_of_noses , vector_elements_nose] = size(Bounding_Box_nose(:,:));

% draw rectangle on the faces
figure(2)
imshow(I_nose); 
hold on
for i = 1:number_of_noses
    rectangle('Position',Bounding_Box_nose(i,:),'LineWidth',2,'EdgeColor','r');
end
hold off
title('NOSE DETECTION')

%% PART 3 : EYES DETECTION
% eyes detection
detector_eyes = vision.CascadeObjectDetector('EyePairBig');

Bounding_Box_eyes = step(detector_eyes,I_eyes);
% BBOX, contains a four-element vector, [x y width height]
[number_of_eyes , vector_elements_eyes] = size(Bounding_Box_eyes(:,:));

% draw rectangle on the faces
figure(3)
imshow(I_eyes); 
hold on
for i = 1:number_of_eyes
    rectangle('Position',Bounding_Box_eyes(i,:),'LineWidth',2,'EdgeColor','r');
end
hold off
title('EYES DETECTION')

%% PART 4 : MOUTH DETECTION
% mouth detection
detector_mouth = vision.CascadeObjectDetector('Mouth','MergeThreshold',64);

Bounding_Box_mouth = step(detector_mouth,I_mouth);
% BBOX, contains a four-element vector, [x y width height]
[number_of_mouth , vector_elements_mouth] = size(Bounding_Box_mouth(:,:));

% draw rectangle on the faces
figure(4)
imshow(I_mouth); 
hold on
for i = 1:number_of_mouth
    rectangle('Position',Bounding_Box_mouth(i,:),'LineWidth',2,'EdgeColor','r');
end
hold off
title('MOUTH DETECTION')

%% PART 5 : UPPER BODY DETECTION
% upper body detection
detector_upperbody = vision.CascadeObjectDetector('UpperBody','MergeThreshold',16);
detector_upperbody.MinSize = [60 60];

Bounding_Box_upperbody = step(detector_upperbody,I_upperbody);
% BBOX, contains a four-element vector, [x y width height]
[number_of_upperbodies , vector_elements_upperbody] = size(Bounding_Box_upperbody(:,:));

% draw rectangle on the faces
figure(5)
imshow(I_upperbody); 
hold on
for i = 1:number_of_upperbodies
    rectangle('Position',Bounding_Box_upperbody(i,:),'LineWidth',2,'EdgeColor','r');
end
hold off
title('UPPER BODY DETECTION')