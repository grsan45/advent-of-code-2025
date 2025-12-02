use std::fs;
use std::io;

fn main() -> io::Result<()> {
    let path = "./input.txt";
    let contents = fs::read_to_string(path)?;

    let mut dial: i32 = 50;
    let mut end_turn_zeros = 0;
    let mut clicks = 0;

    let lines = contents.split("\n");
    for line in lines {
        if line.is_empty() {continue;}

        let components = line.split_at(1);

        let sign = if components.0 == "L" { -1 } else { 1 };
        let mut rot: i32 = components.1.parse::<i32>().expect("Failed to parse rotation value.") * sign;

        // add guaranteed clicks
        clicks += (rot / 100).abs();
        rot %= 100; // ensure we only use a single rotation

        dial += rot;

        // ignore dial == rot, i.e going from 0 -> -5 wouldn't result in a click
        if (dial == 0 || dial >= 100 || dial < 0) && dial != rot { clicks += 1 }

        // *actual* modulus operator
        dial = dial.rem_euclid(100);
        if dial == 0 { end_turn_zeros += 1; }
    }

    println!("Part one answer: {end_turn_zeros}");
    println!("Part two answer: {clicks}");

    /*
        My input resulted in the following output:
        Part one answer: 1145
        Part two answer: 6561
    */

    Ok(())
}