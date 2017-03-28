for k=1:5
    [u,v] = num_diff(0.2,9,100,0.001,1/k,0,01);
    plot(u,v)
    hold on;
end
    a = u(10000);
    b = v(10000);
    plot(a,b,'o')
for k=1:5
    [u,v] = num_diff(0.2,9,100,0.001,-k,0,01);
    plot(u,v)
    hold on;
end


for k=1:5
    [u,v] = num_diff(0.2,9,100,0.001,k,0,01);
    plot(u,v);
    hold on;
end
    a = u(10000);
    b = v(10000);
    plot(a,b,'o')

hold off;