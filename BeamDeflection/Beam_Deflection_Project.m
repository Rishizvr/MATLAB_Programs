% File Name: Beam_Deflection_Project.m
%--------------------------------------------------------------------------
%
% Group 4
% Start Date: 20180713
% Last Revised on: 20180719
%
% Purpose: A computer model that plots the deflection of a beam based 
%          on input parameters that include the beam material, beam cross-
%          section, type of beam support, and the load applied to the beam.
%
%
%      Variables:                        Description:
%  
%   beam                - variable in cell array that holds the type of beam
%   beamProperties      - a structure of arrays that holds pertinent beam 
%                         information for functions                                                               
%   beamProperties.a    - distance of point load from left end of beam
%   beamProperties.b    - width of beam
%   beamProperties.c    - type of beam
%   beamProperties.d1   - output 1 deflection of beam
%   beamProperties.d2   - output 2 deflection of beam
%   beamProperties.e    - elasticity of beam material
%   beamProperties.f    - load magnitude
%   beamProperties.h    - height of beam
%   beamProperties.i    - beam moment of inertia
%   beamProperties.l    - length of beam
%   beamProperties.m    - beam material as a string
%   beamProperties.mat  - beam material in listdlg numeric value
%   beamProperties.s    - support type value 1 or 2
%   beamProperties.t    - thickness of beam walls for beam types 2 - 4
%   beamProperties.u    - load type value 1 or 2
%   beamProperties.w    - load / beam length in case of uniform load 



% Functions Called:(beyond built-in functions)
%
% elasticity
% deflection
% inertia
% plotDeflection
%
%--------------------------------------------------------------------------
% Begin script
clear 

% Acquire beam parameters 
beam{1} = listdlg('promptString','Select the desired cross section of the beam.',...
        'selectionMode','single',...
        'listString',{'solid rectangle', 'hollow rectangle', 'T-beam', 'I-beam'},...
        'name','sample list',...
        'listSize', [200 100]);
        % solid rectangle cell value is 1, hollow rectangle 2, T 3, I 4 
        
% Solid beam requires fewer inputs    
dlgTitle = 'Define beam parameters';
if beam{1} == 1
   prompt = {'Enter beam width (inches)','Enter beam height (inches)','Enter beam length (inches)'};
   defAns = {'4', '6', '50'}; 
   crossSection = inputdlg(prompt,dlgTitle,1,defAns); 
else
     prompt = {'Enter beam width (inches)','Enter beam height (inches)','Enter beam wall thickness (inches)','Enter beam length (inches)'};
     defAns = {'4', '6', '1','50'}; 
     crossSection = inputdlg(prompt,dlgTitle,1,defAns); 
end

% Error Trapping: correct data type
if sum(isnan(str2double(crossSection)))~=0
   error('All inputs must be numeric values.');
end


% Error Trapping: correct numeric value 
if sum(str2double(crossSection)) < sum(abs(str2double(crossSection)))
   error('All inputs must be positive values.');
end

% Error Trapping: possible beam dimensions 
x = size(crossSection,1);
switch x
    case 4 
         if str2double(crossSection{3}) >= 0.5*str2double(crossSection{1}) | str2double(crossSection{3}) >= 0.5*str2double(crossSection{1})
            error('Beam wall thickness must be less than half the value of the width or height of the beam.');
         end
end

% Convert cell array to structure for function use
if beam{1} == 1
   beamProperties.b = str2double(crossSection{1});
   beamProperties.c = beam{1};
   beamProperties.h = str2double(crossSection{2});
   beamProperties.l = str2double(crossSection{3}); 
   beamProperties.t = 0;
else
     beamProperties.b = str2double(crossSection{1});
     beamProperties.c = beam{1};
     beamProperties.h = str2double(crossSection{2});
     beamProperties.l = str2double(crossSection{4});
     beamProperties.t = str2double(crossSection{3});
end




% Prompt user for type of beam support 
% Support type value of 1 is cantilevered, value of 2 is supported
beamProperties.s = listdlg('promptString','Select the type of beam support.',...
        'selectionMode','single',...
        'listString',{'cantilevered', 'supported'},...
        'name','Support Type',...
        'listSize', [200 100]);
        % cantilevered cell value is 1, supported is 2

        
% Prompt user for type of load 
% Load type value of 1 is single point, value of 2 is uniform
beamProperties.u = listdlg('promptString','Select the type of load.',...
        'selectionMode','single',...
        'listString',{'single point load', 'uniformly distributed'},...
        'name','Load Type',...
        'listSize', [200 100]);    
        % single point load cell value is 1, uniform is 2    

% load perameters    
dlgTitle2 = 'Define load parameters';
if beamProperties.u ~= 1     
   prompt2 = {'Enter load magnitude (lbs)'};
   defAns2 = {'400'}; 
else 
     prompt2 = {'Enter load magnitude (lbs)','Enter load location in inches from the left end'};
     defAns2 = {'400', '25'}; 
     
end
loadParameters = inputdlg(prompt2,dlgTitle2,1,defAns2);

% Error Trapping: correct data type
if sum(isnan(str2double(loadParameters)))~=0
   error('All inputs must be numeric values.');
end

% Error Trapping: correct numeric value 
if sum(str2double(loadParameters)) < sum(abs(str2double(loadParameters)))
   error('All inputs must be positive values.');
end

% Error Trapping: impossible dimensions 
x = size(loadParameters,1);
switch x
    case 2 
         if str2double(loadParameters{2}) > beamProperties.l
            error('load placement must lie within the length of the bar.');
         end
end

% Calculations for inputs based on single point load or uniform load.
% If single point load, a = load loacation f = magnitude
% If uniform load, w = load magnitude over length of beam
if beamProperties.u == 1
   beamProperties.f = str2double(loadParameters{1});
   beamProperties.a = str2double(loadParameters{2});
   beamProperties.w = 0;
else 
     beamProperties.w = str2double(loadParameters{1})/beamProperties.l;
     beamProperties.f = 0;
     beamProperties.a = 0;
     
end

% Choose beam material. Saves value as numeric for Elasticity function.
beamProperties.mat = listdlg('PromptString','Select Beam Material',...
    'SelectionMode','single',...
    'ListString',{'Aluminum','Brass','Chromium','Copper','Iron','Lead',...
    'Steel','Tin','Titanium','Zinc'},...
    'Name','Beam Deflection','ListSize',[200 100]);

% Adjusts value of beamProperties.mat to a string value for plotDeflection 
% function. 
switch beamProperties.mat
    case 1 
        beamProperties.m = 'Aluminum';
    case 2 
        beamProperties.m = 'Brass';
    case 3 
        beamProperties.m = 'Chromium';
    case 4 
        beamProperties.m = 'Copper';
    case 5 
        beamProperties.m = 'Iron';
    case 6 
        beamProperties.m = 'Lead';
    case 7 
        beamProperties.m = 'Steel';
    case 8 
        beamProperties.m = 'Tin';
    case 9 
        beamProperties.m = 'Titanium';
    case 10 
        beamProperties.m = 'Zinc';
end



% Receive elasticity coefficient from elasticity function, save output in
% structure as beamProperties.e
beamProperties.e = elasticity(beamProperties);


% Feeds beam properties into inertia function save output in structure as 
% beamProperties.i
beamProperties.i = inertia(beamProperties);


% Feed beamProperties into deflection function, save output in structure
[beamProperties.d1, beamProperties.d2] = deflection(beamProperties);


% Feed beamProperties into plot function. Display plot in figure window
plotDeflection(beamProperties);

% end
