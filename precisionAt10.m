% Copyright (c) 2016 Diego Furtado Silva, Chin-Chia Michael Yeh, 
% Gustavo E. A. P. A. Batista and Eamonn Keogh
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to 
% deal in the Software without restriction, including without limitation the 
% rights to use, copy, modify, merge, publish, distribute, sublicense, and/or 
% sell copies of the Software, and to permit persons to whom the Software is 
% furnished to do so, subject to the following conditions:
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
% OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
% FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
% DEALINGS IN THE SOFTWARE.  

function [meanCont,precVec] = precisionAt10 ...
                    (distM, trainLabels, testLabels)
                
    K = 10;
                
    if nargin >= 3
        nExamples = length(testLabels);
    else
        nExamples = length(trainLabels);
    end
    
    precVec = zeros(nExamples,1);
    
    for i = 1 : nExamples
        
        if nargin >= 3
            thisLabel = testLabels(i);
            [~,sortedIdx] = sort(distM(i,:));
        else
            thisLabel = trainLabels(i);
            [~,sortedIdx] = sort([distM(i,1:i-1),distM(i,i+1:end)]);
        end
		
        precVec(i) = length(...
            find(trainLabels(sortedIdx(1:K)) == thisLabel)) / K;
        
    end
    
    meanCont = mean(precVec);

end

