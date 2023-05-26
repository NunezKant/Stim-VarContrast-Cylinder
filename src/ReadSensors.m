function [boardtime,distance,speed,lickport] = ReadSensors(s)
    flush(s);
    fprintf(s, 'SEND');
    status = strtrim(fscanf(app.s));
    data = sscanf(status,'%f,',[1 4]);
    boardtime = data(1); % timestamp from the board clock
    distance = data(2);
    speed = data(3);
    lickport = data(4);
end