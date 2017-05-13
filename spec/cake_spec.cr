require "./spec_helper"
macro responds_to_methods(array)
  {% for method in array %}
    Cake.responds_to?({{method}}).should be_true
  {% end %}
end

describe Cake do
  it "has DSL methods" do
    responds_to_methods [ :task, :invoke! ]
  end
end
