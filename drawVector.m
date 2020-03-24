function q=drawVector(points, vectors, color, weight, MaxHeadsize)
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
%    points  - 1x3/Nx3 (3D) or 1x2/Nx2 (2D) matrix; rows correspond to points 
%                   if N==1 the same point will be used as origin for all vectors
%    vectors -  1x3/Nx3 (3D) or 1x2/Nx2 (2D) matrix; rows correspond to vectors
%                   if N==1 the same vector will be used for all points
%    color   - (optional) string ('r', 'red', etc), RGB triplet or
%               hexadecimal string; default='red
%            - Alternative: Nx3 array where each row contains the RGB
%               triplet for the corresponding arrow. For this case arrows
%               are drawn sucessively using a for loop making this version
%               much slower. 
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
% December 2019; ; Last revision: 15-Jan-2020 
%
%------------- BEGIN CODE --------------

% % complete inputs if necessary
if nargin<3; color='red'; end
if nargin<4; weight=3; end
if nargin<5; MaxHeadsize=weight; end

% % check points list
% % fill to match vector list if necessary
if size(points, 1)~=size(vectors, 1)
    if size(points, 1)==1
        points=repmat(points, size(vectors, 1), 1);
%         fprintf('drawing all arrows at the single specified point\n');
    elseif size(vectors, 1)==1
        vectors=repmat(vectors, size(points, 1), 1);
%         fprintf('drawing the single specified arrow at every point\n');
    else
        fprintf('rows in points and vector matrices must be 1 or equal to each other\n');
    end
end

if numel(color)==numel(vectors)   
    % draw stuff
    % % 3D case
    hold on
    if size(vectors, 2)==3&&size(points, 2)==3 
        for i=1:size(color, 1)
            quiver3(points(i, 1), points(i, 2), points(i, 3), vectors(i, 1), vectors(i, 2), vectors(i, 3), 0, 'Color', color(i, :),...
                'LineWidth', weight, 'MaxHeadSize', MaxHeadsize);
        end
    % % 2D case
    elseif size(vectors, 2)==2&&size(points, 2)==2 
        for i=1:size(color, 1)
            quiver(points(i, 1), points(i, 2), vectors(i, 1), vectors(i, 2), 0, 'Color', color(i, :),...
            'LineWidth', weight, 'MaxHeadSize', MaxHeadsize);
        end
    % % dimension error or mismatch --> error message and stop     
    else 
        fprintf('input must be either 2D or 3D points and Vectors\n');
        fprintf('!!! "points" is %dD "vector" is %dD, \n both must be equal and either 2D or 3D\n',...
            size(points, 2), size(vectors, 2));
    end
    hold off
  q='Arrows with individual size have to be drawn successively since matlab does not allow for input of a colorVector. The quiver object can therefore not be saved. ';
else
    % draw stuff
    % % 3D case
    if size(vectors, 2)==3&&size(points, 2)==3 
        q=quiver3(points(:, 1), points(:, 2), points(:, 3), vectors(:, 1), vectors(:, 2), vectors(:, 3), 0, 'Color', color,...
            'LineWidth', weight, 'MaxHeadSize', MaxHeadsize);

    % % 2D case
    elseif size(vectors, 2)==2&&size(points, 2)==2 
        q=quiver(points(:, 1), points(:, 2), vectors(:, 1), vectors(:, 2), 0, 'Color', color,...
            'LineWidth', weight, 'MaxHeadSize', MaxHeadsize);

    % % dimension error or mismatch --> error message and stop     
    else 
        fprintf('input must be either 2D or 3D points and Vectors\n');
        fprintf('!!! "points" is %dD "vector" is %dD, \n both must be equal and either 2D or 3D\n',...
            size(points, 2), size(vectors, 2));
    end
end
end
%------------- END OF CODE --------------