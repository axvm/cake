require "./spec_helper"

describe Cake::DSL do
  Spec.before_each do
    Cake.config.storage = Cake::DummyStorage
  end

  Spec.after_each do
    Cake.config.storage = Cake::Storage
  end

  it "should accept symbols in invoke" do
    Cake::DSL.invoke! :test
  end

  it "should accept string in invoke" do
    Cake::DSL.invoke! "test"
  end

  it "should accept string in task" do
    Cake::DSL.task "test" do; end
  end

  it "should accept symbols in task" do
    Cake::DSL.task :test do; end
  end
end
