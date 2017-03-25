clc
close all
clear all

% Face detection using Viola-Jones Algorithm
% Detected face will be in a rectangle an center of the 
% rectangle point out with a star.
% Webcam will be used as input

webcamlist

% opens webcam and print the properties
cam = webcam('ASUS USB2.0 WebCam') % write the webcam name whatever you want

% Preview the image from the Webcam
% Display the video stream
% stream=preview(cam);

% creates a System object, detector, that detects objects 
% default: Face Detection
detector_face = vision.CascadeObjectDetector('MergeThreshold',16);

% we take snaphots within endless loop
while (1)
    img = snapshot(cam);


    % BBOX = step(detector,I) returns BBOX, an M-by-4 matrix defining
    % M bounding boxes containing the detected objects
    Bounding_Box_face = step(detector_face,img);
    % BBOX, contains a four-element vector, [x y width height]
    [number_of_faces , vector_elements_face] = size(Bounding_Box_face(:,:)); 
    
    % to compute center of the face
  imshow(img) 
  hold on
    if(number_of_faces ~= 0) % only reading from existing Bounding_Box_face
        % to draw the rectangles and point out center of all face
        for i=1:number_of_faces
            x = Bounding_Box_face(i,1);
            y = Bounding_Box_face(i,2);
            width = Bounding_Box_face(i,3);
            height = Bounding_Box_face(i,4);
            x_center = x + ceil(height/2);
            y_center = y + ceil(width/2);
            rectangle('Position',Bounding_Box_face(i,:),'LineWidth',2,'EdgeColor','r');
            plot(x_center, y_center, '*','LineWidth',2)
        end
    end
 
    hold off
    title('FACE DETECTION')
end

% to break the endless loop press Ctrl+C



 





