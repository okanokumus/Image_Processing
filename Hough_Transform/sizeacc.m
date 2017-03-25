% to determine the size of hough table
function [K,L,D,teta_range,rho_range]=sizeacc(E,delta_teta,delta_rho)
[x y]=size(E);
D= floor(sqrt(x^2 + y^2));% for accurate result for L
K=0; L=0;
for m= -90:delta_teta:(90-delta_teta);
    K=K+1;
end
for n= -D:delta_rho:D;
    L=L+1;
end
teta_range= -90:delta_teta:89.5;
rho_range = -D:delta_rho:D;