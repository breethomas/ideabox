class Idea
  include Comparable
  attr_reader :title, :description, :rank, :id

  def initialize(attributes = {})
    @title = attributes["title"]
    @description = attributes["description"]
    @rank = attributes["rank"] || 0
    @id = attributes["id"]
  end

  def <=>(other)
    other.rank <=> rank
  end

  def like!
    @rank += 1
  end

  def save
    IdeaStore.create(to_h)
  end

  def to_h
    {
      "title" => title,
      "description" => description,
      "rank" => rank
    }
  end

#  def database
#    Idea.database
#  end
#
#  def save
#    database.transaction do |db|
#      db['ideas'] ||= []
#      db['ideas'] << {"title" => title, "description" => description}
#    end
#  end

end
