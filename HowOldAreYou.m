% Filename:  HowOldAreYou.m
%--------------------------------------------------------------------------
% Your Name:
%
% Start Date: 6/12/2018
% Last Revised On: 6/12/2018
%
% Purpose:  Calculate the years, weeks, days, hours, minutes, and seconds
%           
%
%
% Variables:
% 
%
% Functions Called:  (Beyond Built-In Functions)
%   None
%
%--------------------------------------------------------------------------
% Begin Script

% Prompt user to input name and birthdate.
userName = input('Enter Name:     ', 's');
day = input('\nEnter your Birthdate (day):     ');
month = input('\nEnter your Birthdate (month):     ');
year = input('\nEnter your Birthdate (year):     ');

% Calculate users age in days, years, weeks, hours, minutes, and seconds.
ageInDays = now - datenum(year,month,day);
ageInYears = ageInDays/365.25;
ageInWeeks = ageInYears*52;
ageInHours = ageInDays*24;
ageInMinutes = ageInHours*60;
ageInSeconds = ageInMinutes*60;

% Display a formatted message to user.
disp(sprintf('\n%s is officially:\n', userName))
disp(sprintf('\t%12.2f years old.', ageInYears))
disp(sprintf('\t%12.2f weeks old.', ageInWeeks))
disp(sprintf('\t%12.2f days old.', ageInDays))
disp(sprintf('\t%12.2f hours old.', ageInHours))
disp(sprintf('\t%12.2f minutes old.', ageInMinutes))
disp(sprintf('\t%12.2f seconds old.', ageInSeconds))
