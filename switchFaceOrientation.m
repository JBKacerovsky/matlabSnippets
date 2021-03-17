function fv = switchFaceOrientation(fv)
% switchFaceOrientation - Reorders the faces in an triangulated mesh
% struct (FV), changing the orientation of the face normal 
% 
% used if the face normal (defined by the order of vertices of each face,
% following the right-hand rule) faces the 'wrong' direction
% 
% Syntax:  
%     fv = switchFaceOrientation(fv)
% 
% Inputs:
%    fv - struct defining triangulated mesh (should contain fv.faces)
% 
% Outputs:
%    fv - struct; same as input with columns 1 and 2 of fv.faces switched
% 
% 
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
% 
% See also: OTHER_FUNCTION_NAME1,  OTHER_FUNCTION_NAME2

% Author: J. Benjamin Kacerovsky
% Centre for Research in Neuroscience, McGill University 
% email: johannes.kacerovsky@mail.mcgill.ca
% Created: 16-Mar-2021 ; Last revision: 16-Mar-2021 

% ------------- BEGIN CODE --------------
temp = fv.faces;
fv.faces(:, 1) = temp(:, 2); 
fv.faces(:, 2) = temp(:, 1); 
end
% ------------- END OF CODE --------------
