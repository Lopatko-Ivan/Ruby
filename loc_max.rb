k=0
i=0
begin
	while true
		print "x->"
		x=readline.to_i
		if i==0
			k,last,r,i = 1,x,true,1 
		else
			if (r)and(x>last)
				k,last,r = k,x,true
			else
				if (r)and(x==last) 
					k,last,r = k+1,x,true 
				else
					if x<last
						k,last,r = k,x,false
					else 
						if (!r)and(x>=last)
							k,last,r = k+1,x,true 
						end
					end
				end
			end
		end
	end
rescue EOFError
	puts "\nk=#{k}"
end
