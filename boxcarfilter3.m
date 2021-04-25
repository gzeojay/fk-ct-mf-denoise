function B1= boxcarfilter3(A1,nheight,nwidth,u)
[nt,trace]=size(A1);
A=abs(A1);
% nheight=9;
% nwidth=9;
A2=[zeros(nheight,trace+2*nwidth);zeros(nt,nwidth),A1,zeros(nt,nwidth);zeros(nheight,trace+2*nwidth)];
nx1=(nwidth-1)/2;
ny1=(nheight-1)/2;
nseedx=1;
nseedy=1;
 mA1=mean(A(:));
%  mA2=max(max(A));
[nt1,trace1]=size(A2);
B=zeros(nt1,trace1);
nMoveTotalx=fix(trace1/nseedx);
nMoveTotaly=fix(nt1/nseedy);
for j=1:nMoveTotalx
    if (j-1)*nseedx+nx1+1+nx1>trace1
        break;
    end
    for i=1:nMoveTotaly
        if (i-1)*nseedy+ny1+1+ny1>nt1
            break;
        end
        
        d1=Window2D(A2,(j-1)*nseedx+nx1+1,(i-1)*nseedy+ny1+1,nwidth,nheight);
        md1=mean(abs(d1(:)));
        if md1<u*mA1
            for kx=1:nwidth
                for ky=1:nheight
                    d1(ky,kx)=0;
                end
            end
%         end
        elseif md1>1e-3
        for kx=1:nwidth
            for ky=1:nheight
                B(ky+(i-1)*nseedy+ny1+1-1-(nheight-1)/2,kx+(j-1)*nseedx+nx1+1-1-(nwidth-1)/2)=d1(ky,kx);
            end
        end
        end
    end
end
B1=B(nheight+1:nt1-nheight,nwidth+1:trace1-nwidth);
end



