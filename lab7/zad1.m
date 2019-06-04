clc
clear all
close all

load P_ref

midpoint_vector=[];
trapezoidal_vector=[];
simpson_vector=[];
monte_carlo_vector=[];
iterator=1;
for i=5:50:1e4
    midpoint_vector(iterator)=P_ref-midpoint(i);
    trapezoidal_vector(iterator)=P_ref-trapezoidal(i);
    simpson_vector(iterator)=P_ref-simpson(i);
    monte_carlo_vector(iterator)=abs(P_ref-monte_carlo(i));
    iterator=iterator+1;
end
% figure();
% semilogy(midpoint_vector);
% title('Midpoint algorithm integration');
% xlabel('Number of partitions');
% ylabel('Difference between real value');
% old_Yticks=get(gca,'xtick');
% new_Yticklabel=arrayfun(@num2str,old_Yticks*50,'un',0);
% set(gca,'xticklabel',new_Yticklabel);
% saveas(gcf,'./Midpoint.png');
% 
% figure();
% semilogy(trapezoidal_vector);
% title('Trapezoidal algorithm integration');
% xlabel('Number of partitions');
% ylabel('Difference between real value');
% old_Yticks=get(gca,'xtick');
% new_Yticklabel=arrayfun(@num2str,old_Yticks*50,'un',0);
% set(gca,'xticklabel',new_Yticklabel);
% saveas(gcf,'./Trapezoidal.png');
% 
% figure();
% semilogy(simpson_vector);
% title('Simpson algorithm integration');
% xlabel('Number of partitions');
% ylabel('Difference between real value');
% old_Yticks=get(gca,'xtick');
% new_Yticklabel=arrayfun(@num2str,old_Yticks*50,'un',0);
% set(gca,'xticklabel',new_Yticklabel);
% saveas(gcf,'./Simpson.png');

figure();
semilogy(monte_carlo_vector);
title('Monte Carlo algorithm integration');
xlabel('Number of partitions');
ylabel('Difference between real value');
% old_Yticks=get(gca,'xtick');
% new_Yticklabel=arrayfun(@num2str,old_Yticks*50,'un',0);
% set(gca,'xticklabel',new_Yticklabel);
saveas(gcf,'./Monte_Carlo.png');

test = 1e7;
figure();
tic;
trapezoidal(test);
trapezoidal_time=toc;
tic;
simpson(test);
simpson_time=toc;
tic;
midpoint(test);
midpoint_time=toc;
tic;
monte_carlo(test);
monte_carlo_time=toc;

hold on
names = categorical({'midpoint','trapezoidal','simpson','monte carlo'});
times = [midpoint_time,trapezoidal_time,simpson_time,monte_carlo_time];
bar(names,times)
title('Time of working for N=10^7')
ylabel('time[s]')
saveas(gcf,'./Time.png');


