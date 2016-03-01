gets
groups=gets.split.map(&:to_i).sort!
s=0
for i in 0...(groups.size/2+1)
	s=s+groups[i]/2+1
end
puts s
