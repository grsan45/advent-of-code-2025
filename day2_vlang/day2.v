import os
import strconv
import math
import arrays

fn main() {

	mut input := os.read_file("./input.txt") or { 
		panic(err)
	}
	input = input.replace("\n","")

	ranges := input.split(",")

	mut p1_answer := i64(0)
	mut p2_answer := i64(0)

	mut p2_invalids := []i64{}

	for r in ranges {
		bounds := r.split("-")
		lower_bound := strconv.atoi64(bounds[0])!
		upper_bound := strconv.atoi64(bounds[1])!

		// part 1 -- mathematic approach
		for i in lower_bound .. upper_bound+1 {
			digit_count := i.str().len
			if digit_count % 2 != 0 { continue }

			divisor := i64(math.pow10(digit_count / 2))

			upper_half := i / divisor
			lower_half := i % divisor

			if upper_half == lower_half { p1_answer += i}
		}

		// part 2 -- string approach
		for i in lower_bound .. upper_bound + 1 {
			digit_count := i.str().len
			mut lengths := []int{}
			for l in 1 .. digit_count / 2 + 1 {lengths << l}

			for n in lengths {
				if digit_count % n != 0 { continue } // cannot have repeating components if not divisible by component size
				str_digit := i.str()
				
				mut components := []string{}
				mut d := 0

				// this just splits the string into equal sections of length n
				for d < digit_count {
					components << str_digit[d .. d + n]
					d += n
				}

				// if we have no distinct elements, then this is an invalid id
				if arrays.distinct(components).len == 1 { p2_invalids << i }
			}
		}
	}

	// cheaky way to get around duplicate invalid ids with the part 2 problem. 
	// i.e, [2,2,2,2,2,2] [22,22,22], [222,222] would all be included in the sum, which isnt correct
	for i in arrays.distinct(p2_invalids) {
		p2_answer += i
	}

	println("Part One Answer: ${p1_answer}, Part Two Answer: ${p2_answer}")

	/*
	  My input resulted in the following output:
	  Part One Answer: 13919717792, Part Two Answer: 14582313461
	*/

}