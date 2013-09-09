%{
陕西
destroy=[4697.2	1553	718	135
4726.3	2516	1488	470
4555.4	1910	1240	397
4331.9	2475	1383	338
4198.3	1877	1227	266
4055.8	213.6	116	32.3
4099.8	1121.4	457	101.1
4201.8	1748	888	229
3983.5	1398.6	694.3	203.2
4044.7	1945.8	1041.3	270
4165.8	1046.8	502.3	66
4154.1	1221	571	74
4185.6	1122	536	83
4181	763	292	74];
%}

load destroy.txt
destroy2=destroy;
destroy2(:,2)=destroy2(:,2)-destroy2(:,3);
destroy2(:,3)=destroy2(:,3)-destroy2(:,4);
destroy3=mean(destroy2);
%选棉花来分析


mianhuajine=302;
mianhuafeilv=sum(destroy3(2:end)/destroy3(1).* destroy3(2:end)/sum(destroy3(2:end)))-var(destroy3(2:end)/destroy3(1));%0.0719
mianhuabili=[0.2*0.8 0.7*0.9 1];
mianhuabt=['受灾';'成灾';'绝收'];

%temp[0.395079916052719,0.395079916052720;0.719239003889779,0.719239003889781;0.0504561337799920,0.0504561337799920]!

for k=1:3
    y(1,:)=mianhuajine*mianhuafeilv-mianhuajine*s2*mianhuabili(k)*destroy3(k+1)/destroy3(1);
    y(2,:)=mianhuajine*s2*mianhuabili(k)*destroy3(k+1)/destroy3(1)-mianhuajine*mianhuafeilv*0.2;
    %y(1,:)=baoxianjine(kk)*feilv(kk)-baoxianjine(kk)*s2*sunshilv(k)*bili*zaihaigailv_all(k);
    %y(2,:)=baoxianjine(kk)*s2*sunshilv(k)*bili*zaihaigailv_all(k)-baoxianjine(kk)*feilv(kk)*0.2;
    subplot(1,3,k);hold on;
    title(['\fontsize{14}棉花' mianhuabt(k,:) '赔付情况']);
    plot(s2,y,'LineWidth',3);plot(s2,0.*s2,':k');
    plot([destroy3(k+1)/destroy3(1) destroy3(k+1)/destroy3(1)],[-5 25],':k');
    legend('保险公司收益','农户收益','实际灾害程度');
    tt=ceil(destroy3(k+1)/destroy3(1)*100);
    temp(k,:)=[302*mianhuafeilv-y(1,tt),y(2,tt)+mianhuafeilv*0.2*302];
end %棉花小麦各时期y1,y2

y(1,:)=mianhuajine*mianhuafeilv;
y(2,:)=-mianhuajine*mianhuafeilv*0.2;
%{
for k=1:3
    y(1,:)=y(1,:)-mianhuajine*s2*mianhuabili(k)*destroy3(k+1)/destroy3(1);
    y(2,:)=y(2,:)+mianhuajine*s2*mianhuabili(k)*destroy3(k+1)/destroy3(1);
    %y(1,:)=baoxianjine(kk)*feilv(kk)-baoxianjine(kk)*s2*sunshilv(k)*bili*zaihaigailv_all(k);
    %y(2,:)=baoxianjine(kk)*s2*sunshilv(k)*bili*zaihaigailv_all(k)-baoxianjine(kk)*feilv(kk)*0.2;
    
end %棉花小麦各时期y1,y2
hold on;
    title(['\fontsize{14}棉花' mianhuabt(k,:) '赔付情况']);
    plot(s2,y,'LineWidth',3);plot(s2,0.*s2,':k');
    plot([destroy3(k+1)/destroy3(1) destroy3(k+1)/destroy3(1)],[-100 100],':k');
    legend('保险公司收益','农户收益');
%}


