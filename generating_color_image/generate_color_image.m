clc
clear all
close all
A=double(zeros(300,300,3));
A(:,:,3)=1;% to set intensity value to 1
for i=1:1:300
    A(:,i,1)=i/300;% all of the i. column
    A(i,:,2)=i/300;
end
A_hsv=cat(3,A(:,:,1),A(:,:,2),A(:,:,3));
A_rgb=hsv2rgb(A_hsv);
figure(2)
imshow(A_hsv)
figure(1)
imshow(A_rgb)