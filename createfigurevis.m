function createfigurevis(X1, YMatrix1)
%CREATEFIGURE(X1, YMatrix1)
%  X1:  vector of x data
%  YMATRIX1:  matrix of y data

%  Auto-generated by MATLAB on 05-Jan-2020 13:39:42

% Create figure
figure1 = figure('Color',[1 1 1]);

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create multiple lines using matrix input to plot
plot1 = plot(X1,YMatrix1,'LineWidth',2,'Parent',axes1);
set(plot1(1),'DisplayName','0g/L');
set(plot1(2),'DisplayName','6g/L');
set(plot1(3),'DisplayName','12g/L');
set(plot1(4),'DisplayName','20g/L');

% Create ylabel
ylabel('Average Reflectance','FontWeight','bold',...
    'FontName','Times New Roman');

% Create xlabel
xlabel('Wavelenghts (nm)','FontWeight','bold','FontName','Times New Roman');

% Create title
title('Reflectance Vs Wavelength (Sensor1)');

% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[450 650]);
box(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontName','Times New Roman','FontSize',14,'FontWeight','bold',...
    'XGrid','on','XTick',[450 500 550 570 600 650],'XTickLabel',...
    {'450','500','550','570','600','650'},'YGrid','on');
% Create legend
legend(axes1,'show');

