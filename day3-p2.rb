def generate_coord_set(inst)
  steps = 0 
  curr_coord = [0,0]
  coord_arr = [[0,0]]
  inst.each do |i|
    dist = i[1..-1].to_i
    if(i[0] == "L")
      dist.times do 
        curr_coord[0] -= 1
        coord_arr << curr_coord.dup
      end
    elsif(i[0] == "R")
      dist.times do 
        curr_coord[0] += 1
        coord_arr << curr_coord.dup
      end
    elsif(i[0] == "U")
      dist.times do 
        curr_coord[1] += 1
        coord_arr << curr_coord.dup
      end
    elsif(i[0] == "D")
      dist.times do 
        curr_coord[1] -= 1
        coord_arr << curr_coord.dup
      end
    end
  end
  return coord_arr
end

def compare_arr(arr1, arr2)
  arr = arr1 & arr2
  arr.each do |ele|
    #the trick here is that the index of the coordinate in the original array 
    #is equal to the number of steps to get there 
    #and that we want to find the *first* time that happens
    ele[2] = arr1.find_index(ele) + arr2.find_index(ele)
  end
end

def find_shortest(p_arr)
  shortest = 1000000000
  p_arr.each do |tup|
    dist = tup[2]
    if dist == 0 
      next
    end
    if shortest > dist 
      shortest = dist
    end
  end
  return shortest 
end

def main(s1, s2)

  coord_1 = generate_coord_set(s1.split(","))
  coord_2 = generate_coord_set(s2.split(","))
  intersects = compare_arr(coord_1, coord_2)
  find_shortest(intersects)
end
