s = serialport("COM3",9600);% can check the serialport number from device manager and change the name accordingly COM4
flush(s);
configureTerminator(s,"CR");
fopen(s);
fprintf(s,'thr 20'); %% sets the treshold for the lickport
%status = strtrim(fscanf(app.s));
fprintf(s, 'START');
all = [];
nn = 1000;
for j=1:nn
    flush(s);
    fprintf(s,'SEND')
    status = strtrim(fscanf(s));
    data = sscanf(status,'%f,',[1 4]);
    pause(1/30);
    if j>1
        speed = data(1,3)/100;
        all = [all; [speed data(1,4)]]
    end
end
clear s 

