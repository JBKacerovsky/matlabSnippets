function unionImg = UnionOfSpheres(skelImg)    
    
    sz = size(skelImg); 
    unionImg = Inf(sz); 

    [xCoords, yCoords, zCoords] = ind2sub(sz,find(skelImg)); 
    rad = skelImg(skelImg>0).^2;
    
    [X, Y, Z] = meshgrid(1:sz(2), 1:sz(1), 1:sz(3)); 

    for i = 1:length(xCoords)
        unionImg=min(unionImg, ((X-yCoords(i)).^2+(Y-xCoords(i)).^2+(Z-zCoords(i)).^2)/rad(i));
    end
    
    unionImg = unionImg<=1; 
end