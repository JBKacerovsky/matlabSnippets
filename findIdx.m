function inds=findIdx(bw)
% findIdx - returns xyz index of voxels > 0 as Nx3 matrix
% 
% Syntax:  
%     inds=findIdx(bw)
% 
% Inputs:
%    bw - matrix; NxNxN 
%       (typically this would be a binary 3D image, but voxels with any
%       value > 0 will be returned)
% 
% Outputs:
%    inds - Nx3 matrix with xyz coordinates of all matirx elements >0
% 
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
% 

% Author: J. Benjamin Kacerovsky
% Centre for Research in Neuroscience, McGill University
% email: johannes.kacerovsky@mail.mcgill.ca
% 13-Jan-2020 ; Last revision: 13-Jan-2020 

% ------------- BEGIN CODE --------------

[X, Y, Z]=ind2sub(size(bw), find(bw));
inds=horzcat(X, Y, Z);

% ------------- END OF CODE --------------
