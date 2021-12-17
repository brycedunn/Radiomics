mainfolder = uigetdir;
subfolders = dir(mainfolder);

filelist = dir(fullfile(mainfolder, '**\*.bz2'));
filelist = filelist(~[filelist.isdir]);
len = length(filelist);

for k = 1:len
fullfilepaths{k} = strcat(filelist(k).folder,'\',filelist(k).name);
end
fullfilepaths = string(fullfilepaths);

fprintf('There are %2.0f PlanC files being processed.\n',len)
%%
addpath(genpath('CERR'));
tmpExtractDir = 'B:\Z3_corrected\Temp';

count = 0;
for j = 1:length(fullfilepaths)
    f = convertStringsToChars(fullfilepaths(j));
    try
    % Access PlanC from the viewer or from file
    planC = loadPlanC(f,tmpExtractDir)
    %global planC
    indexS = planC{end};

% Create a new structure with just the central slice

    structNum = 1; % structure for which to obtain the central slice
    struct3M = getStrMask(structNum,planC);
    numSlcs = size(struct3M,3);
    [~,~,~,~,sMin,sMax] = compute_boundingbox(struct3M);
    centralSlc = round(median(sMin:sMax));
    allSlcNumV = 1:numSlcs;
    allSlcNumV(centralSlc) = [];
    struct3M(:,:,allSlcNumV) = false;
    isUniform = 0;
    scanNum = 1;
    strName = 'central slice';

    planC = maskToCERRStructure(struct3M,isUniform, scanNum, strName, planC);

% Calculate features (required settings can be adjusted in JSON config file. Refer to Wiki for documentation)

    paramFileName = fullfile(getCERRPath,'PlanMetrics','heterogenity_metrics','sample_radiomics_extraction_settings.json');
    paramS = getRadiomicsParamTemplate(paramFileName);
    centralSlcStructNum = length(planC{indexS.structures});
    featureS{j} = calcGlobalRadiomicsFeatures(scanNum, centralSlcStructNum, paramS, planC);
    catch
    end
    count = count+1;
end
count
