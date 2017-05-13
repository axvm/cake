module Cake
  module Config
    extend self
    # property storage = Cake::Storage || Cake::DummyStorage
    @@storage = Cake::Storage || Cake::DummyStorage

    def storage
      @@storage
    end

    def storage=(v)
      @@storage = v
    end

    def lib_path
      ENV["CAKEROOT"]? || File.expand_path("../../..", __FILE__)
    end

    def src_path
      File.expand_path("src", lib_path)
    end
  end
end
