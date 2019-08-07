
clc;
clear all;
close all;
qwer1=[];
%data=load('XORrbf.txt')
rng(30);
data=rand(447,1)-0.5;
for i=1:length(data)
    if(data(i)>0)
        data(i)=1;
    else
        data(i)=-1;
    end
end
data=[0;0;0;data];
for i=1:length(data)-3
    d(i,:)=[data(i),data(i+1),data(i+2)];
end
data=d;
size_data=size(data);
lr1=.00002;
lr2=.00002;
no_grp=2;  
no_nodes=3;
in=3;
n0=size_data(1);
n=size_data(1)/no_grp;
weights =rand(1,no_nodes);
weights=[0,0,0];
r=randi(size_data(1),1,2);
r=[1,4,78];
c=data(r,1:3);
c=[0.9,0.9,0.1;0,0,0.3;0.1,.56,1.2]
bias=0;
r=randperm(4);
mean1=sum(data(:,1))/length(data(:,1));
mean2=sum(data(:,2))/length(data(:,2));
mean3=sum(data(:,3))/length(data(:,3));
std1=sqrt(sum((data(:,1)-mean1).^2)/(length(data(:,1))-1));
std2=sqrt(sum((data(:,2)-mean2).^2)/(length(data(:,2))-1));
std3=sqrt(sum((data(:,3)-mean3).^2)/(length(data(:,3))-1));
y1=.304*data(:,1)+.903*data(:,2)+.304*data(:,3);
y2=tan(y1);
y2=awgn(y2,30);
data(:,end+1)=y2;
q1=0;
for i=1:5000
    for k=1:150
        z1(k)=dist(data(k,1:3),c(1,:));
        z2(k)=dist(data(k,1:3),c(2,:));
        z3(k)=dist(data(k,1:3),c(3,:));
        phi1(k)=exp(-((z1(k))^2)/(2*(std1^2)));
        phi2(k)=exp(-((z2(k))^2)/(2*(std2^2)));
        phi3(k)=exp(-((z3(k))^2)/(2*(std3^2)));
        phi=[phi1(k) phi2(k) phi3(k)];
        y(k)=((phi1(k)*weights(1,1))+(phi2(k)*weights(1,2))+(phi3(k)*weights(1,3)));
        y(k)=y(k)+bias;
        for j=1:no_nodes
            c(j,:)=c(j,:) + lr1*(data(k,in+1) -y(k))*weights(j)*(phi(j)*2) *(data(k,1:3)-c(j,:));
            weights(j)=weights(j) + lr2*(data(k,in+1) -y(k))*phi(j);
        end
        e(k)=data(k,in+1) -y(k);
    end
    err(i)=mse(e);
    if(i==1)
        err11(i)=mse(e);
    else
       err11(i)=mse(e)/err11(1); 
    end
    %err(i)=err(i)/err(1);
    %err11(i)=err(i);
    if(i>1)
        if(err11(i)<0.4&&q1==0)
            con1(1)=err(i);
            coniter1(1)=i;
            q1=q1+1;
        end
    end;
end
%con1(1)=con1(1)/max(err);
err=err/max(err);
con1(1)=err(end);
con1(1)=con1(1)/max(err);
figure(21);
plot(err,'LineWidth',2);
txt='\leftarrow model 1'
text(100,err(100),txt)
hold on;
xlabel('iteration');



rng(45);
test=rand(30,1)-.5;
for i=1:length(test)
    if(test(i)>0)
        test(i)=1;
    else
        test(i)=-1;
    end
end
test=[0;0;0;test];
for i=1:length(test)-3
    di(i,:)=[test(i),test(i+1),test(i+2)];
end
y1=[];
y2=[];
test=di;
y1=.304*test(:,1)+.903*test(:,2)+.304*test(:,3);
y2=tan(y1);
y2=awgn(y2,30);
test(:,end+1)=y2;
for i=1:length(test)
    z11=dist(test(i,1:3),c(1,:));
    z22=dist(test(i,1:3),c(2,:));
    z33=dist(test(i,1:3),c(3,:));
    phi11=exp(-((z11)^2)/(2*(std1^2)));
    phi22=exp(-((z22)^2)/(2*(std2^2)));
    phi33=exp(-((z33)^2)/(2*(std3^2)));
    x1(i)=((phi11*weights(1,1))+(phi22*weights(1,2))+(phi33*weights(1,3)));
    x1(i)=x1(i)+bias;
