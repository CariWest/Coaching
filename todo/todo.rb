require 'csv'
# MODEL

# CSV file
# List
# add
# delete

# Tasks
# complete
# update

# VIEW

# display
# list_items

# CONTROLLER
# parses ARGV
# calls the method

class Task
  attr_accessor :complete
  attr_reader :description

  def initialize(args = {})
    args[:complete]
    @description = args[:description]
    @complete = to_bool(args[:complete]) || false
  end

  # this is a helper method which allows us to interpret the CSV file's true/false strings as
  # a boolean. It helps simplify the complexity of logic which would be necessary otherwise.
  def to_bool(input)
    input == 'true'
  end
end

class List
  attr_accessor :tasks

  def initialize
    @tasks = []
  end

  def parse_csv(file)
    # this parsing method could go in the List model or in the Controller, depending on your
    # code design. In this method, the Todo app depends on the CSV, so I want to make sure it's
    # always included.
    CSV.foreach(file, headers: true, header_converters: :symbol) do |todo_data|
      @tasks << Task.new(todo_data)
    end
  end

  def save_csv(file)
    CSV.open(file, 'wb') do |csv|
      csv << ["description", "complete"] # so that we recreate our headers
      @tasks.each do |task|
        csv << [task.description, task.complete]
      end
    end
  end

  def add_task(task)
    @tasks << Task.new({description: task})
  end

  def delete_task(index)
    @tasks.delete_at(index)
  end

  def complete_task(index)
    @tasks[index].complete = true
    return @tasks[index]
  end
end

module View
  def self.list_item(index, description, complete)
    complete = complete ? "[X]" : "[ ]"
    puts "#{index} #{complete} #{description}"
  end

  def self.confirm(action, task)
    puts "#{action}: #{task}"
  end

  def self.confirm_inconceivable
    puts "Inconceivable! (Action cannot be performed)"
  end
end

class Controller
  include View

  # I made this a constant, since it does not change over the course of the program
  POSSIBLE_COMMANDS = [:list, :add, :delete, :complete]

  def initialize(file)
    # I moved calling the parse command to the Controller's responsibility, since
    # it also has the responsibility to save the csv file later. I also moved the
    # ARGV parsing into a separate method. Now this initialization is a series of
    # commands with no logic
    @list = List.new
    @list.parse_csv(file)
    parse_argv
    run_command(@command, @input)
    @list.save_csv(file)
  end

  def list
    @list.tasks.each_with_index do |task, index|
      View.list_item((index + 1), task.description, task.complete)
    end
  end

  def add(args)
    @list.add_task(args)
    View.confirm("ADDED", args)
  end

  def delete(index)
    task = @list.delete_task(index.to_i - 1)
    task ? View.confirm("DELETED", task.description) : View.confirm_inconceivable
  end

  def complete(index)
    task = @list.complete_task(index.to_i - 1)
    task ? View.confirm("COMPLETED", task.description) : View.confirm_inconceivable
  end

  # This method parses our ARGV. While it might seem odd ot separate out the ARGV,
  # it reduces the logic from the initialize method & makes everything a little more
  # readable.
  def parse_argv
    @command = ARGV.shift.to_sym
    @input = ARGV.join(" ") unless ARGV.empty?
  end

  def run_command(cmd, args = nil)
    if POSSIBLE_COMMANDS.include?(cmd)
      args == nil ? self.send(cmd) : self.send(cmd, args)
    else
      View.confirm_inconceivable
    end
  end
end

Controller.new('todo.csv')