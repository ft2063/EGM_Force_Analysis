%Determines the average force segment and average EGM segment over time. 
%Models EGM data by taking the absolute value of EGM and applying gauss fit
%plots the average segment for the force and muscle data over time, for the duration of one trial.
%Create a plot for the grip force (y-axis) against the muscle activity (x-axis). 

clear figure;
AverageSegment = zeros( SegSizeInt, 3);                              %matrix storing data for average segment of force and EGM
AvgSegABS = zeros (SegSizeInt, 3);                                    %matrix storing data for average segment of foce and EGM, EGM is reported in its absolute value for the pourpose of data analysis

for i=1:SegSizeInt
    AverageSegment(i,1) = MatrixFinal((RangeStart+i),1);
end

ForceAti = zeros (1,PeakNumber);
EMGAti = zeros (1,PeakNumber);
for i=0:1:(SegSizeInt-1)                                            %for each position in average cycle
    for k=1:PeakNumber                                              %for each cycle
        row = (SegStartPnt(k))+i;
        ForceAti(k) = MatrixFinal(row,2);                           %stores values of force in that position for each segment
        EMGAti (k) = MatrixFinal(row,3);
    end
AverageForcei = mean(ForceAti);                                     %finds average value of force in that position
AverageSegment((i+1),2)= AverageForcei;
AverageEMGAti = mean(EMGAti);
AverageSegment((i+1),3)= AverageEMGAti;
end

AverageSegment(:,2) = normalize ( AverageSegment(:,2), 'range', [0,100]);  %normalizes force again
AvgSegment = zeros( SegSizeInt, 3);
AvgSegABS(:,1)=AverageSegment(:,1);
AvgSegABS(:,2)= normalize ( AverageSegment(:,2), 'range', [0,100]);
AvgSegABS(:,3)= abs(AverageSegment(:,3));                                   %EGM reported in its absolute value

[ForceMax,FrceMxPos]= findpeaks(AvgSegABS(:,2),'MinPeakHeight',99.9);       %finds the peak of average force segment
[EMGMax,EMGMxPos]= findpeaks(AvgSegABS(:,3),'MinPeakHeight',0.25);          %finds the peak of average egm segment
Shift = AvgSegABS(FrceMxPos,1)- AvgSegABS(EMGMxPos,1);                      %difference in peaks

timeStamps = zeros(1,EMGMxPos);                                             %arrays limiting values till position of EGM peak
egm = zeros(1,EMGMxPos);
force = zeros(1,EMGMxPos);

for i=1:1:EMGMxPos
timeStamps(i)= AverageSegment(i,1);
force(i)=AverageSegment(i,2);
end

subplot(4,1,1);plot(AvgSegABS(:,1),AvgSegABS(:,2));                         %plots average force segment and time
    title('Graph 4: Average Normalized Force and Time Relationship');
    xlabel('Time/t');
    ylabel('Force (%)')
    
subplot(4,1,2);plot(AvgSegABS(:,1),AvgSegABS(:,3));                         %plots absolute average EGM segment and time
    title('Graph 5: Absolute Average EMG and Time Relationship');
    xlabel('Time/t');
    ylabel('EMG /V')

GaussEGM = fit(AvgSegABS(:,1)+Shift,(AvgSegABS(:,3)),'gauss1');             %Finds a model for EGM so that force and EGM curves are similar and can be compared
subplot(4,1,3);plot(GaussEGM,AvgSegABS(:,1)+Shift,AvgSegABS(:,3));          %Allignes EGM and force curve to facilitate regression
    title('Graph 6: Shifted Absolute Average EGM Model');
    xlabel('Time/t');
    ylabel('EGM /V');
ecoeff = coeffvalues(GaussEGM);
egm = ecoeff(1) *exp(-((timeStamps-ecoeff(2))/ecoeff(3)).^2);

subplot(4,1,4);plot(egm,force);                                             %plots force and egm
    title('Graph 7: Force and EGM Relationship');
    xlabel('EGM /V');
    ylabel('Force (%)');