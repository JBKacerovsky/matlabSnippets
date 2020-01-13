function []=playgong()
% plays the gong.mat sound file (comes with matlab distribution)

load gong.mat;
soundsc(y);
end