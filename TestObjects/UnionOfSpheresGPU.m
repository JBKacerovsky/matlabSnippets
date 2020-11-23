function unionImg = UnionOfSpheresGPU(skelImg)    
    
    sz = size(skelImg); 
    
    unionImg = gpuArray(Inf(sz)); 

    [xCoords, yCoords, zCoords] = ind2sub(sz,find(skelImg)); 
    xCoords = gpuArray(xCoords); 
    yCoords = gpuArray(yCoords); 
    zCoords = gpuArray(zCoords); 
    
    rad = gpuArray(skelImg(skelImg>0).^2);
    
    [X, Y, Z] = meshgrid(1:sz(2), 1:sz(1), 1:sz(3)); 
    X = gpuArray(X); 
    Y = gpuArray(Y);
    Z = gpuArray(Z);

    for i = 1:length(xCoords)
        unionImg=min(unionImg, ((X-yCoords(i)).^2+(Y-xCoords(i)).^2+(Z-zCoords(i)).^2)/rad(i));
    end
    
    unionImg = gather(unionImg<=1); 
end