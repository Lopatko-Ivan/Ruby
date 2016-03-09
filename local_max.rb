k=0
last=-1.0/0
r=false
begin
	while true
		print "x->"
		x=readline.to_i 
		if r
			if x>last
				last = x
			elsif x==last
				k,last = k+1,x
			else
				last,r=x,false
			end
		else
			if x<last
				last = x
			else
				k,last,r = k+1,x,true
			end
		end
	end
rescue EOFError
	puts "\nk=#{k}"
end
