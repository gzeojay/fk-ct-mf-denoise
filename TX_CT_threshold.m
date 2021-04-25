clear
clc
close all

addpath(genpath(pwd));

disp(' ');
disp('fdct_wrapping_demo_denoise.m -- Image denoising using Curvelets');
disp(' ');
disp('Denoising is achieved by hard-thresholding of the curvelet coefficients.');
disp('We select the thresholding at 3*sigma_jl for all but the finest scale');
disp('where it is set at 4*sigmajl; here sigma_jl is the noise level of a');
disp('coefficient at scale j and angle l (equal to the noise level times');
disp('the l2 norm of the corresponding curvelet). There are many ways to compute');
disp('the sigma_jl''s, e.g. by computing the norm of each individual curvelet,');
disp('and in this demo, we do an exact computation by applying a forward curvelet');
disp('transform on an image containing a delta function at its center.');
disp(' ');

% fdct_wrapping_demo_denoise.m -- Image denoising using Curvelets

sigma = 1;        
is_real = 1;

load dn.mat;
[nt trace]=size(dn);
noisy_img=dn;
%%
n = size(noisy_img,1);
disp('Compute all thresholds');
F = ones(n);
X = fftshift(ifft2(F)) * sqrt(prod(size(F)));
tic, C = fdct_wrapping(X,0,1,5,8); toc;

% Compute norm of curvelets (exact)
E = cell(size(C));
for s=1:length(C)
  E{s} = cell(size(C{s}));
  for w=1:length(C{s})
    A = C{s}{w};
    E{s}{w} = sqrt(sum(sum(A.*conj(A))) / prod(size(A)));
  end
end

% Take curvelet transform
disp(' ');
disp('Take curvelet transform: fdct_wrapping');
tic; C = fdct_wrapping(noisy_img,0,1,5,8); toc;

% Apply thresholding
Ct = C;
for s = 2:length(C)
    
  thresh = 0.2*sigma + sigma*(s == length(C));  % 数据9=>0.42  数据5=>0.2  数据10=>5  数据4=>
  
  for w = 1:length(C{s})
    Ct{s}{w} = C{s}{w}.* (abs(C{s}{w}) > thresh*E{s}{w});
  end
end

% Take inverse curvelet transform 
disp(' ');
disp('Take inverse transform of thresholded data: ifdct_wrapping');
tic; restored_img = real(ifdct_wrapping(Ct,0,nt,trace)); toc;
%%
figure
% wigb(noisy_img);
imagesc(noisy_img,[-0.6 0.6]);
% colormap(gray);
xlabel('trace');
ylabel('time(ms)');
figure
imagesc(restored_img,[-0.6 0.6]);
% colormap(gray);
xlabel('trace');
ylabel('time(ms)');
figure;
imagesc(noisy_img-restored_img,[-0.6 0.6]);
% colormap(gray);
xlabel('trace');
ylabel('time(ms)');
