# --- docker group activation (kratos / OpenSSH 10) ---
# Mirror of ~/.bashrc: an old tmux server or an SSH login can come up without
# the docker supplementary group, leaving /var/run/docker.sock unreachable. If
# we're a docker member in the group DB but it isn't active in this shell,
# re-exec fish under the docker group. _DGRP guards against a re-exec loop, and
# it skips cleanly when `sg` is missing or we aren't really a member.
if status is-interactive; and not set -q _DGRP; and type -q sg
    and not id -nG | grep -qw docker
    and id -nG (id -un) 2>/dev/null | grep -qw docker
    set -gx _DGRP 1
    exec sg docker -c "exec fish"
end

export PATH="$HOME/.local/bin:$PATH"
fnm env --use-on-cd | source

# --- Auto-attach to tmux for interactive terminals ---
# Guards: only interactive shells (skips Claude/script shells), never nest
# inside an existing tmux, and stay out of the way over SSH.
if status is-interactive; and not set -q TMUX; and not set -q SSH_CONNECTION
    tmux attach -t main 2>/dev/null; or tmux new -s main
end
