clc;
clear all;
close all;
%data=load('XORrbf.txt')
con=[];
coniter=[];
ii=1;
ii1=101;
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
data1=data;
for i=1:length(data)-3
    d(i,:)=[data(i),data(i+1),data(i+2)];
end
data=d;
size_data=size(data);
lr1=.0005;
lr2=.0005;
no_grp=2;  
no_nodes=6;
in=6;
n0=size_data(1);
n=size_data(1)/no_grp;
%weights =rand(1,no_nodes);
weights=[0,0,0,0,0,0];
%r=randi(size_data(1),1,2);
%r=[1,4,78];
%c=data(r,1:3);
c=[0.9,0.9,0.1,0,0,0.3;0.1,.56,1.2,0,0,0.3;0,0,0.3,.1,.6,0;.5,.3,.1,0,0,.2;0,1,.3,0,.1,.9;.7,.1,0,0,.8,.5]
bias=0;
q1=0;
r=randperm(4);
y1=.209*d(:,1)+.995*d(:,2)+.209*d(:,3);
y2=y1+.2*y1.^2-.1*y1.^3;
y2=awgn(y2,30);
y3=y2;
%data(:,end+1)=y2;
y2=[0;0;0;0;0;0;y2];
for i=1:length(y2)-6
    do(i,:)=[y2(i),y2(i+1),y2(i+2),y2(i+3),y2(i+4),y2(i+5)];
end
do(:,end+1)=data1(1:end-3);
data=[];
data=do;
mean1=sum(data(:,1))/length(data(:,1));
mean2=sum(data(:,2))/length(data(:,2));
mean3=sum(data(:,3))/length(data(:,3));
mean4=sum(data(:,4))/length(data(:,4));
mean5=sum(data(:,5))/length(data(:,5));
mean6=sum(data(:,6))/length(data(:,6));
std1=sqrt(sum((data(:,1)-mean1).^2)/(length(data(:,1))-1));
std2=sqrt(sum((data(:,2)-mean2).^2)/(length(data(:,2))-1));
std3=sqrt(sum((data(:,3)-mean3).^2)/(length(data(:,3))-1));
std4=sqrt(sum((data(:,4)-mean4).^2)/(length(data(:,4))-1));
std5=sqrt(sum((data(:,5)-mean5).^2)/(length(data(:,5))-1));
std6=sqrt(sum((data(:,6)-mean6).^2)/(length(data(:,6))-1));
for i=1:2500
    for k=1:150
        z1(k)=dist(data(k,1:6),c(1,:));
        z2(k)=dist(data(k,1:6),c(2,:));
        z3(k)=dist(data(k,1:6),c(3,:));
        z4(k)=dist(data(k,1:6),c(4,:));
        z5(k)=dist(data(k,1:6),c(5,:));
        z6(k)=dist(data(k,1:6),c(6,:));
        phi1(k)=exp(-((z1(k))^2)/(2*(std1^2)));
        phi2(k)=exp(-((z2(k))^2)/(2*(std2^2)));
        phi3(k)=exp(-((z3(k))^2)/(2*(std3^2)));
        phi4(k)=exp(-((z4(k))^2)/(2*(std4^2)));
        phi5(k)=exp(-((z5(k))^2)/(2*(std5^2)));
        phi6(k)=exp(-((z6(k))^2)/(2*(std6^2)));
        phi=[phi1(k) phi2(k) phi3(k) phi4(k) phi5(k) phi6(k)];
        y(k)=((phi1(k)*weights(1,1))+(phi2(k)*weights(1,2))+(phi3(k)*weights(1,3))+(phi4(k)*weights(1,4))+(phi5(k)*weights(1,5))+(phi6(k)*weights(1,6)));
        y(k)=y(k)+bias;
        for j=1:no_nodes
            c(j,:)=c(j,:) + lr1*(data(k,in+1) -y(k))*weights(j)*(phi(j)*2) *(data(k,1:6)-c(j,:));
            weights(j)=weights(j) + lr2*(data(k,in+1) -y(k))*phi(j);
        end
        e(k)=data(k,in+1) -y(k);
        if(k>2)
        if(abs(e(k)-e(k-1))<0.0001)
            ii=k;
            ii1=e(k);
        end
        end
    end
    err(i)=mse(e);
    if(i>1)
        if(err(i)<0.7&&q1==0)
            con(1)=err(i);
            coniter(1)=i;
            q1=q1+1;
        end
    end;
end
con(1)=err(end);
err=err/max(err);
figure(21);
plot(err,'LineWidth',2);
txt='\leftarrow model 1'
text(1000,err(1000),txt)
title('Mean Square Error___');
xlabel('iteration');
hold on;




rng(45);
test=rand(100000,1)-.5;
for i=1:length(test)
    if(test(i)>0)
        test(i)=1;
    else
        test(i)=-1;
    end
end
test=[0;0;0;test];
test2=test;
y1=[];
y2=[];
y=[];
do=[];
for i=1:length(test)-3
    test1(i,:)=[test(i),test(i+1),test(i+2)];
end

mm=[];
qqq=0;
cv=1;
match111=[];
while(qqq<21)
y1=[];
y2=[];
do=[];
y1=.209*test1(:,1)+.995*test1(:,2)+.209*test1(:,3);
y2=y1+.2*y1.^2-.1*y1.^3;
y2=awgn(y2,qqq);
y3=y2;
y2=[0;0;0;0;0;0;y2];
for i=1:length(y2)-6
    do(i,:)=[y2(i),y2(i+1),y2(i+2),y2(i+3),y2(i+4),y2(i+5)];
end
do(:,end+1)=test2(1:end-3);
test=[];
test=do;
match=0;
for i=1:length(test)
        z1(i)=dist(test(i,1:6),c(1,:));
        z2(i)=dist(test(i,1:6),c(2,:));
        z3(i)=dist(test(i,1:6),c(3,:));
        z4(i)=dist(test(i,1:6),c(4,:));
        z5(i)=dist(test(i,1:6),c(5,:));
        z6(i)=dist(test(i,1:6),c(6,:));
        phi1(i)=exp(-((z1(i))^2)/(2*(std1^2)));
        phi2(i)=exp(-((z2(i))^2)/(2*(std2^2)));
        phi3(i)=exp(-((z3(i))^2)/(2*(std3^2)));
        phi4(i)=exp(-((z4(i))^2)/(2*(std4^2)));
        phi5(i)=exp(-((z5(i))^2)/(2*(std5^2)));
        phi6(i)=exp(-((z6(i))^2)/(2*(std6^2)));
        phi=[phi1(i) phi2(i) phi3(i) phi4(i) phi5(i) phi6(i)];
        x(i)=((phi1(i)*weights(1,1))+(phi2(i)*weights(1,2))+(phi3(i)*weights(1,3))+(phi4(i)*weights(1,4))+(phi5(i)*weights(1,5))+(phi6(i)*weights(1,6)));
        x(i)=x(i)+bias;
        if(x(i)<0)
            x(i)=-1;
        else
            x(i)=1;
        end
        if(test(i,in+1)==x(i))
            match=match+1;
        end
