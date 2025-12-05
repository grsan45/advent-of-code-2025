local filename = 'input.txt'
local banks = {}

local puzzle1_answer = 0
local puzzle2_answer = 0

-- read lines of file into banks
for line in io.lines(filename) do
    local bank = {}
    for i = 1, #line do
        table.insert(bank, tonumber(line:sub(i,i)))
    end
    table.insert(banks, bank)
end

-- part 1
for bank_index, bank in ipairs(banks) do
    local forward_max = 0
    local foward_max_idx = -1
    local reverse_max = 0

    for i = 1, #bank - 1 do
        if bank[i] > forward_max then 
            forward_max = bank[i] 
            foward_max_idx = i
        end
    end

    for i = #bank, foward_max_idx + 1, -1 do
        if bank[i] > reverse_max then reverse_max = bank[i] end
    end

    local joltage = tonumber(tostring(forward_max) .. tostring(reverse_max))
    puzzle1_answer = puzzle1_answer + joltage
end

-- part 2
for _, bank in ipairs(banks) do
    local joltage = ""
    local required_digits = 12
    local current_max = 0
    local next_index = 1

    while required_digits > 0 do
        for i = next_index, #bank do
            if i > #bank - required_digits + 1 then
                break
            elseif bank[i] > current_max then
                current_max = bank[i]
                next_index = i + 1
            end
        end

        joltage = joltage .. tostring(current_max)
        required_digits = required_digits - 1
        current_max = 0
    end
    print(joltage)

    puzzle2_answer = puzzle2_answer + tonumber(joltage)
end

print("Part 1 Answer: " .. puzzle1_answer)
print("Part 2 Answer: " .. puzzle2_answer)

--[[
    My input resulted in the following output:
    Part 1 Answer: 17144
    Part 2 Answer: 170371185255900
]]