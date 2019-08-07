data=load('iris1.txt');
[row,column]=size(data);
x=data(:,1:column-1);
y=data(:,column);
%r = randperm(150, .3*row)'
%test=d(r,:);
v=1;
e(:,1)=find(y==0);
e(:,2)=find(y==1);
e(:,3)=find(y==2);
w1=x(e(:,1),:);
w2=x(e(:,2),:);
w3=x(e(:,3),:);
p=[length(find(y==0)),length(find(y==1)),length(find(y==2))];
p=p./row;
mean1=sum(w1)./length(w1);
mean2=sum(w2)./length(w2);
mean3=sum(w3)./length(w3);
var=w1;
for i=1:length(w1)
    var(i,:)=w1(i,:)-mean1;
end
std1=sqrt((sum(var.^2))/length(w2));

var=w2;
for i=1:length(w2)
    var(i,:)=w2(i,:)-mean2;
end
std2=sqrt((sum(var.^2))/length(w1));

var=w3;
for i=1:length(w3)
    var(i,:)=w3(i,:)-mean3;
end
std3=sqrt((sum(var.^2))/length(w2));

%let say x1=
x1=[6.5000,3.2000,5.1000,2.0000];
p0=p(1)*postprob(x1(1),mean1(1),std1(1))*postprob(x1(2),mean1(2),std1(2))*postprob(x1(3),mean1(3),std1(3))*postprob(x1(4),mean1(4),std1(4));
p1=p(2)*postprob(x1(1),mean2(1),std2(1))*postprob(x1(2),mean2(2),std2(2))*postprob(x1(3),mean2(3),std2(3))*postprob(x1(4),mean2(4),std2(4));
p2=p(3)*postprob(x1(1),mean3(1),std3(1))*postprob(x1(2),mean3(2),std3(2))*postprob(x1(3),mean3(3),std3(3))*postprob(x1(4),mean3(4),std3(4));

disp('         For x=6.5000,3.2000,5.1000,2.0000');
disp('         its class is')
if(p0>p1&&p0>p2)
    disp('         Iris-setosa');
elseif(p1>p0&&p1>p2)
    disp('         Iris-versicolor');
else
    disp('         Iris-virginica');
end

