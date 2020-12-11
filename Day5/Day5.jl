function walk_bsp(path::Array{Bool,1})
	n = length(path)
	low = 1
	for i = 1:n
		if path[i] #upper half
			low += 2^(n-i)
		end
	end
	return low-1
end

seat_id(row::Int, col::Int) = row*8+col

function parse_seat(boarding_pass::String)
	row = walk_bsp([c=='B' for c in boarding_pass[1:7]])
	col = walk_bsp([c=='R' for c in boarding_pass[8:10]])
	return seat_id(row, col)
end

sumn(a::Int, b::Int) = (b-a+1)*(a+b)÷2

function Day5()
	minId = typemax(Int)
	maxId = 0
	sumId = 0
	file = open("input.txt")
	for line in eachline(file)
		id = parse_seat(line)
		if id < minId
			minId = id
		end
		if id > maxId
			maxId = id
		end
		sumId += id
	end
	close(file)
	myId = sumn(minId, maxId) - sumId
	return maxId, myId
end

using Printf
@printf("Part1: max. ID %d\nPart2: my ID %d\n", (@time Day5())...)

