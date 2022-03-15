function main()
% Initial state
tt = 2.0;
sigma = 0.5;
mult = 5;
t = -mult:0.05:mult;

% Impulses
x1 = zeros(size(t));
x1(abs(t) - tt < 0) = 1;
x1(abs(t) == tt) = 0.5;
x2 = exp(-(t/sigma).^2);

% FFT
yx1 = fft(x1);
yx2 = fft(x2);

yg1 = fftshift(yx1);
yg2 = fftshift(yx2);

% DFT
zx1 = dft(x1);
zx2 = dft(x2);

zg1 = fftshift(zx1);
zg2 = fftshift(zx2);

M = 0:length(t)-1;

figure;

subplot(2,2,1);
title('FFT: amplitude specter of rectangle impulse');
hold on;
grid on;
plot(M, abs(yx1)/length(M), 'r');
plot(M, abs(yg1)/length(M),'k');
legend('With twins effect', 'Without twins effect');

subplot(2,2,2);
title('FFT: amplitude specter of Gaussian impulse');
hold on;
grid on;
plot(M, abs(yx2)/length(M), 'r');
plot(M, abs(yg2)/length(M), 'k');
legend('With twins effect', 'Without twins effect');

subplot(2,2,3);
title('DFT: amplitude specter of rectangle impulse');
hold on;
grid on;
plot(M, abs(zx1)/length(M), 'r');
plot(M, abs(zg1)/length(M), 'k');
legend('With twins effect', 'Without twins effect');

subplot(2,2,4);
title('DFT: amplitude specter of Gaussian impulse');
hold on;
grid on;
plot(M, abs(zx2)/length(M), 'r');
plot(M, abs(zg2)/length(M), 'k');
legend('With twins effect', 'Without twins effect');
end

% Discrete Fourier transform
function y = dft(x)
a = 0:length(x)-1;
b = -2 * pi * sqrt(-1) * a / length(x);
for i = 1:length(a)
    a(i) = 0;
    for j = 1:length(x)
        a(i) = a(i) + x(j) * exp(b(i) * j);
    end
end
y = a;
end
