function [RewardCount] = DeliverReward(s,RewardCount,ms)
    fprintf(s, ['SOL ',num2str(1), ' ', num2str(ms)]);
    RewardCount = RewardCount + 1;
end

