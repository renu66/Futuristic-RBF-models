function[k,l] = min1(d)
[row1,col]=size(d);
k=1;
l=2;
for i=1:row1
    for j=1:col
        if(d(i,j)<d(k,l)&&(i~=j))
            k=i;
            l=j;
        end
    end;
end;
    
end