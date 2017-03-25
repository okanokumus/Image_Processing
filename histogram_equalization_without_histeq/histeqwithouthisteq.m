clc
clear all
close all
A=imread('house.png');
[m,n]=size(A);
A_double=double(A);
for i=0:255
x=A_double(A_double(:,:)==i);
h(i+1)=length(x);
end
figure(1);
subplot(1,2,1),bar(h);
title('histogram of an image') 
subplot(1,2,2),imshow(histeq(A));
title('histogram equalization with histeq')
figure(3),imhist(histeq(A))
title('imhist of equalized histogram')
sm=0; s=zeros(256);
for k=0:255
sm=sum(h(1:k+1));
s(k+1)=255*sm/(m*n);
A_double(A_double(:,:) == k) = s(k+1);
end
% histogram of the output image
A_int = uint8(A_double);
cs = double(A_int);
for i=0:255
de = cs(cs(:,:)== i);
h_eq(i+1)=length(de);
end
figure(2);
subplot(1,2,1),bar(h_eq);
title('histogram of an image') 
subplot(1,2,2),imshow(A_int);
title('histogram equalization with my own program')