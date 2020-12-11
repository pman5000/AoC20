Passport = Dict{String,String}

const required_fields = ("byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid")
const nreq = length(required_fields)

check_required(p::Passport) = count(field->haskey(p, field), required_fields) == nreq

function check_year(str::String, jmin::Int, jmax::Int)
	year = tryparse(Int, str)

	year != nothing &&
	length(str) == 4 &&
	jmin ≤ year ≤ jmax
end

function check_height(str::String)
	height = first(str, length(str)-2)
	height = tryparse(Int, height)
	unit = last(str, 2)
	if height != nothing
		if  (unit=="cm" && 150 ≤ height ≤ 193) ||
			(unit=="in" &&  59 ≤ height ≤  76)
			return true
		end
	end
	return false
end

const checks = Dict{String, Function}(
	"byr" => v->check_year(v, 1920, 2002),
	"iyr" => v->check_year(v, 2010, 2020),
	"eyr" => v->check_year(v, 2020, 2030),
	"hgt" => v->check_height(v),
	"hcl" => v->occursin(r"\A#([0-9]|[a-f]){6}$", v),
	"ecl" => v->v ∈ ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"],
	"pid" => v->occursin(r"\A[0-9]{9}$", v),
	"cid" => v->true
)

function check_fields(p::Passport)
	for (field, value) in p
		if !checks[field](value)
			return false
		end
	end
	return true
end

function Day4()
	nvalid1 = 0
	nvalid2 = 0
	current = Passport()
	re = r"(\w+):(\S+)"
	file = open("input.txt")
	for line in eachline(file)
		if line == ""
			if check_required(current)
				nvalid1 += 1
				if check_fields(current)
					nvalid2 += 1
				end
			end
			current = Passport()
		else
			for m in eachmatch(re, line)
				current[m.captures[1]] = m.captures[2]
			end
		end
	end
	close(file)
	return nvalid1, nvalid2
end

using Printf
@printf("Part1 %d\nPart2 %d\n", (@time Day4())...)

