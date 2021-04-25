function d1 = Window2D( data,nMiddlex,nMiddley,nWidth,nHeight)
%this window is a rectangle window
%data is a cloumn vector
%nMiddle is the location of input data
%nWidth is the width of window
d1=zeros(nHeight,nWidth);
for j=1:nHeight
for i=1:nWidth
    d1(j,i)=data(j+nMiddley-1-(nHeight-1)/2,i+nMiddlex-1-(nWidth-1)/2);
end

end
end


