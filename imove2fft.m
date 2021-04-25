function [ outdata ] = imove2fft( data )
[nt,trace]=size(data);
nx=nt/2+1;
ny=trace/2+1;
a=data(end-nx+1:end,end-ny+1:end);
b=data(end-nx+1:end,1:end-ny);
c=data(1:end-nx,end-ny+1:end);
d=data(1:end-nx,1:end-ny);

outdata=[a,b;c,d];
end

