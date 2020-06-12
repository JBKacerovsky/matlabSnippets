function FV = meshSphereCreator(r, varargin)
% meshSphereCreator - Creates a triangulated sphere with radius r
%
% Creates a triangulated sphere with radius r as a FV (face, vertex) struct
% using the built-in isosurface function. 
% My main purpose for this funciton was to build test objects of known
% geometry as a testing ground for more complex isosurfaces to try out and 
% develop mesh operations. For creating perfect spheres there other options 
% are likely better suited. 
% By default the sphere will be centred around the origin [0, 0, 0].
% Optionally a differeent Centre Point can be defined
%
% Syntax:  
%     FV = meshSphereCreator(r);
%     FV = meshSphereCreator(r, ..., 'Name', Value); 
%     centrePoint – OPTIONAL; 1x3 vector; defining centre point of the sphere;
%       default=[0, 0, 0]
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
%     % create a sphere with r=10
%     figure
%     sp=meshSphereCreator(10);
%     patch(sp, 'FaceColor', 'none');
%     axis equal
%     
%     
%     % create sphere with r=10 centered at [20, 30, 0]; 
%     sp=meshSphereCreator(10, [20, 30, 0]);
%     patch(sp, 'FaceColor', 'none');
%     axis equal
%     
%     % increase or decrease triangle resolution
%     spFine=meshSphereCreator(10, 'step', 0.5);
%     spCoarse=meshSphereCreator(10, 'step', 4);
%     figure
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
%     figure
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
% Oct-2020 ; Last revision: 05-Jun-2020 

% ------------- BEGIN CODE --------------
p=inputParser;
addRequired(p, 'r'); 
addOptional(p, 'centrePoint', [0, 0, 0], @(x) isnumeric(x)&&(length(x)==3)&&isvector(x)); 
addParameter(p, 'Xsquash', 1, @(x) isnumeric(x)&&isscalar(x));
addParameter(p, 'Ysquash', 1, @(x) isnumeric(x)&&isscalar(x));
addParameter(p, 'Zsquash', 1, @(x) isnumeric(x)&&isscalar(x));
addParameter(p, 'step', 1, @(x) isnumeric(x)&&isscalar(x));

parse(p, r, varargin{:});

centrePoint=p.Results.centrePoint;
Xs=p.Results.Xsquash;
Ys=p.Results.Ysquash;
Zs=p.Results.Zsquash;
rr=p.Results.step;


    [X, Y, Z]=meshgrid(-r:rr:r, -r:rr:r, -r:rr:r);
    A=sqrt((X*Xs).^2+(Y*Ys).^2+(Z*Zs).^2);
    FV=isosurface(X, Y, Z, A, r);
    FV.vertices=FV.vertices+centrePoint; 
end
% ------------- END OF CODE --------------
