function SimpleSpectralAnalysis
%SimpleSpectralAnalysis Simple test to apply spectral analysis to a sin
% Test is to work throug the steps to reproduce the steps for computing
% overlapping bins.
%

% Version: 0.1.01
%
% ---------------------------------------------
% Dennis A. Dean, II, Ph.D
%
% Program for Sleep and Cardiovascular Medicine
% Brigam and Women's Hospital
% Harvard Medical School
% 221 Longwood Ave
% Boston, MA  02149
%
% File created: November 21, 2013
% Last update:  November 21, 2013 
%    
% Copyright © [2013] The Brigham and Women's Hospital, Inc. THE BRIGHAM AND 
% WOMEN'S HOSPITAL, INC. AND ITS AGENTS RETAIN ALL RIGHTS TO THIS SOFTWARE 
% AND ARE MAKING THE SOFTWARE AVAILABLE ONLY FOR SCIENTIFIC RESEARCH 
% PURPOSES. THE SOFTWARE SHALL NOT BE USED FOR ANY OTHER PURPOSES, AND IS
% BEING MADE AVAILABLE WITHOUT WARRANTY OF ANY KIND, EXPRESSED OR IMPLIED, 
% INCLUDING BUT NOT LIMITED TO IMPLIED WARRANTIES OF MERCHANTABILITY AND 
% FITNESS FOR A PARTICULAR PURPOSE. THE BRIGHAM AND WOMEN'S HOSPITAL, INC. 
% AND ITS AGENTS SHALL NOT BE LIABLE FOR ANY CLAIMS, LIABILITIES, OR LOSSES 
% RELATING TO OR ARISING FROM ANY USE OF THIS SOFTWARE.
%

% Run parameters
figPosition = [-1919, 1, 1920, 1004];
freqPlotLimit = 25;

% Generate signal from 'test_generator.edf'
% obj.sinusoid(A, f, SR, D)
% signal parameters
A = 100;   % Signal Amplitude
f = 10.0;  % Signal Frequency
SR = 500;  % Sampling Rate (Hz)
D = 4;     % Duration (sec)
N = SR/4;  % Number of points

% Generate
sgObj = signalGeneratorClass;
sgObj = sgObj.sinusoid(A, f, SR, D);
[t yC4 signalParamC4] = sgObj.sinusoid(A, f, SR, D);
sgObj.titleStr = 'yC4';
sgObj = sgObj.plot(figPosition);

% Taper window
w = tukeywin(length(yC4),0.1);
%w = 0.54-0.46*cos(2*pi*t*f);
yC4w = yC4.*w;

% Apply FFT
Y = fft(yC4w)/N;
Y = abs(Y);

% Compute Fequency Spectrum
samplingRate = SR;
nbp = D*samplingRate;                              % number of bin points
eegFreq = [0:1:nbp-1]*samplingRate/nbp;
nyquistLimit = ceil(nbp/2);
maxIndex = find(eegFreq <= freqPlotLimit);
maxIndex = maxIndex(end);

% Plot spectrum

figure('Position', figPosition);
subplot(2,1,1);
plot(eegFreq(1:maxIndex), Y(1:maxIndex));
title('Power')
subplot(2,1,2);
plot(eegFreq(1:maxIndex), Y(1:maxIndex)/(1/D));
title('Density');

% Find peak
maxIndex = find(max(Y)==Y);
Ymax = Y(maxIndex);
Ymax = Ymax(1);
freqMax = eegFreq(maxIndex);
freqMax = freqMax(1);

sum(Y.^2)

% Echo results to consolefreqMax
fprintf('Y max = %.0f, frequency max = %0.1f\n', sum(Y), freqMax);

end

