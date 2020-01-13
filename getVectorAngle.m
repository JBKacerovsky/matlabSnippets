function vectorAngle=getVectorAngle(vector1, vector2, angleType)
% get angle between 2 n-dimensional vectors 
%
% vectorAngle=getVectorAngle(vector1, vector2, angleType)
%
% Inputs:
%    vector1 - 1xn or nx1 vector
%    vector2 - 1xn or nx1 vector (must be the same dimensions as vector1
%    angleType - optional; toggle between output in degrees (default) or
%               radians (if angleType==2)
%
% Outputs:
%    vectorAngle - angle between vector1 annd vector2
%    output2 - Description
%
% Example: 
%    vector1=[1, 2, 3]; vector2=[3, 4, 5];
%    getVectorAngle(vector1, vector2)
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%

% Author: J. Benjamin Kacerovsky
% Centre for Research in Neuroscience, McGill University
% email: johannes.kacerovsky@mail.mcgill.ca
% January 2020; Last revision: 6 January 2020

%------------- BEGIN CODE --------------
if nargin==2
    angleType=1;
end

if angleType==2
    vectorAngle=acos(dot(vector1, vector2)/(norm(vector1)*norm(vector2)));
else
    vectorAngle=acosd(dot(vector1, vector2)/(norm(vector1)*norm(vector2)));
end
%------------- END OF CODE --------------