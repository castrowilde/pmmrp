% for j = 2:1:J % J - layers
%     for x = 2:1:n-1 % n - length horizontally
%         for y = 2:1:m-1 % m - length vertically
%             A(x-1,) = (tau * D * ( (A(j,i+1) - 2 * A(j,i) + A(j,i-1)) / h^2)) + A(j,i);    

A=imread('1.gif');
A=A/255.0;
tau = 0.005; % time step
h = 0.01; % x step
D = 1; % coeff
X = 10; % X
T = 100; % max T
n = size(A,2); % length horizontally
m = size(A,1); % length vertically
L = 70;
% A=imread('image.gif');
% A=imread('images.jpg');

for l = 2:L % L - layers
    for j=2:m-1
           for i=2:n-1
               A(j,i,l) = (tau * D * ( (A(j,i+1,l-1) - 2 * A(j,i,l-1) + A(j,i-1,l-1)) / h^2)) + (tau * D * ( (A(j+1,i,l-1) - 2 * A(j,i,l-1) + A(j-1,i,l-1)) / h^2)) + A(j,i,l-1);           
           end          
    end
    imshow(A(:,:,l));
     %plot(A(:,:,l));
     %xlabel('Cell'),ylabel('T'), legend('f(t)');
%      F(k) = getframe;
%      k=k+1;
end
%     movie(F);
    
