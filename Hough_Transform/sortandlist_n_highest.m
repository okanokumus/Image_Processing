function [X,Y,sorted_array]=sortandlist_n_highest (B,n)

[sorted_array, pos]=sort(B(:),'descend'); 
sorted_array=sorted_array(1:n,1);
pos(1:n,1);
[X,Y]=ind2sub(size(B),pos(1:n,1));