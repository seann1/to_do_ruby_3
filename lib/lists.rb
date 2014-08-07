require 'pg'

class List
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
  end

  def ==(another_list)
    self.name == another_list.name
  end

  def self.all
    results = DB.exec("SELECT * FROM lists;")
    lists = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      lists << List.new({'name' => name, 'id' => id})
    end
    lists
  end

  def save
    results = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.delete(user_list)
    DB.exec("DELETE FROM lists WHERE name = '#{user_list}'")
  end

  def self.find_list_by_name(user_choice)
    list_id = DB.exec("SELECT * FROM lists WHERE name = '#{user_choice}';")
    name = list_id[0]['name']
    id = list_id[0]['id']
    found_list = List.new('name' => name, 'id' => id)

  end

end
