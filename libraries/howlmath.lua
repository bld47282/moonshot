local howlmath = {}

function howlmath.clamp(low, n, high) 
    return math.min(math.max(n, low), high) 
end

return howlmath