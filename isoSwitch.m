function FV=isoSwitch(FV)
% isoSwitch - tiny function to switch the 1st and 2nd column of vertex coordinates 
% (x, y) in a FV struct
%
% for some reason x and ycoordinates are swithed when using the isosurface
% function to create a triangulated mesh from a binary image (bw matrix),
% with respect to the original image
% these three lines switch it back
% 
% Syntax:  
%     FV=isoSwitch(FV)
% 
% Inputs:
%    FV - FV-struct
% 
% Outputs:
%    FV - FV-struct with x/y dimensions of FV.vertices
% 
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
% 

% Author: J. Benjamin Kacerovsky
% Centre for Research in Neuroscience, McGill University
% email: johannes.kacerovsky@mail.mcgill.ca
% 2019 ; Last revision: 13-Jan-2020 

% ------------- BEGIN CODE --------------

temp=FV.vertices;
FV.vertices(:, 1)=temp(:, 2);
FV.vertices(:, 2)=temp(:, 1);

% ------------- END OF CODE --------------
