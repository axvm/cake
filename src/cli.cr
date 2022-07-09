require "option_parser"
require "colorize"
require "./cake"

show_all = false

OptionParser.parse do |parser|
  parser.banner = <<-BANNER
    #{"Usage:".colorize.white}
      cake task_name
      cake -T

    #{"Cake".colorize.light_cyan} - powerful Make-like utility tool for Crystal-lang.
           #{"Developed by Alexander Marchenko (axvmindaweb@gmail.com)".colorize.dark_gray}

    #{"Options:".colorize.white}
  BANNER
  parser.on("-T", "--tasks", "Show all tasks") { show_all = true }
  parser.on("-D", "--debug", "Enable debug info") { Cake.config.debug = true}

  parser.on("-h", "--help", "This info") do
    puts parser
    exit 0
  end

  parser.on("-v", "--version", "Show version") do
    puts Cake::VERSION
    exit 0
  end
end

unless Process.run(command: "crystal", args: ["eval", "puts", "1+1"]).success?
  begin
    raise Cake::Exceptions::CrystalEvalFailed.new
  rescue ex
    puts "ERROR:".colorize(:white).on_red.to_s + " #{ex.message}\n\n";
    exit(9)
  end
end

cakefile_file = File.join(Dir.current, "Cakefile")

unless File.file?(cakefile_file)
  puts "ERROR:".colorize.white.on_red.to_s + " Can't find Cakefile in the current directory.\n\n";
  exit(1)
end

unless File.readable?(cakefile_file)
  puts "ERROR:".colorize.white.on_red.to_s + " Not enought privileges to read the Cakefile.\n\n"
  exit(2)
end

puts "Cake debug mode ENABLED" if Cake.config.debug
if show_all
  Cake.task_list(cakefile_file)
else
  task_name = "default"
  task_name = ARGV.first.gsub(":","") unless ARGV.empty?

  Cake.run_task(cakefile_file, task_name)
end
