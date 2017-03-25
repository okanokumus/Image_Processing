% to compare central pixel value with 8 neighborhood and 
% if it is greater than all its 8 neighbours keep it;
% if not set it to zero.

function B=comp8neigh(A)
[Kf,Lf]=size(A);
A = padarray(A,[1,1]); % for calculating border pixels' 8-neighborhood
[m,n]=size(A);
for i=2:1:m-1
    for j=2:1:n-1
         if A(i,j)<A(i-1,j-1)
              A(i,j)=0;
            
         elseif A(i,j)<A(i-1,j)
              A(i,j)=0;
         
         elseif A(i,j)<A(i-1,j+1)
              A(i,j)=0;
         
         elseif A(i,j)<A(i,j-1)
              A(i,j)=0;
         
         elseif A(i,j)<A(i,j+1)
              A(i,j)=0;
         
         elseif A(i,j)<A(i+1,j-1)
              A(i,j)=0;
         
         elseif A(i,j)<A(i+1,j)
              A(i,j)=0;
         elseif A(i,j)<A(i+1,j+1)
              A(i,j)=0;
         end
    end     
end
B=zeros(Kf,Lf);
% remove zero padding from matrix
for i=1:1:Kf
    for j=1:1:Lf
    B(i,j)=A(i+1,j+1);
    end
end