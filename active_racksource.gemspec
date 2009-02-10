# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{active_racksource}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["remi"]
  s.date = %q{2009-02-09}
  s.description = %q{Rack backend for ActiveResource for testing RESTful Rack APIs}
  s.email = %q{remi@remitaylor.com}
  s.files = ["Rakefile", "VERSION.yml", "README.markdown", "LICENSE", "lib/active_racksource.rb", "lib/active_racksource", "lib/active_racksource/http.rb", "lib/active_racksource/active_racksource.rb", "lib/active_racksource/base.rb", "lib/active_racksource/connection.rb", "lib/active_racksource/response.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/openrain/active_racksource}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Rack backend for ActiveResource for testing RESTful Rack APIs}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<remi-rackbox>, [">= 0"])
    else
      s.add_dependency(%q<remi-rackbox>, [">= 0"])
    end
  else
    s.add_dependency(%q<remi-rackbox>, [">= 0"])
  end
end
