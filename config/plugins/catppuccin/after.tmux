# The status modules are only defined once the plugin has run.
set -g status-position bottom
# tmux 3.7 draws prompts/messages on top of the status line and
# only clears it with a fill colour, which catppuccin doesn't set;
# without it the pills show through the prompt. Left-aligned so
# the prompt and its input stay together.
set -gF message-style 'fg=#{@thm_teal},bg=default,fill=terminal'
set -gF message-command-style 'fg=#{@thm_teal},bg=default,fill=terminal'
set -g status-left-length 100
set -g status-right-length 100
# Trailing space matches the gap between windows
# (window-status-separator).
set -g status-left '#{E:@catppuccin_status_session} '
set -g status-right '#{E:@catppuccin_status_date_time}'
