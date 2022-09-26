% This script reads time, force, and EGM data from file and stores in
% a matrix
%Apply a low pass filter with a cutoff frequency of 200 Hz for both the EMG signal and the force signal.
%Crop the first 500 samples of the force and EMG data as well as the last 250 data points.
%Normalize the force signal such that the minimum value is zero and the maximum value is 100. 
%Plot the EMG signal (in Volts) and normalized force (in percentage of MVC) against the time axis in two subplots


%define constants 
PassFreq=200;    %cut off frequency of low pass filter
Rate = 1000;     %sampling rate
CancTop = 500;   %number values to discard at the top
CancBott = 250;  %number values to discard at the bottom

load ('Data.mat');
readings = length (timestamps);               %number of readings as per data collection
DataNum = readings - CancTop - CancBott;      %ultimate number of data
matrix = zeros (readings, 3);                 %file data stored the matrix matrix 
MatrixFilter = zeros (readings, 3);           %matrix to store filtered data
[rows,cols]=size(matrix);
for i= 1:rows
    matrix(i,1)=timestamps(i,1);              %copy file data into matrix
    matrix(i,2)=Force_signal(i,1);
    matrix(i,3)=EMG_signal(i,1);
end
MatrixFilter (:,2)= lowpass(matrix(:,2),PassFreq,Rate); %apply low pass filter to EMG and Force 
MatrixFilter (:,3)= lowpass(matrix(:,3),PassFreq,Rate);
for i= 1:rows
  MatrixFilter(i,1) = timestamps(i,1); %ensure time was not filtered
end

for i= 1:CancTop          
    MatrixFilter (i,:)=[];  %delete first 500 values
end
rows = length(MatrixFilter);


MatrixValid = zeros (DataNum,3);   %copy legit values of data into MatrixValid 
for i=1:1:DataNum
MatrixValid(i,1) = MatrixFilter(i,1);
MatrixValid(i,2) = MatrixFilter(i,2);
MatrixValid(i,3) = MatrixFilter(i,3);
end 


MatrixFinal = zeros (DataNum,3);  %MatrixFinal contains the data of force normalised in range [0,100]
MatrixFinal(:,1)= MatrixValid(:,1);
MatrixFinal(:,3)= MatrixValid(:,3);
MatrixFinal(:,2) = normalize ( MatrixValid(:,2), 'range', [0,100]);

MatFinCopy = zeros (DataNum,3);  %MatFinCopy is a copy of MatrixFinal, for security reason. In task_2 smoothdata will be applied to MatFinCopy 
MatFinCopy(:,1) = MatrixFinal(:,1);
MatFinCopy(:,2) = MatrixFinal(:,2);
MatFinCopy(:,3) = MatrixFinal(:,3); 

subplot (4,1,1); plot (matrix (:,1), matrix (:,2)); %plot Normalized force/time
title ('Graph 1.1: Force and Time Relationship');
xlabel('Time/s'),ylabel('Force /(N)');

subplot (4,1,2); plot (MatrixValid (:,1), MatrixValid (:,2)); %plot Normalized force/time
title ('Graph 1.2: Cropped Force and Time Relationship');
xlabel('Time/s'),ylabel('Force/ (N)');

subplot(4,1,3);plot (MatrixFinal (:,1), MatrixFinal (:,2)); %plot Normalized force/time
title ('Graph 1.3: Normalized Force in Percentage of MVC and Time Relationship');
xlabel('Time/s'),ylabel('Force (%)');

subplot(4,1,4);plot (MatrixFinal (:,1), MatrixFinal (:,3));%plot EGM/time
title ('Graph 2: EGM and Time Relationship');
xlabel('Time/s'),ylabel('EGM/V');