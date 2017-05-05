function __file_exists_in_tree
  set -l file $argv[1]
  set -l path ./

  while true
    if test -e (string join "" $path $file)
      return 0
    end
    if test (realpath $path) = "/"
      return 1
    end
    set -l path (string join "" ../ $path)
  end
  return 1
end

function __wrap_bundle_exec_binaries --on-variable implicit_bundle_exec_binaries
  for e in $implicit_bundle_exec_binaries
    function $e --inherit-variable e
      if __file_exists_in_tree Gemfile
        command bundle exec $e $argv
      else
        eval command $e $argv
      end
    end
  end
end

set -g implicit_bundle_exec_binaries rails guard rackup spec

