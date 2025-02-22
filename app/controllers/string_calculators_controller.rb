class StringCalculatorsController < ApplicationController
  # This action receives a string of numbers from params, processes it, and returns the sum as JSON.
  def add
    numbers = params[:numbers] || ""  # Get numbers from parameters or default to an empty string
    result = calculate_sum(numbers)    # Compute the sum

    render json: { result: result }    # Return the result as JSON response
  end

  private

  # Method to calculate the sum of numbers in the input string
  def calculate_sum(numbers)
    return 0 if numbers.empty? # If input is empty, return 0

    delimiter = "," # Default delimiter is a comma

    # Check for custom delimiter
    if numbers.start_with?("//")
      parts = numbers.split("\n", 2)   # Split input into delimiter part and numbers part
      delimiter = parts.first[2..]      # Extract custom delimiter (after "//")
      numbers = parts.last              # Extract numbers string
    end

    numbers = numbers.gsub("\n", delimiter) # Replace newline characters with the delimiter
    num_list = numbers.split(delimiter).map(&:to_i) # Split string into numbers and convert to integers

    # Check for negative numbers and raise an error if any exist
    negatives = num_list.select { |num| num.negative? }
    raise "negative numbers not allowed #{negatives.join(', ')}" unless negatives.empty?

    num_list.sum # Return the sum of numbers
  end
end
