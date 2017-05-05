function __wrap_bundle_exec_binaries --on-variable implicit_bundle_exec_binaries
  for e in $implicit_bundle_exec_binaries
    function $e --inherit-variable e
      if file_exists_in_tree Gemfile
        command bundle exec $e $argv
      else
        eval command $e $argv
      end
    end
  end
end

set -g implicit_bundle_exec_binaries rails guard rackup spec

