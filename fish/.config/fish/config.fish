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
#
# `new-session -A` attaches to `main`, or creates it if it's gone — one command
# instead of attach-then-fall-back, so a real attach error can't be swallowed
# into a surprise second session.
#
# `and exec true` is what closes the terminal window. Detaching makes the tmux
# client exit 0, so the `and` fires and fish replaces itself with `true`, which
# exits immediately — Konsole has nothing left to host and closes.
#
# Two things this is deliberately NOT:
#   - plain `and exit`: a bare `exit` in config.fish is ignored while fish is
#     still sourcing config, so the window would stay open. Verified on 4.2.1.
#   - `exec tmux ...`: also closes the window, but if tmux ever fails to start
#     (bad tmux.conf, dead server) it takes the shell with it and the terminal
#     just flashes and vanishes. Running tmux as a child and gating the exec on
#     its exit status keeps a prompt around to debug from.
if status is-interactive; and not set -q TMUX; and not set -q SSH_CONNECTION
    tmux new-session -A -s main; and exec true
end
