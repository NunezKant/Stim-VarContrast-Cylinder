function getTimelinemini(src,event)

global Timeline

% check if there is a new microscope frame
Timeline.daq.ipack = Timeline.daq.ipack + 1;
tnow = now;
Timeline.daq.pack(Timeline.daq.ipack).time = tnow;
Timeline.daq.pack(Timeline.daq.ipack).data = event.Data(:,1);

data = event.Data(:,1);

if (data(end) > 2) && (min(data) < 2)
    Timeline.daq.nframes = Timeline.daq.nframes + 1;
    Timeline.daq.mic_time(Timeline.daq.nframes) = now;
    Timeline.daq.last_mic = Timeline.daq.mic_time(Timeline.daq.nframes);
end

newN = size(data,1);
newTotal = Timeline.numSamples + newN;
if newTotal>size(Timeline.data,1)
    Timeline.data(2e6 + NewTotal, 1) = 0;
end

nSamples = Timeline.numSamples;
Timeline.data(nSamples + [1:newN], 1) = data;
Timeline.data(nSamples + newN, 2) = tnow;
Timeline.numSamples = newTotal;
Timeline.npacks = Timeline.npacks + 1;
Timeline.packet(Timeline.npacks).nSamples = nSamples;

end

