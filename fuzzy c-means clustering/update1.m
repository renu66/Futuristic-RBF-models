function [p1] = update1(p,dist)
[row,column]=size(dist)
for i=1:row
    for j=1:column
        if((sum((dist(i,j)./dist(i,:)).^2))~=0)
            if(dist(i,:)~=0)
                p1(i,j)=1/(sum((dist(i,j)./dist(i,:)).^2));
            else
                for k=1:column
                    if(dist(i,k)==0)
                        dist(i,k)=0.0001;
                    end
                end
                p1(i,j)=1/(sum((dist(i,j)./dist(i,:)).^2));
            end
        else
            p1(i,j)=1;
    end
end
end