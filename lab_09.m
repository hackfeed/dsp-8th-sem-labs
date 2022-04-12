function main()
I=double(imread('/Users/sekononenko/Study/dsp-8th-sem-labs/bimage3.bmp')) / 255;

figure;
imshow(I); 
title('Source image');

PSF=fspecial('motion', 55, 205);
% PSF=fspecial('motion', 54, 65);
J1=deconvwnr(I, PSF);

figure;
imshow(J1);
title('Recovered image');
end
