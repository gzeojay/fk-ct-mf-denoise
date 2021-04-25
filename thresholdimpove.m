function Ct= thresholdimpove( Ct )

j=1;
for s=1:length(Ct)
    for w=1:length(Ct{1,s})
        maxv(j)=max(max(abs(Ct{1,s}{1,w}(:,:))));
        j=j+1;
    end
end
maxv2=max(maxv);
j=1;
for s=1:length(Ct)
    for w=1:length(Ct{1,s})
        m=abs(Ct{1,s}{1,w}/maxv2);
        aa1(j)=std(m(:),0);
        j=j+1;
    end
end
figure
plot(aa1);
kkm=min(aa1)+0.05*max(aa1);
hold on;
plot(1:length(aa1),kkm*ones(size(kkm)),'-r');
% bb1=aa1(41:60);
% figure
% stem(bb1);
% kkm=min(bb1)+0.03*max(bb1);
% hold on;
% plot(1:length(bb1),kkm*ones(size(bb1)),'-r','linewidth',2);
for s=1:length(Ct)
    for w=1:length(Ct{1,s})
        m=abs(Ct{1,s}{1,w}/maxv2);
        aa=std(m(:),0);
        if aa<kkm
            Ct{1,s}{1,w}=0; 
        end
    end
end

% i=1;
% for s=1:length(Ct)
%     for w=1:length(Ct{1,s})
%         m=abs(Ct{1,s}{1,w}/maxv2);
%         a(i)=std(m(:),0);
%         i=i+1;
%     end
% end
% b=max(a);
% b
% for s=1:length(Ct)
%     for w=1:length(Ct{1,s})
%         temp=abs(Ct{1,s}{1,w});
%         Mh=mean(temp(:));
%         m=abs(Ct{1,s}{1,w}/maxv2);
%         am=std(m(:),0);
%         am
%         [nt,trace]=size(Ct{1,s}{1,w});
%         mm=b/am*Mh
%         for i=1:nt
%             for j=1:trace
%                 if abs(Ct{1,s}{1,w}(i,j))<((b)/(am+0.000001))*Mh
%                     Ct{1,s}{1,w}(i,j)=0.0001;
%                 end
%             end
%         end
%     end
% end



end

