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

function [MPPairs, distM] = findAllMPPairs(data, subSeqLen)

	% data format:
	% it is a structure with, at least, one field (data) ->
	% data.data is a 12xN chroma vector (12 can change)

    if nargin < 3
        subSeqLen = 20;
    end

    nExamples = length(data);
    
    MPPairs = [];
	distM = zeros(nExamples);
       
    for iTest = 1 : nExamples
        
        display(['Test example #', num2str(iTest)]);        
        
        thisTeMP = [];
        for iTrain = 1 : nExamples
          
            if (iTest == iTrain)
                
                MP = 0;
				MPindex = 0;
				
            else
                
                [~,m2] = OTI(data(iTrain).data, data(iTest).data);            
                [MP, MPindex] = SiMPle...
                    (data(iTrain).data, m2, subSeqLen);
                
            end

            thisTeMP = [thisTeMP, struct('MP', MP, 'MPindex', MPindex)];
			distM(iTest,iTrain) = median(MP);
            
        end
        
        MPPairs = [MPPairs;thisTeMP];
        
    end

end

