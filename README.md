# matlabSnippets
Collection of some "little" functions I wrote to make my life easier. Most of these are very simple and the goal for most was to have a faster more convenient way of accessing built in Matlab functions to avoid having to type the same code all the time. 

this repository is linked to mathworks
[![View usefulSnippets on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/73883-usefulsnippets)

EDITOR FUNCTIONS:
insertTemplateHeader - inserts predefined header template into an active script; there are number of similar funnctions on the mathworks exchange. As fare as I could find, these typically create a new script with the header template (and some seem to require going through a GUI,... while extra typing is exactely what I wanted to avoid). I wrote this version, since I generally wanted to be able to insert a header into a function, at the end of my workflow, once I am done building a function and decide to publish it or to add a header so I can remember what it does later on. So that is exactely what this does. 

VECTOR FUNCTIONS:
drawVector- draws 2D or 3D vectors from specified points (on File Exchange)

[![View drawVector- draws 2D or 3D vectors from specified points on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/73734-drawvector-draws-2d-or-3d-vectors-from-specified-points)

planePlotter - draws a plane defined by a point and normal vector (on File Exchange)

[![View planePlotter on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/73731-planeplotter)

getVectorAngle - calculates the angle between 2 n-dimensional vectors 
  (built for 2D and 3D, but should work for all dimensions)

SPHERE FUNCTIONS (BUILD TEST OBJECTS):
These functions were primarily written to create test objects of known underlying geometry to test functions on voxelated objects, or isosurface FV meshes

VoxelSphereCreator - creates a (binary) voxelated sphere of defined radius around a defined point in a given 3D matrix/image. 
    spheres can optionally be deformed along the main axes to create ellipsoids

meshSphereCreator - Creates a triangulated sphere of defined radius using matlab's built isosurface function. 
    spheres can optionally be deformed along the main axes to create ellipsoids
