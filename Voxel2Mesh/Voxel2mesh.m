function FV=Voxel2mesh(bw, polytype)
% Voxel2mesh - creates triangulated or quad mesh from binary array; the
% mesh represents the surface faces of boundary voxels in the input array
% (i.e. each voxel face, facing the outside of the object);
% mesh triangles follow the right hand rule with face normals pointing
% outwards
% the method for cleaning up duplicate vertices was taken from:
%       https://www.mathworks.com/matlabcentral/fileexchange/49691-patch-remesher
% 
% Syntax:  
%     FV=Voxel2mesh(bw)
%     FV=Voxel2mesh(bw, polytype)
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
%    FV - FV struct; FV.faces/FV.vertices defining the mesh
% 
% Example: 
%     % take any binary array as input 
%     % in this case I am using the function starship_voxel.m from 
%     BW=starship_voxel;
% 
%     % generate triangulated surface mesh
%     FV=Voxel2mesh(BW); 
% 
%     % display
%     figure
%     patch(FV, 'FaceColor', 'b'); 
%     axis equal
% 
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
% 

% Author: J. Benjamin Kacerovsky
% Centre for Research in Neuroscience, McGill University
% email: johannes.kacerovsky@mail.mcgill.ca
% Created: 27-Apr-2020 ; Last revision: 27-Apr-2020 

% ------------- BEGIN CODE --------------


% set polytype = 4 to get a quad mesh
if nargin<2 
    polytype=3; % default to triangulated mesh
end
bw=bw>0; 
% define cube points relative to voxel coordinates
Vbase=  [-0.5 -0.5 0.5;...
         0.5 -0.5 0.5;...
         0.5 0.5 0.5;...
        -0.5 0.5 0.5;...
         0.5 -0.5 -0.5;...
        -0.5 -0.5 -0.5;...
        -0.5 0.5 -0.5;...
         0.5 0.5 -0.5];
% figure 
% hold on
% t=cellstr(num2str([1:8]'));
% textscatter3(Vbase(:, 1)+0.1, Vbase(:, 2), Vbase(:, 3), t);
% scatter3(Vbase(:, 1), Vbase(:, 2), Vbase(:, 3), 'filled');
% axis equal
% define possible cube faces
Fbase=  [1 2 3 4;...  % front
        2 5 8 3;... % right
        5 6 7 8;... % back
        6 1 4 7;... % left
        6 5 2 1;... % bottom
        8 7 4 3];   % top
% define search neighbourhood
% for each face of a cube around every perimeter voxel we want to assess if
% it's neighbour is outside the bw object. Faces that face the outside of
% the object will be included in the output FV
searcher=[0 0 -1;... % front (by mshifting the outside "backwards" we find voxels with a "free" frontfacing face
          -1 0 0;... % right
          0 0 1;...  % back
          1 0 0;...  % left
          0 1 0;...  % bottom
          0 -1 0];   % top
% Initialize FV
FV.vertices=[];
FV.faces=[];
Outside=~logical(bw);               % inverse of the input array.
perim=logical(bwperim(bw));     % we only have to consider voxels on the perimeter of the object
for j=1:6
    % shift Outside array in the direction of searcher(j, :)
    temp=circshift(Outside, searcher(j, 1), 1); 
    temp=circshift(temp, searcher(j, 2), 2); 
    temp=circshift(temp, searcher(j, 3), 3); 
    % find perimeter voxels that have a neighbout in this direction 
    temp=temp&perim;
    pts=find(temp); 
    [x, y, z]=ind2sub(size(temp), pts); 
    pts=[x, y, z];
    % base vertices for cube face in direction j
    v=Vbase(Fbase(j, :), :);
    % define new vertices
    vv=zeros(size(pts, 1)*4, 3);
        for i=1:4
            vv(i:4:end, :)=v(i, :)+pts;
        end
    % define new faces
    if polytype==4    % quad-faces if specified
        ff=zeros(4, size(pts, 1));
        ff(:)=1:size(vv, 1); 
        ff=ff';
    else              % triangular faces by default
        ff=zeros(size(pts, 1)*2, 3);
        ff(1:2:end, 1)=1:4:size(vv, 1);
        ff(1:2:end, 2)=2:4:size(vv, 1);
        ff(1:2:end, 3)=3:4:size(vv, 1);
        ff(2:2:end, 1)=1:4:size(vv, 1);
        ff(2:2:end, 2)=3:4:size(vv, 1);
        ff(2:2:end, 3)=4:4:size(vv, 1);
    end
    % remove duplicate vertices 
    [vv, ~, indexn] =  unique(vv, 'rows');
    ff = indexn(ff);
    % add new vertices and faces to FV
    FV.faces=[FV.faces; ff+size(FV.vertices, 1)];
    FV.vertices=[FV.vertices; vv];
end
% final cleanup
[FV.vertices, ~, indexn] =  unique(FV.vertices, 'rows');
FV.faces = indexn(FV.faces);


% ------------- END OF CODE --------------
