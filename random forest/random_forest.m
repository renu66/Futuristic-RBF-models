function [randomForest_accuracy]=random_forest()
%data=load('Heirtrain.txt');
data1=load('Heir.txt');
dat=csvread('HT.csv');
data=dat*data1;
ds1=data;
[row,column]=size(data);
%let k=3;
k=3;
C=[];
for i=1:k
    C(i,:)=data(i,:);
end
d=[];
for i=1:k
    for j=1:row
        d(i,j)=sqrt(sum((C(i,:)-data(j,:)).^2));
    end
end
s=[];
l=d;
z=[];
for i=1:length(d)
    [v,v1]=min(d(:,i));
    d(:,i)=0;
    d(v1,i)=1;
end
t=d+1;
while(t~=d)
    siz=sum(d');
    t=d;
    C=d*data;
    for i=1:length(siz)
        C(i,:)=C(i,:)/siz(i);
    end
    for i=1:k
        for j=1:row
            d(i,j)=sqrt(sum((C(i,:)-data(j,:)).^2));
        end
    end
    l=d;
    for i=1:length(d)
        [v,v1]=min(d(:,i));
        d(:,i)=0;
        d(v1,i)=1;
    end
end
d=d';
d;
 
%data=load('iris1.txt');
%data=data(:,1:end-1);
%d=data(1:2,:)
%d1=data(51:52,:)
%d2=data(101:102,:)
%data=[d;d1;d2];
 
c=3;
%p1=round(rand(150,3));
p1=zeros(30,1);
p2=ones(30,1);
pl1=[p1;p2;p1;p2;p1;p1;p2;p1;p1;p1];
pl1=[pl1;0;0;0;1];
pl3=[p1;p1;p2;p1;p1;p2;p1;p2;p2;p1;0;1;1;0];
pl2=[p2;p1;p1;p1;p2;p1;p1;p1;p1;p2;1;0;0;0];
p=[pl1';pl2';pl3'];
centre=cent(p,data,c);
centre1=centre+1;
i=0;
while(centre~=centre1)
    if(i<25)
        dist=fuzzydist(centre,data);
        p1=update1(p,dist);
        [row1,column1]=size(p1);
        centre1=centre;
        centre=cent(p1',data,c);
        i=i+1;
    else
        break;
    end
end
for i=1:row1
    m=p1(i,1);
    for j=1:column1
        if(p1(i,j)>m)
            m=p1(i,j);
        end
    end
    for l=1:column1
        if(p1(i,l)==m)
            p1(i,l)=1;
        else
            p1(i,l)=0;
        end
    end
end
%disp('final classification')
%disp(p1);
dfs=0;
dfs1=0;
dg=0;
for i=1:row
    if(p1(i-dg,:)==d(i-dg,:))
        dfs1=dfs1+1;
    elseif(dg<50&&p1(i-dg,2)~=1&&p1(i-dg,1)~=1)
        data(i-dg,:)=[];
        p1(i-dg,:)=[];
        d(i-dg,:)=[];
        %dfs=dfs+1;
        dg=dg+1;
    else
    dfs=dfs+1;
    end
end
[r1,c1]=size(find(p1(:,1)==1));
[r2,c2]=size(find(p1(:,2)==1));
[r3,c3]=size(find(p1(:,3)==1));
%ds=find(p1(:,3)==1)
%for i=1:.8*r3
 %   ds1(ds(i)-i+1,:)=[];
%end
[r4,c4]=size(find(d(:,1)==1));
[r5,c5]=size(find(d(:,2)==1));
[r6,c6]=size(find(d(:,3)==1));
comparision=[r1,r2,r3;r4,r5,r6];
match=dfs1;
mismatch=dfs;
correlation=(match/(match+mismatch))*100;
 
%data=[];
%data=d;
y=[];
plll1=p1;
plll2=d;
for i=1:length(plll1)
    if(plll1(i,1)==1)
        y(i)=0;
    elseif(plll1(i,2)==1)
        y(i)=1;
    else
        y(i)=2;
    end
end
y=y';
data(:,end+1)=y;
y=[];
test=data(1:0.3*end,:);
train=data((.3*end):end ,:);
%data=load('iris1.txt');
[row121,column121]=size(train);
X=train(:,1:column121-1);
y=train(:,column121);
%cc=find(y==2)
%for i=1:length(cc)
%y(cc(i))=1;
%end

%tree = decisionTreeTrain( X, y);
%[row1212,column1212]=size(test);
%X1=test(:,1:column1212-1);
%y1=test(:,column1212);
%YY  = dtp( X1, tree );

%match=0;
%for i=1:length(y1)
%if(y1(i)==YY(i))
%match=match+1;
%end
%end
%accuracy=(match/length(y1))*100
[row1212,column1212]=size(test);
X1=test(:,1:column1212-1);
y1=test(:,column1212);
Y1=[];
Y2=[];
Y3=[];
Y4=[];






rng(5);
k=randperm(length(data));
trainx=data(k(1:floor(.7*length(data))),1:end-1);
testx=data(k(floor(.7*length(data)):end),1:end-1);
trainy=data(k(1:floor(.7*length(data))),end);
testy=data(k(floor(.7*length(data)):end),end);
tree=dTtrain(trainx,trainy);
YY1=dtp(testx,tree);




rng(25);
k=randperm(length(data));
trainx=data(k(1:floor(.7*length(data))),1:end-1);
%testx=data(k(floor(.7*length(data)):end),:);
trainy=data(k(1:floor(.7*length(data))),end);
%testy=data(k(floor(.7*length(data)):end),end);
tree=dTtrain(trainx,trainy);
YY2=dtp(testx,tree);



rng(35);
k=randperm(length(data));
trainx=data(k(1:floor(.7*length(data))),1:end-1);
%testx=data(k(floor(.7*length(data)):end),:);
trainy=data(k(1:floor(.7*length(data))),end);
%testy=data(k(floor(.7*length(data)):end),end);
tree=dTtrain(trainx,trainy);
YY3=dtp(testx,tree);




rng(45);
k=randperm(length(data));
trainx=data(k(1:floor(.7*length(data))),1:end-1);
%testx=data(k(floor(.7*length(data)):end),:);
trainy=data(k(1:floor(.7*length(data))),end);
%testy=data(k(floor(.7*length(data)):end),end);
tree=dTtrain(trainx,trainy);
YY4=dtp(testx,tree);







YY=[YY1,YY2,YY3,YY4];

for i=1:length(YY)
    maxx(i,1)=length(find(YY(i,:)==0));
    maxx(i,2)=length(find(YY(i,:)==1));
    maxx(i,3)=length(find(YY(i,:)==2));
end;

for i=1:length(maxx)
    if(maxx(i,1)==4||maxx(i,1)==3||maxx(i,1)==2)
        final_y(i)=0;
    elseif(maxx(i,2)==4||maxx(i,2)==3||maxx(i,2)==2)
        final_y(i)=1;
    else
        final_y(i)=2;
    end
end

match=0;
for i=1:length(final_y)
if(testy(i)==final_y(i))
match=match+1;
end
end
randomForest_accuracy=(match/length(final_y))*100;
end
        
        
        
       