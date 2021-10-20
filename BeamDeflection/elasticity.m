function [modulusE] = elasticity(beamProperties)

% ELASTICITY Find the modulus of elasticity of various materials.
%
%   MODULUSE = elasticity(BEAMPROPERTIES) finds the modulus of elasticity
%   given structure input with field MAT. Accepts integer value 1-10.
%
%   beamProperties.mat = 1          Aluminum
%   beamProperties.mat = 2          Brass
%   beamProperties.mat = 3          Chromium
%   beamProperties.mat = 4          Copper
%   beamProperties.mat = 5          Iron
%   beamProperties.mat = 6          Lead
%   beamProperties.mat = 7          Steel
%   beamProperties.mat = 8          Tin
%   beamProperties.mat = 9          Titanium
%   beamProperties.mat = 10         Zinc
%
%   Variables:
%       modulusE -      Modulus of elasticity of materials.


% Error Handling
% Function must be given at least one input argument.
if nargin == 0
    error('Function elasticity.m requires at least one input')
end

% beamProperties.mat must not be empty
if isempty(beamProperties.mat)
    error('No material type selected')
end


% Main Script
switch beamProperties.mat
    case 1 % Aluminum
        modulusE = 10000000; % lb/in^2
    case 2 % Brass
        modulusE = 15900000; % lb/in^2
    case 3 % Chromium
        modulusE = 36000000; % lb/in^2
    case 4 % Copper
        modulusE = 15600000; % lb/in^2
    case 5 % Iron
        modulusE = 28500000; % lb/in^2
    case 6 % Lead
        modulusE = 2600000; % lb/in^2
    case 7 % Steel
        modulusE = 30000000; % lb/in^2
    case 8 % Tin
        modulusE = 6000000; % lb/in^2
    case 9 % Titanium
        modulusE = 16800000; % lb/in^2
    case 10 % Zinc
        modulusE = 12000000; % lb/in^2
    otherwise
        warning('Error selecting material')
end


end



