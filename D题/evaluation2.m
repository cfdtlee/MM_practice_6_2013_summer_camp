%��ʧ��=1-0.5.^n
%31 28 31 30 31 30 31 31 30 31 30 31
%���ӷ���2.20-4.19(79-140)��4.20-5.09(140-160)��5.10-5.31(160-181)��6.01-6.19(181-199)mmxxxx
%���׷�5.1-6.9(151-189)��6.9-7.19(189-231)��7.20-9.19(231-291)
%��3.1-4.30(90-151)��5.1-7.31(151-243)��8.1-9.30(243-304)
%������������4.15(135)�²��֣�9.1(273)Լ9�·ݳ���
%�޻�4.1(120-273)����9.1����
%������Լ��4�µ���5��(151-251)��Ѯ���֣�����100��150�죬
%�Ͳ�3-4��(90-120)
%�����ϣ����ﶨֲ����2����Ѯ��ʼ��������80�����(75-155)
%ƻ������
%��10.8-13.8��13.9-17.1��17.2-20.7
%��50-100��100-250��>250s
%�����p������n�ڲ�ͬ��ƽ��ֵ��ʮ��ʮ������ÿ��ʱ�ڵ��ܺ�/100��
%weather:��ˮ��������£�����£����٣�����
load weather.txt
stage=[79 140; 140 160; 160 181;181 199;151 189;189 231;231 291;90 151;151 243;243 304;
    135 273;1 365; 151 251;90 120;1 365; 1 365];
[m n]=size(stage);
weather_n=weather;
for i=1:36500%������50-100��100-250��>250s����10.8-13.8��13.9-17.1��17.2-20.7��������ת��Ϊ�ֺ�����
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
cishu=zeros(m,3);%�����ֺ������Ĵ��������������ֺ������ĸ���
sunshi=zeros(m,3);%������ʧ�ĵȼ�������������ʧ��
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
bt=['����';'�޻�';'����';'�Ͳ�';'ƻ��';'ƻ��'];
for k=11:16
    kk=k-10;
    bili=0.7;
    y(1,:)=baoxianjine(kk)*feilv(kk)-baoxianjine(kk)*s2*sunshilv(k)*bili*zaihaigailv_all(k);
    y(2,:)=baoxianjine(kk)*s2*sunshilv(k)*bili*zaihaigailv_all(k)-baoxianjine(kk)*feilv(kk)*0.2;
    subplot(2,3,kk);hold on;
    title(['\fontsize{14}' bt(kk,:) '�����⸶���']);
    plot(s2,y,'LineWidth',3);plot(s2,0.*s2,':k');
    legend('���չ�˾����','ũ������');
end %С���ʱ��y1,y2