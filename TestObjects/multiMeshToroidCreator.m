function FV=multiMeshToroidCreator(R, r, centres, deform, rotation, stepSize)
% multiMeshToroidCreator - builds mesh objects consisting of any number
% of deformed and rotated toroids
%
% by default each torus is built  by revolving a circle of radius r
% around the origin at the major radius R; deformations can be be applied
% to built toroids with elliptical cross section or to build stretched toroids.
% rotations and centre points can be defined to achieve orientations other
% than a torous on the x/z-plane centred at the origin
% 
% Syntax:  
%     FV=multiMeshToroidCreator(R, r, centres)
%     FV=multiMeshToroidCreator(R, r, centres, deform, rotation, stepSize)
% 
% Inputs:
%    R -          Nx1 vector defining the major radius/radius of revolution
%                 for each toroid
%    r -          Nx1 vector defining the minor radius/circle radius
%                 for each toroid
%    centres    - Nx3 matrix defining centre points for each sphere. Each row
%                 should correspond to the x, y, z coordinates of the centre
%                 point; default=[0 0 0]
%    deform     - OPTIONAL Nx3 matrix. The three numbers in each row define the
%                 degree to which each sphere should be transformed along
%                 the x, y, and z axis respectively; 
%                 >1 results in "squashing" 
%                 <1 results in "stretching" along the respective axis 
%                 default=ones(length(radii), 3) i.e no deformation
%                 (deformation is applied before rotation)
%    rotation   - OPTIONAL Nx3 matrix. The three numbers in each row define the
%                 angle in degrees, by which the object is to be rotated
%                 around the x, y, and z axis, respectively. 
%                 only relevant for deformed spheres (ellipsoids) 
%                 default=zeros(length(radii), 3) i.e no rotation
%    stepSize   - OPTIONAL scalar; defines the stepsize used by for the
%                 meshgrid. default=1;
%                 smaller step size -> more/smaller triangles
% 
% Outputs:
%    FV         - Face/Vertex struct defining one triangulated mesh. See
%                 documentation for built in isosurface function
% 
% Example: 
%     R=[45, 60, 30, 20];
%     r=[6, 7, 4, 3]; 
%     stepSize=2;
% 
%     % defining only  major (R) and minor (r) radii builds a series of
%     % concentric toroid rings at [0 0 0]
%     FV=multiMeshToroidCreator(R, r);
%     figure; axis equal; 
%     patch(FV, 'FaceColor', 'b', 'edgecolor', 'r'); 
%     %%
%     % defining centres, deformation and rotation together with R and r from
%     % abbove results in a chain of interlocking toroids
%     centres=[0 0 0; 35 20 25; 72, 60, 35; 78, 105, 28];
%     deform=[1 1 1; 1, 3, 1; 0.6, 1, 1; 1, 1, 1];
%     rotation=[-20, 0, 0; 0, -10, 40; 0, 30, 80; 90, 90, 0];
%     % 
%     FV=multiMeshToroidCreator(R, r, centres, deform, rotation, stepSize);
% 
%     figure; axis equal; 
%     patch(FV, 'FaceColor', 'b', 'edgecolor', 'r'); 
% 
%     %%
%     % R=0 results in a speher, together with a squashed toroid resulting in a
%     % mesh reminiscent of a "Planet and rings" 
%     R=[0, 46, 52, 59, 65, 70, 74];
%     r=[30, 1.7, 1.5, 2, 1.5, 2, 2.5]; 
%     stepSize=1;
% 
%     centres=zeros(length(R), 3); 
%     deform=[1, 1, 1; repmat([1, 2, 1], length(R)-1, 1)];
%     rotation=[0, 0, 0; 5, 20, 40; 5, 20, 40; 5, 20, 40; 5, 20, 40; 5, 20, 40; 5, 20, 40];
%     % 
%     FV=multiMeshToroidCreator(R, r, centres, deform, rotation, stepSize);
% 
%     figure; axis equal; 
%     patch(FV, 'FaceColor', 'b', 'edgecolor', 'r'); 
% 
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
% 
% See also: 

% Author: J. Benjamin Kacerovsky
% Centre for Research in Neuroscience, McGill University
% email: johannes.kacerovsky@mail.mcgill.ca
% Created: 15-Jun-2020 ; Last revision: 15-Jun-2020 

% ------------- BEGIN CODE --------------


if nargin<3; centres=zeros(length(R), 3); end
if nargin<4; deform=ones(length(R), 3); end
if nargin<5; rotation=zeros(length(R), 3); end
if nargin<6, stepSize=1; end
mins=-(R+r)'./deform-1-abs(centres);
maxes=(R+r)'./deform+1+abs(centres);
mins=min(mins(:))-2*stepSize/min(deform(:));
maxes=max(maxes(:))+2*stepSize/min(deform(:));
[X, Y, Z]=meshgrid(mins:stepSize:maxes, mins:stepSize:maxes, mins:stepSize:maxes);
A=zeros(size(X, 1), size(X, 2), size(X, 3), 1);
    for i=1:length(R)
        if any(rotation(i, :)~=0)
                angle1=rotation(i, 1); 
                angle2=rotation(i, 2);  
                angle3=rotation(i, 3); 
                rotMatX=[1, 0, 0;
                        0, cosd(angle1), -sind(angle1);
                        0, sind(angle1), cosd(angle1)];
                rotMatY=[cosd(angle2), 0, sind(angle2);
                        0, 1, 0;
                        -sind(angle2), 0, cosd(angle2)];
                rotMatZ=[cosd(angle3), -sind(angle3), 0;
                        sind(angle3), cosd(angle3), 0;
                        0, 0, 1];
        else
            rotMatX=eye(3);     % matrix remains unchanged (i.e. no rotation) when multiplied with identity matrix eye(3)
            rotMatY=rotMatX; 
            rotMatZ=rotMatX; 
        end
        %rotate meshgrids
            % meshgrid rotation adapted from:
            % https://www.mathworks.com/matlabcentral/answers/285009-rotating-a-3d-meshgrid-with-rotation-matrix#answer_222755
        temp=[X(:),Y(:),Z(:)];
            % by temporarily shifting meshgrid coordinates so that the centre
            % of the object is at the origin we can rotate the coordinates (and
            % ultimately the object) around the object centre (keeping it "in
            % place" aftere rotation, rather than rotating the object loaction
            % around the origin); 
        C=centres(i, :);
        temp=temp-C;
        temp=temp*rotMatX*rotMatY*rotMatZ;
        sz=size(X);
        temp=temp+C;
        Xrot=reshape(temp(:,1),sz);
        Yrot=reshape(temp(:,2),sz);
        Zrot=reshape(temp(:,3),sz);
        xx=(Xrot-centres(i, 1)).*deform(i, 1);
        yy=(Yrot-centres(i, 2)).*deform(i, 2);
        zz=(Zrot-centres(i, 3)).*deform(i, 3);
    A(:, :, :, 1)=(((R(i)-(xx.^2+zz.^2).^(1/2)).^2+yy.^2).^(1/2))/r(i);
    A(:, :, :, 2)=min(A, [],  4);
    end
A=A(:, :, :, 2);
FV=isosurface(X, Y, Z, A, 1); 


% ------------- END OF CODE --------------
