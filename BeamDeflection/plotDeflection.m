function deflectionVsLength= plotDeflection(beamProperties) 

% PLOTDEFLECTION produces a graph of deflected and undeflected values
%
%   deflectionVsLength= plotDeflection(beamProperties) returns a graph of
%                       deflected values and undeflected values at
%                       different positions on the beam from specifications
%                       given in beamProperties
%
%   Input: 
%       beamProperties             a structure array with values for d1, d2, l, mat,
%                                  c, u, s, f, and a 
%  
%   Output: deflectionVsLength     a plot of deflected and undeflected
%                                  values
%  

%   Mikayla Tuma 
%   University of Alabama at Birmingham 
%   Engineering Computations with Matlab
%   Dr. Mark Conner
% 

%   Start Date: Jul 12, 2018
%   Last Revised on: Jul 17, 2018
%

% Error checking input 

narginchk(1,1);


if isstruct(beamProperties)==0 
    error ('beamProperties must be a structure array.');
end 


% Converting structure values into variables 

xPos= beamProperties.d1;
beamDeflectionx= beamProperties.d2;
L= beamProperties.l;
c= beamProperties.c;
u= beamProperties.u;
s= beamProperties.s;
f= beamProperties.f;
a= beamProperties.a;
w= beamProperties.w;
material= beamProperties.m; 

% Getting maximum deflection point 
maxDeflection= max(xPos);

% Converting support and load type and beam type from numerical desription to string description
support= s;
switch s 
    case 1 
        s= 'Cantilevered Supported'; 
    case 2
        s= 'Simply Supported';
end 
        

loadType= u;
switch u 
    case 1 
        u= 'Point Load';
    case 2 
        u= 'Uniform Load';
end 

beamType= c;
switch c 
    case 1 
        c= 'Solid Rectangle';
    case 2 
        c= 'Hollow Rectangle';
    case 3
        c= 'T-beam';
    case 4
        c= 'I-beam';
end 


% Creating y value to plot undeflected beam 
y=zeros(1,50);

% Plotting beam 

figure 
hold on
plot(beamDeflectionx,-xPos);
plot(beamDeflectionx,y,'--k');
hold off


xlabel('Distance of the Beam (inches)');
ylabel('Distance Deflected (inches)');


dim=[.2 .5 .3 .3];
if strcmp(u,'Point Load') == 1
   str = sprintf('The length of the beam is %.2f inches.\nThe location of the load is %.2f inches from the left.\nThe material of the beam is %s.\nThe shape of the cross section is %s.\nThe maximum deflection is %.9f inches.',L,a,beamProperties.m,c,maxDeflection);
   annotation('textbox',dim,'String',str,'FitBoxToText','on');
   title(sprintf('The type of the support is %s\nThe type of load is %s.\nThe magnitude of the load is %.2f pounds. ',s,u,f));
else strcmp(u,'Point Load') == 0
     str = sprintf('The length of the beam is %.2f inches.\nThe material of the beam is %s.\nThe shape of the cross section is %s.\nThe maximum deflection is %.9f inches.',L,beamProperties.m,c,maxDeflection);
     annotation('textbox',dim,'String',str,'FitBoxToText','on');
     title(sprintf('The type of the support is %s\nThe type of load is %s.\nThe magnitude of the load is %.2f pounds. ',s,u,w));
end






