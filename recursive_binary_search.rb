# BINARY SEARCH: USING A WHILE LOOP VS USING RECURSION

# WHAT DO WE NEED FOR A WHILE LOOP?
  # INPUT: Number you want, a Sorted Array
  # OUTPUT: Index of Element
  # END CASE: Find the Element or Don't Find the Element
      # (where an end case, in this sense, is the case in which you'll stop the while loop)

  # PROS:
    # takes up less space in the computer's memory
    # pretty readible & easy to grasp

  # CONS:
    # not as beautiful


def binary_search_while_loop(array, desired_num)

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
p "FOUND AT INDEX: #{binary_search_while_loop(array_short, 2)}"
p "FOUND AT INDEX: #{binary_search_while_loop(array_short, 1)}"
p "FOUND AT INDEX: #{binary_search_while_loop(array_long, 9)}"
p "FOUND AT INDEX: #{binary_search_while_loop(array_long, 10)}"
p "FOUND AT INDEX: #{binary_search_while_loop(array_long, 11)}"
puts




# WHAT DO WE NEED FOR RECURSION?
  # INPUT: target num, array
  # OUTPUT: true/false
  # BASE CASE(S): find the number; number doesn't exist
  # PERSISTENT INFORMATION: the array which hasn't been ruled out, the target number

  # This example just returns true or false based on whether or not the element is found.
  # It is destructive because we destroy the method (by reducing its size) as we search
  # through the array.

  # PROS:
    # reusing your own code is beautiful
  # CONS:
    # takes up more space in the computer's memory
    # this method is destructive, which isn't very positive


def binary_search_recursive_destructive(array, target)

  low = 0
  high = array.length - 1
  mid = (low + high) / 2

  binding.pry

  return true if target == array[mid] # the target is found
  return false if array[mid] == nil # the target doesn't exist

  # reduce the search area && call recursively
  if target > array[mid]
    new_array = array[(mid + 1)..high]
    binary_search_recursive_destructive(new_array, target)
  elsif target < array[mid]
    new_array = array[low..(mid - 1)]
    binary_search_recursive_destructive(new_array, target)
  end

end



array_short = [1, 2, 3]
array_long = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

p "BINARY SEARCH: WHILE LOOP"
p "FOUND AT INDEX: #{binary_search_recursive_destructive(array_short, 2)}"
p "FOUND AT INDEX: #{binary_search_recursive_destructive(array_short, 1)}"
p "FOUND AT INDEX: #{binary_search_recursive_destructive(array_long, 9)}"
p "FOUND AT INDEX: #{binary_search_recursive_destructive(array_long, 10)}"
p "FOUND AT INDEX: #{binary_search_recursive_destructive(array_long, 11)}"
puts


# This version of Binary Search Recursive isn't destructive. It returns the index of the
# element if the element exists, or it returns -1 if the element doesn't exist (which is
# an expectation in regards to Computer Science). The array stays the same as it is passed
# recursively, and instead we change the start and end indices. Those start & end indices
# are defaulted to be 0 and the last index of the array so that the user doens't have to
# pass that information in.

  # PROS:
    # really beautiful & short!
    # is not destructive!
    # very readible
  # CONS:
    # takes up more space in the computer's memory


def binary_search_recursive_non_destructive(array, desired_num, start_index = 0, end_index = array.length - 1)
  mid_index = (start_index + end_index) / 2

  return -1 if start_index > end_index # BASE CASE #1

  if array[mid_index] == desired_num
    return mid_index # BASE CASE #2
  elsif array[mid_index] > desired_num
    end_index = mid_index - 1
  elsif array[mid_index] < desired_num
    start_index = mid_index + 1
  end

  binary_search_recursive_non_destructive(array, desired_num, start_index, end_index)
end

p "BINARY SEARCH: RECURSIVE"
p "FOUND AT INDEX: #{binary_search_recursive_non_destructive(array_short, 2)}"
p "FOUND AT INDEX: #{binary_search_recursive_non_destructive(array_short, 1)}"
p "FOUND AT INDEX: #{binary_search_recursive_non_destructive(array_long, 9)}"
p "FOUND AT INDEX: #{binary_search_recursive_non_destructive(array_long, 10)}"
p "FOUND AT INDEX: #{binary_search_recursive_non_destructive(array_long, 11)}"