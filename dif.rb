y=0
y1=0
i=0
print "t="
t=gets.to_i
begin
	while true
		print "a#{i}-> "
		y1=t*y1+y
		y=t*y+readline.to_i
		puts "P'(#{t})=#{y1}"
		i+=1
	end
rescue EOFError
	puts "\n"
end
