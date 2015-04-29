# WHAT DO WE NEED FOR A WHILE LOOP?
  # INPUT
  # OUTPUT
  # END CASE



































def binary_search(array, desired_num)

  start_index = 0
  end_index = array.length - 1

  while start_index <= end_index
    mid_index = (start_index + end_index) / 2

    if array[mid_index] == desired_num
      return mid_index
    elsif array[mid_index] > desired_num
      end_index = mid_index - 1
    elsif array[mid_index] < desired_num
      start_index = mid_index + 1
    end

  end

  return -1
end


array_short = [1, 2, 3]
array_long = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

p "BINARY SEARCH: WHILE LOOP"
p "FOUND AT INDEX: #{binary_search(array_short, 2)}"
p "FOUND AT INDEX: #{binary_search(array_short, 1)}"
p "FOUND AT INDEX: #{binary_search(array_long, 9)}"
p "FOUND AT INDEX: #{binary_search(array_long, 10)}"
p "FOUND AT INDEX: #{binary_search(array_long, 11)}"
puts








































# WHAT DO WE NEED FOR RECURSION?
  # INPUT
  # OUTPUT
  # BASE CASE(S)
  # PERSISTENT INFORMATION











































# def binary_search_recursive(array, desired_num, start_index = 0, end_index = array.length - 1)
#   mid_index = (start_index + end_index) / 2

#   return -1 if start_index > end_index

#   if array[mid_index] == desired_num
#     return mid_index
#   elsif array[mid_index] > desired_num
#     end_index = mid_index - 1
#   elsif array[mid_index] < desired_num
#     start_index = mid_index + 1
#   end

#   binary_search_recursive(array, desired_num, start_index, end_index)
# end

# p "BINARY SEARCH: RECURSIVE"
# p "FOUND AT INDEX: #{binary_search_recursive(array_short, 2)}"
# p "FOUND AT INDEX: #{binary_search_recursive(array_short, 1)}"
# p "FOUND AT INDEX: #{binary_search_recursive(array_long, 9)}"
# p "FOUND AT INDEX: #{binary_search_recursive(array_long, 10)}"
# p "FOUND AT INDEX: #{binary_search_recursive(array_long, 11)}"