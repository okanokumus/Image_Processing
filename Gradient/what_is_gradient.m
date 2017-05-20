% some works on directional gradients, magnitude and direction
clc
clear all
close all

% The Gradient Magnitude
% Tells us how quickly intensity is
% changing in the neighborhood of pixel
% (x,y) in the direction of the gradient.

% The Gradient Orientation
% Tells us how quickly intensity is
% changing in the neighborhood of pixel
% (x,y) in the direction of the gradient.

% reads an image and converts it into gray scale and double presicion
I = imread('peppers.png'); 
Igray = rgb2gray(I);
Idouble = im2double(Igray);

[Gx,Gy] = imgradientxy(Idouble,'Sobel'); % directional gradient of the image
figure
subplot(121);imshow(Gx,[]);
title('image gradient in x');
subplot(122);imshow(Gy,[]);
title('image gradient in y');

% Calculate the gradient magnitude and direction using the directional gradients
[Gmag, Gdir] = imgradient(Gx, Gy);
figure
subplot(121);imshow(Gmag,[]);
title('image gradient magnitude');
subplot(122);imshow(Gdir,[]);
title('image gradient direction');

% display the image gradient flow
figure
imshow(I)
hold on;
quiver(Gx,Gy);
quiver(-Gy,Gx,'r');
quiver(Gy,-Gx,'r');