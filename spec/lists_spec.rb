require 'rspec'
require 'lists'
require 'pg'

DB = PG.connect({:dbname => 'to_do_test'})

RSpec.configure do |config|
  config.after (:each) do
    DB.exec("DELETE FROM lists *;")
  end
end


describe List do
  it 'is initialized with a hash of attributes' do
    list = List.new({'name'=> 'Epicodus stuff'})
    list.should be_an_instance_of List
  end

  it 'tells you its name' do
    list = List.new({'name' => 'Epicodus'})
    list.name.should eq 'Epicodus'
  end

  it 'is the same list if it has the same name' do
    list1 = List.new({'name' => 'Epicodus'})
    list2 = List.new({'name' => 'Epicodus'})
    list1.should eq list2
  end

  it 'starts off with no lists' do
    List.all.should eq []
  end

  it 'lets you save lists to the database' do
    list = List.new({'name' => 'learn SQL'})
    list.save
    List.all.should eq [list]
  end

  it 'sets its ID when you save it' do
    list = List.new({'name' => 'learn SQL'})
    list.save
    list.id.should be_an_instance_of Fixnum
  end

  it 'can be initialized with its database ID' do
    list = List.new({'name' => 'Epicodus', 'id' => 1})
    list.should be_an_instance_of List
  end
end
