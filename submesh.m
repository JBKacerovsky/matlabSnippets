function subFV=submesh(FV, vertexIDs)
% submesh - Returns a submesh of the input mesh containing only the
% specified vertices as a new mesh
% 
% Syntax:  
%     subFV=submesh(FV, vertexIDs)
% 
% Inputs:
%    FV - input mesh, struct with two fields (FV.faces and FV.vertices) defining
%         triangulated mesh
%    vertexIDs - 1D array of vertex indices or 1D logical array defining
%         vertices to include in the output mesh
% 
% Outputs:
%    subFV - output mesh, containing only specified vertices and
%         faces/triangles that contain retained vertices.
% 
% 
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
% 

% Author: J. Benjamin Kacerovsky
% Centre for Research in Neuroscience, McGill University 
% email: johannes.kacerovsky@mail.mcgill.ca
% Created: 23-Oct-2019 ; Last revision: 08-Jul-2021 

% ------------- BEGIN CODE --------------


        if islogical(vertexIDs)
                % I have tried to find an efficient way to only use logical indexing
                % instead of "find"
                % but the only one I could come up with was 3x slower
            vertexIDs=find(vertexIDs); 
        end
    vnew=FV.vertices(vertexIDs, :);
    
    if (size(FV.faces, 2))==3   %triangle mesh
        fsel=ismember(FV.faces(:, 1), vertexIDs)&ismember(FV.faces(:, 2), vertexIDs)&ismember(FV.faces(:, 3), vertexIDs);
        fnew=FV.faces(fsel,:);
        
    elseif (size(FV.faces, 2))==4   %quad mesh
        fsel=ismember(FV.faces(:, 1), vertexIDs)&ismember(FV.faces(:, 2), vertexIDs)&ismember(FV.faces(:, 3), vertexIDs)&ismember(FV.faces(:, 4), vertexIDs);
        fnew=FV.faces(fsel,:);
        
    else
        fprintf('ERROR! Expected size for FV.faces: Nx3 (triangle mesh) or Nx4(quad mesh)\nfound: %dx%d \n', size(FV.facess));
    end
    
    
        % this way of re-indexing the new faces is borrowed from cleanpatch.m
        % function in the Patch Remesher by Manu
        % (https://www.mathworks.com/matlabcentral/fileexchange/49691-patch-remesher), MATLAB Central File Exchange. Retrieved January 28, 2020.
    [~, b]=ismember(FV.vertices, vnew, 'rows');
    subFV.faces=b(fnew); 
        if size(fnew, 1)<2 % for some reason if the fnew is a single row the resulting reindexed face ids are transposed. this fixes the issue
            subFV.faces = subFV.faces'; 
        end
    subFV.vertices=vnew;
     


% ------------- END OF CODE --------------
