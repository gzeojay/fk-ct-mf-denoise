clear
clc
close all

addpath(genpath(pwd));

load dn.mat;
noisy_img=dn;
[nt,trace]=size(noisy_img);
%% f-k
nf=round(nt/2)+1;
fftnoisy_img=fft2(noisy_img);
a=fftnoisy_img(1:nf,:);
b=fftnoisy_img(nf+1:end,:);
% A=[zeros(size(b),trace),b;a,zeros(size(a))];
nFKSpectrum=[fliplr(b),b;a,fliplr(a)];
%%
n = size(nFKSpectrum,1);
sigma = 1;
F = ones(n);
X = fftshift(ifft2(F)) * sqrt(prod(size(F)));
tic, C = fdct_wrapping(X,0); toc;

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
C = fdct_wrapping(nFKSpectrum,0);

% Apply thresholding
Ct = C;
for s = 1:length(C)
  thresh =5*sigma + sigma*(s == length(C));  % 数据9=>0.42  数据5=>0.2  数据10=>5  数据4=>
  for w = 1:length(C{s})
    Ct{s}{w} = C{s}{w}.* (abs(C{s}{w}) > thresh);
  end
end
%%
restored_img = ifdct_wrapping(Ct,0);
%%
[nar,nac]=size(a);
[nbr,nbc]=size(b);
c=restored_img(nbr+1:end,1:nac);
d1=restored_img(1:nbr,nac+1:end);
B=[c;d1];
Crestored_img=real(ifft2(B));
%%
figure
imagesc((noisy_img));
xlabel('trace');
ylabel('time(ms)');
figure
imagesc(Crestored_img);
xlabel('trace');
ylabel('time(ms)');
figure;
imagesc(noisy_img-Crestored_img);
xlabel('trace');
ylabel('time(ms)');