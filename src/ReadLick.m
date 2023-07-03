function [Licks, IsLicking] = ReadLick(Licks,trial,distance,lickdistance,alpha,Isrewarded,lickport)
    IsLicking = 0;
    if lickport == 1
        IsLicking = 1;
        Licks(end+1,:) = [trial lickdistance alpha Isrewarded now 0 distance];
    end
end

