#!/usr/bin/ruby

$block_total = 0
$running_total = 0

def block_complete
    return if $block_total == 0
    puts "==== #{$block_total/60}:#{$block_total%60} hours.\n\n"
    $running_total += $block_total
    $block_total = 0
end

def line_read(date, start, finish)
    h1, m1 = start.split(':').collect { |str| str.to_i }
    h2, m2 = finish.split(':').collect { |str| str.to_i }

    minutes = (h2 * 60 + m2) - (h1 * 60 + m1)
    puts "Day: #{minutes/60}:#{minutes%60} hours."
    $block_total += minutes
end

File.open("/home/nishant/hours", "r") { |f|
    f.readlines.each { |line|
        content = line.split('#')[0].strip

        if content.empty?
            block_complete
            next
        end

        date, start, finish = content.split("\t")
        line_read(date, start, finish)
    }

    puts "Total: #{$running_total/60}:#{$running_total%60} hours."
}
