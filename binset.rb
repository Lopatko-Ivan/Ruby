class BinSet
  DEF_SIZE = 7

  def initialize(size = DEF_SIZE)
    @array = Array.new(size)
    empty
  end

  def empty; @size = 0 end

  def empty?; @size == 0 end
 
  def include?(val)
    !search(val).nil?
  end

  def insert(val)
    if search(val).nil?
      raise 'LSet is full' if @size >= @array.size
      @array[search_ind(0,@size-1,val),0] = val
      @size += 1
    end
  end

  def delete(val)
    unless (i = search(0,@size-1,val)).nil?
      @array[i,1] = nil
      @array.compact!
      @size-=1
    end
  end

  private
  
  def search(left,right,val)
    return nil if right < left
    mid=(right+left)/2
    case var<=>@array[mid]
      when -1
        search(left,mid-1,val)
      when 1
        search(mid+1,right,val)
      else mid
    end
  end

  def search_ind(right,left,val)
    return 0 if right==-1
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
    case var <=> @array[mid]
      when -1
        search(left,mid,val)
      when 1
        search(mid,right,val)
    end
  end
end
