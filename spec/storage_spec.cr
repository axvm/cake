require "./spec_helper"

describe Cake::Storage do
  it "accepts value by key and return it" do
    val = Cake::Task.new("t", "d") do
      puts "hey from task!"
    end

    Cake::Storage["test"] = val
    Cake::Storage["test"].should eq(val)
  end

  it "should raise exception if task not defined" do
    val = Cake::Task.new("t", "d") do
      puts "hey from task!"
    end

    expect_raises Cake::Exceptions::TaskNotFound do
      Cake::Storage["error"]
    end

    Cake::Storage["error"] = val
    Cake::Storage["error"].should eq(val)
  end
end
