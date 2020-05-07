function [FV, p]=starship(display, stepsize)
% starship - builds a test object that resembles a starship as FV
% triangulated mesh
% 
% Syntax:  
%     starship;
%     FV=starship(display); 
%     [FV, p]=starship(display);
% 
% Inputs:
%    display - boolean choice whether to display the FV mesh in a new figure
%           1 -> display figure (default)
%           0 -> built FV but do not display (overruled if output p is
%           defined)
% 
% Outputs:
%    FV - struct; FV.faces/FV.vertices defining triangulated mesh object
%    p  - patch object; displaying the mesh; see documentation for built in
%         patch function; if outputargument p is defined a new figure will
%         be displyed regardless of the value display
% 
% 
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
% 
% See also: starship_voxel

% Author: J. Benjamin Kacerovsky
% Centre for Research in Neuroscience, McGill University
% email: johannes.kacerovsky@mail.mcgill.ca
% Created: 04-Mar-2020 ; Last revision: 27-Apr-2020 

% ------------- BEGIN CODE --------------


if nargin<1
    display=1;
end

if nargin<2
    stepsize=0.5;
end
r=[11, 5, 6, 8, 8, 7, 7];
c=[40, 20, 20;
    32, 17, 20;
    27, 13, 20;
    22, 17.5, 23;
    22, 17.5, 18;
    15, 23, 16.8;
    15, 23, 26.5];
deform=[1, 6, 1;
    6, 1, 6;
    1, 3, 3
    10, 1, 10;
    10, 1, 10;
    1, 6, 6;
    1, 6, 6];
rotation=[0, 0, 0;
    0, 0, -40;
    0, 0, 0;
    10, 30, 40;
    10, -30, 40; 
    0, 0, 0; 
    0, 0, 0];
% apply the function
FV=multiMeshElipsoidCreator(r, c, deform, rotation, stepsize);
% visualize the mesh
if display==1||nargout>1
%     figure
    FV.vertices=FV.vertices.*2-1;  % this is just to make it line up with starship_voxel.m
    p=patch(FV, 'FaceColor', 'b', 'EdgeColor', 'r', 'LineWidth', 1);
    axis equal
end


% ------------- END OF CODE --------------
