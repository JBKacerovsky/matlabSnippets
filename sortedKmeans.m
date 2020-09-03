function [sortedClusters, cen]=sortedKmeans(N, k, direction)
% sortedKmeans - performs kmeans clustering on 1D data (using built-in
% kmeans function and sorts cluster IDs by centroid values. Meaning for
% example when using 'descending' sort direction the cluster of ID==1
% corresponds  to the cluster with the largest value for cen, ID==2 to
% the 2nd largest and so on. 
% 
% Syntax:  
%     sortedClusters=sortedKmeans(N, k)
%     sortedClusters=sortedKmeans(N, k, direction)
% 
% Inputs:
%    N - Nx1 array of input values to be clustered
%    k - scalar integer; number of clusters
%    direction - scalar; defining sort direction; 
%       direction == 1 --> 'descending'; DEFAULT
%       direction == 2 --> 'ascending' 
%       
% Outputs:
%    sortedClusters - Nx1 array of sorted cluster IDs
%    cen - kx1 array of centroid values
% 
% Other m-files required: only built-in functions
% Subfunctions: none
% MAT-files required: none
% 

% Author: J. Benjamin Kacerovsky
% Centre for Research in Neuroscience, McGill University
% email: johannes.kacerovsky@mail.mcgill.ca
% Created: 03-Sep-2020 ; Last revision: 03-Sep-2020 

% ------------- BEGIN CODE --------------

 if nargin<3
     direction=1;
 end
 
% enforce dim1 > dim2
if size(N, 2) > size(N, 1)
    N = N';
end
    
    if direction==1
        [C, cen]=kmeans(N, k);
        [cen, id]=sort(cen, 'descend');
        sortedClusters=zeros(size(C)); 
            for i=1:k
            sortedClusters(C==id(i))=i;
            end
            
    elseif direction==2
        [C, cen]=kmeans(N, k);
        [cen, id]=sort(cen, 'ascend');
        sortedClusters=zeros(size(C)); 
            for i=1:k
            sortedClusters(C==id(i))=i;
            end
    else
        fprintf('please specify direction, 1 for descending, 2 for ascending sort\n')
    end
end


% ------------- END OF CODE --------------
