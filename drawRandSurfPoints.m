function [X, Y, Z]=drawRandSurfPoints(bw, n, varargin)
p=inputParser;
addParameter(p, 'color', 'r', @ischar);
addParameter(p, 'size', 10, @isnumeric);
addParameter(p, 'markertype', '.', @ischar);
addParameter(p, 'draw', true, @islogical);
addParameter(p, 'nhood', [1, 1, 1; 1, 1, 1; 1, 1, 1], @islogical);
parse(p, varargin{:});
color=p.Results.color;
SZ=p.Results.size;
markertype=p.Results.markertype;
draw=p.Results.draw;
nhood=p.Results.nhood;


IDX=find(bw-imerode(bw, nhood));

if n<=1
    n=ceil(length(IDX)*n);
end

IDX=randsample(IDX, n);

[X, Y, Z]=ind2sub(size(bw), IDX);

if draw==true
    scatter3(X, Y, Z, SZ, color, markertype);
    axis equal
end


end