end
match111(qqq+1)=match
mm3(cv)=1-(match)/100000;

%disp(qqq)
cv=cv+1
qqq=qqq+1;
end
qq=0:20;
figure(22)
l1=log10(mm3);
plot(qq,log10(mm3),'LineWidth',2)
txt='\leftarrow model 1'
text(qq(12),l1(12),txt)
xlabel('SNR')
ylabel('BER')
title('BER RATE MODEL1')
hold on;




%data=load('XORrbf.txt')
ii2=1;
ii3=101;
do=[];
y1=[];
y2=[];
y=[];
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
data1=data;
for i=1:length(data)-3
    d(i,:)=[data(i),data(i+1),data(i+2)];
end
data=d;
size_data=size(data);
lr1=0.005;
lr2=0.005;
lr3=0.001;
no_grp=2;  
no_nodes=6;
in=6;
n0=size_data(1);
n=size_data(1)/no_grp;
%weights =rand(1,no_nodes);
weights=[0,0,0,0,0,0];
%r=randi(size_data(1),1,2);
%r=[1,4,78];
%c=data(r,1:3);
c=[0.9,0.9,0.1,0,0,0.3;0.1,.56,1.2,0,0,0.3;0,0,0.3,.1,.6,0;.5,.3,.1,0,0,.2;0,1,.3,0,.1,.9;.7,.1,0,0,.8,.5]
bias=0;
r=randperm(4);
y1=.209*d(:,1)+.995*d(:,2)+.209*d(:,3);
y2=y1+.2*y1.^2-.1*y1.^3;
y2=awgn(y2,30);
y3=y2;
%data(:,end+1)=y2;
y2=[0;0;0;0;0;0;y2];
for i=1:length(y2)-6
    do(i,:)=[y2(i),y2(i+1),y2(i+2),y2(i+3),y2(i+4),y2(i+5)];
end
do(:,end+1)=data1(1:end-3);
data=[];
data=do;
mean1=sum(data(:,1))/length(data(:,1));
mean2=sum(data(:,2))/length(data(:,2));
mean3=sum(data(:,3))/length(data(:,3));
mean4=sum(data(:,4))/length(data(:,4));
mean5=sum(data(:,5))/length(data(:,5));
mean6=sum(data(:,6))/length(data(:,6));
std1=sqrt(sum((data(:,1)-mean1).^2)/(length(data(:,1))-1));
std2=sqrt(sum((data(:,2)-mean2).^2)/(length(data(:,2))-1));
std3=sqrt(sum((data(:,3)-mean3).^2)/(length(data(:,3))-1));
std4=sqrt(sum((data(:,4)-mean4).^2)/(length(data(:,4))-1));
std5=sqrt(sum((data(:,5)-mean5).^2)/(length(data(:,5))-1));
std6=sqrt(sum((data(:,6)-mean6).^2)/(length(data(:,6))-1));
q1=0;
for i=1:2500
    for k=1:150
        z1(k)=dist(data(k,1:6),c(1,:));
        z2(k)=dist(data(k,1:6),c(2,:));
        z3(k)=dist(data(k,1:6),c(3,:));
        z4(k)=dist(data(k,1:6),c(4,:));
        z5(k)=dist(data(k,1:6),c(5,:));
        z6(k)=dist(data(k,1:6),c(6,:));
        phi1(k)=exp(-((z1(k))^2)/(2*(std1^2)));
        phi2(k)=exp(-((z2(k))^2)/(2*(std2^2)));
        phi3(k)=exp(-((z3(k))^2)/(2*(std3^2)));
        phi4(k)=exp(-((z4(k))^2)/(2*(std4^2)));
        phi5(k)=exp(-((z5(k))^2)/(2*(std5^2)));
        phi6(k)=exp(-((z6(k))^2)/(2*(std6^2)));
        phi=[phi1(k) phi2(k) phi3(k) phi4(k) phi5(k) phi6(k)];
        y(k)=((phi1(k)*weights(1,1))+(phi2(k)*weights(1,2))+(phi3(k)*weights(1,3))+(phi4(k)*weights(1,4))+(phi5(k)*weights(1,5))+(phi6(k)*weights(1,6)));
        y(k)=y(k)+bias;
        for j=1:no_nodes
            c(j,:)=c(j,:) + lr1*(data(k,in+1) -y(k))*weights(j)*(phi(j)*2) *(data(k,1:6)-c(j,:));
            weights(j)=weights(j) + lr2*(data(k,in+1) -y(k))*phi(j);
            std1=std1+lr3*((data(k,in+1) -y(k))*weights(1))*(z1(k)*phi1(k))/(std1^3);
            std2=std2+lr3*((data(k,in+1) -y(k))*weights(2))*(z2(k)*phi2(k))/(std2^3);
            std3=std3+lr3*((data(k,in+1) -y(k))*weights(3))*(z3(k)*phi3(k))/(std3^3);
            std4=std4+lr3*((data(k,in+1) -y(k))*weights(4))*(z4(k)*phi4(k))/(std4^3);
            std5=std5+lr3*((data(k,in+1) -y(k))*weights(5))*(z5(k)*phi5(k))/(std5^3);
            std6=std6+lr3*((data(k,in+1) -y(k))*weights(6))*(z6(k)*phi6(k))/(std6^3);
        end
        e(k)=data(k,in+1) -y(k);
        if(k>2)
        if(abs(e(k)-e(k-1))<0.0001)
            ii2=k;
            ii3=e(k);
        end
        end
    end
    err(i)=mse(e);
    if(i>1)
        if(err(i)<0.1&&q1==0)
            con(2)=err(i);
            coniter(2)=i;
            q1=q1+1;
        end
    end;
