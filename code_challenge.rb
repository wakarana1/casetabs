
# 1. RUBY CONVERT A STRING TO A HASH
require 'json'
str = "{key:[[value_1, value_2],[value_3, value4]], 5:10:00AM]}"

def convert_string_to_hash(string)
  h_string = string.sub("]}", "}") # get rid of extra bracket
  h_string.gsub!(/:(?=\[)/, " => ")
  h_string.gsub!(/:(?!\d{2}[AP]M)/, "=>") # for 5 key with no space
  h_string.gsub!(/(\d{2}:\d{2}[AP]M|[a-z]+_?\d*)/, '"\1"')

  h = eval(h_string)
end

p convert_string_to_hash(str) #h = {"key" => [["value_1", "value_2"],["value_3", "value4"]], 5=>"10:00AM"}

# 2. RUBY WRITE A CLASS WHERE METHODS CAN BE INITIALIZED

h = {"this" => [1,2,3,4,5,6], "that" => ['here', 'there', 'everywhere'], :other => 100}

class Sample
  def initialize(hash)
    hash.each do |key, value|
      instance_variable_set("@#{key}", value)
      self.class.send(:attr_reader, key)
    end
  end
end

c = Sample.new(h)
p c.this # == [1,2,3,4,5,6]
p c.that # == ['here', 'there', 'everywhere']
p c.other # == 100


# 3. RUBY COUNT MAX GROUP OF ZEROES

a = 1041

def largest_zero_set(integer)
  zero_size = []
  binary = integer.to_s(2)
  bin_array = binary.split('1').reject(&:empty?)
  bin_array.each do |number|
    zero_size << number.length
  end
  return zero_size.max
end

puts largest_zero_set(a) # 5
