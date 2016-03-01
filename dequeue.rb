# Ограниченный дек
class Dequeue
  DEF_SIZE = 7

  def initialize(size = DEF_SIZE)
    @array = Array.new(size)
    empty
  end

  def empty; @size = @head = 0; @tail = @array.size - 1 end

  def empty?; @size == 0 end

  def push_back(val)
    raise 'Dequeue is full' if @size >= @array.size
    @size += 1
    @tail = forward(@tail)
    @array[@tail] = val
  end

  def push_front(val)
    raise 'Dequeue is full' if @size >= @array.size
    @size += 1
    @head = backward(@head)
    @array[@head] = val
  end

  attr_reader :size 

  def pop_front
    raise 'Dequeue is empty' if @size <= 0
    val = @array[@head]
    @size -= 1
    @head = forward(@head)
    val
  end

  def pop_back
    raise 'Dequeue is empty' if @size <= 0
    val = @array[@tail]
    @size -= 1
    @tail = backward(@tail)
    val
  end

  def front
    raise 'Dequeue is empty' if @size <= 0
    @array[@head]
  end

  def back
    raise 'Dequeue is empty' if @size <= 0
    @array[@tail]
  end

  private

  def forward(index)
    index == @array.size - 1 ? 0 : index + 1
  end

  def backward(index)
    index == 0 ? @array.size - 1 : index - 1
  end
end
