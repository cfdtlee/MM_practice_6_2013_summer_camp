%损失率=1-0.5.^n
%31 28 31 30 31 30 31 31 30 31 30 31
%麦子返青2.20-4.19(79-140)抽4.20-5.09(140-160)灌5.10-5.31(160-181)成6.01-6.19(181-199)mmxxxx
%玉米分5.1-6.9(151-189)抽6.9-7.19(189-231)成7.20-9.19(231-291)
%稻3.1-4.30(90-151)，5.1-7.31(151-243)，8.1-9.30(243-304)
%北方春大豆型于4.15(135)月播种，9.1(273)约9月份成熟
%棉花4.1(120-273)月种9.1月收
%花生：约在4月底至5月(151-251)上旬播种，生长100～150天，
%油菜3-4月(90-120)
%春西瓜：大棚定植日在2月中旬开始播种育苗80天成熟(75-155)
%苹果整年
%风10.8-13.8，13.9-17.1，17.2-20.7
%雨50-100，100-250，>250s
%求概率p、次数n在不同区平均值（十年十个地区每个时期的总和/100）
%weather:降水，日最高温，最低温，风速，冰雹
load weather.txt
stage=[79 140; 140 160; 160 181;181 199;151 189;189 231;231 291;90 151;151 243;243 304];
[m n]=size(stage);
weather_n=weather;
for i=1:36500%根据雨50-100，100-250，>250s，风10.8-13.8，13.9-17.1，17.2-20.7，将天气转化为灾害次数
    if(weather(i,1)<50)
        weather_n(i,1)=0;
    elseif(weather(i,1)<100)
        weather_n(i,1)=1;
    elseif(weather(i,1)<250)
        weather_n(i,1)=2;
    elseif(weather(i,1)>250)
        weather_n(i,1)=3;
    end
    if(weather(i,4)<10.8)
        weather_n(i,4)=0;
    elseif(weather(i,4)<13.9)
        weather_n(i,4)=1;
    elseif(weather(i,4)<17.1)
        weather_n(i,4)=2;
    elseif(weather(i,4)>=17.1)
        weather_n(i,4)=3;
    end
end
cishu=zeros(m,3);%保存灾害发生的次数，用来计算灾害发生的概率
sunshi=zeros(m,3);%保存损失的等级，用来计算损失率
for i=1:36500
    k=mod(i,365);
    if k==0
        k=365;
    end
    for j=1:m
        if(k>=stage(j,1) && k<stage(j,2))
            cishu(j,1)=cishu(j,1)+(weather_n(i,1)~=0);
            sunshi(j,1)=sunshi(j,1)+weather_n(i,1);
            cishu(j,2)=cishu(j,2)+(weather_n(i,4)~=0);
            sunshi(j,2)=sunshi(j,2)+weather_n(i,4);
            cishu(j,3)=cishu(j,3)+(weather_n(i,5)~=0);
            sunshi(j,3)=sunshi(j,3)+weather_n(i,5);
        end
    end
end
zaihaigailv(:,1)=cishu(:,1)./100./(stage(:,2)-stage(:,1));
zaihaigailv(:,2)=cishu(:,2)./100./(stage(:,2)-stage(:,1));
zaihaigailv(:,3)=cishu(:,3)./100./(stage(:,2)-stage(:,1));
zaihaigailv_all=1-(1-zaihaigailv(:,1)).*(1-zaihaigailv(:,2)).*(1-zaihaigailv(:,3));
sunshilv=1-0.5.^(sum(sunshi,2)./100);
s2=0:0.01:1;
figure
ans=0.058;
for k=1:4
    bili=[0.3 0.5 0.7 1];
    bt=['返青期';'抽穗期';'灌浆期';'成熟期'];
    y(1,:)=311*ans-311*s2*sunshilv(k)*bili(k)*zaihaigailv_all(k);
    y(2,:)=311*s2*sunshilv(k)*bili(k)*zaihaigailv_all(k)-311*ans*0.2;
    subplot(2,2,k);
    hold on
    title(bt(k,:));
    plot(s2,y,'LineWidth',3);plot(s2,0.*s2,':k');
    legend('保险公司收益','农户收益');
    temp(k,:)=[311*ans-y(1,30),y(2,30)+ans*0.2*311];
