%% FileName: Visualizing Data
% Name: Rishi Zaveri
% University of Alabama at Birmingham
% Date: 26 June 2018
% Last Revised: 27 June 2018

% Purpose: Learn how to generate differently formatted graphs of data from
%   different sources.

%% Begin Script

% Prompt user for input and store file into variable (myFile).
% Load myFile
popD = input('Please input your population density file (ex. popDensity.txt).     ', 's');
popD = load(popD);
[Rows Columns] = size(popD);

% Info on Population Density (per square mile) across North/South regions
%   and East/West regions.
% Since matlab operates column-wise, we can transpose the datafile to
%   easily operate functions across rows.
popDNorthSouthAverage = mean(transpose(popD));
popDNorthSouthMax = max(transpose(popD));
popDNorthSouthMin = min(transpose(popD));

popDEastWestAverage = mean(popD);
popDEastWestMax = max(popD);
popDEastWestMin = min(popD);

% Info on Population Density for entire file.
% Total population
popDTotal = sum(sum(popD));
% Total Area (square miles)
popDArea = 2*Rows * 2*Columns;
% Average population density (total population divided by total area)
popDAverage = popDTotal/popDArea;

% Region with highest population density.
popDHighestArray = max(popD); % The highest popD in each column
% Find the highest population D and the column index it is found.
[popDHighest, popDHighestLocationColumn] = max(popDHighestArray);
% Using the column index, find the row index of the highest population D.
[popDHighest, popDHighestLocationRow] = max(popD(:,popDHighestLocationColumn));

% Avg pop D in 10x10 mile region surrounding the region with highest pop D.
%   Note: 10x10 mile region = 5x5 matrix
% Since a user's data could have the highest pop D region in a corner..
%   Add 2 columns of zeros and 2 rows of zeros to each of the 4 edges.
popD2 = [popD , zeros(Rows,2)];
popD2 = [popD2 ; zeros(2,Columns+2)];
popD2 = [zeros(Rows+2,2) , popD2];
popD2 = [zeros(2,Columns+4) ; popD2];

% Now use popD2 to calculate Avg pop D in 10x10 mile region surrounding the
%   region with the highest pop D.
% Also note, since we added the zeros into the matrix, the row and column
%   location of the highest pop D region will have shifted right 2 and down
%   2 in popD2.
popDConcentratedRegion = popD2(popDHighestLocationRow:1:popDHighestLocationRow+4 ,...
    popDHighestLocationColumn:1:popDHighestLocationColumn+4);

popDConcentratedRegionAverage = (sum(sum(popDConcentratedRegion)))/100;

%% Figure 1
fig1 = figure(1);
fig1.WindowStyle = 'docked';

% Subplot 1
subplot(2,2,1)
bar3(popD, 'b')
title('Highest Population Densities Highlighted','fontsize',14,'fontname','Arial')
xlabel('East/West','fontsize',12,'fontname','Arial')
ylabel('North/South','fontsize',12,'fontname','Arial')
zlabel('Population Density','fontsize',12,'fontname','Arial')
hold on

popD3 = zeros(size(popD));
[ x, i ] = max(popDNorthSouthAverage); % Maximum index row-wise (left/right)
[ x2, i2 ] = max(popDEastWestAverage); % Maximum index column-wise
popD3(i,:) = popD(i,:);
popD3(:,i2) = popD(:,i2);

bar3(popD3, 'g')
hold off

% Subplot 2
subplot(2,2,2)
bar3(popD, 'b')
title('Lowest Population Densities Highlighted','fontsize',14,'fontname','Arial')
xlabel('East/West','fontsize',12,'fontname','Arial')
ylabel('North/South','fontsize',12,'fontname','Arial')
zlabel('Population Density','fontsize',12,'fontname','Arial')
hold on

popD4 = zeros(size(popD));
[ x3, i3 ] = min(popDNorthSouthAverage); % Maximum index row-wise (left/right)
[ x4, i4 ] = min(popDEastWestAverage); % Maximum index column-wise
popD4(i3,:) = popD(i3,:);
popD4(:,i4) = popD(:,i4);

bar3(popD4, 'r')
hold off

% Subplot 3
subplot(2,2,3)
bar3(popD, 'b')
title('')
xlabel('East/West','fontsize',12,'fontname','Arial')
ylabel('North/South','fontsize',12,'fontname','Arial')
zlabel('Population Density','fontsize',12,'fontname','Arial')
hold on

