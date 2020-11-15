local hscores = {}

function hscores.getScores() 
    -- loads scores from default file and outputs a table of scores
    local scores = {}
    local first, last, sub1, sub2
    for line in io.lines("scores.txt") do
        if line then
            first, last = string.find(line,":")
            sub1 = line:sub(1, first - 1)
            sub2 = line:sub(first + 1)
            scores[tonumber(sub1)] = tonumber(sub2)
        end
    end
    return scores
end

function hscores.saveScores(scores)
    local scoreFile = assert(io.open("scores.txt", "w"))
    for k, v in ipairs(scores) do
        scoreFile:write(string.format("%d:%.2f\n", k, v))
    end
    scoreFile:close()
end

return hscores