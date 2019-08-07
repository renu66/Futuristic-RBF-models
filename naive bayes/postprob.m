function [post] = postprob(x,mean,std)
post=(1/(std*sqrt(2*3.14)))*exp(-(((x-mean)^2)/(2*(std^2))));
end