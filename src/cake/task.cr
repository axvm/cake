module Cake
  struct Task
    def initialize(@name : String, @description : String, &block : Proc(Nil))
      @proc = block
    end

    def name : String
      @name
    end

    def description : String
      @description
    end

    def run
      @proc.call
    end
  end
end
