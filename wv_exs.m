%Exploratory code for finding overlapping wave synch in spk data

%exclude waveforms with excessive continuous oscillation: 
% assume this suggests noise

examples = {};
templates = {};

%bound max by sum of largest waveform averages
for i=1:length(wvs)
    %compute template waves
    clu_set = unique(clus{i});
    %remove '0' cluster
    clu_set = clu_set(find(clu_set));

    avg = [];
    avgs = [];
    for j=1:length(clu_set)
        avg = mean(wvs{i}(:, :, find(clus{i}==clu_set(j))), 3);
        avgs = [avgs, avg];
    end
    template{i} = avgs;
    %sort template waves 

    for wv=1:size(wvs{i}, 3)
        if isempty(find(max(wvs{i}(:, :, wv))>200))
            candidates = [candidates, wvs{i}(:, :, wv)];
        end
    end
    examples{i} = candidates;
end

