export PATH="$HOME/.local/bin:$PATH"
fnm env --use-on-cd | source

# --- Auto-attach to tmux for interactive terminals ---
# Guards: only interactive shells (skips Claude/script shells), never nest
# inside an existing tmux, and stay out of the way over SSH.
if status is-interactive; and not set -q TMUX; and not set -q SSH_CONNECTION
    tmux attach -t main 2>/dev/null; or tmux new -s main
end
