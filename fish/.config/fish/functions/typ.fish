function typ --wraps='uv run mypy backend/' --description 'alias typ=uv run mypy backend/'
  uv run mypy backend/ $argv
        
end
