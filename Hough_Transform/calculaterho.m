function HT=calculaterho(E,HT,D)
% rho= x*cos(teta)+y*sin(teta)
delta_teta=0.5;
[x_nz,y_nz]=find(E); % to find nonzero elemnt indicies in the E matrix
for i=1:1:size(x_nz(:,1)) % to manipulate the nonzero element x and y
    for teta= -90:delta_teta:89.5;
        rho=cosd(teta)*x_nz(i)+sind(teta)*y_nz(i);
        rho=floor(rho+D); % to mapping rho value (transform the range from[-D D] to [1 K])
        teta_fl=floor(2*(teta+90.5)); % to mapping teta value(transform the range from[-90 89.5] to [1 L])
        HT(teta_fl,rho)=HT(teta_fl,rho)+1;
     end
end