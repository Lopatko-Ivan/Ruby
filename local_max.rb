k=0
i=0
begin
	while true
		print "x->"
		x=readline.to_i
		if i==0
			k,last,r,i = 1,x,true,1 
		elsif (r)and(x>last)
			k,last,r = k,x,true
		elsif (r)and(x==last) 
			k,last,r = k+1,x,true 
		elsif x<last
			k,last,r = k,x,false
		elsif (!r)and(x>=last)
			k,last,r = k+1,x,true 
		end
	end
rescue EOFError
	puts "\nk=#{k}"
end
