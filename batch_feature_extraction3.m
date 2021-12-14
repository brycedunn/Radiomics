% This script performs the batch feature extraction of the segmented
% scans.
addpath(genpath('B:\CERR-master')) % Add CERR
mainfolder = uigetdir; % Specify folder with segmentations.
paramFileName = 'B:\Feature Extraction\paramsForCtRadiomics.json'; % parameter file
patientfolders = dir(mainfolder);
patientfolders = patientfolders([patientfolders.isdir]);
patientfolders = patientfolders(3:end);
for j = 1:length(patientfolders)
   fullpatientfolderpaths{j} = strcat(patientfolders(j).folder,'\',patientfolders(j).name);
end
fullpatientfolderpaths = string(fullpatientfolderpaths);
for j = 1:length(fullpatientfolderpaths)
    folderpath = convertStringsToChars(fullpatientfolderpaths(j));
    try
    featureS{j} = batchExtractRadiomics(folderpath,paramFileName);
    catch
    end
end