clear all;

close all;

A = imread('house.png');

figure(1);

imshow(A);

title('Original Image');

A = double(A);

laplacian_mask = [0 -1 0;-1 4 -1;0 -1 0];

% laplacian_mask = [-1 -1 -1;-1 8 -1;-1 -1 -1];

L = imfilter(A,laplacian_mask);

figure(2);

imshow(abs(L),[0 max(abs(L(:)))]);

title('Absolute value of the image after Laplacian filtering');

figure(3);

imshow(L,[min(L(:)) max(L(:))]);

title('Image after Laplacian filtering');

C = 5*randn(size(A)); % Gaussian noise image with std 5

A_noisy = C+A;

figure(4);

imshow(A_noisy,[0 255]);

title('Noisy Image');

L_noisy = imfilter(A_noisy,laplacian_mask);

figure(5);

imshow(abs(L_noisy),[0 max(abs(L_noisy(:)))]);

title('Absolute value of the noisy image after Laplacian filtering');

figure(6);

imshow(L_noisy,[min(L_noisy(:)) max(L_noisy(:))]);

title('Noisy image after Laplacian filtering');