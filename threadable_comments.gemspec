require File.expand_path('../lib/threadable_comments/version', __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "threadable_comments"
  s.version     = ThreadableComments::VERSION
  s.authors     = ["Yves Riel"]
  s.email       = ["whyves@okapya.com"]
  s.homepage    = "https://github.com/Whyves/acts_as_commentable_with_threading"
  s.summary     = "Summary of ThreadableComments."
  s.description = "Description of ThreadableComments."
  s.license     = "MIT"

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec`.split("\n")

  s.add_development_dependency "rspec", ">= 3.4"
  s.add_development_dependency "sqlite3"

  s.add_dependency "rails", ">= 4.0"
  s.add_dependency 'ancestry', '>= 2.1'
end
