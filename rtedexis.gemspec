Gem::Specification.new do |s|
  s.name               = "rtedexis"
  s.version            = "0.0.1"
  s.default_executable = "rtedexis"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nerio Navea"]
  s.date = %q{2016-03-30}
  s.description = %q{A Ruby integration for Tedexis SMS delivery}
  s.email = %q{neriojose5@gmail.com}
  s.files = ["Rakefile", "lib/rtedexis.rb", "lib/rtedexis/soap.rb", "lib/rtedexis/sftp.rb", "bin/rtedexis"]
  s.test_files = ["test/rtedexis.rb"]
  s.homepage = %q{http://rubygems.org/gems/rtedexis}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{rtedexis}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

