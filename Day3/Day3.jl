const input = read("input.txt", String)
const stride = findfirst("\n", input).start
const w = stride - 1
const h = (length(input)) ÷ stride
const tree = '#'
istree(x::Int, y::Int) = input[mod1(x,w)+stride*(y-1)] == tree

function check_slope(dx::Int, dy::Int)
    x = 1; y = 1
    n = 0
    while y ≤ h
        istree(x,y) && (n += 1)
        x += dx; y += dy
    end
    return n
end

const slopes = (
    (1, 1),
    (3, 1),
    (5, 1),
    (7, 1),
    (1, 2)
)

results = @time [check_slope(s...) for s in slopes]
println("Part1 $(results[2])")
println("Part2 $(prod(results))")

