# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('lib', __dir__)

require 'timesheet_reader/version'
require 'English'

Gem::Specification.new do |s|
  s.name = 'timesheet-reader'
  s.version = TimesheetReader::Version::VERSION
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.6.0'
  s.authors = ['Diego Leal']
  s.description = <<-DESCRIPTION
    A timesheet reader.
  DESCRIPTION

  s.email = 'leal.banks@gmail.com'
  s.files = `git ls-files bin lib LICENSE README.md \
             spec`
            .split($RS)
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.extra_rdoc_files = ['LICENSE', 'README.md']
  s.homepage = 'https://github.com/diego-leal/timesheet-reader'
  s.licenses = ['MIT']
  s.summary = 'A timesheet reader.'

  if s.respond_to?(:metadata=)
    s.metadata = {
      'homepage_uri' => 'https://github.com/diego-leal/timesheet-reader/blob/master/README.md',
      'changelog_uri' => 'https://github.com/diego-leal/timesheet-reader/blob/master/CHANGELOG.md',
      'source_code_uri' => 'https://github.com/diego-leal/timesheet-reader/',
      'documentation_uri' => 'https://github.com/diego-leal/timesheet-reader/',
      'bug_tracker_uri' => 'https://github.com/diego-leal/timesheet-reader/issues'
    }
  end

  s.add_development_dependency('rubocop-rspec', '~> 1.3.6', '>= 1.3.6')
end
