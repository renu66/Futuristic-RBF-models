function [dist] = fuzzydist(centre,data)
[row,column]=size(centre)
for i=1:length(data)
    for j=1:row
        dist(i,j)=sqrt(sum((data(i,:)-centre(j,:)).^2))
    end
    
end
    
end