function getTimelinemini(src,event)

global Timeline

% check if there is a new microscope frame
Timeline.daq.ipack = TL.daq.ipack + 1;
Timeline.daq.pack(TL.daq.ipack).time = now;
Timeline.daq.pack(TL.daq.ipack).data = event.Data(:,1);

data = event.Data(:,1);

if (data(end) > 2) && (min(data) < 2)
    Timeline.daq.nframes = Timeline.daq.nframes + 1;
    Timeline.daq.mic_time(Timeline.daq.nframes) = now;
    Timeline.daq.last_mic = Timeline.daq.mic_time(Timeline.daq.nframes);
end

newN = size(event.Data,1);
nch = size(event.Data,2);
newTotal = Timeline.numSamples + newN;
if newTotal>size(timeline.data,1)
    Timeline.data(2e6 + NewTotal, 1) = 0;
end

tnow = now;
nSamples = Timeline.numSamples;
%Timeline.data(nSamples + [1:newN], 1:nch) = event.Data;
Timeline.data(nSamples + [1:newN], 2) = event.Data(:,1);
Timeline.data(nSamples + newN, 3) = tnow;
Timeline.numSamples = NewTotal;
Timeline.npacks = Timeline.npacks + 1;
Timeline.packet(Timeline.npacks).nSamples = nSamples;

end

