function inds=findIdx(bw)
% returns xyz index of voxels >0 as Nx3 matrix
[X, Y, Z]=ind2sub(size(bw), find(bw));
inds=horzcat(X, Y, Z);