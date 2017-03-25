clc
clear all
close all

% read images
I_face = imread('face.jpg');

detector_face = vision.CascadeObjectDetector; 

% BBOX = step(detector,I) returns BBOX, an M-by-4 matrix defining
% M bounding boxes containing the detected objects
Bounding_Box_face = step(detector_face,I_face)
% BBOX, contains a four-element vector, [x y width height]
[number_of_faces , vector_elements_face] = size(Bounding_Box_face(:,:));

 imshow(I_face) 
 hold on
    if(number_of_faces ~= 0) % only reading from existing Bounding_Box_face
         % to compute center of the each face
        for i=1:number_of_faces
            x = Bounding_Box_face(i,1);
            y = Bounding_Box_face(i,2);
            width = Bounding_Box_face(i,3);
            height = Bounding_Box_face(i,4);
            x_center  = x + ceil(width/2);
            y_center  = y + ceil(height/2);
            rectangle('Position',Bounding_Box_face(i,:),'LineWidth',2,'EdgeColor','r');     
            plot(x_center,y_center,'*','LineWidth',2)
        end

    end
    
    hold off
    title('FACE DETECTION')
    % to break the endless loop press Ctrl+C
