%Obtain the best fit function to represent the variation of EMG activity versus the force
%Superimpose the fit function on the plot of the EMG activity/force.
%Analyzes the results by displaying R^2.
%to find R^2 the following code was used:
%Jered Wells (2020). R-square: The coefficient of determination (https://www.mathworks.com/matlabcentral/fileexchange/34492-r-square-the-coefficient-of-determination), MATLAB Central File Exchange. Retrieved December 15, 2020.

clear figure;

m = polyfit (egm,force,2);                                                          %find coefficients of parabola relating force and egm
p = polyval(m,egm);

plot(egm,force,'*',egm,p,'-');                                                      %compares empirical and predicted data of force on same graph for comparison
    title('Graph 8: Empirical Data and Solution Comparison');
    xlabel('EGM/V');
    ylabel('Force (%)');
    legend ('Empirical values of Force', 'Model Prediction of Force');
    grid on;
    s = sprintf('y =(%.1f) x^2 + (%.1f) x + (%.1f)',m(1),m(2),m(3));                %Finds equation relationg force and egm
    text(0.035,60,s);
    [r2 rmse] = rsquare(force,p);                                                   %finds R^2
    text(0.035,70,strcat(['R2 = ' num2str(r2) '; RMSE = ' num2str(rmse)]));        %Reports equation on the graph

