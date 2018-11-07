function [signatures, labels] = LoadSpectralSignatures(filename)

% Load a spectral cube, with its labels, and extracts a matrix with the
% spectral signatures
%
% Crisostomo Barajas-Solano
% Noviembre 2018

load(filename);

[M,N,L]=size(hyperimg);

hyperimg=hyperimg/max(hyperimg(:));
signatures=reshape(hyperimg(:)', [M*N L])';

labels=hyperimg_gt(:);


end

