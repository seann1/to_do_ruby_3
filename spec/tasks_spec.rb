require 'tasks'
require 'rspec'
require 'pg'

DB = PG.connect({:dbname => 'to_do_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM tasks *;")
  end
end

describe Task do
  it 'is initialized with a name and a list ID' do
    test_task = Task.new({'name' => 'Epicodus', 'list_id' => 1})
    test_task.should be_an_instance_of Task
  end

  it 'tells you its name' do
    task = Task.new({'name' => 'learn SQL', 'list_id' => 1})
    task.name.should eq 'learn SQL'
  end

  it 'tells you its list ID' do
    task = Task.new({'name' => 'learn SQL', 'list_id' => 1})
    task.list_id.should eq 1
  end

  it 'starts off with no tasks' do
    Task.all.should eq []
  end

  it 'lets you save tasks to the database' do
    task = Task.new({'name' => 'learn SQL', 'list_id' => 1})
    task.save
    Task.all.should eq [task]
  end

  it 'is the same task if it has the same name and ID' do
    task1 = Task.new({'name' => 'learn SQL', 'id' => 1})
    task2 = Task.new({'name' => 'learn SQL', 'id' => 1})
    task1.should eq task2
  end

describe "list_tasks_for_list" do
  it "list all tasks with the given list_id" do
  list1 = List.new({'name' => 'school'})
  list2 = List.new({'name' => 'work'})
  list1.save
  list2.save
  task1 = Task.new({'name' => 'homework', 'list_id' => list1.id})
  task2 = Task.new({'name' => 'show up', 'list_id' => list1.id})
  task1.save
  task2.save
  Task.list_tasks_for_list(list1.id).should eq [task1, task2]
  end
end
end
