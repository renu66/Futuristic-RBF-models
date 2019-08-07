function [tr]=dTtrain( X, y)
f_imp=-1;
ftr=0;
ffi=0;
fl1=[];
fl2=[];
fr1=[];
fr2=[];
tr=struct('l',false,'c','null','left','null','right','null','res','null');
[N,d]=size(X);
l=unique(y);
lc=length(l);
%if(size(unique(X,'rows'),1)==1)
%    tr.l=true;
%    tr.res=mode(y);
%    return;
%end
Sx=sort(X);
if(lc==1)
    tr.l=true;
    tr.res=y(1);
    return;
end
for fi=1:d
    for i=1:N-1
        threshold=(Sx(i,fi)+Sx(i+1,fi))/2;
        htc1=0;
        htc2=0;
        h1=zeros(lc,1);
        h2=zeros(lc,1);
        l1=zeros(N,d);
        r1=zeros(N,d);
        l2=zeros(N,1);
        r2=zeros(N,1);
        for j=1:N
           if(X(j,fi)>=threshold)
               htc1=htc1+1;
               li=find(l==y(j));
               h1(li)=h1(li)+1;
               l1(htc1,:)=X(j,:);
               l2(htc1)=y(j);
           else
               htc2=htc2+1;
               li=find(l==y(j));
               h2(li)=h2(li)+1;
               r1(htc2,:)=X(j,:);
               r2(htc2)=y(j);
           end
        end
        hi1=1-sum((h1/htc1).^2);
        hi2=1-sum((h2/htc2).^2);
        imp=htc1/N*hi1+htc2/N*hi2;
        if((f_imp==-1)||(f_imp>imp))
            f_imp=imp;
            ffi=fi;
            ftr=threshold;
            fl1=l1(1:htc1,:);
            fl2=l2(1:htc1,:);
            fr1=r1(1:htc2,:);
            fr2=r2(1:htc2,:);
        end
    end
end
tr.c=[ffi,ftr];
tr.left=dTtrain(fl1,fl2);
tr.right=dTtrain(fr1,fr2);
end