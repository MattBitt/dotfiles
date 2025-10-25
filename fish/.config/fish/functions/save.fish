function save --wraps=git\ add\ .\ \&\&\ git\ commit\ -m\ \'checkpoint\' --description alias\ save=git\ add\ .\ \&\&\ git\ commit\ -m\ \'checkpoint\'
  git add . && git commit -m 'checkpoint' $argv
        
end
