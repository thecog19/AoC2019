def valid_number?(num)
  arr = num.split("")
  if arr.length != 6
    return false
  elsif !adjacency?(arr)
    return false
  elsif !increasing?(arr)
    return false
  else
    return true
  end
end

def adjacency?(arr)
  arr.each_with_index do |e, i|
    if(e == arr[i + 1])
      return true
    end
  end
  false
end

def increasing?(arr)
  prev = 0
  arr.each do |curr|
    if prev > curr.to_i
      return false
    end
    prev = curr.to_i
  end
  true
end

def test_range(start_num, end_num)
  count = 0 
  num = start_num 
  while num < end_num
    if valid_number?(num.to_s)
      count += 1
    end
    num += 1
  end
  count 
end

test_range(153517, 630395)