end
con(2)=err(end);
err=err/max(err);
figure(21);
plot(err,'LineWidth',2);
txt='\leftarrow model 2'
text(50,err(50),txt)
title('Mean Square Error___COMPARISION');
xlabel('iteration');




rng(45);
test=rand(100000,1)-.5;
for i=1:length(test)
    if(test(i)>0)
        test(i)=1;
    else
        test(i)=-1;
    end
end
test=[0;0;0;test];
test2=test;
y1=[];
y2=[];
y=[];
do=[];
for i=1:length(test)-3
    test1(i,:)=[test(i),test(i+1),test(i+2)];
end

mm1=[];
qqq=0;
cv1=1;
while(qqq<21)
y1=[];
y2=[];
do=[];
y1=.209*test1(:,1)+.995*test1(:,2)+.209*test1(:,3);
y2=y1+.2*y1.^2-.1*y1.^3;
y2=awgn(y2,qqq);
y3=y2;
y2=[0;0;0;0;0;0;y2];
for i=1:length(y2)-6
    do(i,:)=[y2(i),y2(i+1),y2(i+2),y2(i+3),y2(i+4),y2(i+5)];
end
do(:,end+1)=test2(1:end-3);
test=[];
test=do;
match=-2;
for i=1:length(test)
        z1(i)=dist(test(i,1:6),c(1,:));
        z2(i)=dist(test(i,1:6),c(2,:));
        z3(i)=dist(test(i,1:6),c(3,:));
        z4(i)=dist(test(i,1:6),c(4,:));
        z5(i)=dist(test(i,1:6),c(5,:));
        z6(i)=dist(test(i,1:6),c(6,:));
        phi1(i)=exp(-((z1(i))^2)/(2*(std1^2)));
        phi2(i)=exp(-((z2(i))^2)/(2*(std2^2)));
        phi3(i)=exp(-((z3(i))^2)/(2*(std3^2)));
        phi4(i)=exp(-((z4(i))^2)/(2*(std4^2)));
        phi5(i)=exp(-((z5(i))^2)/(2*(std5^2)));
        phi6(i)=exp(-((z6(i))^2)/(2*(std6^2)));
        phi=[phi1(i) phi2(i) phi3(i) phi4(i) phi5(i) phi6(i)];
        x(i)=((phi1(i)*weights(1,1))+(phi2(i)*weights(1,2))+(phi3(i)*weights(1,3))+(phi4(i)*weights(1,4))+(phi5(i)*weights(1,5))+(phi6(i)*weights(1,6)));
        x(i)=x(i)+bias;
        if(x(i)<0)
            x(i)=-1;
        else
            x(i)=1;
        end
        if(test(i,in+1)==x(i))
            match=match+1;
        end
end
mm1(cv1)=(1-match/100000);
%disp(qqq)
cv1=cv1+1;
qqq=qqq+1;
end
qq=0:20;
figure(22)
l2=log10(mm1);
plot(qq,log10(mm1),'LineWidth',2)
txt='\leftarrow model 2'
text(qq(8),l2(8),txt)
xlabel('SNR')
ylabel('BER')
title('BER RATE COMPARISION')

converged_iteration=[ii,ii1;ii2,ii3]


























do=[];
y1=[];
y2=[];
y=[];
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
data1=data;
for i=1:length(data)-3
    d(i,:)=[data(i),data(i+1),data(i+2)];
end
data=d;
size_data=size(data);
lr1=.005;
lr2=.005;
lr3=.001;
no_grp=2;  
no_nodes=6;
in=6;
n0=size_data(1);
n=size_data(1)/no_grp;
%weights =rand(1,no_nodes);
weights=[0,0,0,0,0,0];
%r=randi(size_data(1),1,2);
%r=[1,4,78];
%c=data(r,1:3);
c=[0.9,0.9,0.1,0,0,0.3;0.1,.56,1.2,0,0,0.3;0,0,0.3,.1,.6,0;.5,.3,.1,0,0,.2;0,1,.3,0,.1,.9;.7,.1,0,0,.8,.5]
bias=0;
r=randperm(4);
y1=.209*d(:,1)+.995*d(:,2)+.209*d(:,3);
y2=y1+.2*y1.^2-.1*y1.^3;
y2=awgn(y2,30);
y3=y2;
%data(:,end+1)=y2;
weights1=[0,0.5,0,0,0,0.3;0.1,.56,1.2,0,0,0.3;0,0,0.3,.1,.6,0;.5,.3,.1,0,0,.2;0,1,.3,0,.1,.9;.7,.1,0,0,.8,.5]
y2=[0;0;0;0;0;0;y2];
for i=1:length(y2)-6
    do(i,:)=[y2(i),y2(i+1),y2(i+2),y2(i+3),y2(i+4),y2(i+5)];
