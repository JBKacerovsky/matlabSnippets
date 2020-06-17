function arcPoints=getArcPoints(startPoint, endPoint, centerPoint, steps)

vecA=centerPoint-startPoint;
vecA=vecA/norm(vecA); 

vecB=centerPoint-endPoint;
vecB=vecB/norm(vecB); 

vecC=cross(vecA, vecB); 
vecC=vecC/norm(vecC); 

vec3=cross(vecA, vecC); 
vec3=vec3/norm(vec3); 

baseMatrix=[vecA', vecC', vec3'];

changeOfBase=baseMatrix'; 
arcPoints=zeros(3, steps);
arcPoints(:, 1)=startPoint;

dispAngle=getVectorAngle(vecA, vecB)/steps; 

rotationMatirx=[cosd(dispAngle), 0, sind(dispAngle);
        0, 1, 0;
        -sind(dispAngle), 0, cosd(dispAngle)];
    
centerChanged=changeOfBase*centerPoint';

rDisp=(norm(centerPoint-startPoint)-norm(centerPoint-endPoint))/steps; 

for i=2:steps+1
    
    temp=changeOfBase*arcPoints(:, i-1);
    dispVec=centerChanged-temp; 
    dispVec=dispVec/norm(dispVec)*rDisp; 
    
    temp=temp-centerChanged; 
    temp=rotationMatirx*temp; 

    arcPoints(:, i)=baseMatrix*(temp+centerChanged+dispVec); 
end