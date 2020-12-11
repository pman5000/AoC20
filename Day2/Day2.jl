function Day2()
	nvalid1 = 0
	nvalid2 = 0
	n1 = 0
	n2 = 0
	letter::Char = 0

	function check_part1(password::SubString{String})
		n = count(c->c==letter, password)
	    if n1 ≤ n ≤ n2
    	    nvalid1 += 1
	    end
	end

	function check_part2(password::SubString{String})
    	if n1 ≤ length(password) && n2 ≤ length(password)
        	if (password[n1] == letter) ⊻ (password[n2] == letter)
            	nvalid2 += 1
	        end
    	end
	end

	regex = r"(\d+)-(\d+) (\w): (\w+)$"
	open("input.txt") do file
		for line in eachline(file)
		    m = match(regex, line)
	    	n1 = parse(Int, m.captures[1])
	    	n2 = parse(Int, m.captures[2])
		    letter = m.captures[3][1]
	    	check_part1(m.captures[4])
		    check_part2(m.captures[4])
		end
	end
	return nvalid1, nvalid2
end

using Printf
@printf("Part1 %d\nPart2 %d\n", (@time Day2())...)

