function FV=drawConnectingCylinders(pt1, pt2, width, n)
% drawConnectingCylinders - draw cylinder connecting 2 sets of
% points as triangulated FV mesh
%
% Useful e.g. to display straight lines in situations where only meshes are
% acceptable (e.g. to export lines into wavefront .obj files) 
% 
% Syntax:  
%     FV=drawConnectingCylinders(pt1, pt2)
%     FV=drawConnectingCylinders(pt1, pt2, width)
% 
% Inputs:
%    pt1 - Nx3 list of point coordinates
%    pt2 - Nx3 list of point coordinates 
%           cylinders will bee drawn between pt1(i, :) and pt2(i, :)
%    width - width of cylinder to bee drawn (default=1) 
%    n - number of points to be drawn around the circumference (default =5)
%           (higher n -> smoother cylinder, but more triangles = more
%           memory); 
% Outputs:
%    FV - struct with faces and vertices
%
% !!! Note !!!:
%         the delauney triangulation prints the following warining message when
%         building the initial cylinder template: 
%                 Warning: Duplicate data points have been detected and removed.
%                  Some point indices will not be referenced by the triangulation. 
%                 Warning: Some input points are not referenced by the triangulation. 
%         This message can just be ignored.
%
% Example
%         % define sets of points
%         pt1=[-10 5 8; 10 -30 10]; 
%         pt2=[1 9 10; 40, 30, -10];
% 
%         % build FV struct of connecting cylinders
%         CY=drawConnectingCylinders(pt1, pt2, 0.5, 15); 
% 
%         % display (show input points using scatter3)
%         figure;
%         hold on; axis equal;
%         scatter3(pt1(:, 1), pt1(:, 2), pt1(:, 3), 1000, 'r', '+'); 
%         scatter3(pt2(:, 1), pt2(:, 2), pt2(:, 3), 1000, 'r', '*'); 
%         patch (CY, 'facecolor', 'b', 'edgecolor', 'none'); 
%
% 
% Other m-files required: cylinder.m (built in) 
% Subfunctions: none
% MAT-files required: none
% 

% Author: J. Benjamin Kacerovsky
% Centre for Research in Neuroscience, McGill University
% email: johannes.kacerovsky@mail.mcgill.ca
% Created: 01-Jun-2020 ; Last revision: 02-Jun-2020 

% ------------- BEGIN CODE --------------


if nargin<3
    width=1;
end

if nargin<4
    n=5;
end

% build template cylinder centered at the origin 
[XX, YY, ZZ]=cylinder(width, n);
tri=delaunay(XX, YY, ZZ);
TR=triangulation(tri, XX(:), YY(:), ZZ(:));
[cy.faces, cy.vertices]=TR.freeBoundary;
cy.vertices=cy.vertices-mean(cy.vertices);
incr=size(cy.vertices, 1); 

FV.vertices=[];
FV.faces=[];
    for i=1:size(pt1, 1)
%         use vector 
        vec=pt1(i, :)-pt2(i, :); 
        hp=pt2(i, :)+vec/2;
        ort=null(vec); 
        V=cy.vertices*[ort, vec']';
        V=V+hp;
        FV.faces=[FV.faces; cy.faces+incr*(i-1)]; 
        FV.vertices=[FV.vertices; V];
    end
end


% ------------- END OF CODE --------------