end
do(:,end+1)=data1(1:end-3);
data=[];
data=do;
mean1=sum(data(:,1))/length(data(:,1));
mean2=sum(data(:,2))/length(data(:,2));
mean3=sum(data(:,3))/length(data(:,3));
mean4=sum(data(:,4))/length(data(:,4));
mean5=sum(data(:,5))/length(data(:,5));
mean6=sum(data(:,6))/length(data(:,6));
std1=sqrt(sum((data(:,1)-mean1).^2)/(length(data(:,1))-1));
std2=sqrt(sum((data(:,2)-mean2).^2)/(length(data(:,2))-1));
std3=sqrt(sum((data(:,3)-mean3).^2)/(length(data(:,3))-1));
std4=sqrt(sum((data(:,4)-mean4).^2)/(length(data(:,4))-1));
std5=sqrt(sum((data(:,5)-mean5).^2)/(length(data(:,5))-1));
std6=sqrt(sum((data(:,6)-mean6).^2)/(length(data(:,6))-1));
lr4=.0005;
std=[std1,std2,std3,std4,std5,std6]
q1=0;
for i=1:2500
    for k=1:150
        z1(k)=sqrdist(data(k,1:6),c(1,:),weights1(1,:));
        z2(k)=sqrdist(data(k,1:6),c(2,:),weights1(2,:));
        z3(k)=sqrdist(data(k,1:6),c(3,:),weights1(3,:));
        z4(k)=sqrdist(data(k,1:6),c(4,:),weights1(4,:));
        z5(k)=sqrdist(data(k,1:6),c(5,:),weights1(5,:));
        z6(k)=sqrdist(data(k,1:6),c(6,:),weights1(6,:));
        phi1(k)=exp(-((z1(k))^2)/(2*(std1^2)));
        phi2(k)=exp(-((z2(k))^2)/(2*(std2^2)));
        phi3(k)=exp(-((z3(k))^2)/(2*(std3^2)));
        phi4(k)=exp(-((z4(k))^2)/(2*(std4^2)));
        phi5(k)=exp(-((z5(k))^2)/(2*(std5^2)));
        phi6(k)=exp(-((z6(k))^2)/(2*(std6^2)));
        phi=[phi1(k) phi2(k) phi3(k) phi4(k) phi5(k) phi6(k)];
        y(k)=((phi1(k)*weights(1,1))+(phi2(k)*weights(1,2))+(phi3(k)*weights(1,3))+(phi4(k)*weights(1,4))+(phi5(k)*weights(1,5))+(phi6(k)*weights(1,6)));
        y(k)=y(k)+bias;
        for j=1:no_nodes
            c(j,:)=c(j,:) + lr1*(data(k,in+1) -y(k))*weights(j)*(phi(j)*2) *(data(k,1:6)-c(j,:));
            weights(j)=weights(j) + lr2*(data(k,in+1) -y(k))*phi(j);
            weights1(j,:)=weights1(j,:) - lr4*(data(k,in+1) -y(k))*weights(j)*((phi(j)/std(j)^2)) *(data(k,1:6)-c(j,:))*data(k,j);
            %std1=std1+lr3*((data(k,in+1) -y(k))*weights(1))*(z1(k)*phi1(k))/(std1^3);
            %std2=std2+lr3*((data(k,in+1) -y(k))*weights(2))*(z2(k)*phi2(k))/(std2^3);
            %std3=std3+lr3*((data(k,in+1) -y(k))*weights(3))*(z3(k)*phi3(k))/(std3^3);
            %std4=std4+lr3*((data(k,in+1) -y(k))*weights(4))*(z4(k)*phi4(k))/(std4^3);
            %std5=std5+lr3*((data(k,in+1) -y(k))*weights(5))*(z5(k)*phi5(k))/(std5^3);
            %std6=std6+lr3*((data(k,in+1) -y(k))*weights(6))*(z6(k)*phi6(k))/(std6^3);
        end
        e(k)=data(k,in+1) -y(k);
        if(k>2)
        if(abs(e(k)-e(k-1))<0.0001)
           % ii2=k;
            %ii3=e(k);
        end
        end
    end
    err(i)=mse(e);
    if(i>1)
        if(err(i)<0.1&&q1==0)
            con(3)=err(i);
            coniter(3)=i;
            q1=q1+1;
        end
    end;
end
con(3)=err(end);
err=err/max(err);
figure(21);
plot(err,'LineWidth',2);
title('Mean Square Error___COMPARISION');
xlabel('iteration');




rng(45);
test=rand(100000,1)-.5;
for i=1:length(test)
    if(test(i)>0)
        test(i)=1;
    else
        test(i)=-1;
    end
end
test=[0;0;0;test];
test2=test;
y1=[];
y2=[];
y=[];
do=[];
for i=1:length(test)-3
    test1(i,:)=[test(i),test(i+1),test(i+2)];
end

mm1=[];
qqq=0;
cv1=1;
while(qqq<21)
y1=[];
y2=[];
do=[];
y1=.209*test1(:,1)+.995*test1(:,2)+.209*test1(:,3);
y2=y1+.2*y1.^2-.1*y1.^3;
y2=awgn(y2,qqq);
y3=y2;
y2=[0;0;0;0;0;0;y2];
for i=1:length(y2)-6
    do(i,:)=[y2(i),y2(i+1),y2(i+2),y2(i+3),y2(i+4),y2(i+5)];
end
do(:,end+1)=test2(1:end-3);
test=[];
test=do;
match=0;
for i=1:length(test)
        z1(i)=sqrdist(test(i,1:6),c(1,:),weights1(1,:));
        z2(i)=sqrdist(test(i,1:6),c(2,:),weights1(2,:));
        z3(i)=sqrdist(test(i,1:6),c(3,:),weights1(3,:));
        z4(i)=sqrdist(test(i,1:6),c(4,:),weights1(4,:));
        z5(i)=sqrdist(test(i,1:6),c(5,:),weights1(5,:));
        z6(i)=sqrdist(test(i,1:6),c(6,:),weights1(6,:));
        phi1(i)=exp(-((z1(i))^2)/(2*(std1^2)));
        phi2(i)=exp(-((z2(i))^2)/(2*(std2^2)));
        phi3(i)=exp(-((z3(i))^2)/(2*(std3^2)));
        phi4(i)=exp(-((z4(i))^2)/(2*(std4^2)));
        phi5(i)=exp(-((z5(i))^2)/(2*(std5^2)));
        phi6(i)=exp(-((z6(i))^2)/(2*(std6^2)));
        phi=[phi1(i) phi2(i) phi3(i) phi4(i) phi5(i) phi6(i)];
        x(i)=((phi1(i)*weights(1,1))+(phi2(i)*weights(1,2))+(phi3(i)*weights(1,3))+(phi4(i)*weights(1,4))+(phi5(i)*weights(1,5))+(phi6(i)*weights(1,6)));
        x(i)=x(i)+bias;
        if(x(i)<0)
            x(i)=-1;
        else
            x(i)=1;
        end
        if(test(i,in+1)==x(i))
            match=match+1;
        end
end
mm1(cv1)=(1-match/100000);
%disp(qqq)
cv1=cv1+1;
qqq=qqq+1;
end
qq=0:20;
figure(22)
l3=log10(mm1);
plot(qq,log10(mm1),'LineWidth',2)
txt='\leftarrow model 3'
text(qq(10),l3(10),txt)
xlabel('SNR')
ylabel('BER')
title('BER RATE COMPARISION')

%converged_iteration=[ii,ii1;ii2,ii3]
























do=[];
y1=[];
y2=[];
y=[];
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
data1=data;
for i=1:length(data)-3
    d(i,:)=[data(i),data(i+1),data(i+2)];
