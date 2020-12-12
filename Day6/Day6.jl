function Day6(filename::String)
	sum_any = 0
	group_any::UInt32 = 0

	sum_all = 0
	group_notall::UInt32 = 0

	next_group() = begin
		sum_any += count_ones(group_any)
		group_any = 0

		sum_all += count_zeros(group_notall)
		group_notall = 0
	end
	file = open(filename)
	for line in eachline(file)
		if line == ""
			next_group()
		else
			person::UInt32 = 0
			for answer in line
				person |= UInt32(1) << (answer-'a')
			end
			group_any |= person
			group_notall |= ~person
		end
	end
	next_group() #because eachline() omits the last empty line
	close(file)

	return sum_any, sum_all
end

using Printf
@printf("Part1 %d\nPart2 %d\n", (@time Day6("input.txt"))...)

