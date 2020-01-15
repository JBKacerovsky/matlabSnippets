function q=drawVector(points, vectors, color, weigth, MaxHeadsize)
% drawVector - draws 2D or 3D vectors from specified points
% 
% this is a very simple function to make drawing vectors using the 
% quiver and quiver3 functions a little more convenient
%
% all this is to prepare the input from xyz triplets or lists of pints and
% vectors and pass it into the quiver or quiver3 functions
%
% I was just getting tired of typing it out every time
%
% Syntax:  
%         q=drawVector(points, vectors);
%         q=drawVector(points, vectors, color);
%         q=drawVector(points, vectors, color, weigth);
%         q=drawVector(points, vectors, color, weigth, MaxHeadsize);
% 
%         drawVector(points, vectors);
%         drawVector(points, vectors, color);
%         drawVector(points, vectors, color, weigth);
%         drawVector(points, vectors, color, weigth, MaxHeadsize);
%
% Inputs:
%    points  - Nx3 (3D) or Nx2 (2D) matrix; rows correspond to points 
%                   if N==1 the same point will be used as origin for all vectors
%    vectors -  Nx3 (3D) or Nx2 (2D) matrix; rows correspond to vectors
%    color   - (optional) string ('r', 'red', etc), RGB triplet or
%               hexadecimal string; default='red
%    weight  - (optional) scalar setting LineWidth; default=3;
%    MaxHeadsize  - (optional) scalar setting arrow head size; default=weight;
%
% Outputs:
%    for simple drawing the output does not have to be defined
%    defining the output, p, saves the graphics element to allow later editing
%
% Example: 
%     % draw 3 red vector arrows from 3 points
%     % red is the default color
%     p=[0 0 0; 0 1 1; 2 1 1];
%     v=[1 1 1; 2 3 -4; 1 0 0];
%     drawVector(p, v);
%     axis equal
% 
%     % draw 3 blue vector arrows from a single point with wider lines
%     p=[2 1 1];
%     v=[1 1 1; 2 -3 -1; 1 0 0];
%     drawVector(p, v, 'blue', 5);
%     axis equal
% 
%     % defining the output saves the graphics element and allows for later
%     % changes to quiver properties
%     p=[2 1 1];
%     v=[1 1 1; 2 -3 -1; 1 0 0];
%     q=drawVector(p, v, 'blue', 5);
%     axis equal
%     q.LineStyle='-.';
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

% % complete inputs if necessary
if nargin<3; color='red'; end
if nargin<4; weigth=3; end
if nargin<5; MaxHeadsize=weight; end

% % check points list
% % fill to match vector list if necessary
if size(points, 1)~=size(vectors, 1)
    if size(points, 1)==1
        points=repmat(points, size(vectors, 1), 1);
    else
        fprintf('number of points (rows) must be 1 or equal to the number of vectors\n');
    end
end

% draw stuff
% % 3D case
if size(vectors, 2)==3&&size(points, 2)==3 
    q=quiver3(points(:, 1), points(:, 2), points(:, 3), vectors(:, 1), vectors(:, 2), vectors(:, 3), 0, 'Color', color,...
        'LineWidth', weigth, 'MaxHeadSize', MaxHeadsize);

% % 2D case
elseif size(vectors, 2)==2&&size(points, 2)==2 
    q=quiver(points(:, 1), points(:, 2), vectors(:, 1), vectors(:, 2), 0, 'Color', color,...
        'LineWidth', weigth, 'MaxHeadSize', MaxHeadsize);
    
% % dimension error or mismatch --> error message and stop     
else 
    fprintf('input must be either 2D or 3D points and Vectors\n');
    fprintf('!!! "points" is %dD "vector" is %dD, \n both must be equal and either 2D or 3D\n',...
        size(points, 2), size(vectors, 2));
end
end
%------------- END OF CODE --------------