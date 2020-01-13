function FV = meshSphereCreator(r, varargin)
% meshSphereCreator - Creates a triangulated sphere with radius r
%
% Creates a triangulated sphere with radius r as a FV (face, vertex) struct
% using the built-in isosurface function. 
% My main purpose for this funciton was to build test objects of known
% geometry as a testing ground for more complex isosurfaces to try out and 
% develop mesh operations. For creating perfect spheres there other options 
% are likely better suited. 
% The centerpoint of the spehere is selected so that all sphere vertices
% are positive (i.e. xyz=[r+1, r+1, r+1])
%
% Syntax:  
%     FV = meshSphereCreator(r)
%     FV = meshSphereCreator(r, ...)
% 
% Inputs:
%    r - scalar; radius of the sphere. 
%    input2 - Description
%    input3 - Description
%
% Optional Inputs as Name-Value pairs
%    
%   'Ysquash' - scalar; sphere is "squashed" N-fold along the y axis
%   'Xsquash' - scalar; sphere is "squashed" N-fold along the x axis
%   'Zsquash' - scalar; sphere is "squashed" N-fold along the z axis
%   'step' - scalar; stepsize of the meshgrid used to build the sphere 
%        indirectly defines edge length/triangle size 
%       (smaller 'step' -> shorter edges -> higher "resolution"),  default = 1
% 
% Outputs:
%    FV struct (output of built-in isosurface function)
% 
% Examples: 
%     create a sphere with r=10
%     sp=meshSphereCreator(10);
%     patch(sp, 'FaceColor', 'none');
%     axis equal
% 
%     % increase or decrease triangle resolution
%     spFine=meshSphereCreator(10, 'step', 0.5);
%     spCoarse=meshSphereCreator(10, 'step', 4);
% 
%     subplot(1,2,1)
%     patch(spFine, 'FaceColor', 'none');
%     axis equal
%     title 'smaller stepsize = smaller triangles'
%     subplot(1,2,2)
%     patch(spCoarse, 'FaceColor', 'none');
%     axis equal
%     title 'larger stepsize = larger triangles'
% 
%     % mesh spheres can be "squashed" along x, y, or z axis
%     sp=meshSphereCreator(10, 'Ysquash', 3, 'Zsquash', 3, 'step', 0.5);
%     patch(sp, 'FaceColor', 'none');
%     axis equal
% 
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
% 
% See also: isosurface 
%
% Author: J. Benjamin Kacerovsky
% Centre for Research in Neuroscience, McGill University
% email: johannes.kacerovsky@mail.mcgill.ca
% Oct-2020 ; Last revision: 13-Jan-2020 

% ------------- BEGIN CODE --------------
p=inputParser;
addParameter(p, 'Xsquash', 1, @isnumeric);
addParameter(p, 'Ysquash', 1, @isnumeric);
addParameter(p, 'Zsquash', 1, @isnumeric);
addParameter(p, 'step', 1, @isnumeric);
parse(p, varargin{:});
Ys=p.Results.Xsquash;
Xs=p.Results.Ysquash;
Zs=p.Results.Zsquash;
rr=p.Results.step;
x=r+1;
    [X, Y, Z]=meshgrid(1:rr:2*r+1, 1:rr:2*r+1, 1:rr:2*r+1);
    A=sqrt(((X-x)*Xs).^2+((Y-x)*Ys).^2+((Z-x)*Zs).^2);
    FV=isosurface(X, Y, Z, A, r);
   
end
% ------------- END OF CODE --------------