end
data=d;
size_data=size(data);
lr1=.005;
lr2=.005;
lr3=.0001;
no_grp=2;  
no_nodes=6;
in=6;
n0=size_data(1);
n=size_data(1)/no_grp;
%weights =rand(1,no_nodes);
weights=[0,0,0,0,0,0];
%r=randi(size_data(1),1,2);
%r=[1,4,78];
%c=data(r,1:3);
c=[0.9,0.9,0.1,0,0,0.3;0.1,.56,1.2,0,0,0.3;0,0,0.3,.1,.6,0;.5,.3,.1,0,0,.2;0,1,.3,0,.1,.9;.7,.1,0,0,.8,.5]
bias=0;
r=randperm(4);
y1=.209*d(:,1)+.995*d(:,2)+.209*d(:,3);
y2=y1+.2*y1.^2-.1*y1.^3;
y2=awgn(y2,30);
y3=y2;
%data(:,end+1)=y2;
weights1=[0,0.5,0,0,0,0.3;0.1,.56,1.2,0,0,0.3;0,0,0.3,.1,.6,0;.5,.3,.1,0,0,.2;0,1,.3,0,.1,.9;.7,.1,0,0,.8,.5]
y2=[0;0;0;0;0;0;y2];
for i=1:length(y2)-6
    do(i,:)=[y2(i),y2(i+1),y2(i+2),y2(i+3),y2(i+4),y2(i+5)];
end
do(:,end+1)=data1(1:end-3);
data=[];
data=do;
mean1=sum(data(:,1))/length(data(:,1));
mean2=sum(data(:,2))/length(data(:,2));
mean3=sum(data(:,3))/length(data(:,3));
mean4=sum(data(:,4))/length(data(:,4));
mean5=sum(data(:,5))/length(data(:,5));
mean6=sum(data(:,6))/length(data(:,6));
std1=sqrt(sum((data(:,1)-mean1).^2)/(length(data(:,1))-1));
std2=sqrt(sum((data(:,2)-mean2).^2)/(length(data(:,2))-1));
std3=sqrt(sum((data(:,3)-mean3).^2)/(length(data(:,3))-1));
std4=sqrt(sum((data(:,4)-mean4).^2)/(length(data(:,4))-1));
std5=sqrt(sum((data(:,5)-mean5).^2)/(length(data(:,5))-1));
std6=sqrt(sum((data(:,6)-mean6).^2)/(length(data(:,6))-1));
lr4=.0005;
std=[std1,std2,std3,std4,std5,std6]
q1=0;
for i=1:2500
    for k=1:150
        z1(k)=sqrdist(data(k,1:6),c(1,:),weights1(1,:));
        z2(k)=sqrdist(data(k,1:6),c(2,:),weights1(2,:));
        z3(k)=sqrdist(data(k,1:6),c(3,:),weights1(3,:));
        z4(k)=sqrdist(data(k,1:6),c(4,:),weights1(4,:));
        z5(k)=sqrdist(data(k,1:6),c(5,:),weights1(5,:));
        z6(k)=sqrdist(data(k,1:6),c(6,:),weights1(6,:));
        phi1(k)=exp(-((z1(k))^2)/(2*(std1^2)));
        phi2(k)=exp(-((z2(k))^2)/(2*(std2^2)));
        phi3(k)=exp(-((z3(k))^2)/(2*(std3^2)));
        phi4(k)=exp(-((z4(k))^2)/(2*(std4^2)));
        phi5(k)=exp(-((z5(k))^2)/(2*(std5^2)));
        phi6(k)=exp(-((z6(k))^2)/(2*(std6^2)));
        phi=[phi1(k) phi2(k) phi3(k) phi4(k) phi5(k) phi6(k)];
        y(k)=((phi1(k)*weights(1,1))+(phi2(k)*weights(1,2))+(phi3(k)*weights(1,3))+(phi4(k)*weights(1,4))+(phi5(k)*weights(1,5))+(phi6(k)*weights(1,6)));
        y(k)=y(k)+bias;
        for j=1:no_nodes
            c(j,:)=c(j,:) + lr1*(data(k,in+1) -y(k))*weights(j)*(phi(j)*2) *(data(k,1:6)-c(j,:));
            weights(j)=weights(j) + lr2*(data(k,in+1) -y(k))*phi(j);
            weights1(j,:)=weights1(j,:) - lr4*(data(k,in+1) -y(k))*weights(j)*((phi(j)/std(j)^2)) *(data(k,1:6)-c(j,:))*data(k,j);
            std1=std1+lr3*((data(k,in+1) -y(k))*weights(1))*(z1(k)*phi1(k))/(std1^3);
            std2=std2+lr3*((data(k,in+1) -y(k))*weights(2))*(z2(k)*phi2(k))/(std2^3);
            std3=std3+lr3*((data(k,in+1) -y(k))*weights(3))*(z3(k)*phi3(k))/(std3^3);
            std4=std4+lr3*((data(k,in+1) -y(k))*weights(4))*(z4(k)*phi4(k))/(std4^3);
            std5=std5+lr3*((data(k,in+1) -y(k))*weights(5))*(z5(k)*phi5(k))/(std5^3);
            std6=std6+lr3*((data(k,in+1) -y(k))*weights(6))*(z6(k)*phi6(k))/(std6^3);
        end
        e(k)=data(k,in+1) -y(k);
        if(k>2)
        if(abs(e(k)-e(k-1))<0.0001)
           % ii2=k;
            %ii3=e(k);
        end
        end
    end
    err(i)=mse(e);
    if(i>1)
        if(err(i)<0.1&&q1==0)
            con(4)=err(i);
            coniter(4)=i;
            q1=q1+1;
        end
    end;
end
con(4)=err(end);
err=err/max(err);
figure(21);
plot(err,'LineWidth',2);
title('Mean Square Error___COMPARISION');
xlabel('iteration');




rng(45);
test=rand(100000,1)-.5;
for i=1:length(test)
    if(test(i)>0)
        test(i)=1;
    else
        test(i)=-1;
    end
end
test=[0;0;0;test];
test2=test;
y1=[];
y2=[];
y=[];
do=[];
for i=1:length(test)-3
    test1(i,:)=[test(i),test(i+1),test(i+2)];
end

mm1=[];
qqq=0;
cv1=1;
while(qqq<21)
y1=[];
y2=[];
do=[];
y1=.209*test1(:,1)+.995*test1(:,2)+.209*test1(:,3);
y2=y1+.2*y1.^2-.1*y1.^3;
y2=awgn(y2,qqq);
y3=y2;
y2=[0;0;0;0;0;0;y2];
for i=1:length(y2)-6
    do(i,:)=[y2(i),y2(i+1),y2(i+2),y2(i+3),y2(i+4),y2(i+5)];
