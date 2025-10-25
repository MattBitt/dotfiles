function howmanylines --wraps='cloc --by-file --include-ext=py,vue ~/programming/hmtc/hmtc | head -n 20' --description 'alias howmanylines=cloc --by-file --include-ext=py,vue ~/programming/hmtc/hmtc | head -n 20'
  cloc --by-file --include-ext=py,vue ~/programming/hmtc/hmtc | head -n 20 $argv
        
end
