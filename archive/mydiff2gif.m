tau = 0.005; % time step
h = 0.1; % x step
D = 1; % coeff
X = 1; % X
T = 10; % max T
n = X/h; % length horizontally // pixels horizontally - 1
m = T/tau; % length vertically // pixels vertically - 1
%A = imread('image2.gif');
A = ones(m+1,n+1);

for j=1:m+1
    A(j,1) = 100;
    A(j,n+1) = 0;
end

for i=1:n+1
    A(m+1,i) = 0;
end

k=1;
figure(1)
filename = 'example.gif';
for j=m+1:-1:2
       for i=2:n
           A(j-1,i) = (tau * D * ( (A(j,i+1) - 2 * A(j,i) + A(j,i-1)) / h^2)) + A(j,i);           
       end
       %imshow(A);
       plot(A(j-1,:),'','DisplayName','temp','Marker','*','LineWidth',3,'Color',[0 0.447058826684952 0.74117648601532]);
       xlabel('Cell');
       ylabel('Temperature');
       title('Diffusion equation in action');
       legend('temp');
       grid on;
%        F(k) = getframe;
%        k=k+1;
      drawnow
      frame = getframe(1);
      im = frame2im(frame);
      [imind,cm] = rgb2ind(im,256);
      if j == m+1;
          imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
      else
          imwrite(imind,cm,filename,'gif','WriteMode','append');
      end
end
%movie(F)

%disp(A);
