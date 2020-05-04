function [BW, p]=starship_voxel(display)
% starship_voxel - builds a test object that resembles a starship as uint8
% binary array
% 
% Syntax:  
%     starship_voxel
%     BW=starship_voxel(display)
%     [BW, p]=starship_voxel(display)
% 
% Inputs:
%    display - boolean choice whether to display the FV mesh in a new figure
%           1 -> display figure (default); requires Voxel2mesh.m (see
%           below)
%           0 -> built FV but do not display (overruled if output p is
%           defined)
% 
% Outputs:
%    BW - uint8 binary array
%    p  - patch object; displaying the binary array as a surface mesh
% 
% Other m-files required: to use the display option Voxel2mesh.m is
% required:
%           https://www.mathworks.com/matlabcentral/fileexchange/75240-voxel2mesh-plotvoxelarray?s_tid=prof_contriblnk
% 
% MAT-files required: none
% 
% See also: starship.m

% Author: J. Benjamin Kacerovsky
% Centre for Research in Neuroscience, McGill University
% email: johannes.kacerovsky@mail.mcgill.ca
% Created: 27-Apr-2020 ; Last revision: 27-Apr-2020 

% ------------- BEGIN CODE --------------


    
    if nargin<1 % default to no display
        display=0;
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
    BW=multiVoxelElipsoidCreator(r, c, deform, rotation, 0.5);
    
   % visualize the object
   if display==1
%         figure
        FV=Voxel2mesh(BW, 3); 
%             temp=FV.vertices;
%             FV.vertices(:, 1)=temp(:, 2);
%             FV.vertices(:, 2)=temp(:, 1);
        p=patch(FV, 'FaceColor', 'b');
        axis equal
   end


% ------------- END OF CODE --------------
