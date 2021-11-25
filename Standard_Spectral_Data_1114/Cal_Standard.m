% 实现相对定标，处理数据，画出结果图
% Yangkai,2021/11/15
clc,clear

% 读取数据
for i = 1:7
    filename1 = ['Spectrum_', num2str(i) , '_0_1.sps'];
    filename2 = ['Spectrum_', num2str(i) , '_1.sps'];
    filename3 = ['Spectrum_', num2str(i) , '_1_1.sps'];
    Spectrum_Big{i} = importFile(filename1);
    Spectrum_Small{i} = importFile(filename2);
    Spectrum_Mid{i} = importFile(filename3);
end

% 相对定标，以第一根光纤为标准
for i = 2:7
    dis_Big(:,i-1) = Spectrum_Big{i}(:,2) - Spectrum_Big{1}(:,2);
    dis_Small(:,i-1) = Spectrum_Small{i}(:,2) - Spectrum_Small{1}(:,2);
end
% 对这两个差值进行线性插值
n = 350:1020;
for i = 1:6
    dis{i} = [dis_Big(:,i), dis_Small(:,i)];
end
MAX_LIGHT = max(Spectrum_Big{1}(:,2));
MIN_LIGHT = max(Spectrum_Small{1}(:,2));
mid_light = max(Spectrum_Mid{1}(:,2));

footstep = floor(MIN_LIGHT):floor(MAX_LIGHT);
[~, col] = find(footstep == round(mid_light));
for i = 1:6
    for j = 1:size(dis{i},1)
        Light_Fiber{i}(j,:) = interp1([MIN_LIGHT, MAX_LIGHT], dis{i}(j,:), footstep, 'linear');
    end
    
    Spectrum_Mid_Correct{i} = Spectrum_Mid{i}(:,2) + Light_Fiber{i}(:,col);
end



%% 画图
figure(1)
subplot(3,1,1)
plot(n, Spectrum_Big{1}(:,2), 'r', 'linewidth',2),hold on
plot(n, Spectrum_Big{2}(:,2), 'g--', 'linewidth',1)
plot(n, Spectrum_Big{3}(:,2), 'c--', 'linewidth',1)
plot(n, Spectrum_Big{4}(:,2), 'y--', 'linewidth',1)
plot(n, Spectrum_Big{5}(:,2), 'm--', 'linewidth',1)
plot(n, Spectrum_Big{6}(:,2), 'b--', 'linewidth',1)
plot(n, Spectrum_Big{7}(:,2), 'k--', 'linewidth',1)
grid on
xlabel('Wavelength')
ylabel('Intensity')
title('高光照强度')

subplot(3,1,2)
plot(n, Spectrum_Mid{1}(:,2), 'r', 'linewidth',2),hold on
plot(n, Spectrum_Mid{2}(:,2), 'g--', 'linewidth',1)
plot(n, Spectrum_Mid{3}(:,2), 'c--', 'linewidth',1)
plot(n, Spectrum_Mid{4}(:,2), 'y--', 'linewidth',1)
plot(n, Spectrum_Mid{5}(:,2), 'm--', 'linewidth',1)
plot(n, Spectrum_Mid{6}(:,2), 'b--', 'linewidth',1)
plot(n, Spectrum_Mid{7}(:,2), 'k--', 'linewidth',1)
grid on
xlabel('Wavelength')
ylabel('Intensity')
title('中光照强度')


subplot(3,1,3)
plot(n, Spectrum_Small{1}(:,2), 'r', 'linewidth',2),hold on
plot(n, Spectrum_Small{2}(:,2), 'g--', 'linewidth',1)
plot(n, Spectrum_Small{3}(:,2), 'c--', 'linewidth',1)
plot(n, Spectrum_Small{4}(:,2), 'y--', 'linewidth',1)
plot(n, Spectrum_Small{5}(:,2), 'm--', 'linewidth',1)
plot(n, Spectrum_Small{6}(:,2), 'b--', 'linewidth',1)
plot(n, Spectrum_Small{7}(:,2), 'k--', 'linewidth',1)
grid on
xlabel('Wavelength')
ylabel('Intensity')
title('低光照强度')
legend('光纤1','光纤2','光纤3','光纤4','光纤5','光纤6','光纤7')


figure(2)
subplot(2,3,1)
    plot(n, Spectrum_Mid_Correct{1}, 'b--', 'linewidth',2),hold on
    plot(n, Spectrum_Mid{1}(:,2), 'r', 'linewidth',1)
    title('第2根光纤'),xlabel('Wavelength'),ylabel('Intensity'),grid on,legend('定标数据','原始数据')
subplot(2,3,2)
    plot(n, Spectrum_Mid_Correct{2}, 'b--', 'linewidth',2),hold on
    plot(n, Spectrum_Mid{2}(:,2), 'r', 'linewidth',1)
    title('第3根光纤'),xlabel('Wavelength'),ylabel('Intensity'),grid on,legend('定标数据','原始数据')
subplot(2,3,3)
    plot(n, Spectrum_Mid_Correct{3}, 'b--', 'linewidth',2),hold on
    plot(n, Spectrum_Mid{3}(:,2), 'r', 'linewidth',1)
    title('第4根光纤'),xlabel('Wavelength'),ylabel('Intensity'),grid on,legend('定标数据','原始数据')
subplot(2,3,4)
    plot(n, Spectrum_Mid_Correct{4}, 'b--', 'linewidth',2),hold on
    plot(n, Spectrum_Mid{4}(:,2), 'r', 'linewidth',1)
    title('第5根光纤'),xlabel('Wavelength'),ylabel('Intensity'),grid on,legend('定标数据','原始数据')
subplot(2,3,5)
    plot(n, Spectrum_Mid_Correct{5}, 'b--', 'linewidth',2),hold on
    plot(n, Spectrum_Mid{5}(:,2), 'r', 'linewidth',1)
    title('第6根光纤'),xlabel('Wavelength'),ylabel('Intensity'),grid on,legend('定标数据','原始数据')
subplot(2,3,6)
    plot(n, Spectrum_Mid_Correct{6}, 'b--', 'linewidth',2),hold on
    plot(n, Spectrum_Mid{6}(:,2), 'r', 'linewidth',1)
    title('第7根光纤'),xlabel('Wavelength'),ylabel('Intensity'),grid on,legend('定标数据','原始数据')
