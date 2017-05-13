require "ecr"

class Cake::Templates::TaskList
  def initialize(@src_path : String, @import_segment : Array(String), @code_segment : Array(String))
  end

  ECR.def_to_s "src/cake/templates/task_list.ecr"
end
