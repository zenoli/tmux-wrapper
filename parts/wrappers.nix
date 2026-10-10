{ ... }:
{
  flake.wrappers.tmux =
    { pkgs, wlib, ... }:
    {
      imports = [ wlib.wrapperModules.tmux ];

      terminal = "tmux-256color";
      escapeTime = 0;
      statusKeys = "vi";
      modeKeys = "vi";
      # Keep the home-manager module's behaviour where the wrapper's defaults
      # differ.
      clock24 = true;
      disableConfirmationPrompt = false;
      secureSocket = true;
      plugins = [
        {
          plugin = pkgs.tmuxPlugins.catppuccin;
          configBefore = ''
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
          '';
          # The status modules are only defined once the plugin has run.
          configAfter = ''
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
          '';
        }
      ];

      configAfter = ''
        # Split windows
        bind-key h split-window -c "#{pane_current_path}"
        bind-key v split-window -h -c "#{pane_current_path}"
        bind-key H split-window -f -c "#{pane_current_path}"
        bind-key V split-window -f -h -c "#{pane_current_path}"

        # Select pre-defined windows
        bind-key -T prefix e switch-client -T window-selector
        bind-key -T window-selector w select-window -t "vimwiki"
        bind-key -T window-selector d select-window -t "dotfiles"

        bind-key S set -w synchronize-panes
        bind-key q display-panes -d 5000

        bind-key = select-layout even-horizontal

        # Resize panes
        bind-key -n C-Down resize-pane -D 5
        bind-key -n C-Up resize-pane -U 5
        bind-key -n C-Left resize-pane -L 5
        bind-key -n C-Right resize-pane -R 5

        # Shift + Alt to switch windows or sessions
        bind-key -n M-H previous-window
        bind-key -n M-L next-window
        bind-key -n M-N switch-client -n
        bind-key -n M-P switch-client -p

        # Swap windows
        bind-key -r "<" swap-window -d -t -1
        bind-key -r ">" swap-window -d -t +1
      '';
    };
}
