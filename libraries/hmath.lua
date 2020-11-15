local hmath = {}

function hmath.clamp(low, n, high) 
    return math.min(math.max(n, low), high) 
end

return hmath