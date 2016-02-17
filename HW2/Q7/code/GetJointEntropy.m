function [ prob, jointEntropy] = GetJointEntropy( in1,in2 )
%GetJointEntropy Estimates joint entropy using histograms

% assume input bounded between 0 and 1 (inclusive)

% bin widhts 10 along both X and Y

binEdges = 0:10/255:1;
binEdges(1)=0;
binEdges = [binEdges, 1.1];

numBins = length(binEdges)-1;

M = size(in1,1);
N = size(in1,2);

prob = zeros(numBins,numBins);

for i=1:M
    for j=1:N
        val1 = in1(i,j);
        val2 = in2(i,j);
        
        binIndex1=find(binEdges>val1,1)-1;
        
        binIndex2=find(binEdges>val2,1)-1;
        
        prob(binIndex1,binIndex2)=prob(binIndex1,binIndex2)+1;
    end
end

prob = prob/(M*N);

jointEntropy = -sum(nansum(prob.*log2(prob)));


end

