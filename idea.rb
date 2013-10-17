require 'yaml/store'

class Idea
  attr_reader :title, :description

  def self.all
    raw_ideas.map do |data|
      new(data)
    end
  end

  def self.raw_ideas
    database.transaction do |db|
      db['ideas'] || []
    end
  end

  def self.database
    @database ||= YAML::Store.new "ideabox"
  end

  def self.delete(position)
    database.transaction do
      database['ideas'].delete_at(position)
    end
  end

  def self.find(id)
    raw_idea = find_raw_idea(id)
    new(raw_idea)
  end

  def self.find_raw_idea(id)
    database.transaction do
      database['ideas'].at(id)
    end
  end

  def self.update(id, data)
    database.transaction do
      database['ideas'][id] = data
    end
  end

  def initialize(attributes = {})
    @title = attributes["title"]
    @description = attributes["description"]
  end

  def database
    Idea.database
  end

  def save
    database.transaction do |db|
      db['ideas'] ||= []
      db['ideas'] << {"title" => title, "description" => description}
    end
  end

end
