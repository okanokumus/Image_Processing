clc
clear all
close all
% I=imread('castle.jpg');
I=imread('candy.bmp'); % for second part of question
% STEP 1: Read the "castle.jpg" image and display it. Convert to double.
figure(1)
imshow(I)
I_double=double(I);
[m n]=size(I(:,:,1));
% STEP 2: Extract the R, G and B components of the image. Form your data matrix X such that each
% row corresponds to a pixel and the columns correspond to R, G and B values.
R=I_double(:,:,1);
G=I_double(:,:,2);
B=I_double(:,:,3);
X=[R(:) G(:) B(:)];
% STEP 3
Kmax=20;
THR_K=100;
figure(2)
for K=2:1:Kmax
    [IDX, C, SUMD] = kmeans(X, K);
    ave_dist(K) = sum(SUMD(:))/(m*n);
    % STEP 4
    plot(K,ave_dist(K),'*','MarkerSize',5)
    hold on 
end
% plot([2:20],ave_dist(2:20))
% STEP 5
% Determine the smallest K* for which | ave_dist(K*) - ave_dist(K*+1) | < THR_K
% Set THR_K = 100.
for K=2:1:Kmax-1   
    if abs(ave_dist(K) - ave_dist(K+1)) < THR_K
        K_new=K;
        if(K_new>0)
        break
        end
    end    
end
% STEP 6
[IDX_new, C, SUMD] = kmeans(X, K_new);
% segmentation map
S=reshape(IDX_new,size(I,1),size(I,2));
figure(3)
imshow(S,[1 K_new]);
colormap(jet);




