s = serialport("COM3",9600);% can check the serialport number from device manager and change the name accordingly COM4
flush(s);
configureTerminator(s,"CR");
fopen(s);
fprintf(s, 'START');
all = [];
time = [];
t0 = tic;
while 1
    flush(s);
    fprintf(s,'SEND')
    status = strtrim(fscanf(s));
    data = sscanf(status,'%f,',[1 4]);
    if j>1
        distance = data(1,2);
        speed = data(1,3)/100; %dm/s
        all = [all; [speed distance]];
    end

    time = toc(t0);
    if time>(1*60) %30 min 
        meanspd = mean(all(all(:,1)>0,1)); % > or < depending the sing of moving forward on the training rig 
        total_distance_traveled = all(end,2) - all(1,2); % total distance in mm
        disp('mean speed (dm/s):')
        disp(meanspd)
        disp('total distance traveled (mm):')
        disp(total_distance_traveled)
        break;
    end
end
clear s 