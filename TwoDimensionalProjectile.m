%% FileName: TwoDimensionalProjectile
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name: Rishi Zaveri
% Date: 9 July 2018
% Last Revised: 10 July 2018
%
% Purpose:
%       Produce 2-dimensional projectile motion given user input.
%
% Variables:
%       angle - Launch angle of projectile angle (positive 0-90)
%       initialVel - Initial launch velocity of projectile
%       vertAccel - Acceleration in the vertical y axis (gravity)
%       initialPosY - Starting height of projectile
%       finalPosY - Ending height of projectile
%       initialVelX - X component of initial launch velocity
%       initialVelY - Y component of initial launch velocity
%       vertCheck - If value is positive, finalPosY has acceptable value
%                   Otherwise send error msg and terminate script
%       time1 - First 'zero' of quadratic function
%       time2 - Second 'zero' of quadratic function (total air time)
%       airTime - time2, the total air time for projectile
%       finalPosX - max horizontal distance
%       xTime - vector of time values (50 elements)
%       yVertPos - vector of vertical positions from t0-tf (50 elements)
%       yHorzPos - vector of horizontal positions from t0-tf (50 elements)
%       yVertVel - vector of vertical velocities from t0-tf (50 elements)
%       fig1 - figure 1 containing two graphs
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Pseodocode
%Input
%   1. Prompt user for launch angle (degrees, above horizontal) and speed (m/s),
%       vertical acceleration (m/s^2), initial vertical positon (m), and
%       final vertical pos (m).
%       
%   2. Store input into appropriate variables.
%Process
%   3. Consider gravity to be a negative acceleration.
%   4. Calculate initial horizontal and vertical velocities.
%       initialVelX = initialVel * cos(launchAngle);
%       initialVelY = initialVel * sin(launchAngle);
%   5. Calculate total air time.
%       Formula:
%       0 = 0.5*vertAccel*(t^2) + initialVelY*t - (finalPosY-initialPosY);
%       Quadratic Equation Form (Accept the Positive Value for t):
%       time = (-b + sqrt(b^2 - 4ac))/(2*a);
%       time = (-b - sqrt(b^2 - 4ac))/(2*a);
%   6. Calculate final velocity.
%       finalVelY^2 = initialVelY^2 + 2(vertAccel)(finalPosY - finalPosX);

%% Begin Script
clear all
home

% User Input
angle = input('Launch Angle (degrees 0-90, above horizontal):     ');
initialVel = input('Initial Velocity (m/s):     ');
vertAccel = input('Vertical Acceleration (m/s^2):     ');
initialPosY = input('Initial Vertical Position (m):     ');
finalPosY = input('Final Vertical Position (m):     ');

if angle < 0 | angle > 90
    error('Improper angle value. Please select an angle between 0 and 90 degrees.')
end

vertAccel = abs(vertAccel);
vertAccel = -(vertAccel);

% Initial Velocity Components
initialVelX = initialVel * cosd(angle);
initialVelY = initialVel * sind(angle);

% Vertical Height Errors
vertCheck = initialVelY^2 - 4*(0.5*vertAccel)*(initialPosY-finalPosY);
if vertCheck ~= abs(vertCheck)
    error('Final vertical position value is unreachable with the given launch angle and speed.')
end

% Total Time
time1 = (-(initialVelY) + sqrt( initialVelY^2 - ...
    4*(0.5*vertAccel)*(initialPosY-finalPosY)))/(2*(0.5*vertAccel));
time2 = (-(initialVelY) - sqrt( initialVelY^2 - ...
    4*(0.5*vertAccel)*(initialPosY-finalPosY)))/(2*(0.5*vertAccel));
airTime = time2;

% Total Horizontal Distance
finalPosX = initialVelX*airTime;

% Vertical Position as Function of Time
xTime = linspace(0,airTime,50);
yVertPos = initialVelY*xTime + 0.5*vertAccel*(xTime.^2);

% Horizontal Position as Function of Time
yHorzPos = initialVelX*xTime;

% Vertical Velocity as Function of Time
yVertVel = initialVelY + vertAccel*xTime;

% Output
disp(' ')
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp(sprintf('Total Airtime: %0.2f seconds', airTime));

% Figure1, 2 Graphs
fig1 = figure(1);
fig1.WindowStyle = 'docked';

% Vertical Position vs Time
subplot(2,1,1)
plot(xTime,yVertPos,'color','b','linestyle','-')
xlabel('Time(s)')
ylabel('Vertical Position (m)','fontsize',10,'fontname','Arial')
title(['Projectile Motion Launched at ', num2str(initialVel),'(m/s^{2}), ', num2str(angle),' Degrees Above Horizontal'],'fontsize',12,'fontname','Arial')
grid on
grid minor

% Vertical Velocity vs Time
subplot(2,1,2)
plot(xTime,yVertVel,'color','g','linestyle','-')
xlabel('Time(s)','fontsize',10,'fontname','Arial')
ylabel('Vertical Velocity (m/s)','fontsize',10,'fontname','Arial')
title(['Projectile Motion Launched at ', num2str(initialVel),'(m/s^{2}), ', num2str(angle),' Degrees Above Horizontal'],'fontsize',12,'fontname','Arial')
grid on
grid minor

