module Cake::Exceptions
  class TaskNotFound < Exception
    def initialize(message = "Task not defined")
      super
    end
  end

  class CakefileNotFound < Exception
    def initialize(message = "Cakefile not found")
      super
    end
  end

  class CrystalEvalFailed < Exception
    def initialize(message = "Crystal-lang compiler not found")
      super
    end
  end
end
