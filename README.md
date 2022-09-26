# EGM_Force_Analysis


The aim of this assignment is to analyze the relationship between the EMG signal and the grip force, and to derive a mathematical model to infer the grip force from the muscle activity.

The assignment requires the following tasks from the student:


1.	Task 1:

•	Load the recorded data

•	Apply a low pass filter with a cutoff frequency of 200 Hz for both the EMG signal and the force signal.

•	Crop the first 500 samples of the force and EMG data as well as the last 250 data points.

•	Normalize the force signal such that the minimum value is zero and the maximum value is 100.

•	Plot the EMG signal (in Volts) and normalized force (in percentage of MVC) against the time axis in two subplots


2.	Task 2:
•	Develop a method for automatic identification of portions (segments) corresponding to one trial of grasping activity. These segments must have an equal number of data points.


3.	Task 3:
•	Determine the average of all these segments (force and muscle signals). You must plot the average segment for the force and muscle data over time, for the duration of one trial. Create a plot for the grip force (y-axis) against the muscle activity (x-axis). Comment on this graph.


4.	Task 4:
•	Obtain the best fit function to represent the variation of EMG activity versus the force Superimpose the fit function on the plot of the EMG activity/force. Analyze the results


Step 2: Gathering Information
One important research about hand-arm system is the information about hand grip force and pressing force on a tool handle. One popular solution for measuring grip force involves attaching force sensors to the handled tool. However, this is uncomfortable because the force sensors interfere with the handle construction. An alternative solution is to record the electrical activity produced by muscles, electromyography (EMG). It has been assumed that EMG signal are proportional to muscle tension responsible for palm grip. This solution has a significant advantage when comparing to force sensors, it can be used with regular tool without interfering in the handle.


Electromyography is a technique connected with receiving, recording, and examining of myoelectric signals. These signals are coming into being thanks to physiological changes which are taking place in muscular fibers. During relaxation, a muscle shows no electric relevant activity so that the electric line is straight. During the contraction, potential of motor units deviates the EMG line.
EMG data is collected through the Delsys Bagnoli EMG system along with a flex sensor attached to a soft body. The EMG electrode and force sensor are connected to the data acquisition board which records the EMG and grip force signals (in the form of voltage) and store them into a file. The file stores the time stamp, the grip force, and the EMG muscle activity as three columns of data in the same order. The data is collected at a sampling rate of 1 kHz for a duration of 30 seconds. The recorded data is stored in the
data file “Data.mat”. The recorded data contains a total of 31 trials of press/release of the hand
