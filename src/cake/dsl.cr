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

  def log(message : String, status = 0)
    puts "#{">> ".colorize(status == 0 ? :light_cyan : :light_red)} #{message}"
  end

  def execute(cmd : String, args = [] of String, announce = "", success = "", error = "", output = "always")
    cmd = cmd.split(" ")
    args = cmd[1..cmd.size-1]
    cmd = cmd[0]

    log(announce) unless announce == ""

    io = IO::Memory.new
    status = Process.run(command: cmd, args: args, output: io, error: io)

    unless io.empty? || io.to_s == "" || io.to_s == "\n"
      if io.to_s.ends_with? "\n"
        io = IO::Memory.new io.to_s.chomp
      end

      case output
      when "never"
        nil
      when "success"
        puts io if status.success?
      when "error"
        puts io unless status.success?
      else
        puts io
      end
    end

    if status.success?
      log(success, 0) unless success == ""
    else
      log(error, 1) unless error == ""
    end
  end

  # FIXME:
  # def invoke!(names_array : Array(String | Symbol))
  #   names_array.each do |task_name|
  #     invoke!(task_name)
  #   end
  # end

  def storage
    Cake.config.storage
  end
end
