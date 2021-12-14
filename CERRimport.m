% Folder by folder batch import (DICOM TO CERR PLANC)
%%
addpath(genpath('B:\CERR-master'))
%init_ML_DICOM
%%
mainfolder = uigetdir;
patientfolders = dir(mainfolder);
patientfolders = patientfolders([patientfolders.isdir]);
patientfolders = patientfolders(3:end);
%%
for j = 1:length(patientfolders)
   fullpatientfolderpaths{j} = strcat(patientfolders(j).folder,'\',patientfolders(j).name);
   destinationfolders{j} = strcat('F:\CSplanCtest\',patientfolders(j).name);
end

fullpatientfolderpaths = string(fullpatientfolderpaths);
destinationfolders = string(destinationfolders);
%%
for k = 1:length(destinationfolders)
if ~exist(destinationfolders(k), 'dir')
   mkdir(destinationfolders(k))
end
end
%%
for l = 1:length(destinationfolders)
    
    % Define data source and destination paths 
srcDir = convertStringsToChars(fullpatientfolderpaths(l));    
dstDir = convertStringsToChars(destinationfolders(l));

    %Set flags for compression and merging
zipFlag = 'Yes'; %Set to 'Yes' for compression to bz2 zip 
mergeFlag = 'No'; %Set to 'Yes' to merge all scans into a single series

    %Batch import
init_ML_DICOM;
singleCerrFileFlag = 'no';
batchConvertWithSubDirs(srcDir,dstDir,zipFlag,mergeFlag,singleCerrFileFlag);
end