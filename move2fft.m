function [ outdata ] = move2fft( data )
[nt,trace]=size(data);
nx=nt/2+1;
ny=trace/2+1;
a=data(1:nx,1:ny);
b=data(1:nx,ny+1:end);
c=data(nx+1:end,1:ny);
d=data(nx+1:end,ny+1:end);
outdata=[d,c;b,a];


end

