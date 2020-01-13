function drawOrdinates(varargin)
% drawOrdinates - simple function to draw arrows representing the basis
% vectors of any R3 coordinate system
%
% Syntax:  drawOrdinates
%          drawOrdinates(ord, ori)
%          drawOrdinates(ord, ori, ...)
%
% this is a simple function to draw 3 vectors representing the axes of a
% coordinate system
% All this really does is prepare the inputs to pass them into the built-in
% quiver3 function. I was just tired of typing it out all the time.
%
%
% Inputs:
%    ord - ordinates; 3x3 matrix, each column represents one axis as a 1x3
%       vector. default  x, y, z unit vectors at the origin ([1, 0, 0; 0, 1, 0; 0, 0, 1])
%    ori - origin; 1x3 matrix specifing the coordinates at which to draw;
%       default [0, 0, 0]
% Optional Name-Value pairs      
%    scale - scalar; factor by which to scale the length of each arrow;
%       default=0
%    weight - scalar; defines lineweight and arrow head size; default=3
%    colors - 1x3 list of strings defining colors for each vector;
%       default=['r', 'b', 'g']);
%       alternative: 3x3 matrix, where each row defienes one arrow color as
%       an RGB triplet
%
% Outputs:
%    no outputs need to be specified
%
% Example 1: 
%    %  calling the function without specifying any input will draw 3 unit
%    %  vectors alon the x, y, and z axis at the origin
%    drawOrdinates
%
% Example 2: 
%     % vec=[3, 4, 5];              % start with a random vector
%     % vec=vec/norm(vec);          % normalize
%     % ord=null(vec);              % use null(x) to find 2 orthonormal vectors
%     % ord=horzcat(vec', ord);     % concatenate matrix of orthonormal basis vectors
%     % 
%     % % draw new ordinates with default settinngs at the origin
%     % drawOrdinates(ord);         
%     % axis equal
%     % 
%     % % draw new ordinates centered at [2, 10, 3] with a changed appearence
%     % drawOrdinates(ord, [2, 10, 3], 'weight', 5, 'scale', 5, 'colors', [0 0 1; 0 0 1; 0 0 1]);
%     % axis equal
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% Author: J. Benjamin Kacerovsky
% Centre for Research in Neuroscience, McGill University
% email: johannes.kacerovsky@mail.mcgill.ca
% January 2020; Last revision: 7 January 2020

%------------- BEGIN CODE --------------

p=inputParser;
p.CaseSensitive=false;
addOptional(p, 'ord', [1, 0, 0; 0, 1, 0; 0, 0, 1]);
addOptional(p, 'ori', [0, 0, 0]);
addParameter(p, 'scale', 0);
addParameter(p, 'weight', 3);
addParameter(p, 'colors', ['r', 'b', 'g']);

parse(p, varargin{:});
ord=p.Results.ord;
ori=p.Results.ori;
scale=p.Results.scale;
weight=p.Results.weight;
colors=p.Results.colors;

if isnumeric(colors)
    colors=colors';
end

hold on
quiver3(ori(1), ori(2), ori(3), ord(1, 1), ord(2, 1), ord(3, 1), scale, 'Color', colors(:, 1), 'LineWidth', weight, 'MaxHeadSize', weight);
quiver3(ori(1), ori(2), ori(3), ord(1, 2), ord(2, 2), ord(3, 2), scale, 'Color', colors(:, 2), 'LineWidth', weight, 'MaxHeadSize', weight);
quiver3(ori(1), ori(2), ori(3), ord(1, 3), ord(2, 3), ord(3, 3), scale, 'Color', colors(:, 3), 'LineWidth', weight, 'MaxHeadSize', weight);

%------------- END OF CODE --------------