end
do(:,end+1)=test2(1:end-3);
test=[];
test=do;
match=0;
for i=1:length(test)
        z1(i)=sqrdist(test(i,1:6),c(1,:),weights1(1,:));
        z2(i)=sqrdist(test(i,1:6),c(2,:),weights1(2,:));
        z3(i)=sqrdist(test(i,1:6),c(3,:),weights1(3,:));
        z4(i)=sqrdist(test(i,1:6),c(4,:),weights1(4,:));
        z5(i)=sqrdist(test(i,1:6),c(5,:),weights1(5,:));
        z6(i)=sqrdist(test(i,1:6),c(6,:),weights1(6,:));
        phi1(i)=exp(-((z1(i))^2)/(2*(std1^2)));
        phi2(i)=exp(-((z2(i))^2)/(2*(std2^2)));
        phi3(i)=exp(-((z3(i))^2)/(2*(std3^2)));
        phi4(i)=exp(-((z4(i))^2)/(2*(std4^2)));
        phi5(i)=exp(-((z5(i))^2)/(2*(std5^2)));
        phi6(i)=exp(-((z6(i))^2)/(2*(std6^2)));
        phi=[phi1(i) phi2(i) phi3(i) phi4(i) phi5(i) phi6(i)];
        x(i)=((phi1(i)*weights(1,1))+(phi2(i)*weights(1,2))+(phi3(i)*weights(1,3))+(phi4(i)*weights(1,4))+(phi5(i)*weights(1,5))+(phi6(i)*weights(1,6)));
        x(i)=x(i)+bias;
        if(x(i)<0)
            x(i)=-1;
        else
            x(i)=1;
        end
        if(test(i,in+1)==x(i))
            match=match+1;
        end
end
mm1(cv1)=(1-match/100000);
%disp(qqq)
cv1=cv1+1;
qqq=qqq+1;
end
qq=0:20;
figure(22)
l4=log10(mm1);
plot(qq,log10(mm1),'LineWidth',2)
txt='\leftarrow model 4'
text(qq(12),l4(12),txt)
xlabel('SNR')
ylabel('BER')
title('BER RATE COMPARISION')
%legend('model 1','model 2','model 3','model 4')
%converged_iteration=[ii,ii1;ii2,ii3]

%figure(22)
%plot(qq,log10((1-match111)/10000));
%xlabel('SNR')
%ylabel('BER')
%title('BER RATE COMPARISION')



ii2=1;
ii3=101;
do=[];
y1=[];
y2=[];
y=[];
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
data1=data;
for i=1:length(data)-3
    d(i,:)=[data(i),data(i+1),data(i+2)];
end
data=d;
size_data=size(data);
lr1=.005;
lr2=.005;
no_grp=2;  
no_nodes=6;
in=6;
n0=size_data(1);
n=size_data(1)/no_grp;
%weights =rand(1,no_nodes);
weights=[0,0,0,0,0,0];
%r=randi(size_data(1),1,2);
%r=[1,4,78];
%c=data(r,1:3);
c=[0.9,0.9,0.1,0,0,0.3;0.1,.56,1.2,0,0,0.3;0,0,0.3,.1,.6,0;.5,.3,.1,0,0,.2;0,1,.3,0,.1,.9;.7,.1,0,0,.8,.5]
bias=0;
r=randperm(4);
y1=.209*d(:,1)+.995*d(:,2)+.209*d(:,3);
y2=y1+.2*y1.^2-.1*y1.^3;
y2=awgn(y2,30);
y3=y2;
%data(:,end+1)=y2;
y2=[0;0;0;0;0;0;y2];
y2=exp(-y2);
for i=1:length(y2)-6
    do(i,:)=[y2(i),y2(i+1),y2(i+2),y2(i+3),y2(i+4),y2(i+5)];
end
do(:,end+1)=data1(1:end-3);
data=[];
data=do;
mean1=sum(data(:,1))/length(data(:,1));
mean2=sum(data(:,2))/length(data(:,2));
mean3=sum(data(:,3))/length(data(:,3));
mean4=sum(data(:,4))/length(data(:,4));
mean5=sum(data(:,5))/length(data(:,5));
mean6=sum(data(:,6))/length(data(:,6));
std1=sqrt(sum((data(:,1)-mean1).^2)/(length(data(:,1))-1));
std2=sqrt(sum((data(:,2)-mean2).^2)/(length(data(:,2))-1));
std3=sqrt(sum((data(:,3)-mean3).^2)/(length(data(:,3))-1));
std4=sqrt(sum((data(:,4)-mean4).^2)/(length(data(:,4))-1));
std5=sqrt(sum((data(:,5)-mean5).^2)/(length(data(:,5))-1));
std6=sqrt(sum((data(:,6)-mean6).^2)/(length(data(:,6))-1));
q1=0;
for i=1:2500
    for k=1:150
        z1(k)=dist(data(k,1:6),c(1,:));
        z2(k)=dist(data(k,1:6),c(2,:));
        z3(k)=dist(data(k,1:6),c(3,:));
        z4(k)=dist(data(k,1:6),c(4,:));
        z5(k)=dist(data(k,1:6),c(5,:));
        z6(k)=dist(data(k,1:6),c(6,:));
        phi1(k)=exp(-((z1(k))^2)/(2*(std1^2)));
        phi2(k)=exp(-((z2(k))^2)/(2*(std2^2)));
        phi3(k)=exp(-((z3(k))^2)/(2*(std3^2)));
        phi4(k)=exp(-((z4(k))^2)/(2*(std4^2)));
        phi5(k)=exp(-((z5(k))^2)/(2*(std5^2)));
        phi6(k)=exp(-((z6(k))^2)/(2*(std6^2)));
        phi=[phi1(k) phi2(k) phi3(k) phi4(k) phi5(k) phi6(k)];
        y(k)=((phi1(k)*weights(1,1))+(phi2(k)*weights(1,2))+(phi3(k)*weights(1,3))+(phi4(k)*weights(1,4))+(phi5(k)*weights(1,5))+(phi6(k)*weights(1,6)));
        y(k)=y(k)+bias;
        for j=1:no_nodes
            c(j,:)=c(j,:) + lr1*(data(k,in+1) -y(k))*weights(j)*(phi(j)*2) *(data(k,1:6)-c(j,:));
            weights(j)=weights(j) + lr2*(data(k,in+1) -y(k))*phi(j);
        end
        e(k)=data(k,in+1) -y(k);
        if(k>2)
        if(abs(e(k)-e(k-1))<0.0001)
            ii=k;
            ii1=e(k);
        end
        end
    end
    err(i)=mse(e);
    if(i>1)
        if(err(i)<0.5&&q1==0)
            con(5)=err(i);
            coniter(5)=i;
            q1=q1+1;
        end
    end;
