function [Licks, IsLicking] = ReadLick(Licks,trial,distance,alpha,Isrewarded)
    IsLicking = 0;
    if lickport > 0
        IsLicking = 1;
        Licks(end+1,:) = [trial distance alpha Isrewarded now 0];
    end
end

