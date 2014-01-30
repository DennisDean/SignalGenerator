function testSignalGenerator
%testSignalGenerator Test Signal Generator Class
%   Signal generator is used to test analytical functions.  It was written
%   initially to test a spectral analysis program.
%
%
%
% Version: 0.1.04
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

% Test flags
RUN_TEST_1 =  0;   % Generate sinusoid
RUN_TEST_2 =  0;   % Generate sinusoid with parameters
RUN_TEST_3 =  0;   % Add plot function to class
RUN_TEST_4 =  1;   % Create test for run

% Run parameters
% Replace position with your monitor coordinates
figPosition = [-1919, 1, 1920, 1004]; 
 
% ------------------------------------------------------------------ Test 1
% Test 1: Generate sinusoid 
if RUN_TEST_1 == 1
    % Write test results to console
    fprintf('------------------------------- Test 1\n\n');
    fprintf('Generate sinusoid\n\n');
    
    % Create signal generation class
    sgObj = signalGeneratorClass;
    
    % Generate signals
    sgObj = sgObj.sinusoid;
    t = sgObj.t;
    y = sgObj.y;
    signalParam = sgObj.signalParam;
    
    % Check plot
    fid = figure('Position', figPosition);
    plot(t,y);xlabel('t'); ylabel('Y');
    
    % Mimic functional form call
    sgObj = sgObj.sinusoid;
    [t y] = sgObj.sinusoid;
    [t y signalParam] = sgObj.sinusoid;
    
end
% ------------------------------------------------------------------ Test 2
% Test 2: Generate sinusoid 
if RUN_TEST_2 == 1
    % Write test results to console
    fprintf('------------------------------- Test 2\n\n');
    fprintf('Generate sinusoid with parameters\n\n');
    
    % Create signal generation class
    sgObj = signalGeneratorClass;
    
    % Generate signal from 'test_generator.edf'
    % obj.sinusoid(A, f, SR, D)
    % signal parameters
    A = 100;  % Signal Amplitude
    f = 1.0;  % Signal Frequency
    SR = 500; % Sampling Rate (Hz)
    D = 450;  % Duration (sec)
    
    % Generate
    [t yC4 signalParamC4] = sgObj.sinusoid(A, 1.0, SR, D);
    [t yP3 signalParamP3] = sgObj.sinusoid(A, 8.0, SR, D);
    [t yC3 signalParamC3] = sgObj.sinusoid(A, 8.5, SR, D);
    [t yX9 signalParamX9] = sgObj.sinusoid(A, 15.0, SR, D);
    [t yFP1 signalParamFP1] = sgObj.sinusoid(A, 17.0, SR, D);
    
    % Plot figures overlapping
    t = [t t t t t];
    y = [yC4 yP3 yC3 yX9 yFP1];
    fid = figure('Position', figPosition);
    plot(t(1:SR/2,:),y(1:SR/2,:));xlabel('t'); ylabel('Y');
    title('Test Signals - [yC4 yP3 yC3 yX9 yFP1]');
    xlabel('t (sec)'); ylabel('Y');
end
% ------------------------------------------------------------------ Test 3
% Test 3: Add plot function to class
if RUN_TEST_3 == 1
    % Write test results to console
    fprintf('------------------------------- Test 2\n\n');
    fprintf('Add plot function to class\n\n');
    
    % Create signal generation class
    sgObj = signalGeneratorClass;
    
    % Generate signal from 'test_generator.edf'
    A = 100;  % Signal Amplitude
    f = 0.2;  % Signal Frequency
    SR = 500; % Sampling Rate (Hz)
    D = 30;  % Duration (sec)
    
    % Create and plot sinusoid
    sgObj = sgObj.sinusoid(A, f, SR, D);
    sgObj.titleStr = 'yC4';
    sgObj = sgObj.plot(figPosition);
end
% ------------------------------------------------------------------ Test 4
% Test 4: Add plot function to class
if RUN_TEST_4 == 1
    % Write test results to console
    fprintf('------------------------------- Test 4\n\n');
    fprintf('Create EDF Check files\n\n');
    
    % Create signal generation class
    sgObj = signalGeneratorClass;
    
    % Generate signal from 'test_generator.edf'
    A = 100;  % Signal Amplitude
    f = 0.2;  % Signal Frequency
    SR = 500; % Sampling Rate (Hz)
    D = 30;  % Duration (sec)
    
    % Create and plot sinusoid
    sgObj = sgObj.sinusoid(A, f, SR, D);
    sgObj.titleStr = 'yC4';
    sgObj = sgObj.plot(figPosition);
end

end

