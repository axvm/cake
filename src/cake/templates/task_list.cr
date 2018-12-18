require "ecr"

class Cake::Templates::TaskList
  def initialize(@src_path : String, @import_segment : Array(String), @code_segment : Array(String))
  end

  ECR.def_to_s "#{__DIR__}/task_list.ecr"
end
