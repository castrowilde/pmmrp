for k=1:5
    [u,v] = num_diff(0.2,3,100,0.0001,1/k,0,0.01);
    plot(u,v)
    hold on;
end
for k=1:5
    [u,v] = num_diff(0.2,3,100,0.0001,-1/k,0,0.01);
    plot(u,v)
    hold on;
end
for k=1:5
    [u,v] = num_diff(0.2,1,100,0.0001,0.5,0,0.01);
    plot(u,v)
    hold on;
end
    a = u(10000);
    b = v(10000);
    plot(a,b,'o')
hold off;