function [ u,v ] = num_diff( a,b,T,h,u0,v0,eps)
    ucurr = u0;
    vcurr = v0;

    for i=1:ceil(T/h)
       u(i)=ucurr;
       v(i)=vcurr;
       unew = (1/eps)*(h*((ucurr*(1-ucurr)*(ucurr-a))-vcurr))+ucurr;
       vnew = (h*(ucurr-(b*vcurr)))+vcurr;
       ucurr = unew;
       vcurr = vnew;
    end
end

