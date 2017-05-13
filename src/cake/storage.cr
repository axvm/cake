module Cake
  module Storage
    extend self
    @@tasks = Hash(String, Cake::Task).new
    @@desc = ""

    def []=(key : String, value : Cake::Task)
      @@tasks[key] = value
    end

    def []=(key : String, value : String)
      @@desc = value if key == "desc"
    end

    def [](key : String)
      if key == "desc"
        desc = @@desc.dup
        @@desc = ""
        return desc
      else
        return @@tasks[key]
      end
    rescue ex : KeyError
      raise Cake::Exceptions::TaskNotFound.new
    end

    def tasks
      @@tasks.values
    end
  end

  module DummyStorage
    def self.[]=(key, value); end
    def self.[](key : String)
      Cake::Task.new(name: "t", description: "d") do
        -> {}
      end
    end
    def self.tasks; [] of Task; end
  end
end
