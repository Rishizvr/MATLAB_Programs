function [beamDeflection,xPos] = deflection(beamProperties)

% DEFLECTION Find the deflection of a beam given its parameters.
%
%   [BEAMDEFLECTION,XPOS] = deflection(BEAMPROPERTIES) generates two 1x50
%   vectors given structure BEAMPROPERTIES. BEAMDEFLECTION gives the
%   deflection of the beam from left to right. XPOS is a vector of 50 
%   values ranging from 0 to the total beam length.
%
%   Variables:
%       a -         Distance of force load from left of beam (inches)
%       b -         Distance from force load to right end of beam (inches)
%       Columns -   Number of column indices within vector xPos
%       E -         Elasticity value (lb/in^2)
%       F -         Force value (N) (single point load)
%       I -         Inertia value (in^4)
%       L -         Length of beam (inches)
%       Rows -      Number of row indices within vector xPos
%       w -         Force value (N) (distributed load)
%       xPos -      Row vector of 50 equally spaced distance values ranging
%                   from 0 to the total length of the beam

% Rishi Zaveri
% University of Alabama at Birmingham
% Dr. Conner
% Beam Deflection Group Project w/ Jack Chamberlain and Mikayla Tuma


% Error Handling
% Function must be given at least one input argument.
if nargin == 0
    error('Function deflection.m requires at least one input')
end

% Certain fields in beamProperties must not be empty
if isempty(beamProperties.e) || ...
        isempty(beamProperties.i) || ...
        isempty(beamProperties.l) || ...
        isempty(beamProperties.a) || ...
        isempty(beamProperties.f)
    error('Invalid value for beamProperties field')
end

% Certain fields in beamProperties must not be NaN
if sum(isnan([beamProperties.e beamProperties.i beamProperties.l ...
        beamProperties.a beamProperties.f])) > 0
    error('Invalid value for beamProperties field')
end

% For a distributed load, omega must be a number
if beamProperties.u == 2 % If a distributed load was selected
    if isnan(beamProperties.w) || isempty(beamProperties.w)
        error('Invalid value for beamProperties.w')
    end
end

% User must select valid support and load types
if beamProperties.s ~= 1 && beamProperties.s ~= 2
    error('Invalid value for beam support type')
end

if beamProperties.u ~= 1 && beamProperties.u ~= 2
    error('Invalid value for load type')
end


% Main Script
E = beamProperties.e; % elasticity value (lb/in^2)
I = beamProperties.i; % inertia value (in^4)
L = beamProperties.l; % length of beam (inches)
xPos = linspace(0,L,50); % array of points along beam
[ Rows, Columns ] = size(xPos);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cantilever Beam
if beamProperties.s == 1
    if beamProperties.u == 1 % Single point load
        beamDeflection = zeros(Rows,Columns);
        a = beamProperties.a;
        b = beamProperties.l - beamProperties.a;
        F = beamProperties.f;
        for x = 2:Columns % ignore the first end of the beam (zero deflection)
            if xPos(x) > 0 && xPos(x) < a  % 0<x<a
                beamDeflection(x) = ((F*(xPos(x)^2))/(6*E*I)) * (3*a - xPos(x));
            elseif xPos(x) >= a && xPos(x) <= L  %a<x<L, end of cantilever and pos of force included
                beamDeflection(x) = ((F*(a^2))/(6*E*I)) * (3*xPos(x) - a);
            end
        end
    end
    
    if beamProperties.u == 2 % Uniformly distributed
        w = beamProperties.w; % force value (N) (distributed load)
        beamDeflection = ((w*(xPos.^2))/(24*E*I)) .* ((xPos.^2) + 6*(L^2) - 4*L.*xPos);
    end
end

% Supported Beam
if beamProperties.s == 2
    if beamProperties.u == 1 % Single point load
        beamDeflection = zeros(Rows,Columns);
        a = beamProperties.a;
        b = beamProperties.l - beamProperties.a;
        F = beamProperties.f;
        for x = 2:Columns-1 % ignore the two ends of the beam (zero deflection)
            if xPos(x) > 0 && xPos(x) < a  % 0<x<a
                beamDeflection(x) = ((F*b*xPos(x))/(6*L*E*I)) * (L^2 - (xPos(x)^2) - b^2);
            elseif xPos(x) >= a && xPos(x) < L  %a<x<L, position of force included
                beamDeflection(x) = ((F*b)/(6*L*E*I)) * ((L/b)*((xPos(x)-a)^3) + ((L^2 - b^2)*xPos(x)) - xPos(x)^3);
            end
        end
    end
    
    if beamProperties.u == 2 % Uniformly distributed
        w = beamProperties.w; % force value (lb) (distributed load)
        beamDeflection = ((w.*xPos)/(24*E*I)) .* (L^3 - 2.*L.*(xPos.^2) + xPos.^3);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


end

