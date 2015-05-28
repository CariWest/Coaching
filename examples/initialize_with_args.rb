class Person
  def initialize(first_name, last_name, age, height, hair_color, love, quirk)
    @first_name = first_name || "John"
    @last_name = last_name || "Doe"
  end
end


class PersonArgs
  def initialize(args)
    @first_name = args.fetch(first_name) { |x| puts "What is your first name"; gets.chomp }
    @last_name = args.fetch(last_name, "Doe")
    @age = args.fetch(age)
    @height = args.fetch(height)
  end
end

benoit = {
  first_name = "Benoit",
  last_name = "Demonsant",
  love = "cats",
  quirk = "best last name",
  age = 7
}

Person.new("Cari", "Westbrook", 26, 5.5, "brown", "my dog", "dances a lot")
PersonArgs.new(benoit)
