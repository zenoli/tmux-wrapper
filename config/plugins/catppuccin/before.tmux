set -g @catppuccin_flavor 'mocha'
# Transparent bar; pills keep their own colours.
set -g @catppuccin_status_background 'none'
# Status modules default to a square right edge (a plain space);
# round it off to match the left cap.
set -g @catppuccin_status_right_separator ""
# Otherwise the cap keeps the pill's own background and vanishes.
set -g @catppuccin_status_connect_separator 'no'
# catppuccin's 'rounded' style draws its caps as
# fg=<status bg>,reverse, which only works on a solid bar (tmux
# rejects fg=none, and reversing the terminal default paints the
# terminal's foreground). The documented 'custom' style with the
# cap in the pill's colour on the default background works.
set -g @catppuccin_window_status_style 'custom'
set -g @catppuccin_window_left_separator "#[fg=#{E:@catppuccin_window_text_color},bg=default]"
set -g @catppuccin_window_middle_separator ' '
set -g @catppuccin_window_right_separator "#[fg=#{E:@catppuccin_window_number_color},bg=default]"
set -g @catppuccin_window_current_left_separator "#[fg=#{E:@catppuccin_window_current_text_color},bg=default]"
set -g @catppuccin_window_current_right_separator "#[fg=#{E:@catppuccin_window_current_number_color},bg=default]"
set -g @catppuccin_window_number_position 'right'
# Darkest palette colour for unfocused window names, so the
# focused one (surface_1) stands out.
set -g @catppuccin_window_text_color '#{@thm_crust}'
set -g @catppuccin_window_text ' #W'
set -g @catppuccin_window_current_text ' #W#{?window_zoomed_flag, (󰁌),}'
set -g @catppuccin_date_time_text ' %H:%M'

