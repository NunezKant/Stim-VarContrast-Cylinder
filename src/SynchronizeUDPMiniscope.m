function SynchronizeUDPMiniscope(app)
    global Timeline;
    global sess
    Timeline = [];

    x = instrfindall;
    for j =1:length(x)
        fclose(x(j)); % close all exist instance (UDP)
    end

    datexp = datestr(now, 'yyyy_mm_dd');
    fpath = fullfile(app.SelectedPath, app.AnimalIDEditField.Value, datexp);
    % global sampling rate
    srate = 5000;
    if app.RecordyesCheckBox.Value
        msg = 'instruction hello ';
        app.u = udp('10.123.1.176', 1002, 'LocalPort', 1001); % mesoscope
        fopen(app.u); % start udp
        fwrite(app.u, msg); %send message to mesoscope matlab
        sess.fs      = str2double(char(fread(app.u)));
        sess.nplanes = str2double(char(fread(app.u)));

        if isnan(TL.sess.fs)
            error('Could not communicate with scanimage computer');
        end
            pause(3);
    end
    daqreset; % rest NIdaq
    
    fld = dir(fpath);
    nmax = 0;
    for i = 3:numel(fld)
        if fld(i).isdir
            nmax = max(nmax, str2num(fld(i).name));
        end
    end
    blockexp = sprintf('%d', nmax+1); % save as different files for diffrent blocks
    fdata= fullfile(fpath, blockexp);
    mkdir(fdata);
    fprintf('Block %s, of mouse %s, date %s \n', blockexp, app.AnimalIDEditField.Value, datexp);

    %NIdaq
    sess.sread = daq.createSession('ni'); % need to read information from NIdaq
    addAnalogInputChannel(sess.sread,'Dev4',1,'Voltage'); % read in the twop
    sess.sread.Rate = srate;
    sess.sread.IsContinuous = true;

    %t   = 1;
    %fr  = 50; % frequency of pulse generation (per second)
    %NT = ceil(t*srate);
    %fperiod = srate/fr;
    %idx = [1:NT]';
    % generate this pulse
    %wave = 5 * double(sin(pi + 2*pi*(idx/fperiod)) - .5 > 0);
    Timeline.daq.nframes = 0;
    Timeline.daq.last_mic = now;
    Timeline.daq.ipack = 0;
    Timeline.daq.pack = [];
    sess.readL = addlistener(sess.sread,'DataAvailable',@getTimelinemini);
    sess.sread.NotifyWhenDataAvailableExceeds = 80;  % update the screen at 50 Hz
    Timeline.data = zeros(5*sess.sread.Rate * 3600, 2);
    Timeline.numSamples = 0;
    Timeline.npacks = 0;
    sess.mname = app.AnimalIDEditField.Value;
    sess.datexp = datexp;
    sess.blockexp = blockexp;
    sess.fdata = fdata;
    % queueOutputData(sess.sgen,wave);
    startBackground(sess.sread); % start reading frames
    pause(0.25);


    % hard-coded paths and addresses for starting acquisition
    root_data = 'D:\DATA\'; % 2p rig
    fname = sprintf('%s_%s_%s', app.AnimalIDEditField.Value, datexp, blockexp);
    fpath = fullfile(root_data, app.AnimalIDEditField.Value, datexp, sprintf('%s', blockexp), fname);
    msg = sprintf('instruction ExpStart filepath %s', fpath);
    if app.RecordyesCheckBox.Value
        fwrite(app.u, msg); %send message to mesoscope matlab
        pause(20); % allow session to start
    end
end