end
qwer1(1)=sum(abs(x1'-y2))/length(x1);






%data=load('XORrbf.txt')
rng(30);
data=rand(447,1)-0.5;
for i=1:length(data)
    if(data(i)>0)
        data(i)=1;
    else
        data(i)=-1;
    end
end
data=[0;0;0;data];
for i=1:length(data)-3
    d(i,:)=[data(i),data(i+1),data(i+2)];
end
data=d;
size_data=size(data);
lr1=.00002;
lr2=.00002;
lr3=.00001;
no_grp=2;  
no_nodes=3;
in=3;
n0=size_data(1);
n=size_data(1)/no_grp;
weights =rand(1,no_nodes);
weights=[0,0,0];
r=randi(size_data(1),1,2);
r=[1,4,78];
c=data(r,1:3);
c=[0.9,0.9,0.1;0,0,0.3;0.1,.56,1.2]
bias=0;
r=randperm(4);
mean1=sum(data(:,1))/length(data(:,1));
mean2=sum(data(:,2))/length(data(:,2));
mean3=sum(data(:,3))/length(data(:,3));
std1=sqrt(sum((data(:,1)-mean1).^2)/(length(data(:,1))-1));
std2=sqrt(sum((data(:,2)-mean2).^2)/(length(data(:,2))-1));
std3=sqrt(sum((data(:,3)-mean3).^2)/(length(data(:,3))-1));
y1=.304*data(:,1)+.903*data(:,2)+.304*data(:,3);
y2=tan(y1);
y2=awgn(y2,30);
data(:,end+1)=y2;
q1=0;
for i=1:5000
    for k=1:150
        z1(k)=dist(data(k,1:3),c(1,:));
        z2(k)=dist(data(k,1:3),c(2,:));
        z3(k)=dist(data(k,1:3),c(3,:));
        phi1(k)=exp(-((z1(k))^2)/(2*(std1^2)));
        phi2(k)=exp(-((z2(k))^2)/(2*(std2^2)));
        phi3(k)=exp(-((z3(k))^2)/(2*(std3^2)));
        phi=[phi1(k) phi2(k) phi3(k)];
        y(k)=((phi1(k)*weights(1,1))+(phi2(k)*weights(1,2))+(phi3(k)*weights(1,3)));
        y(k)=y(k)+bias;
        for j=1:no_nodes
            c(j,:)=c(j,:) + lr1*(data(k,in+1) -y(k))*weights(j)*(phi(j)*2) *(data(k,1:3)-c(j,:));
            weights(j)=weights(j) + lr2*(data(k,in+1) -y(k))*phi(j);
            std1=std1+lr3*((data(k,in+1) -y(k))*weights(1))*(z1(k)*phi1(k))/(std1^3);
            std2=std2+lr3*((data(k,in+1) -y(k))*weights(2))*(z2(k)*phi2(k))/(std2^3);
            std3=std3+lr3*((data(k,in+1) -y(k))*weights(3))*(z3(k)*phi3(k))/(std3^3);
        end
        e(k)=data(k,in+1) -y(k);
    end
    err(i)=mse(e);
    if(i==1)
        err11(i)=mse(e);
    else
       err11(i)=mse(e)/err11(1); 
    end
    if(i>1)
        if(err11(i)<0.4&&q1==0)
            con1(2)=err(i);
            coniter1(2)=i;
            q1=q1+1;
        end
    end;
end
%con1(2)=con1(2)/max(err);
err=err/max(err);
con1(2)=err(end);
con1(2)=con1(2)/max(err);
figure(21);
plot(err,'LineWidth',2);
txt='\leftarrow model 2'
text(300,err(300),txt)
%title('Mean Square Error___MODEL_1');
xlabel('iteration');



rng(45);
test=rand(30,1)-.5;
for i=1:length(test)
    if(test(i)>0)
        test(i)=1;
    else
        test(i)=-1;
    end
end
test=[0;0;0;test];
for i=1:length(test)-3
    di(i,:)=[test(i),test(i+1),test(i+2)];
end
y1=[];
y2=[];
test=di;
y1=.304*test(:,1)+.903*test(:,2)+.304*test(:,3);
y2=tan(y1);
y2=awgn(y2,30);
test(:,end+1)=y2;
for i=1:length(test)
    z11=dist(test(i,1:3),c(1,:));
    z22=dist(test(i,1:3),c(2,:));
    z33=dist(test(i,1:3),c(3,:));
    phi11=exp(-((z11)^2)/(2*(std1^2)));
    phi22=exp(-((z22)^2)/(2*(std2^2)));
    phi33=exp(-((z33)^2)/(2*(std3^2)));
    x(i)=((phi11*weights(1,1))+(phi22*weights(1,2))+(phi33*weights(1,3)));
    x(i)=x(i)+bias;
end
qwer1(2)=sum(abs(x'-y2))/length(x);













rng(30);
data=rand(447,1)-0.5;
for i=1:length(data)
    if(data(i)>0)
        data(i)=1;
    else
        data(i)=-1;
    end
end
data=[0;0;0;data];
for i=1:length(data)-3
    d(i,:)=[data(i),data(i+1),data(i+2)];
end
data=d;
size_data=size(data);
lr1=.00005;
lr2=.00005;
lr3=.0001;
no_grp=2;  
no_nodes=3;
in=3;
n0=size_data(1);
n=size_data(1)/no_grp;
weights =rand(1,no_nodes);
weights=[0,0,0];
r=randi(size_data(1),1,2);
r=[1,4,78];
c=data(r,1:3);
c=[0.9,0.9,0.1;0,0,0.3;0.1,.56,1.2]
bias=0;
r=randperm(4);
mean1=sum(data(:,1))/length(data(:,1));
mean2=sum(data(:,2))/length(data(:,2));
mean3=sum(data(:,3))/length(data(:,3));
std1=sqrt(sum((data(:,1)-mean1).^2)/(length(data(:,1))-1));
std2=sqrt(sum((data(:,2)-mean2).^2)/(length(data(:,2))-1));
std3=sqrt(sum((data(:,3)-mean3).^2)/(length(data(:,3))-1));
y1=.304*data(:,1)+.903*data(:,2)+.304*data(:,3);
y2=tan(y1);
y2=awgn(y2,30);
data(:,end+1)=y2;
weights1=[0,0,0;.1,.4,0.2;0,.7,.9]
lr4=.0006;
std=[std1,std2,std3];
q1=0;
for i=1:5000
    for k=1:150
        z1(k)=sqrdist(data(k,1:3),c(1,:),weights1(1,:));
        z2(k)=sqrdist(data(k,1:3),c(2,:),weights1(2,:));
        z3(k)=sqrdist(data(k,1:3),c(3,:),weights1(3,:));
        phi1(k)=exp(-((z1(k))^2)/(2*(std1^2)));
        phi2(k)=exp(-((z2(k))^2)/(2*(std2^2)));
        phi3(k)=exp(-((z3(k))^2)/(2*(std3^2)));
        phi=[phi1(k) phi2(k) phi3(k)];
        y(k)=((phi1(k)*weights(1,1))+(phi2(k)*weights(1,2))+(phi3(k)*weights(1,3)));
        y(k)=y(k)+bias;
        for j=1:no_nodes
            c(j,:)=c(j,:) + lr1*(data(k,in+1) -y(k))*weights(j)*(phi(j)*2) *(data(k,1:3)-c(j,:));
            weights(j)=weights(j) + lr2*(data(k,in+1) -y(k))*phi(j);
            weights1(j,:)=weights1(j,:) - lr4*(data(k,in+1) -y(k))*weights(j)*((phi(j)/std(j)^2)) *(data(k,1:3)-c(j,:))*data(k,j);
            %std1=std1+lr3*((data(k,in+1) -y(k))*weights(1))*(z1(k)*phi1(k))/(std1^3);
            %std2=std2+lr3*((data(k,in+1) -y(k))*weights(2))*(z2(k)*phi2(k))/(std2^3);
            %std3=std3+lr3*((data(k,in+1) -y(k))*weights(3))*(z3(k)*phi3(k))/(std3^3);
        end
        e(k)=data(k,in+1) -y(k);
    end
    err(i)=mse(e);
    if(i==1)
        err11(i)=mse(e);
    else
       err11(i)=mse(e)/err11(1); 
    end
    if(i>1)
        if(err11(i)<0.4&&q1==0)
            con1(3)=err(i);
            coniter1(3)=i;
            q1=q1+1;
        end
    end;
end
%con1(3)=con1(3)/max(err);
err=err/max(err);
con1(3)=err(end);
con1(3)=con1(3)/max(err);
figure(21);
plot(err,'LineWidth',2);
txt='\leftarrow model 3'
text(500,err(500),txt)
%hold on;
%title('Mean Square Error___MODEL_1');
xlabel('iteration');



rng(45);
test=rand(30,1)-.5;
for i=1:length(test)
    if(test(i)>0)
        test(i)=1;
    else
        test(i)=-1;
    end
end
test=[0;0;0;test];
for i=1:length(test)-3
    di(i,:)=[test(i),test(i+1),test(i+2)];
end
y1=[];
y2=[];
test=di;
y1=.304*test(:,1)+.903*test(:,2)+.304*test(:,3);
y2=tan(y1);
y2=awgn(y2,30);
test(:,end+1)=y2;
for i=1:length(test)
    z11=sqrdist(test(i,1:3),c(1,:),weights1(1,:));
    z22=sqrdist(test(i,1:3),c(2,:),weights1(2,:));
    z33=sqrdist(test(i,1:3),c(3,:),weights1(3,:));
    phi11=exp(-((z11)^2)/(2*(std1^2)));
    phi22=exp(-((z22)^2)/(2*(std2^2)));
    phi33=exp(-((z33)^2)/(2*(std3^2)));
    x3(i)=((phi11*weights(1,1))+(phi22*weights(1,2))+(phi33*weights(1,3)));
    x3(i)=x3(i)+bias;
end
qwer1(3)=sum(abs(x3'-y2))/length(x3);















rng(30);
data=rand(447,1)-0.5;
for i=1:length(data)
    if(data(i)>0)
        data(i)=1;
    else
        data(i)=-1;
    end
end
data=[0;0;0;data];
for i=1:length(data)-3
    d(i,:)=[data(i),data(i+1),data(i+2)];
end
data=d;
size_data=size(data);
lr1=.00005;
lr2=.00005;
lr3=.00001;
no_grp=2;  
no_nodes=3;
in=3;
n0=size_data(1);
n=size_data(1)/no_grp;
weights =rand(1,no_nodes);
weights=[0,0,0];
r=randi(size_data(1),1,2);
r=[1,4,78];
c=data(r,1:3);
c=[0.9,0.9,0.1;0,0,0.3;0.1,.56,1.2]
bias=0;
r=randperm(4);
mean1=sum(data(:,1))/length(data(:,1));
mean2=sum(data(:,2))/length(data(:,2));
mean3=sum(data(:,3))/length(data(:,3));
std1=sqrt(sum((data(:,1)-mean1).^2)/(length(data(:,1))-1));
std2=sqrt(sum((data(:,2)-mean2).^2)/(length(data(:,2))-1));
std3=sqrt(sum((data(:,3)-mean3).^2)/(length(data(:,3))-1));
y1=.304*data(:,1)+.903*data(:,2)+.304*data(:,3);
y2=tan(y1);
y2=awgn(y2,30);
data(:,end+1)=y2;
weights1=[0,0,0;.1,.4,0.2;0,.7,.9]
lr4=.0005;
std=[std1,std2,std3];
q1=0;
for i=1:5000
    for k=1:150
        z1(k)=sqrdist(data(k,1:3),c(1,:),weights1(1,:));
        z2(k)=sqrdist(data(k,1:3),c(2,:),weights1(2,:));
        z3(k)=sqrdist(data(k,1:3),c(3,:),weights1(3,:));
        phi1(k)=exp(-((z1(k))^2)/(2*(std1^2)));
        phi2(k)=exp(-((z2(k))^2)/(2*(std2^2)));
        phi3(k)=exp(-((z3(k))^2)/(2*(std3^2)));
        phi=[phi1(k) phi2(k) phi3(k)];
        y(k)=((phi1(k)*weights(1,1))+(phi2(k)*weights(1,2))+(phi3(k)*weights(1,3)));
        y(k)=y(k)+bias;
        for j=1:no_nodes
            c(j,:)=c(j,:) + lr1*(data(k,in+1) -y(k))*weights(j)*(phi(j)*2) *(data(k,1:3)-c(j,:));
            weights(j)=weights(j) + lr2*(data(k,in+1) -y(k))*phi(j);
            weights1(j,:)=weights1(j,:) - lr4*(data(k,in+1) -y(k))*weights(j)*((phi(j)/std(j)^2)) *(data(k,1:3)-c(j,:))*data(k,j);
            std1=std1+lr3*((data(k,in+1) -y(k))*weights(1))*(z1(k)*phi1(k))/(std1^3);
            std2=std2+lr3*((data(k,in+1) -y(k))*weights(2))*(z2(k)*phi2(k))/(std2^3);
            std3=std3+lr3*((data(k,in+1) -y(k))*weights(3))*(z3(k)*phi3(k))/(std3^3);
        end
        e(k)=data(k,in+1) -y(k);
    end
    err(i)=mse(e);
    if(i==1)
        err11(i)=mse(e);
    else
       err11(i)=mse(e)/err11(1); 
    end
    if(i>1)
        if(err11(i)<0.4&&q1==0)
            con1(4)=err(i);
            coniter1(4)=i;
            q1=q1+1;
        end
    end;
end
%con1(4)=con1(4)/max(err);
err=err/max(err);
con1(4)=err(end);
con1(4)=min(err);
con1(4)=con1(4)/max(err);
figure(21);
plot(err,'LineWidth',2);
txt='\leftarrow model 4'
text(800,err(800),txt)
%title('Mean Square Error___MODEL_1');
xlabel('iteration');



rng(45);
test=rand(30,1)-.5;
for i=1:length(test)
    if(test(i)>0)
        test(i)=1;
    else
        test(i)=-1;
    end
end
test=[0;0;0;test];
for i=1:length(test)-3
    di(i,:)=[test(i),test(i+1),test(i+2)];
end
y1=[];
y2=[];
test=di;
y1=.304*test(:,1)+.903*test(:,2)+.304*test(:,3);
y2=tan(y1);
y2=awgn(y2,30);
test(:,end+1)=y2;
for i=1:length(test)
    z11=sqrdist(test(i,1:3),c(1,:),weights1(1,:));
    z22=sqrdist(test(i,1:3),c(2,:),weights1(2,:));
    z33=sqrdist(test(i,1:3),c(3,:),weights1(3,:));
    phi11=exp(-((z11)^2)/(2*(std1^2)));
    phi22=exp(-((z22)^2)/(2*(std2^2)));
    phi33=exp(-((z33)^2)/(2*(std3^2)));
    x4(i)=((phi11*weights(1,1))+(phi22*weights(1,2))+(phi33*weights(1,3)));
    x4(i)=x4(i)+bias;
end
qwer1(4)=sum(abs(x4'-y2))/length(x4);
figure(22)
plot(x1,'LineWidth',2)
hold on;
txt='\leftarrow model 1'
text(3,x1(3),txt)
plot(x,'LineWidth',2)
hold on;
txt='\leftarrow model 2'
text(8,x(8),txt)
plot(x3,'LineWidth',2)
hold on;
txt='\leftarrow model 3'
text(3,x3(3),txt)
plot(x4,'LineWidth',2)
hold on;
txt='\leftarrow model 4'
text(3,x4(3)+1,txt)
plot(y2,'LineWidth',2)
txt='\leftarrow actual'
text(11,y2(11),txt)
xlabel('no of samples')
ylabel('rbf value')
title('rbf value comparision')













%data=load('XORrbf.txt')
rng(30);
data=rand(447,1)-0.5;
data=exp(-data);
data=[0;0;0;data];
for i=1:length(data)-3
    d(i,:)=[data(i),data(i+1),data(i+2)];
end
data=d;
size_data=size(data);
lr1=0.0001;
lr2=0.0001;
lr3=0.0001;
no_grp=2;  
no_nodes=3;
in=3;
n0=size_data(1);
n=size_data(1)/no_grp;
weights =rand(1,no_nodes);
weights=[0,0,0];
r=randi(size_data(1),1,2);
r=[1,4,78];
c=data(r,1:3);
c=[0.9,0.9,0.1;0,0,0.3;0.1,.56,1.2]
bias=0;
r=randperm(4);
mean1=sum(data(:,1))/length(data(:,1));
mean2=sum(data(:,2))/length(data(:,2));
mean3=sum(data(:,3))/length(data(:,3));
std1=sqrt(sum((data(:,1)-mean1).^2)/(length(data(:,1))-1));
std2=sqrt(sum((data(:,2)-mean2).^2)/(length(data(:,2))-1));
std3=sqrt(sum((data(:,3)-mean3).^2)/(length(data(:,3))-1));
y1=.304*data(:,1)+.903*data(:,2)+.304*data(:,3);
y2=y1+.2*y1.^2-.1*y1.^3;
y2=awgn(y2,30);
data(:,end+1)=y2;
q1=0;
bias=2;
for i=1:5000
    for k=1:length(data)
        z1(k)=dist(data(k,1:3),c(1,:));
        z2(k)=dist(data(k,1:3),c(2,:));
        z3(k)=dist(data(k,1:3),c(3,:));
        phi1(k)=exp(-((z1(k))^2)/(2*(std1^2)));
        phi2(k)=exp(-((z2(k))^2)/(2*(std2^2)));
        phi3(k)=exp(-((z3(k))^2)/(2*(std3^2)));
        phi=[phi1(k) phi2(k) phi3(k)];
        y(k)=((phi1(k)*weights(1,1))+(phi2(k)*weights(1,2))+(phi3(k)*weights(1,3)));
        y(k)=y(k)+bias;
        %y(k)=exp(-y(k));
        for j=1:no_nodes
            c(j,:)=c(j,:) + lr1*(data(k,in+1) -y(k))*weights(j)*(phi(j)*2) *(data(k,1:3)-c(j,:));
            weights(j)=weights(j) + lr2*(data(k,in+1) -y(k))*phi(j);
        end
        e(k)=(data(k,in+1) -y(k))/2;
    end
    err(i)=mse(e);
    if(i==1)
        err11(i)=mse(e);
    else
       err11(i)=mse(e)/err11(1); 
    end
    %err(i)=mse(e)/err(1);
    if(i>1)
        if(err11(i)<0.2&&q1==0)
            con1(5)=err(i);
            coniter1(5)=i;
            q1=q1+1;
        end
    end;
end
err=err./max(err);
con1(5)=err(end);
err=err./max(err);
%con(1)=err(end);
figure(21);
plot(err,'LineWidth',2);
txt='\leftarrow model 5'
text(1000,err(1000),txt)
hold on;
title('Mean Square Error___MODEL_1');
xlabel('iteration');





rng(45);
test=rand(30,1)-.5;
test=exp(-test);
test=[0;0;0;test];
for i=1:length(test)-3
    di(i,:)=[test(i),test(i+1),test(i+2)];
end
y1=[];
y2=[];
test=di;
y1=.304*test(:,1)+.903*test(:,2)+.304*test(:,3);
y2=y1+.2*y1.^2-.1*y1.^3;
y2=awgn(y2,30);
test(:,end+1)=y2;
for i=1:length(test)
    z11=dist(test(i,1:3),c(1,:));
    z22=dist(test(i,1:3),c(2,:));
    z33=dist(test(i,1:3),c(3,:));
    phi11=exp(-((z11)^2)/(2*(std1^2)));
    phi22=exp(-((z22)^2)/(2*(std2^2)));
    phi33=exp(-((z33)^2)/(2*(std3^2)));
    x5(i)=((phi11*weights(1,1))+(phi22*weights(1,2))+(phi33*weights(1,3)));
    x5(i)=x5(i)+bias;
end
qwer(1)=sum(abs(x5'-y2))/length(x5);
figure(3)
plot(x5(5:end),'LineWidth',2);
hold on;
txt='\leftarrow model 5'
text(3,x5(3),txt)
plot(y2(5:end),'LineWidth',2)
%txt='\leftarrow actual'
%text(10,y2(10),txt)
xlabel('no of input samples')
ylabel('response')







rng(30);
data=rand(447,1)-0.5;
data=exp(-data);
data=[0;0;0;data];
for i=1:length(data)-3
    d(i,:)=[data(i),data(i+1),data(i+2)];
end
data=d;
size_data=size(data);
lr1=0.0005;
lr2=0.0005;
lr3=0.0002;
no_grp=2;  
no_nodes=3;
in=3;
n0=size_data(1);
n=size_data(1)/no_grp;
weights =rand(1,no_nodes);
weights=[0,0,0];
r=randi(size_data(1),1,2);
r=[1,4,78];
c=data(r,1:3);
c=[0.1,0.4,0.1;0,0,0.3;0.1,.56,1.2]
bias=0;
r=randperm(4);
mean1=sum(data(:,1))/length(data(:,1));
mean2=sum(data(:,2))/length(data(:,2));
mean3=sum(data(:,3))/length(data(:,3));
std1=sqrt(sum((data(:,1)-mean1).^2)/(length(data(:,1))-1));
std2=sqrt(sum((data(:,2)-mean2).^2)/(length(data(:,2))-1));
std3=sqrt(sum((data(:,3)-mean3).^2)/(length(data(:,3))-1));
y1=.304*data(:,1)+.903*data(:,2)+.304*data(:,3);
y2=y1+.2*y1.^2-.1*y1.^3;
y2=awgn(y2,30);
data(:,end+1)=y2;
weights1=[0,0,0;.1,.8,0.2;0,.1,.9]
lr4=.00005;
std=[std1,std2,std3];
q1=0;
for i=1:5000
    for k=1:150
        z1(k)=sqrdist(data(k,1:3),c(1,:),weights1(1,:));
        z2(k)=sqrdist(data(k,1:3),c(2,:),weights1(2,:));
        z3(k)=sqrdist(data(k,1:3),c(3,:),weights1(3,:));
        phi1(k)=exp(-((z1(k))^2)/(2*(std1^2)));
        phi2(k)=exp(-((z2(k))^2)/(2*(std2^2)));
        phi3(k)=exp(-((z3(k))^2)/(2*(std3^2)));
        phi=[phi1(k) phi2(k) phi3(k)];
        y(k)=((phi1(k)*weights(1,1))+(phi2(k)*weights(1,2))+(phi3(k)*weights(1,3)));
        y(k)=y(k)+bias;
        for j=1:no_nodes
            c(j,:)=c(j,:) + lr1*(data(k,in+1) -y(k))*weights(j)*(phi(j)*2) *(data(k,1:3)-c(j,:));
            weights(j)=weights(j) + lr2*(data(k,in+1) -y(k))*phi(j);
            weights1(j,:)=weights1(j,:) - lr4*(data(k,in+1) -y(k))*weights(j)*((phi(j)/std(j)^2)) *(data(k,1:3)-c(j,:))*data(k,j);
            std1=std1+lr3*((data(k,in+1) -y(k))*weights(1))*(z1(k)*phi1(k))/(std1^3);
            std2=std2+lr3*((data(k,in+1) -y(k))*weights(2))*(z2(k)*phi2(k))/(std2^3);
            std3=std3+lr3*((data(k,in+1) -y(k))*weights(3))*(z3(k)*phi3(k))/(std3^3);
        end
        e(k)=(data(k,in+1) -y(k))/2;
    end
    err(i)=mse(e);
    if(i==1)
        err11(i)=mse(e);
    else
       err11(i)=mse(e)/err11(1); 
    end
    %err(i)=mse(e);
    if(i>1)
        if(err11(i)<0.1&&q1==0)
            con1(6)=err(i);
            coniter1(6)=i;
            q1=q1+1;
        end
    end;
end

con1(6)=err(end);
err=err./max(err);
%con(2)=err(end);
figure(21);
plot(err,'LineWidth',2);
txt='\leftarrow model 6'
text(1300,err(1300),txt)
hold on;
%title('Mean Square Error___MODEL_1');
xlabel('iteration');






rng(45);
test=rand(30,1)-.5;
test=exp(-test);
test=[0;0;0;test];
for i=1:length(test)-3
    di(i,:)=[test(i),test(i+1),test(i+2)];
end
y1=[];
y2=[];
test=di;
y1=.304*test(:,1)+.903*test(:,2)+.304*test(:,3);
y2=y1+.2*y1.^2-.1*y1.^3;
y2=awgn(y2,30);
%y2=sigmoid(y2);
test(:,end+1)=y2;
for i=1:length(test)
    z11=sqrdist(test(i,1:3),c(1,:),weights1(1,:));
    z22=sqrdist(test(i,1:3),c(2,:),weights1(2,:));
    z33=sqrdist(test(i,1:3),c(3,:),weights1(3,:));
    phi11=exp(-((z11)^2)/(2*(std1^2)));
    phi22=exp(-((z22)^2)/(2*(std2^2)));
    phi33=exp(-((z33)^2)/(2*(std3^2)));
    x31(i)=((phi11*weights(1,1))+(phi22*weights(1,2))+(phi33*weights(1,3)));
    x31(i)=x31(i)+bias;
    x31(i)=x31(i);
end
qwer(2)=sum(abs(x31'-y2))/length(x31);
figure(3)
%plot(y2);
%hold on;
plot(x31(5:end),'LineWidth',2);
txt='\leftarrow model 6'
text(5,2.075,txt)
hold on;


