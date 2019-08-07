function [centre] = cent(p,data,c)
[row,column]=size(data);
for i=1:c
    for j=1:column
        centre(i,j)=(p(i,:)*data(:,j))/sum(p(i,:))
    end
end

end