end %小麦各时期y1,y2

figure
ans=0.059;
for k=5:7%玉米
    kk=k-4;
    bili(5:7)=[0.4 0.7 1];
    bt=['定植成活—分孽期';'拨节期——抽穗期';'灌浆期——成熟期'];
    y(1,:)=251*ans-251*s2*sunshilv(k)*bili(k)*zaihaigailv_all(k);
    y(2,:)=251*s2*sunshilv(k)*bili(k)*zaihaigailv_all(k)-251*ans*0.2;
    subplot(1,3,kk);
    hold on
    title(bt(kk,:));
    plot(s2,y,'LineWidth',3);plot(s2,0.*s2,':k');
    legend('保险公司收益','农户收益');
    temp(k,:)=[251*ans-y(1,30),y(2,30)+ans*0.2*251];
end 

figure
ans=0.058;
for k=8:10%水稻
    kk=k-7;
    bili(8:10)=[0.4 0.7 1];
    bt=['定植成活—分孽期';'拨节期——抽穗期';'灌浆期——成熟期'];
    y(1,:)=278*ans-278*s2*sunshilv(k)*bili(k)*zaihaigailv_all(k);
    y(2,:)=278*s2*sunshilv(k)*bili(k)*zaihaigailv_all(k)-278*ans*0.2;
    subplot(1,3,kk);
    hold on
    title(bt(kk,:));
    plot(s2,y,'LineWidth',3);plot(s2,0.*s2,':k');
    legend('保险公司收益','农户收益');
    temp(k,:)=[278*ans-y(1,30),y(2,30)+ans*0.2*278];
end
    %%0.0292, 0.0246
    
    
    
%改进后
ans=0.0289;figure
for k=1:4 %小麦各时期y1,y2    
    bili=[0.7 0.7 0.7 1];
    bt=['返青期';'抽穗期';'灌浆期';'成熟期'];
    y(1,:)=311*ans-311*s2*sunshilv(k)*bili(k)*zaihaigailv_all(k);
    y(2,:)=311*s2*sunshilv(k)*bili(k)*zaihaigailv_all(k)-ans*0.2*311;
    subplot(2,2,k);
    hold on
    title(bt(k,:));
    plot(s2,y,'LineWidth',3);plot(s2,0.*s2,':k');
    legend('保险公司收益','农户收益');
    temp(k,:)=[311*ans-y(1,30),y(2,30)+ans*0.2*311];
end
ans=0.0245;figure
for k=5:7%玉米
    kk=k-4;
    bili(5:7)=[0.5 0.7 1];
    bt=['定植成活—分孽期';'拨节期——抽穗期';'灌浆期——成熟期'];
    y(1,:)=251*ans-251*s2*sunshilv(k)*bili(k)*zaihaigailv_all(k);
    y(2,:)=251*s2*sunshilv(k)*bili(k)*zaihaigailv_all(k)-251*ans*0.2;
    subplot(1,3,kk);
    hold on
    title(bt(kk,:));
    plot(s2,y,'LineWidth',3);plot(s2,0.*s2,':k');
    legend('保险公司收益','农户收益');
    temp(k,:)=[251*ans-y(1,30),y(2,30)+ans*0.2*251];
end 
figure
ans=0.0166;
for k=8:10%水稻
    kk=k-7;
    bili(8:10)=[0.6 0.6 1];
    bt=['定植成活—分孽期';'拨节期——抽穗期';'灌浆期——成熟期'];
    y(1,:)=278*ans-278*s2*sunshilv(k)*bili(k)*zaihaigailv_all(k);
    y(2,:)=278*s2*sunshilv(k)*bili(k)*zaihaigailv_all(k)-278*0.2*ans;
    subplot(1,3,kk);
    hold on
    title(bt(kk,:));
    plot(s2,y,'LineWidth',3);plot(s2,0.*s2,':k');
    legend('保险公司收益','农户收益');
    temp(k,:)=[278*ans-y(1,30),y(2,30)+ans*0.2*278];
end    