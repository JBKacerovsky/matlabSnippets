# matlabSnippets
Collection of some "little" functions I wrote to make my life easier. Most of these are very simple and the goal for most was to have a faster more convenient way of accessing built-in Matlab functions to avoid having to type the same code all the time. 
More Snippets will be added over time. 

this repository is linked to MathWorks
[![View usefulSnippets on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/73883-usefulsnippets)

EDITOR FUNCTIONS:

insertTemplateHeader - inserts a predefined header template into an active script; there are a number of similar functions on the MathWorks exchange. As far as I could find, these typically create a new script with the header template (and some seem to require going through a GUI,... while extra typing is exactly what I wanted to avoid). I wrote this version since I generally wanted to be able to insert a header into a function, at the end of my workflow, once I am done building a function and decide to publish it or to add a header so I can remember what it does later on.

VECTOR FUNCTIONS:

drawVector- draws 2D or 3D vectors from specified points 

[![View drawVector- draws 2D or 3D vectors from specified points on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/73734-drawvector-draws-2d-or-3d-vectors-from-specified-points) drawVector on File Exchange

planePlotter - draws a plane defined by a point and normal vector

[![View planePlotter on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/73731-planeplotter) planePlotter - on File Exchange

getVectorAngle - calculates the angle between 2 n-dimensional vectors 
  (built for 2D and 3D, but should work for all dimensions)

SPHERE FUNCTIONS (BUILD TEST OBJECTS):
These functions were primarily written to create test objects of known underlying geometry to test functions on voxelated objects, or isosurface FV meshes

VoxelSphereCreator - creates a (binary) voxelated sphere of defined radius around a defined point in a given 3D matrix/image. 
    spheres can optionally be deformed along the main axes to create ellipsoids

meshSphereCreator - Creates a triangulated sphere of a defined radius using Matlab's built isosurface function. 
    spheres can optionally be deformed along the main axes to create ellipsoids


TINY FUNCTIONS:
these are tiny snippets (just a few lines) that really don't do very much but do save a bit of repetitive typing. These were nuisance enough for me at one point to make them into functions

isoSwitch - switch the 1st and 2nd column of vertex coordinates (x, y) in an FV struct.
	For some reason, x and y coordinates are switched when using the isosurface function to create a triangulated mesh from a binary image (bw matrix), with respect to the original image. These three lines switch them back (aligning the mesh and original image)

findIdx - returns xyz index of voxels > 0 as Nx3 matrix
