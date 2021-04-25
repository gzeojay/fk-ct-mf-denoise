clear
clc
close all

addpath(genpath(pwd));

load dn.mat;
dAddNoise=dn;
[ d_fKSpectrum,d_nFKSpectrum,d_dNFKSpectrum,d_dNoiseData] = CCTcomplex(dAddNoise);
dn=dAddNoise;
dnd=d_dNoiseData;
%%
figure
imagesc(dAddNoise);xlabel('trace');ylabel('time(ms)');
figure
imagesc(d_dNoiseData);xlabel('trace');ylabel('time(ms)');
figure
imagesc(dAddNoise-d_dNoiseData);xlabel('trace');ylabel('time(ms)');





