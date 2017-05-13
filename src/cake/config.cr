module Cake
  module Config
    extend self
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

    def crystal_path
      ENV["CRYSTALROOT"]? || File.expand_path("../", Process.find_executable("crystal"))
    end

    def crystal_binary_path
      File.join(crystal_path, "/crystal")
    end
  end
end
