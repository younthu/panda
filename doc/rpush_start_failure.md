# Error
`rpush start` throws

~~~sh
* Booting Rails 'development' environment... Traceback (most recent call last):
        16: from /Users/i532140/.rvm/gems/ruby-2.6.3/bin/ruby_executable_hooks:24:in `<main>'
        15: from /Users/i532140/.rvm/gems/ruby-2.6.3/bin/ruby_executable_hooks:24:in `eval'
        14: from /Users/i532140/.rvm/gems/ruby-2.6.3/bin/rpush:23:in `<main>'
        13: from /Users/i532140/.rvm/gems/ruby-2.6.3/bin/rpush:23:in `load'
        12: from /Users/i532140/.rvm/gems/ruby-2.6.3/gems/rpush-6.0.1/bin/rpush:4:in `<top (required)>'
        11: from /Users/i532140/.rvm/gems/ruby-2.6.3/gems/thor-1.1.0/lib/thor/base.rb:485:in `start'
        10: from /Users/i532140/.rvm/gems/ruby-2.6.3/gems/thor-1.1.0/lib/thor.rb:392:in `dispatch'
         9: from /Users/i532140/.rvm/gems/ruby-2.6.3/gems/thor-1.1.0/lib/thor/invocation.rb:127:in `invoke_command'
         8: from /Users/i532140/.rvm/gems/ruby-2.6.3/gems/thor-1.1.0/lib/thor/command.rb:27:in `run'
         7: from /Users/i532140/.rvm/gems/ruby-2.6.3/gems/rpush-6.0.1/lib/rpush/cli.rb:23:in `start'
         6: from /Users/i532140/.rvm/gems/ruby-2.6.3/gems/rpush-6.0.1/lib/rpush/cli.rb:106:in `config_setup'
         5: from /Users/i532140/.rvm/gems/ruby-2.6.3/gems/rpush-6.0.1/lib/rpush/cli.rb:110:in `configure_rpush'
         4: from /Users/i532140/.rvm/gems/ruby-2.6.3/gems/rpush-6.0.1/lib/rpush/cli.rb:118:in `load_rails_environment'
         3: from /Users/i532140/.rvm/gems/ruby-2.6.3/gems/activesupport-6.1.4.1/lib/active_support/dependencies.rb:326:in `load'
         2: from /Users/i532140/.rvm/gems/ruby-2.6.3/gems/activesupport-6.1.4.1/lib/active_support/dependencies.rb:299:in `load_dependency'
         1: from /Users/i532140/.rvm/gems/ruby-2.6.3/gems/activesupport-6.1.4.1/lib/active_support/dependencies.rb:326:in `block in load'
/Users/i532140/.rvm/gems/ruby-2.6.3/gems/activesupport-6.1.4.1/lib/active_support/dependencies.rb:326:in `load': cannot load such file -- config/environment.rb (LoadError)

~~~


To bo resolved.
