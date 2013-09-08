load destroy.txt
destroy2=destroy;
destroy2(:,2)=destroy2(:,2)-destroy2(:,3);
destroy2(:,3)=destroy2(:,3)-destroy2(:,4);
%选棉花来分析

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