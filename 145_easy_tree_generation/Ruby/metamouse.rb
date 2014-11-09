#!/usr/bin/ruby


puts "? "
xtree = $stdin.gets

xu = xtree.split

num = xu[0].to_i
leaf = xu[1]
base = xu[2]

for i in 1..num
    if i.odd?
        puts (" ".* ((num - i) / 2)) + (leaf.* i) + (" ".* ((num - i) / 2))
    end
end

puts (" ".* ((num - 3) / 2)) + (base.* 3) + (" ".* ((num - 3) / 2))
