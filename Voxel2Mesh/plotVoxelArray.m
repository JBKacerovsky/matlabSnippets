function [p, FV]=plotVoxelArray(bw, polytype)
% plotVoxelArray - displays the surface of a binary voxel array as a patch
% object
% 
% Syntax:  
%     p=plotVoxelArray(bw)
%     p=plotVoxelArray(bw, polytype)
%     [p, FV]=plotVoxelArray(bw)
%     [p, FV]=plotVoxelArray(bw, polytype)
% 
% Inputs:
%    bw - R3 array; binary or logical (if not binary, every voxel>0 will be
%       seen as 19
%    polytype - selection of type of mesh polygon
%       3 -> DEFAULT; triangulated mesh (each square voxel face is made up of 2
%           triangles; 
%       4 -> quad-mesh
%       any other input will default to 3
% 
% Outputs:
%    p  - patch object
%    FV - FV struct; FV.faces/FV.vertices defining the mesh
% 
% Example: 
%     % take any binary array as input 
%     % in this case I am using the function starship_voxel.m from 
%           https://www.mathworks.com/matlabcentral/fileexchange/75241-build-mesh-or-voxel-spheres-ellipsoid-and-test-objects
%     BW=starship_voxel;
% 
%     % generate triangulated surface mesh
%     figure
%     p=plotVoxelArray(BW); 
%     p.FaceColor='b'; 
%     axis equal
% 
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
% 
% See also: Voxel2mesh.m

% Author: J. Benjamin Kacerovsky
% Centre for Research in Neuroscience, McGill University
% email: johannes.kacerovsky@mail.mcgill.ca
% Created: 27-Apr-2020 ; Last revision: 27-Apr-2020 

% ------------- BEGIN CODE --------------


% set polytype = 3 to plot voxel Array as triangulated mesh
if nargin < 2
    polytype =4;    % default to quad-mesh
end
if polytype==4 
    FV=Voxel2mesh(bw, 4);
else
    FV=Voxel2mesh(bw, 3); 
end
p=patch(FV, 'FaceColor', 'b'); 


% ------------- END OF CODE --------------
