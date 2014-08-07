require 'pg'
require './lib/tasks'
require './lib/lists'

DB = PG.connect({:dbname => 'to_do'})

def welcome
  puts "*****Welcome to the To Do list!*****"
  loop do
    puts "Press '1' to create a list"
    puts "Press '2' to show all lists"
    puts "Press '3' to add task(s)"
    puts "Press 'x' to exit"
    main_choice = gets.chomp

    if main_choice == '1'
      create_list
    elsif main_choice == '2'
      show_lists
    elsif main_choice == '3'
      add_task
    elsif main_choice =='x'
      puts "Goodbye."
      exit
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



welcome
