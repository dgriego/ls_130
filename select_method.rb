require 'pry'
arr = [1, 2, 3, 4]

def my_select(arr)
    new_arr = []
    max = arr.length
    count = 0
    while count < max
        new_arr << arr[count] if yield(arr[count])
        count += 1
    end

    new_arr
end

p my_select(arr) { |item| item.odd? }

def my_reduce(arr, acc = 0)
    max = arr.length
    count = 0
    while count < max
        acc = yield(acc, arr[count])
        count += 1
    end

    acc
end
