% Okan Okumus
% okanokumuss@gmail.com

% there are two steps to run code
% 1. I = imread('image.jpg');
% 2. kirsch_robinson( I )

function kirsch_robinson( I )
% I is RGB image as an input in this function
% Igray is grayscale of the original image 
Igray = rgb2gray(I);
im_double=double(Igray); % converts double presicion
% Eight directions Kirsch edge masks. below masks are gettting from
% rotation of the one mask.
g1=[5,5,5; -3,0,-3; -3,-3,-3]; % South
g2=[5,5,-3; 5,0,-3; -3,-3,-3]; % Southeast
g3=[5,-3,-3; 5,0,-3; 5,-3,-3]; % East
g4=[-3,-3,-3; 5,0,-3; 5,5,-3]; 
g5=[-3,-3,-3; -3,0,-3; 5,5,5];
g6=[-3,-3,-3; -3,0,5;-3,5,5];
g7=[-3,-3,5; -3,0,5;-3,-3,5];
g8=[-3,5,5; -3,0,5;-3,-3,-3];
% filtering with Kirsch mask
% edges in all the direction
% Each mask respondsmaximally to an edge oriented in a particular general
% direction. The maximum value over all eight orientations
% is the output value for the edge magnitude image.
x1=imfilter(im_double,g1,'replicate');
x2=imfilter(im_double,g2,'replicate');
x3=imfilter(im_double,g3,'replicate');
x4=imfilter(im_double,g4,'replicate');
x5=imfilter(im_double,g5,'replicate');
x6=imfilter(im_double,g6,'replicate');
x7=imfilter(im_double,g7,'replicate');
x8=imfilter(im_double,g8,'replicate');

y1=max(x1,x2);
y2=max(y1,x3);
y3=max(y2,x4);
y4=max(y3,x5);
y5=max(y4,x6);
y6=max(y5,x7);
result_image=max(y6,x8); % result image
figure
subplot(121);imshow (result_image,[0 255]);
title ('Kirsch Operator')

% The Robinson operator
% There is no fixed mask. You can take any mask and you have to rotate it to
% find edges in all the above mentioned directions. All the masks are rotated 
% on the bases of direction of zero columns
% Eight directions Robinson edge masks. below masks are gettting from
% rotation of the one mask.
g1=[-1, 0, 1; -2, 0, -2; -1, 0, 1]; % NORTH DIRECTION MASK
g2=[0, 1, 2; -1 , 0, 1; -2, -1, 0]; % NORTH WEST DIRECTION MASK
g3=[1, 2, 1; 0, 0, 0; -1, -2, -1]; % WEST DIRECTION MASK
g4=[2, 1, 0; 1, 0, -1; 0, -1, -2]; % SOUTH WEST DIRECTION MASK
g5=[1, 0, -1; 2, 0,-2; 1, 0, -1]; % SOUTH DIRECTION MASK
g6=[0,-1,-2; 1, 0, -1; 2, 1, 0]; % SOUTH EAST DIRECTION MASK
g7=[-1, -2, -1; 0,0,0;1, 2, 1]; %EAST DIRECTION MASK
g8=[-2, -1 ,0; -1, 0, 1; 0, 1, 2]; % NORTH EAST DIRECTION MASK
% filtering with Robinson mask
% edges in all the direction
% Each mask respondsmaximally to an edge oriented in a particular general
% direction. The maximum value over all eight orientations
% is the output value for the edge magnitude image.
x1=imfilter(im_double,g1,'replicate');
x2=imfilter(im_double,g2,'replicate');
x3=imfilter(im_double,g3,'replicate');
x4=imfilter(im_double,g4,'replicate');
x5=imfilter(im_double,g5,'replicate');
x6=imfilter(im_double,g6,'replicate');
x7=imfilter(im_double,g7,'replicate');
x8=imfilter(im_double,g8,'replicate');

y1=max(x1,x2);
y2=max(y1,x3);
y3=max(y2,x4);
y4=max(y3,x5);
y5=max(y4,x6);
y6=max(y5,x7);
result_image=max(y6,x8); % result image 
subplot(122); imshow(result_image,[0 255]);
title ('Robinson Operator')
end

