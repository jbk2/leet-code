class MaxHeap
  attr_reader :heap_arr
  
  def initialize(arr)
    @heap_arr = build_heap(arr)
  end
  
  def max
    @heap_arr[0]
  end

  def insert
    # add to end of heap_arr
    # calc parent
    # if larger than parent then swap (sift up or sift down)- repeat until in order
  end

  def sift_up(index)
    
  end

  def sift_down(index)
    
  end

  def parent(index)
    (index - 1) / 2
  end

  def left(index)
    2 * index + 1
  end

  def right(index)
    2 * index + 2
  end

  def max_heapify
    
  end

  private
  def build_heap(arr)
    # build the arr of the heap
    []
  end

end