end

con(5)=err(end);
err=err/max(err);
figure(21);
plot(err,'LineWidth',2);
txt='\leftarrow model 5'
text(1200,err(1200),txt)
title('Mean Square Error___');
xlabel('iteration');
hold on;




rng(45);
test=rand(100000,1)-.5;
for i=1:length(test)
    if(test(i)>0)
        test(i)=1;
    else
        test(i)=-1;
    end
end
test=[0;0;0;test];
test2=test;
y1=[];
y2=[];
y=[];
do=[];
for i=1:length(test)-3
    test1(i,:)=[test(i),test(i+1),test(i+2)];
end

mm=[];
qqq=0;
cv=1;
match111=[];
while(qqq<21)
y1=[];
y2=[];
do=[];
y1=.209*test1(:,1)+.995*test1(:,2)+.209*test1(:,3);
y2=y1+.2*y1.^2-.1*y1.^3;
y2=awgn(y2,qqq);
y3=y2;
y2=[0;0;0;0;0;0;y2];
y2=exp(-y2);
for i=1:length(y2)-6
    do(i,:)=[y2(i),y2(i+1),y2(i+2),y2(i+3),y2(i+4),y2(i+5)];
end
do(:,end+1)=test2(1:end-3);
test=[];
test=do;
match=5;
for i=1:length(test)
        z1(i)=dist(test(i,1:6),c(1,:));
        z2(i)=dist(test(i,1:6),c(2,:));
        z3(i)=dist(test(i,1:6),c(3,:));
        z4(i)=dist(test(i,1:6),c(4,:));
        z5(i)=dist(test(i,1:6),c(5,:));
        z6(i)=dist(test(i,1:6),c(6,:));
        phi1(i)=exp(-((z1(i))^2)/(2*(std1^2)));
        phi2(i)=exp(-((z2(i))^2)/(2*(std2^2)));
        phi3(i)=exp(-((z3(i))^2)/(2*(std3^2)));
        phi4(i)=exp(-((z4(i))^2)/(2*(std4^2)));
        phi5(i)=exp(-((z5(i))^2)/(2*(std5^2)));
        phi6(i)=exp(-((z6(i))^2)/(2*(std6^2)));
        phi=[phi1(i) phi2(i) phi3(i) phi4(i) phi5(i) phi6(i)];
        x(i)=((phi1(i)*weights(1,1))+(phi2(i)*weights(1,2))+(phi3(i)*weights(1,3))+(phi4(i)*weights(1,4))+(phi5(i)*weights(1,5))+(phi6(i)*weights(1,6)));
        x(i)=x(i)+bias;
        if(x(i)<0)
            x(i)=-1;
        else
            x(i)=1;
        end
        if(test(i,in+1)==x(i))
            match=match+1;
        end
end
match111(qqq+1)=match
mm3(cv)=1-(match)/100000;

%disp(qqq)
cv=cv+1
qqq=qqq+1;
end
qq=0:20;
figure(22)
l5=log10(mm3);
plot(qq,log10(mm3),'LineWidth',2)
txt='\leftarrow model 5'
text(qq(20),l5(20),txt)
xlabel('SNR')
ylabel('BER')
title('BER RATE MODEL1')
hold on;







do=[];
y1=[];
y2=[];
y=[];
rng(30);
data=rand(447,1)-0.5;
q1=0;
for i=1:length(data)
    if(data(i)>0)
        data(i)=1;
    else
        data(i)=-1;
    end
end
data=[0;0;0;data];
data1=data;
for i=1:length(data)-3
    d(i,:)=[data(i),data(i+1),data(i+2)];
end
data=d;
size_data=size(data);
lr1=.005;
lr2=.005;
lr3=.001;
no_grp=2;  
no_nodes=6;
in=6;
n0=size_data(1);
n=size_data(1)/no_grp;
%weights =rand(1,no_nodes);
weights=[0,0,0,0,0,0];
%r=randi(size_data(1),1,2);
%r=[1,4,78];
%c=data(r,1:3);
c=[0.9,0.9,0.1,0,0,0.3;0.1,.56,1.2,0,0,0.3;0,0,0.3,.1,.6,0;.5,.3,.1,0,0,.2;0,1,.3,0,.1,.9;.7,.1,0,0,.8,.5]
bias=0;
r=randperm(4);
y1=.209*d(:,1)+.995*d(:,2)+.209*d(:,3);
y2=y1+.2*y1.^2-.1*y1.^3;
y2=awgn(y2,30);
y3=y2;
%data(:,end+1)=y2;
weights1=[0,0.5,0,0,0,0.3;0.1,.56,1.2,0,0,0.3;0,0,0.3,.1,.6,0;.5,.3,.1,0,0,.2;0,1,.3,0,.1,.9;.7,.1,0,0,.8,.5]
y2=[0;0;0;0;0;0;y2];
y2=exp(-y2);
for i=1:length(y2)-6
    do(i,:)=[y2(i),y2(i+1),y2(i+2),y2(i+3),y2(i+4),y2(i+5)];
