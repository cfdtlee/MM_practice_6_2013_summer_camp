load destroy.txt
destroy2=destroy;
destroy2(:,2)=destroy2(:,2)-destroy2(:,3);
destroy2(:,3)=destroy2(:,3)-destroy2(:,4);
%ѡ�޻�������

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