function FV=isoSwitch(FV)
% tiny function to swith the 1st and 2nd column of vertex coordinates (x % y) in a FV struct
% for some reason x and ycoordinates are swithed when using the isosurface
% function to create a triangulated mesh from a binary image (bw matrix),
% with respect to the original image
%
%
% these three lines switch it back
temp=FV.vertices;
FV.vertices(:, 1)=temp(:, 2);
FV.vertices(:, 2)=temp(:, 1);