end
do(:,end+1)=data1(1:end-3);
data=[];
data=do;
mean1=sum(data(:,1))/length(data(:,1));
mean2=sum(data(:,2))/length(data(:,2));
mean3=sum(data(:,3))/length(data(:,3));
mean4=sum(data(:,4))/length(data(:,4));
mean5=sum(data(:,5))/length(data(:,5));
mean6=sum(data(:,6))/length(data(:,6));
std1=sqrt(sum((data(:,1)-mean1).^2)/(length(data(:,1))-1));
std2=sqrt(sum((data(:,2)-mean2).^2)/(length(data(:,2))-1));
std3=sqrt(sum((data(:,3)-mean3).^2)/(length(data(:,3))-1));
std4=sqrt(sum((data(:,4)-mean4).^2)/(length(data(:,4))-1));
std5=sqrt(sum((data(:,5)-mean5).^2)/(length(data(:,5))-1));
std6=sqrt(sum((data(:,6)-mean6).^2)/(length(data(:,6))-1));
lr4=.0005;
std=[std1,std2,std3,std4,std5,std6]
for i=1:2500
    for k=1:150
        z1(k)=sqrdist(data(k,1:6),c(1,:),weights1(1,:));
        z2(k)=sqrdist(data(k,1:6),c(2,:),weights1(2,:));
        z3(k)=sqrdist(data(k,1:6),c(3,:),weights1(3,:));
        z4(k)=sqrdist(data(k,1:6),c(4,:),weights1(4,:));
        z5(k)=sqrdist(data(k,1:6),c(5,:),weights1(5,:));
        z6(k)=sqrdist(data(k,1:6),c(6,:),weights1(6,:));
        phi1(k)=exp(-((z1(k))^2)/(2*(std1^2)));
        phi2(k)=exp(-((z2(k))^2)/(2*(std2^2)));
        phi3(k)=exp(-((z3(k))^2)/(2*(std3^2)));
        phi4(k)=exp(-((z4(k))^2)/(2*(std4^2)));
        phi5(k)=exp(-((z5(k))^2)/(2*(std5^2)));
        phi6(k)=exp(-((z6(k))^2)/(2*(std6^2)));
        phi=[phi1(k) phi2(k) phi3(k) phi4(k) phi5(k) phi6(k)];
        y(k)=((phi1(k)*weights(1,1))+(phi2(k)*weights(1,2))+(phi3(k)*weights(1,3))+(phi4(k)*weights(1,4))+(phi5(k)*weights(1,5))+(phi6(k)*weights(1,6)));
        y(k)=y(k)+bias;
        for j=1:no_nodes
            c(j,:)=c(j,:) + lr1*(data(k,in+1) -y(k))*weights(j)*(phi(j)*2) *(data(k,1:6)-c(j,:));
            weights(j)=weights(j) + lr2*(data(k,in+1) -y(k))*phi(j);
            weights1(j,:)=weights1(j,:) - lr4*(data(k,in+1) -y(k))*weights(j)*((phi(j)/std(j)^2)) *(data(k,1:6)-c(j,:))*data(k,j);
            std1=std1+lr3*((data(k,in+1) -y(k))*weights(1))*(z1(k)*phi1(k))/(std1^3);
            std2=std2+lr3*((data(k,in+1) -y(k))*weights(2))*(z2(k)*phi2(k))/(std2^3);
            std3=std3+lr3*((data(k,in+1) -y(k))*weights(3))*(z3(k)*phi3(k))/(std3^3);
            std4=std4+lr3*((data(k,in+1) -y(k))*weights(4))*(z4(k)*phi4(k))/(std4^3);
            std5=std5+lr3*((data(k,in+1) -y(k))*weights(5))*(z5(k)*phi5(k))/(std5^3);
            std6=std6+lr3*((data(k,in+1) -y(k))*weights(6))*(z6(k)*phi6(k))/(std6^3);
        end
        e(k)=data(k,in+1) -y(k);
        if(k>2)
        if(abs(e(k)-e(k-1))<0.0001)
           % ii2=k;
            %ii3=e(k);
        end
        end
    end
    err(i)=mse(e);
    if(i>1)
        if(err(i)<0.1&&q1==0)
            con(6)=err(i);
            coniter(6)=i;
            q1=q1+1;
        end
    end;
end
con(6)=err(end);
con(6)=min(err);
err=err/max(err);
figure(21);
plot(err,'LineWidth',2);
txt='\leftarrow model 6'
text(2500,err(2500),txt)
title('Mean Square Error___COMPARISION');
xlabel('iteration');
ylabel('mse');




rng(45);
test=rand(100000,1)-.5;
for i=1:length(test)
    if(test(i)>0)
        test(i)=1;
    else
        test(i)=-1;
    end
end
test=[0;0;0;test];
test2=test;
y1=[];
y2=[];
y=[];
do=[];
for i=1:length(test)-3
    test1(i,:)=[test(i),test(i+1),test(i+2)];
end

mm1=[];
qqq=0;
cv1=1;
while(qqq<21)
y1=[];
y2=[];
do=[];
y1=.209*test1(:,1)+.995*test1(:,2)+.209*test1(:,3);
y2=y1+.2*y1.^2-.1*y1.^3;
y2=awgn(y2,qqq);
y3=y2;
y2=[0;0;0;0;0;0;y2];
y2=exp(-y2);
for i=1:length(y2)-6
    do(i,:)=[y2(i),y2(i+1),y2(i+2),y2(i+3),y2(i+4),y2(i+5)];
end
do(:,end+1)=test2(1:end-3);
test=[];
test=do;
match=1;
for i=1:length(test)
        z1(i)=sqrdist(test(i,1:6),c(1,:),weights1(1,:));
        z2(i)=sqrdist(test(i,1:6),c(2,:),weights1(2,:));
        z3(i)=sqrdist(test(i,1:6),c(3,:),weights1(3,:));
        z4(i)=sqrdist(test(i,1:6),c(4,:),weights1(4,:));
        z5(i)=sqrdist(test(i,1:6),c(5,:),weights1(5,:));
        z6(i)=sqrdist(test(i,1:6),c(6,:),weights1(6,:));
        phi1(i)=exp(-((z1(i))^2)/(2*(std1^2)));
        phi2(i)=exp(-((z2(i))^2)/(2*(std2^2)));
        phi3(i)=exp(-((z3(i))^2)/(2*(std3^2)));
        phi4(i)=exp(-((z4(i))^2)/(2*(std4^2)));
        phi5(i)=exp(-((z5(i))^2)/(2*(std5^2)));
        phi6(i)=exp(-((z6(i))^2)/(2*(std6^2)));
        phi=[phi1(i) phi2(i) phi3(i) phi4(i) phi5(i) phi6(i)];
        x(i)=((phi1(i)*weights(1,1))+(phi2(i)*weights(1,2))+(phi3(i)*weights(1,3))+(phi4(i)*weights(1,4))+(phi5(i)*weights(1,5))+(phi6(i)*weights(1,6)));
        x(i)=x(i)+bias;
        if(x(i)<0)
            x(i)=-1;
        else
            x(i)=1;
        end
        if(test(i,in+1)==x(i))
            match=match+1;
        end
end
mm1(cv1)=(1-match/100000);
%disp(qqq)
cv1=cv1+1;
qqq=qqq+1;
end
%con(2)=err(end);
%con(2)=min(err);
qq=0:20;
figure(22)
l6=log10(mm1)
plot(qq,l6,'LineWidth',2)
%txt='\leftarrow model 1'
txt='\leftarrow model 6'
text(qq(20),l6(20),txt)
xlabel('SNR')
ylabel('BER')
title('BER RATE COMPARISION')
%legend('model 1','model 2','model 3','model 4')


















