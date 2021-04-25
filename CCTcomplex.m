function [ C, Ct, dNFKSpectrum,dNoiseData] = CCTcomplex(noiseData)
%%
%曲波变换
% C = fdct_wrapping(A,0);
%%
%含噪fk谱
noisy_img=noiseData;
[nt,trace]=size(noisy_img);
nf=2^nextpow2(nt);
nk=2^nextpow2(trace);
% break
fftnoisy_img=fft2(noisy_img,nf,nk); 
fftnoisy_img(1,:)=0;
nFKSpectrum=move2fft(fftnoisy_img);

C = fdct_wrapping(nFKSpectrum,0,1,5,8);
%%
%2Dwindowfilter
Ct = C;
for s=1:length(Ct)
    for w=1:length(Ct{1,s})
   Ct{1,s}{1,w}= boxcarfilter3(Ct{1,s}{1,w},5,5,1.7);    % 数据9=>4,4,2.3   数据5=>5,5,1.7  数据10=>5,5,1.9
    end
end
%%
restored_img = ifdct_wrapping(Ct,0,nf,nk);
dNFKSpectrum= restored_img;
%%
restored_img=imove2fft(restored_img);
Crestored_img=real(ifft2(restored_img));
Crestored_img=Crestored_img(1:nt,1:trace);
dNoiseData=Crestored_img;

end

