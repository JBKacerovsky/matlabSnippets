function fv=meshArrows(inputPoints, inputVectors, shaftRadius, headlength, shapeFactor, stepSize)
% meshArrows - build arrows as triangulated mesh from points + vector
%      analogous to quiver3 for mesh surfaces
% 
% Syntax:  
%     fv=meshArrows(inputPoint, inputVector, shaftRadius, headlength, shapeFactor, stepSize)
% 
% Inputs:
%    inputPoints    - Nx3 array; arrow starting point coordinates
%    inputVectors   - Nx3 array; arrow vectors
%    shaftRadius    - scalar; radius of arrow shaft cylinder
%    headlength     - scalar; lenght of arrow head; OPTIONAL; default =
%                       1/3*max Length of inputVectors
%    shapefactor    - scalar; higher value -> more acute angle at arrow tip;
%                       OPTIONAL; default = 3
%    stepSize       - scalar; defines the stepsize used by for the
%                       meshgrid. OPTIONAL; default=shaftRadius/4;
%                       smaller step size -> more/smaller triangles
% 
% Outputs:
%    FV             - Face/Vertex struct defining one triangulated mesh. See
%                       documentation for built in isosurface function
% 
% Example: 
%     shaftRadius=2; 
%     headlength=10; 
%     shapeFactor=3;
% 
%     inputPoint=[1 1 1; 10, 3, 5]; 
%     inputVector=[18 14 -15; 17, -19, 3]; 
% 
% 
%     stepSize=0.5;
% 
%     fv=meshArrows(inputPoint, inputVector, shaftRadius, headlength, shapeFactor, stepSize);
% 
%     figure; 
%     axis equal
%     hold on
%     quiver3(inputPoint(:, 1), inputPoint(:, 2), inputPoint(:, 3), inputVector(:, 1), inputVector(:, 2), inputVector(:, 3), 0, 'r', 'LineWidth', 3, 'MaxHeadSize', 10); 
%     patch(fv, 'facecolor', 'b', 'edgecolor', 'none', 'facealpha', 0.5); 
% 


% Author: J. Benjamin Kacerovsky
% Centre for Research in Neuroscience, McGill University
% email: johannes.kacerovsky@mail.mcgill.ca
% Created: 22-Jun-2020 ; Last revision: 22-Jun-2020 

% ------------- BEGIN CODE --------------

if nargin < 3; shaftRadius=2; end
if nargin < 4
    maxLength=max(sqrt(sum(inputVectors.^2, 2)), [], 1); 
    headlength=maxLength*1/3;
end
if nargin < 5; shapeFactor=3; end
if nargin < 6; stepSize=shaftRadius/4; end



temp=[inputPoints; inputPoints+inputVectors];
mins=min(temp, [], 1)-headlength; 
maxes=max(temp, [], 1)+headlength; 

[X, Y, Z]=meshgrid(mins(1):stepSize:maxes(1), mins(2):stepSize:maxes(2), mins(3):stepSize:maxes(3));

B=zeros(size(X, 1), size(X, 2), size(X, 3), 1);
    for i=1:size(inputVectors, 1)
            pt=inputPoints(i, :); 
            vec=inputVectors(i, :); 
            vecLength=norm(vec); 
            hl=vecLength/2;
            centre=pt+vec/2;
            
            temp=[X(:),Y(:),Z(:)];
            temp=temp-centre; 
            ort=null(vec); 
            ort=[ort, (vec/(vecLength))'];
            temp=temp*ort;
            sz=size(X);
            
            Xrot=reshape(temp(:,1),sz);
            Yrot=reshape(temp(:,2),sz);
            Zrot=reshape(temp(:,3),sz);
            
            temp=[];
            A=[];
            
            temp=((Xrot.^2+Yrot.^2).^(1/2))./(shaftRadius); 
            temp(Zrot>(hl-headlength))=Inf; 
            
            A(:, :, :, 1)=temp;
            temp=(((Xrot.^2+Yrot.^2).^(1/2)).*shapeFactor+(Zrot-(hl)));
            temp(Zrot<(hl-headlength))=Inf;
            A(:, :, :, 2)=temp; 
            
            A=min(A, [], 4); 
            A(Zrot<-(hl))=max(A(:));
            
            B(:, :, :, 1)=A; 
            B(:, :, :, 2)=min(B, [], 4); 
    end
B=B(:, :, :, 2); 
% B=imgaussfilt3(B, 0.5); 
fv=isosurface(X, Y, Z, B, 0.5);
end


% ------------- END OF CODE --------------
