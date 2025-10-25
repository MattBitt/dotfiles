if status is-interactive
    # Commands to run in interactive sessions can go here
    function git
        set project_root /home/matt/programming/hmtc
        set frontend_dir $project_root/frontend

        # If current directory is frontend or any subdirectory of frontend
        if string match -q "$frontend_dir*" (pwd)
            echo "Don't run git in frontend/. Redirecting to project root..."
            pushd $project_root > /dev/null
            command git $argv
            popd > /dev/null
            return $status
        end
        command git $argv
   end
end
export PATH="$HOME/bin:$PATH"
alias run="./run"

alias claude="/home/matt/.claude/local/claude"
