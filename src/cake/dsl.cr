module Cake::DSL
  extend self

  def desc(message : String) : String
    storage["desc"] = message
    message
  end

  def desc() : String
    str = storage["desc"]
    str.is_a?(String) ? str : ""
  end

  def task(name : String | Symbol, &block : Proc(Nil))
    raise "Forbidden task name" if name.to_s == "desc"

    # FIXME: lost in data types
    description = desc
    if description.is_a? String
      cake_task = Cake::Task.new(name: name.to_s, description: description, &block)
      storage[name.to_s] = cake_task
    end
  end

  def invoke!(name : String | Symbol)
    storage[name.to_s].as(Cake::Task).run
  end

  # FIXME:
  # def invoke!(names_array : Array(String | Symbol))
  #   names_array.each do |task_name|
  #     invoke!(task_name)
  #   end
  # end
  #
  # def execute(cmd : String)
  # end
  #
  # def shell(cmd : String)
  # end

  def storage
    Cake.config.storage
  end
end
