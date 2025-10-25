function gc --wraps=git\ commit\ -m\ \'asdf...\' --description alias\ gc=git\ commit\ -m\ \'asdf...\'
  git commit -m 'asdf...' $argv
        
end
