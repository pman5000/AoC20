using DelimitedFiles

input = readdlm("input.txt", Int);
N = length(input)

function part1()
    for i = 1:N-1, j = i+1:N
        if input[i] + input[j] == 2020
            return input[i] * input[j]
        end
    end
end

function part2()
    for i = 1:N-1, j = i+1:N, k = j+1:N
        if input[i] + input[j] + input[k] == 2020
            return input[i] * input[j] * input[k]
        end
    end
end

@time begin
	println("Part1 $(part1())")
	println("Part2 $(part2())")
end

