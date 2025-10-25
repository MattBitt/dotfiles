function gss --wraps='git diff --shortstat' --description 'alias gss=git diff --shortstat'
  git diff --shortstat $argv
        
end
