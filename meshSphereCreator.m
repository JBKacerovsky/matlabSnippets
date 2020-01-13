function FV = meshSphereCreator( r, varargin)
% creates a triangulated sphere with radius r
% 
% there probably much better options for creating perfect spheres but that
% is not the main purpose of this function
% it was written to build simple triangulated mesh test objects using the
% built in isosurface function to serve as a testing ground for more
% complex isosurfaces to try out and develop mesh operations
%
% optional inputs as Name Value pairs
% 'step' scalar input, determines the stepsize of the meshgrid used to
%       build the sphere -> changes edge length/triangle size (smaller
%       'step' -> shorter edges -> higher "resolution"),  default = 1
% Ysquash, Xsquash, Zsquash --> will "squash" the sphere by numeric factor
%       along X, Y orZ axis respectively 

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
    
    