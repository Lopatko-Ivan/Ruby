class BinSet
  DEF_SIZE = 7

  def initialize(size = DEF_SIZE)
    @array = Array.new(size)
    empty
  end

  def empty; @size = 0 end

  def empty?; @size == 0 end
 
  def include?(val)
    !search(0,@size-1,val).nil?
  end

  def insert(val)
    if search(0,@size-1,val).nil?
      raise 'BinSet is full' if @size >= @array.size
      if @size==0
	@array[0]=val
      else
        i=search_ind(0,@size-1,val)
        forward(i)
        @array[i]=val
      end
      @size += 1
    end
  end

  def delete(val)
    unless (i = search(0,@size-1,val)).nil?
      backward(i)
      @size-=1
    end
  end

  private
  
  def search(left,right,val)
    return nil if right < left
    mid=(right+left)/2
    case val<=>@array[mid]
      when -1
        search(left,mid-1,val)
      when 1
        search(mid+1,right,val)
      else mid
    end
  end

  def search_ind(left,right,val)
    if right-left < 2
      if val > @array[right]
        return right+1
      elsif val < @array[left]
	return left
      else
	return right
      end
    end
    mid=(right+left)/2
    case val <=> @array[mid]
      when -1
        search_ind(left,mid,val)
      when 1
        search_ind(mid,right,val)
    end
  end

  def forward(i)
    (@size).downto(i+1) do |x|
      @array[x]=@array[x-1]
    end
  end  

  def backward(i)
    i.upto(@size-2) do |x|
      @array[x]=@array[x+1]
    end
  end 
end
