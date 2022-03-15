function main()
% Initial state
tt = 2.0;
sigma = 1.0;
mult = 5;
t = -mult:0.05:mult;

% Impulses
x1 = [rect_impulse(t,1.0,tt) zeros(1,length(t))];
x2 = [gaussian_impulse(t,tt,sigma) zeros(1,length(t))];
x3 = [rect_impulse(t,tt/2,0.5) zeros(1,length(t))];
x4 = [gaussian_impulse(t,0.5,sigma/2) zeros(1,length(t))];

% Convolution
y1 = ifft(fft(x1).*fft(x2))*0.05;
y2 = ifft(fft(x1).*fft(x3))*0.05;
y3 = ifft(fft(x2).*fft(x4))*0.05;

% Convolution normalization
start = fix((length(y1)-length(t))/2);
y1 = y1(start+1:start+length(t));
y2 = y2(start+1:start+length(t));
y3 = y3(start+1:start+length(t));

figure;

subplot(3,1,1);
title('Rectangle and rectangle convolutions');
hold on;
grid on;
plot(t, x1(1:201), 'r');
plot(t, x3(1:201), 'b');
plot(t, y2, 'k');
legend('Rectangle', 'Rectangle', 'Convolution');

subplot(3,1,2);
title('Rectangle and Gaussian convolutions');
hold on;
grid on;
plot(t, x1(1:201), 'r');
plot(t, x2(1:201), 'b');
plot(t, y1, 'k');
legend('Rectangle', 'Gaussian', 'Convolution');

subplot(3,1,3);
title('Gaussian and Gaussian convolutions');
hold on;
grid on;
plot(t, x2(1:201), 'r');
plot(t, x4(1:201), 'b');
plot(t, y3, 'k');
legend('Gaussian', 'Gaussian', 'Convolution');
end

% Rectangle impulse
function y = rect_impulse(x,T,A)
y = zeros(size(x));
y(abs(x) - T < 0) = A;
y(abs(x) == T) = A/2;
end

% Gaussian impulse
function y = gaussian_impulse(x,A,s)
y = A * exp(-(x/s).^2);
end
