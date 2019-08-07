clc;
clear all;
close all;
qwer=[];
con=[];
coniter=[];
data=load('XORrbf.txt')
size_data=size(data);
lr1=.0005;
lr2=.0006;
no_grp=2;  
no_nodes=2;
in=2;
n0=size_data(1);
n=size_data(1)/no_grp;
weights =rand(1,no_nodes);
weights=[0,0];
r=randi(size_data(1),1,2);
r=[1,4,78];
%c=data(r,1:3);
c=[0.9,0.1;0,0]
bias=0;
r=randperm(4);
mean1=sum(data(:,1))/length(data(:,1));
mean2=sum(data(:,2))/length(data(:,2));
%mean3=sum(data(:,3))/length(data(:,3));
std1=sqrt(sum((data(:,1)-mean1).^2)/(length(data(:,1))-1));
std2=sqrt(sum((data(:,2)-mean2).^2)/(length(data(:,2))-1));
%std3=sqrt(sum((data(:,3)-mean3).^2)/(length(data(:,3))-1));
q1=0;
for i=1:20000
    for k=1:length(data)
        z1(k)=dist(data(k,1:2),c(1,:));
        z2(k)=dist(data(k,1:2),c(2,:));
        %z3(k)=dist(data(k,1:3),c(3,:));
        phi1(k)=exp(-((z1(k))^2)/(2*(std1^2)));
        phi2(k)=exp(-((z2(k))^2)/(2*(std2^2)));
        %phi3(k)=exp(-((z3(k))^2)/(2*(std3^2)));
        phi=[phi1(k) phi2(k)];
        y(k)=((phi1(k)*weights(1,1))+(phi2(k)*weights(1,2)));
        y(k)=y(k)+bias;
        for j=1:no_nodes
            c(j,:)=c(j,:) + lr1*(data(k,in+1) -y(k))*weights(j)*(phi(j)*2) *(data(k,1:2)-c(j,:));
            weights(j)=weights(j) + lr2*(data(k,in+1) -y(k))*phi(j);
        end
        e(k)=data(k,in+1) -y(k);
    end
    err(i)=mse(e);
    if(i>1)
        if(err(i)<0.1782&&q1==0)
            con(1)=err(i);
            coniter(1)=i*10;
            q1=q1+1;
        end
    end;
end
err=err/max(err);
con(1)=err(end);
%err=err/max(err);
figure(2);
plot(err,'LineWidth',2);
txt='\leftarrow model 1'
text(100,err(100),txt)
hold on;
title('Mean Square Error___');
xlabel('iteration');



test=[0.1,.8,.9;0,0,.01;.15,.7,.75;1,.9,0];
for i=1:length(test)
    z11=dist(test(i,1:2),c(1,:));
    z22=dist(test(i,1:2),c(2,:));
    %z33=dist(test(i,1:3),c(3,:));
    phi11=exp(-((z11)^2)/(2*(std1^2)));
    phi22=exp(-((z22)^2)/(2*(std2^2)));
    %phi33=exp(-((z33)^2)/(2*(std3^2)));
    x1(i)=((phi11*weights(1,1))+(phi22*weights(1,2)));
    x1(i)=x1(i)+bias;
