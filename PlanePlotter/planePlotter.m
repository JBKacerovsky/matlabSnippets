function p=planePlotter(point, normal, varargin)
% PLANE PLOTTER - draws a plane defined by a point and normal vector
%
% the plane will be drawn as a square of specified range centred around 'point'
%
% ! this is an implementation of a method suggested by Roger Stafford on
% ! the MATLAB answers forum  
% ! https://www.mathworks.com/matlabcentral/answers/291485-how-can-i-plot-a-3d-plane-knowing-its-center-point-coordinates-and-its-normal#answer_226405
% ! the actual method is taken straight from the forum, I simply added some
% ! input features etc to make it universal and more convenient to use
% 
% Syntax: p=planePlotter(point, normal)
%         p=planePlotter(point, normal, ...)
%         planePlotter(point, normal)
%         planePlotter(point, normal, ...)
%
% INPUTS: 
%   point - xyz coordinates (1x3 or 3x1) of a point in the plane 
% 
%   normal - normal vector to the plane (1x3 or 3x1)
% 
% OPTIONAL INPUTS:
% optional inputs can be specified as Name-Value pairs to give additional
% graphics choices
%
%     'range': scalar; defines the range of the plane that will be graphed
%     (size of the square); default=1 resulting in a 2x2 square
% 
%     'gridlines': scalar, defines how many gridlines will be drawn on the plane; 
%       default=1 -> no lines; 2 -> edges drawn; 3 -> edges plus 4 squares; etc
% 
%     'FaceColor': string, RGB triplet or hexadecimal string; default='green'
% 
%     'FaceAlpha': scalar; default=0.3
% 
%     'EdgeColor': string, RGB triplet or hexadecimal string; default='black'
%
%     OUTPUT:
%     for simple drawing the output does not have to be defined
%     defining the output, p, saves the graphics element to allow later editing
%
% Example 1:
%     % plane at 45º angle through origin
%     % specifying only point and normal vector leaves optional inputs as
%     % default resulting in a green plane with no lines:
%
%     point=[0 0 0];
%     vector=[1 1 1];
%     planePlotter(point, vector);
%     axis equal
%    
%     % we can add the point and vector to this as illustrations:
%     hold on
%     scatter3(point(1), point(2), point(3),  500, '+', 'LineWidth', 2);
%     quiver3(point(1), point(2), point(3), vector(1), vector(2), vector(3), 'Color', 'r', 'MaxHeadSize', 1, 'LineWidth', 2);
%     view(2);
%   
% Example 2:      
% 
%     % drawing the same plane with a range of 5 (resulting in a 10x10 square)
%     % with gridlines drawing 1x1 grid squares (11 gridlines including 0 and 10)
%     % with teal faces and magenta edges
%     p=planePlotter([0 0 0], [1 1 1], 'range', 5, 'gridlines', 11, 'FaceColor', [0, 1, 1], 'EdgeColor', '#FF00FF');
%     axis equal
% 
%     % specifying the graphics output (p) allows us to change individual graphics settings afterwards
%     p.FaceAlpha=0.8;
%     p.FaceColor='blue';
%     p.EdgeColor='r';
%     p.LineWidth=3;
%     p.LineStyle=':';
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% Author: J. Benjamin Kacerovsky
% Centre for Research in Neuroscience, McGill University
% email: johannes.kacerovsky@mail.mcgill.ca
% December 2019; Last revision: 19 December 2019
% 
%------------- BEGIN CODE --------------

p=inputParser;

addParameter(p, 'range', 1, @isnumeric);
addParameter(p, 'gridlines', 1, @isnumeric);
addParameter(p, 'FaceColor', 'green');
addParameter(p, 'FaceAlpha', 0.3, @isnumeric);
addParameter(p, 'EdgeColor', 'black');
parse(p, varargin{:});

range=p.Results.range;
gridlines=p.Results.gridlines;
col=p.Results.FaceColor;
alph=p.Results.FaceAlpha;
edCol=p.Results.EdgeColor;

if gridlines<2
    gridlines=2;
    edCol='none';
end
    

if size(normal, 2)<size(normal, 1)
    normal=normal';
end

if size(point, 1)>size(point, 2)
    point=point';
end

w = null(normal); % Find two orthonormal vectors which are orthogonal to v
[P,Q] = meshgrid(linspace(-range, range, gridlines)); % Provide a gridwork (you choose the size)

X = point(1)+w(1,1)*P+w(1,2)*Q; % Compute the corresponding cartesian coordinates
Y = point(2)+w(2,1)*P+w(2,2)*Q; % using the two vectors in w
Z = point(3)+w(3,1)*P+w(3,2)*Q;
p=surf(X,Y,Z, 'FaceColor', col, 'FaceAlpha', alph, 'EdgeColor', edCol);
   
end
%------------- END OF CODE --------------