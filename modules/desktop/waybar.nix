# In your home.nix or a separate module file
{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    # Optional: enable systemd service to start it automatically
    # You might alternatively start it from your window manager's startup script (e.g., in Hyprland/Sway)
    systemd.enable = true;

    # Configure settings and style using Nix attributes
    settings = {
      # These are your typical Waybar config options, but in Nix syntax
      # The module translates this to the standard config.jsonc
      height = 30;
      layer = "top";
      position = "bottom";

      # Example modules
      modules-left = [ "sway/workspaces" ];
      modules-right = [ "pulseaudio" "clock" "tray" ];

      "pulseaudio" = {
        format = "{volume}% {icon}";
        format-muted = "";
        format-icons = {
          default = [ "" "" "" ];
        };
      };

      "clock" = {
        format = "{:%H:%M}";
        tooltip-format = "{:%Y-%m-%d | %H:%M}";
      };
      # Add more module configurations here...
    };

    # Configure styles using Nix (automatically translated to style.css)
    style = ''
      window#waybar {
        background: transparent;
        border-bottom: none;
        font-size: 14px;
      }
      /* Add more CSS styles here... */
    '';
  };
}

