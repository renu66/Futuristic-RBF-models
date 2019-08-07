function[dist] = Distmatrix(d)
[row,column]=size(d);
for i=1:row
    for j=1:row
        dist(i,j)=sqrt(sum(((d(j,:)-d(i,:)).^2)));
    end;
end;
    
end