popD3 = zeros(size(popD));
[ x, i ] = max(popDNorthSouthAverage); % Maximum index row-wise (left/right)
[ x2, i2 ] = max(popDEastWestAverage); % Maximum index column-wise
popD3(i,:) = popD(i,:);
popD3(:,i2) = popD(:,i2);

bar3(popD3, 'g')

view(0,90)

hold off

% Subplot 4
subplot(2,2,4)
bar3(popD, 'b')
title('')
xlabel('East/West','fontsize',12,'fontname','Arial')
ylabel('North/South','fontsize',12,'fontname','Arial')
zlabel('Population Density','fontsize',12,'fontname','Arial')
hold on

popD4 = zeros(size(popD));
[ x3, i3 ] = min(popDNorthSouthAverage); % Maximum index row-wise (left/right)
[ x4, i4 ] = min(popDEastWestAverage); % Maximum index column-wise
popD4(i3,:) = popD(i3,:);
popD4(:,i4) = popD(:,i4);

bar3(popD4, 'r')

view(0,90)

hold off

%% Figure 2
fig2 = figure(2);
fig2.WindowStyle = 'docked';

% Subplot 1
subplot(2,1,1)
bar3(popD, 'b')
title(sprintf('The Highest Population Density is %i.\nThe Surrounding Regions have an Average Density of %i.',popDHighest,round(popDConcentratedRegionAverage)) ...
    ,'fontsize',12,'fontname','Arial')
xlabel('East/West','fontsize',10,'fontname','Arial')
ylabel('North/South','fontsize',10,'fontname','Arial')
zlabel('Population Density','fontsize',10,'fontname','Arial')
hold on

popD5 = zeros(size(popD));
popD5(popDHighestLocationRow-2:1:popDHighestLocationRow+2 , popDHighestLocationColumn-2:1:popDHighestLocationColumn+2) = ...
    popD(popDHighestLocationRow-2:1:popDHighestLocationRow+2 , popDHighestLocationColumn-2:1:popDHighestLocationColumn+2);

bar3(popD5, 'y')
hold off

% Subplot 2
subplot(2,1,2)
bar3(popD, 'b')
title('')
xlabel('East/West','fontsize',10,'fontname','Arial')
ylabel('North/South','fontsize',10,'fontname','Arial')
zlabel('Population Density','fontsize',10,'fontname','Arial')
hold on

popD5 = zeros(size(popD));
popD5(popDHighestLocationRow-2:1:popDHighestLocationRow+2 , popDHighestLocationColumn-2:1:popDHighestLocationColumn+2) = ...
    popD(popDHighestLocationRow-2:1:popDHighestLocationRow+2 , popDHighestLocationColumn-2:1:popDHighestLocationColumn+2);

bar3(popD5, 'y')

view(0,90)

hold off

%% Figure 3
fig3 = figure(3);
fig3.WindowStyle = 'docked';

% Subplot 1
subplot(2,1,1)
histogram(popD,20,'facecolor','g')
title('Frequency of certain Population Densities','fontsize',14,'fontname','Arial')
xlabel('Population Density','fontsize',14,'fontname','Arial')
ylabel('Frequency','fontsize',14,'fontname','Arial')
% Subplot 2
subplot(2,2,3)

popD6 = zeros(size(popD));
popD6(1:3,:) = popD(1:3,:);
popD6(end-2:end,:) = popD(end-2:end,:);
popD6(:,1:3) = popD(:,1:3);
popD6(:,end-2:end) = popD(:,end-2:end);
popD6(popD6 == 0) = NaN;
% I had to google for this 'NaN' tip, otherwise the 0 value would show up
%   in my histogram...

histogram(popD6,20,'facecolor','b')
title('Frequency of Outer Three Geo Regions PopD','fontsize',14,'fontname','Arial')
xlabel('Population Density','fontsize',14,'fontname','Arial')
ylabel('Frequency','fontsize',14,'fontname','Arial')

% Subplot 3
subplot(2,2,4)

popD7 = zeros(size(popD));
popD7(4:end-3,4:end-3) = popD(4:end-3,4:end-3);
popD7(popD7 == 0) = NaN;

histogram(popD7,20,'facecolor','m')
title('Frequency of Inner Geo Regions PopD','fontsize',14,'fontname','Arial')
xlabel('Population Density','fontsize',14,'fontname','Arial')
ylabel('Frequency','fontsize',14,'fontname','Arial')
