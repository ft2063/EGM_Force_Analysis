%Automatic identifies portions (segments) corresponding to one trial of grasping activity. 
%These segments have an equal number of data points.
%Starting points of each segment are stored in vector SegStartPnt

clear figure;
MatrixSmooth = zeros (DataNum, 3);                                      %MatrixSmooth containes data smoothed one time
MatrixSuperSmooth = zeros (DataNum,3);                                  %MatrixSuperSmooth containes data smoothed two times

MatrixSmooth(:,1) = MatFinCopy(:,1);
MatrixSmooth(:,2) = smoothdata (MatFinCopy(:,2));                       %smooth force and egm data first time
MatrixSmooth(:,3) = smoothdata (MatFinCopy(:,3));
MatrixSuperSmooth(:,1) = MatFinCopy(:,1);
MatrixSuperSmooth(:,2) = smoothdata(MatrixSmooth(:,2));                 %smooths force and egm data second time
MatrixSuperSmooth(:,3) = smoothdata (MatrixSmooth(:,3));

plot (MatrixFinal (:,1), MatrixFinal (:,2));                            %superimposes smoothed values and original values to make comparisons
hold on;
plot (MatrixSuperSmooth (:,1), MatrixSuperSmooth (:,2),'b');
title ('Graph 3: Smoothed Force Curve and Normalized Force Comparison');
xlabel('Time/s'),ylabel('Force (%)');
legend('Normalized Force curve', 'Smoothed Force curve');
hold off;


[Max,idxMax, Width]=findpeaks( MatrixSuperSmooth (:,2),'MinPeakHeight',16.6);  %Find maximum peaks, and their position
PeakNumber = length (Max);                                                      %stores number of peaks
[Min, idxMin] = findpeaks ( -MatrixSuperSmooth (:,2));                          %find minimum values of force and their position

ComputedMin = length(idxMin);                                                   %number of min detected by machine, which is overestimated by two
RangeStart = idxMin(2);                                                         %identidy first and last minimum
RangeEnd = idxMin(ComputedMin - 1);
SegmentSize = (RangeEnd-RangeStart) / PeakNumber;               
SegSizeInt = int16(SegmentSize);                                                %number of elements per segment


SegStartPnt = zeros (1,PeakNumber);
for i=0:1:(PeakNumber-1)                                                        %stores initial position of each cycle in array SegStartPnt
   SegStartPnt (i+1) = RangeStart + i * SegSizeInt;
end


