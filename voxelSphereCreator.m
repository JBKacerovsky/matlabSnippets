function sphereImage = voxelSphereCreator(sphereImage, r, x, y, z, varargin)
% VoxelSphereCreator - creates a voxelated sphere 
% Creates a voxelated sphere of defined radius at defined centre point
% coordinates of the input image/matrix (matrix element=voxel).
% Optional inputs can be added to create deformed spheres. 
% Sphere-voxels will be set to 1 in the output matrix
% 
% Syntax:  
%     sphereImage = voxelSphereCreator(sphereImage, r, y, x, z, varargin)
%     [output1,output2] = function_name(input1,input2,input3)
% 
% Inputs:
%    sphereImage - target matrix NxNxN
%    r - scalar; radius of the sphere
%    x - scalar; x-coordinate of sphere center point
%    y - scalar; y-coordinate of sphere center point
%    z - scalar; z-coordinate of sphere center point
%    
% Optional Inputs as Name-Value pairs
%    
%   'Ysquash' - scalar; sphere is "squashed" N-fold along the y axis
%   'Xsquash' - scalar; sphere is "squashed" N-fold along the x axis
%   'Zsquash' - scalar; sphere is "squashed" N-fold along the z axis
%   'resample' - scalar; sphere is resampled to a grid with N-fold higher 
%       resolution for more precise boundaries (using built-in interp3 with
%       on a meshgird with stepsize 1/N); usually not necessary; high N can
%       increase computation time dramatically; 
%    
% Outputs:
%    sphereImage - same as input sphereImage with voxels in the newly created
%    sphere set to 1
% 
% Example: 
% for visualizing the result these examples use the VoxelPlotter function
% by Itzik Ben Shabat 
% (https://www.mathworks.com/matlabcentral/fileexchange/50802-voxelplotter), MATLAB Central File Exchange. Retrieved January 13, 2020.
%
% build a sphere r=10 at the center of a 51x51x51 matrix
% 
% sp=zeros(51, 51, 51); 
% sp=voxelSphereCreator(sp, 10, 25, 25, 25);
% VoxelPlotter(sp);
% axis equal
% 
% % use 'Ysquash' to create a disc instead
% sp=zeros(51, 51, 51); 
% sp=voxelSphereCreator(sp, 20, 25, 25, 25, 'Ysquash', 2);
% VoxelPlotter(sp);
% axis equal
% 
% % sphereImages can be added and subtracted to create testObjects
% sp=zeros(51, 51, 51); 
% S=voxelSphereCreator(sp, 15, 25, 25, 25);
% S=voxelSphereCreator(S, 10, 25, 35, 25, 'Xsquash', 3, 'Zsquash', 3);
% S=S-voxelSphereCreator(sp, 20, 10, 25, 30, 'Ysquash', 2);
% VoxelPlotter(S);
% axis equal
% 
% 
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
% 

% Author: J. Benjamin Kacerovsky
% Centre for Research in Neuroscience, McGill University
% email: johannes.kacerovsky@mail.mcgill.ca
% Oct-2019 ; Last revision: 13-Jan-2020 

% ------------- BEGIN CODE --------------


p=inputParser;
addParameter(p, 'Xsquash', 1, @isnumeric);
addParameter(p, 'Ysquash', 1, @isnumeric);
addParameter(p, 'Zsquash', 1, @isnumeric);
addParameter(p, 'resample', 1, @isnumeric);
parse(p, varargin{:});
Ys=p.Results.Xsquash;
Xs=p.Results.Ysquash;
Zs=p.Results.Zsquash;
RR=p.Results.resample;
rr=round(1/RR, 2);
    [X, Y, Z]=meshgrid(1:rr:size(sphereImage, 2), 1:rr:size(sphereImage, 1), 1:rr:size(sphereImage, 3));
    A=sqrt(((X-y)*Xs).^2+((Y-x)*Ys).^2+((Z-z)*Zs).^2);
    sp=A<=r;
    
    if rr~=1
        disp('resample');
        sp=single(sp);
        [Xb, Yb, Zb]=meshgrid(1:1:size(sphereImage, 2), 1:1:size(sphereImage, 1), 1:1:size(sphereImage, 3));
        sp = interp3(X,Y,Z,sp,Xb,Yb,Zb);
        sp = sp>0.5;
        
    end
    
   sphereImage(sp)=1;
   
end

% ------------- END OF CODE --------------
