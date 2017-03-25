clc
clear all
close all
clear variables
I=imread('pentagon.png');
I_gr=rgb2gray(I);
% STEP 1
E = edge(I_gr,'canny');
subplot(1,2,1); imshow(I)
title('original image')
subplot(1,2,2);  imshow(E)
title('edge map')
delta_teta=0.5; delta_rho= 1;
% step 2
[K,L,D,teta_range,rho_range]=sizeacc(E,delta_teta,delta_rho);
HT=zeros(K,L);
A=zeros(K,L); % firstly it will be copy of the HT, after that it will be used for compare HT 
% STEP 3
HT=calculaterho(E,HT,D);
% STEP 4
figure(3); imshow(HT,[0 max(HT(:))])
% STEP 5
B=comp8neigh(HT);
% STEP 6
n=5; % first 5 highest elements
[x,y,sorted_array]=sortandlist_n_highest(B,n);
figure(4); imshow(HT,[0 max(HT(:))])
hold on
for kk=1:1:n
plot(y(kk),x(kk),'r*');
end

% mapping x and y into the specific range
for i=1:1:n
    t(i)=(x(i)/2)-90.4;
    r(i)=(y(i)-D);
end
disp('coordinates (x,y) and (teta,rho) values in the form [x y teta rho]')
[x y t' r']

% STEP 7
figure(5); imshow(I)
hold on
 a= -1000:1000;
 b1 = (r(1) - a* cosd(t(1)) )/ sind(t(1));
 plot(b1,a,'y','LineWidth',2)
 b2 = (r(2) - a* cosd(t(2)) )/ sind(t(2));
 plot(b2,a,'r','LineWidth',2)
 b3 = (r(3) - a* cosd(t(3)) )/ sind(t(3));
 plot(b3,a,'g','LineWidth',2)
 b4 = (r(4) - a* cosd(t(4)) )/ sind(t(4));
 plot(b4,a,'b','LineWidth',2)
 b5 = (r(5) - a* cosd(t(5)) )/ sind(t(5));
 plot(b5,a,'w','LineWidth',2)

