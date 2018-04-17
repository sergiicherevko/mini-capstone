// # Write a method that accepts an array of numbers as a parameter, and counts how many 55’s there are in the array.

// Write a function that accepts an array of strings and returns a new array containing every other string from the original array. For example, if the input is ["a", "b", "c", "d", "e", "f"], the output should be ["a", "c", "e"].

// numbers.forEach(function(number) {
//   console.log("Your number is " + number);
// });

// var array = ["a", "b", "c", "d", "e", "f"];
// function everySecond() {
//   var index = 0;
//   var new_array = [];

//   array.forEach(function(string) {
//     if (index % 2 === 0) {
//       new_array.push(string);
//     }
//     index = index + 1;
//   });

//   return console.log(new_array);
// }

// everySecond();

// Write a method that accepts one argument - an array of numbers. The method should return the greatest number. For example, if the input is [5, 4, 8, 1, 2], the output should be 8.

// def max(numbers)
//   current_max = numbers[0]
//   numbers.each do |number|
//     if number > current_max
//       current_max = number
//     end
//   end
//   current_max
// end

var numbers = [5, 4, 8, 1, 2];

function largestNumber() {
  var current_max = numbers[0];
  numbers.forEach(function(number) {
    if (current_max < number) {
      current_max = number;
    }
  });
  console.log(current_max);
}

largestNumber();
