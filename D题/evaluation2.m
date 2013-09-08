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
stage=[79 140; 140 160; 160 181;181 199;151 189;189 231;231 291;90 151;151 243;243 304;
    135 273;1 365; 151 251;90 120;1 365; 1 365];
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
zaihaigailv_all(15)=1-(1-zaihaigailv(15,2)).*(1-zaihaigailv(15,3));
zaihaigailv_all(16)=1-(1-zaihaigailv(16,2)).*(1-zaihaigailv(16,3));
sunshilv=1-0.5.^(sum(sunshi,2)./100);
sunshilv(15)=1-0.5.^((sunshi(15,2)+sunshi(15,3))./100);
sunshilv(16)=1-0.5.^((sunshi(16,2)+sunshi(16,3))./100);
s2=0:0.01:1;

baoxianjine=[98 302 292 149 2000 4000];
feilv=[0.051 0.06 0.058 0.054 0.07 0.07];
bt=['豆类';'棉花';'花生';'油菜';'苹果';'苹果'];
for k=11:16
    kk=k-10;
    bili=0.7;
    y(1,:)=baoxianjine(kk)*feilv(kk)-baoxianjine(kk)*s2*sunshilv(k)*bili*zaihaigailv_all(k);
    y(2,:)=baoxianjine(kk)*s2*sunshilv(k)*bili*zaihaigailv_all(k)-baoxianjine(kk)*feilv(kk)*0.2;
    subplot(2,3,kk);hold on;
    title(['\fontsize{14}' bt(kk,:) '受灾赔付情况']);
    plot(s2,y,'LineWidth',3);plot(s2,0.*s2,':k');
    legend('保险公司收益','农户收益');
end %小麦各时期y1,y2