function beamPropertiesI= inertia(beamProperties) 

% INERTIA calculates the moment of inertia for a solid rectangle beam, hollow
%           rectangle beam, T-beam, and an I-beam. 
% 
%   beamPropertiesI= inertia(beamProperties) returns a structure array of
%                    the moment of inertia of the beam 
%
%   Input: 
%       beamProperties    structure array with values for b,c,h,l,t 
%       
%   Output: 
%       beamPropertiesI   structure array of the inertia from the
%                         specifications of the beam input 
%
%   Notes: 
%       beamProperties must be a structure array 
%    Variables
%       b          width of beam 
%       beamType   beam type 
%       h          height of beam 
%       l          length of beam 
%       t          thickness of beam



%
%   Mikayla Tuma 
%   University of Alabama at Birmingham 
%   Engineering Computations with MATLAB
%   Dr. Mark Conner

%
%   Start Date: Jul 12, 2018
%   Last Revised on: Jul 17, 2018


% Error trapping input

if isstruct(beamProperties)==0 
    error ('beamProperties must be a structure array.');
end 

narginchk(1,1);

% Converting structure array to variables 

b= beamProperties.b;
beamType= beamProperties.c;
h= beamProperties.h;
l= beamProperties.l;
t= beamProperties.t;


% Caluculating inertia based on beam type


switch beamType
    case 1
        i= (b*h^3)/12;
        
    case 2
        i= ((b*h^3)/12)-(((b-(2*t))*(h-(2*t))^3)/12);
        
    case 3
        y= h-(((t*h^2)+(t^2*(b-t)))/(2*((b*t)+(h-t)*t)));
        i= (1/3)*((t*y^3)+(b*(h-y)^3)-(b-t)*(h-y-t)^3);
        
    case 4 
        i= (2*t*b)*(.5*(h-2*t)+(.5*t))^2+(((t*(h-(2*t)))^3)/12);
        
        
end


beamPropertiesI=i;


        
        
        
        
        
        