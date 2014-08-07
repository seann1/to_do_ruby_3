require 'pg'
require './lib/tasks'
require './lib/lists'
require 'pry'

DB = PG.connect({:dbname => 'to_do'})

def welcome
  puts "*****Welcome to the To Do list!*****"
  loop do
    puts "Press '1' to create a list"
    puts "Press '2' to show all lists"
    puts "Press '3' to add task(s)"
    puts "Press '4' to delete list"
    puts "Press '5' to view tasks by list"
    puts "Press 'x' to exit"
    main_choice = gets.chomp

    if main_choice == '1'
      create_list
    elsif main_choice == '2'
      show_lists
    elsif main_choice == '3'
      add_task
    elsif main_choice == '4'
      delete_list
    elsif main_choice == '5'
      list_tasks
    elsif main_choice =='x'
      puts "Goodbye."
      exit
    else
      puts "Invalid entry."
      puts "\n"
    end
  end
end

def create_list
  puts "Enter list title."
  list_title = gets.chomp
  new_list = List.new({'name' => list_title})
  new_list.save
end

def show_lists
  List.all.each do |item|
    puts "#{item.id}. #{item.name}"
  end
end

def delete_list
  show_lists
  puts "what list would you like to delete?"
  user_choice = gets.chomp
  List.delete(user_choice)
  puts "'#{user_choice} has been deleted"
end

def add_task
  show_lists
  puts "What list would you like to add a task to?"
  user_choice = gets.chomp
  puts "Add task name"
  user_task = gets.chomp
  list_object = List.find_list_by_name(user_choice)
  list_id = list_object.id
  new_task = Task.new({'name' => user_task, 'list_id' => list_id})
  new_task.save
  puts "New task added"
end

def list_tasks
  puts "\n"
  show_lists
  puts "Select a list to view its tasks"
  list_choice = gets.chomp
  user_list = List.find_list_by_name(list_choice)
  user_list_id = user_list.id
  Task.list_tasks_for_list(user_list_id)
end

welcome
