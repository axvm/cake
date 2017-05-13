require "./cake/*"
require "./cake/templates/task_list"
require "./cake/templates/run_task"

module Cake
  extend self
  include Cake::DSL

  def config
    Cake::Config
  end

  def process_cakefile(cakefile_path : String)
    import = [] of String; can_require = true
    code = [] of String

    File.read_lines(cakefile_path).each do |line|
      next if line.empty?
      if line.includes?(%(require ")) && can_require == true
        import << line
      else
        code << line
      end
    end

    # puts "Import: #{import} Code: #{code}"

    [ import, code ]
  end

  def eval_code(code : String, silent = false)
    output = IO::Memory.new
    status = Process.run(command: "crystal", args: ["eval", code], output: output, error: output)

    raise Cake::Exceptions::CrystalEvalFailed.new unless status.success?
    puts output unless silent
  end

  def task_list(path_to_cakefile : String)
    import_segment, code_segment = process_cakefile(path_to_cakefile)
    code = Cake::Templates::TaskList.new(Cake.config.src_path, import_segment, code_segment).to_s
    eval_code code
  end

  def run_task(path_to_cakefile : String, task_name : String)
    import_segment, code_segment = process_cakefile(path_to_cakefile)
    code = Cake::Templates::RunTask.new(Cake.config.src_path, task_name, import_segment, code_segment).to_s
    eval_code code
  end
end
