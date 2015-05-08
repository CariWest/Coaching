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
    @description = args.fetch(:description)
    @complete = args.fetch(:complete, false)
  end

end

class List

  attr_accessor :tasks

  def initialize(file)
    @tasks = []
    parse_csv(file)
  end

  def parse_csv(file)
    CSV.foreach(file, headers: true, header_converters: :symbol) do |todo_data|
      add_task(todo_data)
    end
  end

  def add_task(task)
    @tasks << Task.new({description: task})
  end

  def delete_task(index)
    p @tasks.delete_at(index)
  end

end

module View

  def self.list_item(index, description, complete)
    complete = complete ? "[X]" : "[ ]"
    puts "#{index} #{complete} #{description}"
  end

  def self.display
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

  def initialize(file)
    @list = List.new(file)
    @command = ARGV.shift.to_sym
    @input = ARGV.join(" ")
    @possible_commands = [:list, :add, :delete]
    run_command(@command, @input)
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
    if task
      View.confirm("DELETED", task.description)
    else
      View.confirm_inconceivable
    end
  end

  def run_command(cmd, args = nil)
    @possible_commands.include?(cmd) ? self.send(cmd, args) : View.confirm_inconceivable
  end

end

Controller.new('todo.csv')