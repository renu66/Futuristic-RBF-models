function [YY]=dtp( X, tr )
N=length(X);
YY=zeros(N, 1);
for i=1:N
    ttr=tr;
    while (~ttr.l)
        fi=ttr.c(1,1);
        threshold=ttr.c(1,2);
        if(X(i,fi)>=threshold)
            ttr=ttr.left;
        else
            ttr=ttr.right;
        end
    end
    YY(i)=ttr.res;
end
end