end
qwer(1)=sum(abs(x1'-test(:,end)))/length(x1);




data=load('XORrbf.txt')
size_data=size(data);
lr1=0.03;
lr2=0.04;
lr3=.0004;
no_grp=2;  
no_nodes=2;
in=2;
n0=size_data(1);
n=size_data(1)/no_grp;
weights =rand(1,no_nodes);
weights=[0,0];
r=randi(size_data(1),1,2);
r=[1,4,78];
%c=data(r,1:3);
c=[0.9,0.1;0,0]
bias=0;
r=randperm(4);
mean1=sum(data(:,1))/length(data(:,1));
mean2=sum(data(:,2))/length(data(:,2));
%mean3=sum(data(:,3))/length(data(:,3));
std1=sqrt(sum((data(:,1)-mean1).^2)/(length(data(:,1))-1));
std2=sqrt(sum((data(:,2)-mean2).^2)/(length(data(:,2))-1));
%std3=sqrt(sum((data(:,3)-mean3).^2)/(length(data(:,3))-1));
std=[std1,std2]
q1=0;
for i=1:20000
    for k=1:length(data)
        z1(k)=dist(data(k,1:2),c(1,:));
        z2(k)=dist(data(k,1:2),c(2,:));
        %z3(k)=dist(data(k,1:3),c(3,:));
        phi1(k)=exp(-((z1(k))^2)/(2*(std1^2)));
        phi2(k)=exp(-((z2(k))^2)/(2*(std2^2)));
        %phi3(k)=exp(-((z3(k))^2)/(2*(std3^2)));
        phi=[phi1(k) phi2(k)];
        y(k)=((phi1(k)*weights(1,1))+(phi2(k)*weights(1,2)));
        y(k)=y(k)+bias;
        for j=1:no_nodes
            c(j,:)=c(j,:) + lr1*(data(k,in+1) -y(k))*weights(j)*(phi(j)*2) *(data(k,1:2)-c(j,:));
            weights(j)=weights(j) + lr2*(data(k,in+1) -y(k))*phi(j);
            std1=std1+lr3*((data(k,in+1) -y(k))*weights(1))*(z1(k)*phi1(k))/(std1^3);
            std2=std2+lr3*((data(k,in+1) -y(k))*weights(2))*(z1(k)*phi1(k))/(std2^3);
        end
        e(k)=data(k,in+1) -y(k);
    end
    err(i)=mse(e);
    if(i>1)
        if(err(i)<0.15&&q1==0)
            con(2)=err(i);
            coniter(2)=i*10;
            q1=q1+1;
        end
    end;
end
err=err/max(err);
con(2)=err(end);
%err=err/max(err);
figure(2);
plot(err,'LineWidth',2);
txt='\leftarrow model 2'
text(300,err(300),txt)
hold on;
title('Mean Square Error___');
xlabel('iteration');



test=[0.1,.8,.9;0,0,.01;.15,.7,.75;1,.9,0];
for i=1:length(test)
    z11=dist(test(i,1:2),c(1,:));
    z22=dist(test(i,1:2),c(2,:));
    %z33=dist(test(i,1:3),c(3,:));
    phi11=exp(-((z11)^2)/(2*(std1^2)));
    phi22=exp(-((z22)^2)/(2*(std2^2)));
    %phi33=exp(-((z33)^2)/(2*(std3^2)));
    x2(i)=((phi11*weights(1,1))+(phi22*weights(1,2)));
    x2(i)=x2(i)+bias;
end
qwer(2)=sum(abs(x2'-test(:,end)))/length(x2);









data=load('XORrbf.txt')
size_data=size(data);
lr1=.004;
lr2=.003;
lr3=.0004;
no_grp=2;  
no_nodes=2;
in=2;
n0=size_data(1);
n=size_data(1)/no_grp;
weights =rand(1,no_nodes);
weights=[0,0];
weights1=[0,0;0,0];
r=randi(size_data(1),1,2);
r=[1,4,78];
%c=data(r,1:3);
c=[0.9,0.1;0,0]
bias=0;
r=randperm(4);
mean1=sum(data(:,1))/length(data(:,1));
mean2=sum(data(:,2))/length(data(:,2));
%mean3=sum(data(:,3))/length(data(:,3));
std1=sqrt(sum((data(:,1)-mean1).^2)/(length(data(:,1))-1));
std2=sqrt(sum((data(:,2)-mean2).^2)/(length(data(:,2))-1));
%std3=sqrt(sum((data(:,3)-mean3).^2)/(length(data(:,3))-1));
std=[std1,std2]
%lr4=0.0005;
q1=0;
for i=1:20000
    for k=1:length(data)
        z1(k)=sqrdist(data(k,1:2),c(1,:),weights1(1,:));
        z2(k)=sqrdist(data(k,1:2),c(2,:),weights1(2,:));
        %z3(k)=dist(data(k,1:3),c(3,:));
        phi1(k)=exp(-((z1(k))^2)/(2*(std1^2)));
        phi2(k)=exp(-((z2(k))^2)/(2*(std2^2)));
        %phi3(k)=exp(-((z3(k))^2)/(2*(std3^2)));
        phi=[phi1(k) phi2(k)];
        y(k)=((phi1(k)*weights(1,1))+(phi2(k)*weights(1,2)));
        y(k)=y(k)+bias;
        for j=1:no_nodes
            c(j,:)=c(j,:) + lr1*(data(k,in+1) -y(k))*weights(j)*(phi(j)*2) *(data(k,1:2)-c(j,:));
            weights(j)=weights(j) + lr2*(data(k,in+1) -y(k))*phi(j);
            weights1(j,:)=weights1(j,:) - lr2*(data(k,in+1) -y(k))*weights(j)*((phi(j)/std(j)^2)) *(data(k,1:2)-c(j,:))*data(k,j);
            std1=std1+lr3*((data(k,in+1) -y(k))*weights(1))*(z1(k)*phi1(k))/(std1^3);
            std2=std2+lr3*((data(k,in+1) -y(k))*weights(2))*(z1(k)*phi1(k))/(std2^3);
        end
        e(k)=data(k,in+1) -y(k);
    end
    
    err(i)=mse(e);
    if(i>1)
        if(err(i)<0.1782&&q1==0)
            con(3)=err(i);
            coniter(3)=i*10;
            q1=q1+1;
        end
    end;
end
err=err/max(err);
con(3)=err(end);
%err=err/max(err);
figure(2);
plot(err,'LineWidth',2);
txt='\leftarrow model 3'
text(500,err(500),txt)
hold on;
title('Mean Square Error___');
xlabel('iteration');



test=[0.1,.8,.9;0,0,.01;.15,.7,.75;1,.9,0];
for i=1:length(test)
    z11=sqrdist(test(i,1:2),c(1,:),weights1(1,:));
    z22=sqrdist(test(i,1:2),c(2,:),weights1(2,:));
    %z33=dist(test(i,1:3),c(3,:));
    phi11=exp(-((z11)^2)/(2*(std1^2)));
    phi22=exp(-((z22)^2)/(2*(std2^2)));
    %phi33=exp(-((z33)^2)/(2*(std3^2)));
    x3(i)=((phi11*weights(1,1))+(phi22*weights(1,2)));
    x3(i)=x3(i)+bias;
end
qwer(3)=sum(abs(x3'-test(:,end)))/length(x3);











data=load('XORrbf.txt')
size_data=size(data);
lr1=.004;
lr2=.003;
lr3=.001;
no_grp=2;  
no_nodes=2;
in=2;
n0=size_data(1);
n=size_data(1)/no_grp;
weights =rand(1,no_nodes);
weights=[0,0];
weights1=[0,0;0,0];
r=randi(size_data(1),1,2);
r=[1,4,78];
%c=data(r,1:3);
c=[0.9,0.1;0,0]
bias=0;
r=randperm(4);
mean1=sum(data(:,1))/length(data(:,1));
mean2=sum(data(:,2))/length(data(:,2));
%mean3=sum(data(:,3))/length(data(:,3));
std1=sqrt(sum((data(:,1)-mean1).^2)/(length(data(:,1))-1));
std2=sqrt(sum((data(:,2)-mean2).^2)/(length(data(:,2))-1));
%std3=sqrt(sum((data(:,3)-mean3).^2)/(length(data(:,3))-1));
std=[std1,std2]
lr4=0.0005;
q1=0;
for i=1:20000
    for k=1:length(data)
        z1(k)=sqrdist(data(k,1:2),c(1,:),weights1(1,:));
        z2(k)=sqrdist(data(k,1:2),c(2,:),weights1(2,:));
        %z3(k)=dist(data(k,1:3),c(3,:));
        phi1(k)=exp(-((z1(k))^2)/(2*(std1^2)));
        phi2(k)=exp(-((z2(k))^2)/(2*(std2^2)));
        %phi3(k)=exp(-((z3(k))^2)/(2*(std3^2)));
        phi=[phi1(k) phi2(k)];
        y(k)=((phi1(k)*weights(1,1))+(phi2(k)*weights(1,2)));
        y(k)=y(k)+bias;
        for j=1:no_nodes
            c(j,:)=c(j,:) + lr1*(data(k,in+1) -y(k))*weights(j)*(phi(j)*2) *(data(k,1:2)-c(j,:));
            weights(j)=weights(j) + lr2*(data(k,in+1) -y(k))*phi(j);
            weights1(j,:)=weights1(j,:) - lr2*(data(k,in+1) -y(k))*weights(j)*((phi(j)/std(j)^2)) *(data(k,1:2)-c(j,:))*data(k,j);
            %std1=std1+lr3*((data(k,in+1) -y(k))*weights(1))*(z1(k)*phi1(k))/(std1^3);
            %std2=std2+lr3*((data(k,in+1) -y(k))*weights(2))*(z1(k)*phi1(k))/(std2^3);
        end
        e(k)=data(k,in+1) -y(k);
    end
    err(i)=mse(e);
    if(i>1)
        if(err(i)<0.1782&&q1==0)
            con(4)=err(i);
            coniter(4)=i*10;
            q1=q1+1;
        end
    end;
end
err=err/max(err);
con(4)=err(end);
%err=err/max(err);
figure(2);
plot(err,'LineWidth',2);
txt='\leftarrow model 4'
text(800,err(800),txt)
hold on;
title('Mean Square Error___comparison');
xlabel('iteration');



test=[0.1,.8,.9;0,0,.01;.15,.7,.75;1,.9,0];
for i=1:length(test)
    z11=sqrdist(test(i,1:2),c(1,:),weights1(1,:));
    z22=sqrdist(test(i,1:2),c(2,:),weights1(2,:));
    %z33=dist(test(i,1:3),c(3,:));
    phi11=exp(-((z11)^2)/(2*(std1^2)));
    phi22=exp(-((z22)^2)/(2*(std2^2)));
    %phi33=exp(-((z33)^2)/(2*(std3^2)));
    x4(i)=((phi11*weights(1,1))+(phi22*weights(1,2)));
    x4(i)=x4(i)+bias;
end
qwer(4)=sum(abs(x4'-test(:,end)))/length(x4);












data=load('XORrbf.txt')
size_data=size(data);
lr1=.0007;
lr2=.0006;
no_grp=2;  
no_nodes=2;
in=2;
n0=size_data(1);
n=size_data(1)/no_grp;
weights =rand(1,no_nodes);
weights=[0,0];
r=randi(size_data(1),1,2);
r=[1,4,78];
%c=data(r,1:3);
c=[0.9,0.1;0,0]
data(:,1:2)=exp(-data(:,1:2));
bias=0;
r=randperm(4);
mean1=sum(data(:,1))/length(data(:,1));
mean2=sum(data(:,2))/length(data(:,2));
%mean3=sum(data(:,3))/length(data(:,3));
std1=sqrt(sum((data(:,1)-mean1).^2)/(length(data(:,1))-1));
std2=sqrt(sum((data(:,2)-mean2).^2)/(length(data(:,2))-1));
%std3=sqrt(sum((data(:,3)-mean3).^2)/(length(data(:,3))-1));
q1=0;
for i=1:20000
    for k=1:length(data)
        z1(k)=dist(data(k,1:2),c(1,:));
        z2(k)=dist(data(k,1:2),c(2,:));
        %z3(k)=dist(data(k,1:3),c(3,:));
        phi1(k)=exp(-((z1(k))^2)/(2*(std1^2)));
        phi2(k)=exp(-((z2(k))^2)/(2*(std2^2)));
        %phi3(k)=exp(-((z3(k))^2)/(2*(std3^2)));
        phi=[phi1(k) phi2(k)];
        y(k)=((phi1(k)*weights(1,1))+(phi2(k)*weights(1,2)));
        y(k)=y(k)+bias;
        for j=1:no_nodes
            c(j,:)=c(j,:) + lr1*(data(k,in+1) -y(k))*weights(j)*(phi(j)*2) *(data(k,1:2)-c(j,:));
            weights(j)=weights(j) + lr2*(data(k,in+1) -y(k))*phi(j);
        end
        e(k)=data(k,in+1) -y(k);
    end
    err1(i)=mse(e);
    if(i>1)
        if(err1(i)<0.3&&q1==0)
            con(5)=err1(i);
            coniter(5)=i*10;
            q1=q1+1;
        end
    end;
end
con(5)=err1(end);
err1=err1/max(err1);
figure(2);
plot(err1,'LineWidth',2);
txt='\leftarrow model 5'
text(1000,err1(1000),txt)
hold on;
title('Mean Square Error___');
xlabel('iteration');



test=[0.1,.8,.9;0,0,.01;.15,.7,.75;1,.9,0];
for i=1:length(test)
    z11=dist(test(i,1:2),c(1,:));
    z22=dist(test(i,1:2),c(2,:));
    %z33=dist(test(i,1:3),c(3,:));
    phi11=exp(-((z11)^2)/(2*(std1^2)));
    phi22=exp(-((z22)^2)/(2*(std2^2)));
    %phi33=exp(-((z33)^2)/(2*(std3^2)));
    x1(i)=((phi11*weights(1,1))+(phi22*weights(1,2)));
    x1(i)=x1(i)+bias;
end
qwer(5)=sum(abs(x1'-test(:,end)))/length(x1);










data=load('XORrbf.txt')
size_data=size(data);
lr1=0.008;
lr2=0.006;
lr3=0.001;
no_grp=2;  
no_nodes=2;
in=2;
n0=size_data(1);
n=size_data(1)/no_grp;
weights =rand(1,no_nodes);
weights=[0,0];
weights1=[0,0;0,0];
r=randi(size_data(1),1,2);
r=[1,4,78];
%c=data(r,1:3);
c=[0.9,0.1;0,0]
bias=0;
r=randperm(4);
data(:,1:2)=exp(-data(:,1:2));
mean1=sum(data(:,1))/length(data(:,1));
mean2=sum(data(:,2))/length(data(:,2));
%mean3=sum(data(:,3))/length(data(:,3));
std1=sqrt(sum((data(:,1)-mean1).^2)/(length(data(:,1))-1));
std2=sqrt(sum((data(:,2)-mean2).^2)/(length(data(:,2))-1));
%std3=sqrt(sum((data(:,3)-mean3).^2)/(length(data(:,3))-1));
std=[std1,std2]
lr4=0.0005;
q1=0;
for i=1:20000
    for k=1:length(data)
        z1(k)=sqrdist(data(k,1:2),c(1,:),weights1(1,:));
        z2(k)=sqrdist(data(k,1:2),c(2,:),weights1(2,:));
        %z3(k)=dist(data(k,1:3),c(3,:));
        phi1(k)=exp(-((z1(k))^2)/(2*(std1^2)));
        phi2(k)=exp(-((z2(k))^2)/(2*(std2^2)));
        %phi3(k)=exp(-((z3(k))^2)/(2*(std3^2)));
        phi=[phi1(k) phi2(k)];
        y(k)=((phi1(k)*weights(1,1))+(phi2(k)*weights(1,2)));
        y(k)=y(k)+bias;
        for j=1:no_nodes
            c(j,:)=c(j,:) + lr1*(data(k,in+1) -y(k))*weights(j)*(phi(j)*2) *(data(k,1:2)-c(j,:));
            weights(j)=weights(j) + lr2*(data(k,in+1) -y(k))*phi(j);
            weights1(j,:)=weights1(j,:) + lr2*(data(k,in+1) -y(k))*weights(j)*((phi(j)/std(j)^2)) *(data(k,1:2)-c(j,:))*data(k,j)*data(k,j);
            std1=std1+lr3*((data(k,in+1) -y(k))*weights(1))*(z1(k)*phi1(k))/(std1^3);
            std2=std2+lr3*((data(k,in+1) -y(k))*weights(2))*(z1(k)*phi1(k))/(std2^3);
        end
        e(k)=data(k,in+1) -y(k);
    end
    err(i)=mse(e);
    if(i>1)
        if(err(i)<0.1782&&q1==0)
            con(6)=err(i);
            coniter(6)=i*10;
            q1=q1+1;
        end
    end;
end
con(6)=err(end);
err=err/max(err);
figure(2);
plot(err,'LineWidth',2);
txt='\leftarrow model 6'
text(1300,err(1300),txt)
hold on;
title('Mean Square Error___');
xlabel('iteration');



test=[0.1,.8,.9;0,0,.01;.15,.7,.75;1,.9,0];
for i=1:length(test)
    z11=sqrdist(test(i,1:2),c(1,:),weights1(1,:));
    z22=sqrdist(test(i,1:2),c(2,:),weights1(2,:));
    %z33=dist(test(i,1:3),c(3,:));
    phi11=exp(-((z11)^2)/(2*(std1^2)));
    phi22=exp(-((z22)^2)/(2*(std2^2)));
    %phi33=exp(-((z33)^2)/(2*(std3^2)));
    x3(i)=((phi11*weights(1,1))+(phi22*weights(1,2)));
    x3(i)=x3(i)+bias;
end
qwer(6)=sum(abs(x3'-test(:,end)))/(length(x3)*10);










