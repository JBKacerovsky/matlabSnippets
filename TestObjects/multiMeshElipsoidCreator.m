function FV=multiMeshElipsoidCreator(radii, centres, deform, rotation, stepSize)
% multiMeshElipsoidCreator - builds mesh objects consisting of any number
% of deformed and rotated spheres
%
% useful for generating meshes as test objects
% Spheres are defined by radius and centre point. All user defined spheres
% are merged to create a single mesh object. To get get different shapes
% each sphere can be deformed and rotated. 
%
% The objects are defined as function over a meshgrid. The FV mesh is
% created using the built in isosurface function.
% 
% Syntax:  
%     FV=multiMeshElipsoidCreator(radii, centres, deform, rotation)
% 
% Inputs:
%    radii      - 1xN matrix defining the radius for each sphere to be built
%    centres    - Nx3 matrix defining centre points for each sphere. Each row
%                 should correspond to the x, y, z coordinates of the centre
%                 point
%    deform     - OPTIONAL Nx3 matrix. The three numbers in each row define the
%                 degree to which each sphere should be transformed along
%                 the x, y, and z axis respectively; 
%                 >1 results in "squashing" 
%                 <1 results in "stretching" along the respective axis 
%                 default=ones(length(radii), 3) i.e no deformation
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
%    % first define the input variables
%    % this collection of elipsoids incidently build an object that vaguely
%    % resembles a certain starship
%    
%     r=[11, 5, 6, 8, 8, 7, 7];
%     c=[20, 20, 20;
%         12, 17, 20;
%         7, 13, 20;
%         2, 17.5, 23;
%         2, 17.5, 18;
%         -5, 23, 16.8;
%         -5, 23, 26.5];
%     deform=[1, 6, 1;
%         6, 1, 6;
%         1, 3, 3
%         10, 1, 10;
%         10, 1, 10;
%         1, 6, 6;
%         1, 6, 6];
%     rotation=[0, 0, 0;
%         0, 0, -40;
%         0, 0, 0;
%         10, 30, 40;
%         10, -30, 40; 
%         0, 0, 0; 
%         0, 0, 0];
%     
%    % apply the function
%     FV=multiMeshElipsoidCreator(r, c, deform, rotation, 0.5);
%     
%    % visualize the mesh
%     figure
%     P=patch(FV, 'FaceColor', 'none', 'EdgeColor', 'r');
%     axis equal
% 
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
% 

% Author: J. Benjamin Kacerovsky
% Centre for Research in Neuroscience, McGill University
% email: johannes.kacerovsky@mail.mcgill.ca
% Created: 04-Mar-2020 ; Last revision: 04-Jun-2020 

% ------------- BEGIN CODE --------------

if nargin<3
    deform=ones(length(radii), 3); 
end
if nargin<4
    rotation=zeros(length(radii), 3); 
end
if nargin<5
    stepSize=1;
end

% get dimensions and appropriate meshgrid
mins=centres-radii'./deform;
maxes=centres+radii'./deform;

mins=min(mins, [], 1)-2*stepSize/min(deform(:));
maxes=max(maxes, [], 1)+2*stepSize/min(deform(:));

[X, Y, Z]=meshgrid(mins(1):stepSize:maxes(1), mins(2):stepSize:maxes(2), mins(3):stepSize:maxes(3));
SP=zeros(size(X, 1), size(X, 2), size(X, 3), 1);
% build elipsoids
for i=1:length(radii)
    % get input values
        x=centres(i, 1);
        y=centres(i, 2);
        z=centres(i, 3);
        Xs=deform(i, 1);
        Ys=deform(i, 2);
        Zs=deform(i, 3);
       
    
    % calculate rotation matrices
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
    
    % calculate sphere/elipsoid function using rotated meshgrids
    SP(:, :, :, 1)=sqrt(((Xrot-x)*Xs).^2+((Yrot-y)*Ys).^2+((Zrot-z)*Zs).^2)/radii(i);
    SP(:, :, :, 2)=min(SP, [],  4); % bringing this inside the loop avoids inflating the memory (which slows down the code) 
end
% SP=min(SP, [],  4);
SP=SP(:, :, :, 2);
FV=isosurface(X, Y, Z, SP, 1);


% ------------- END OF CODE --------------