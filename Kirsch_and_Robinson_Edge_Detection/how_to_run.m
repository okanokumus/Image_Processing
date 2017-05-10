% how to run the kirsch_robinson
clc
close all
current_folder = pwd; % take the current folder
path = [current_folder '\peppers.png']; % if you want you can edit the name of image
I = imread(path);
kirsch_robinson(I)