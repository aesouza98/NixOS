{ self, inputs, ... }:
{
  flake.nixosModules.niri =
    { pkgs, lib, ... }:
    {
      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
      };
    };
  perSystem =
    {
      system,
      pkgs,
      lib,
      self',
      ...
    }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;

        settings = {
          prefer-no-csd = true;
          hotkey-overlay.skip-at-startup = true;
          screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
          input = {
            keyboard = {
              xkb = {
                layout = "us";
                variant = "intl";
              };
              repeat-delay = 600;
              repeat-rate = 40;
            };
            mouse = {
              accel-speed = 0.5;
              accel-profile = "flat";
              scroll-method = "no-scroll";
            };
            focus-follows-mouse.max-scroll-amount = "0%";
          };

          outputs."DP-1" = {
            mode = "2560x1440@155.000";
            scale = 1.0;
            transform = "normal";
          };

          layout = {
            gaps = 8;
            center-focused-column = "never";
            preset-column-widths = [ { proportion = 0.5; } ];
            default-column-width = {
              proportion = 0.5;
            };

            focus-ring = {
              width = 2;
              active-color = "#7aa2f7";
              inactive-color = "#505050";
            };
            border = {
              off = true; # Equivalent to `off` in KDL
              width = 2;
              active-color = "#ffc87f";
              inactive-color = "#505050";
              urgent-color = "#9b0000";
            };
            shadow = {
              on = true;
              softness = 30;
              spread = 5;
              offset = {
                x = 0;
                y = 5;
              };
              color = "#0007";
            };
          };

          spawn-at-startup = [
            (lib.getExe pkgs.fcitx5)
            #(lib.getExe pkgs.swayosd)
            #(/usr/lib/pam_kwallet_init)
            (lib.getExe self'.packages.noctalia)
            "wl-clip-persist --clipboard regular --all-mime-type-regex ^(?!x-kde-passwordManagerHint).+"
          ];

          window-rules = [
            {
              matches = [ { title = "Picture.{0,1}in.{0,1}[Pp]icture"; } ];
              open-floating = true;
              open-focused = false;
              default-floating-position = {
                props = {
                  x = 16;
                  y = 16;
                  relative-to = "bottom-right";
                };
              };
            }
            {
              geometry-corner-radius = "20";
              clip-to-geometry = true;
            }
            {
              matches = [ { title = "LocalSend"; } ];
              open-floating = true;
            }
            {
              matches = [ { title = "Open File"; } ];
              open-floating = true;
            }
            {
              matches = [ { app-id = "^org\.gnome\.NautilusPreviewer$"; } ];
              open-floating = true;
            }
          ];

          layer-rules = [
            {
              matches = [ { namespace = "^noctalia-overview*"; } ];
              place-within-backdrop = true;
            }
          ];

          binds = {

            "Mod+Shift+Slash".action.show-hotkey-overlay = { };

            "Mod+Return" = {
              hotkey-overlay-title = "Terminal";
              action.spawn = [ (lib.getExe pkgs.ghostty) ];
            };
            "Mod+D" = {
              hotkey-overlay-title = "Application Launcher";
              action.spawn = [ (lib.getExe pkgs.fuzzel) ];
            };
            "Mod+B" = {
              hotkey-overlay-title = "Open Browser";
              action.spawn = [ (lib.getExe pkgs.brave) ];
            };

            # --- Applications --- #
            "Mod+E".action.spawn = [ (lib.getExe pkgs.nautilus) ];
            "Mod+O".action.spawn = [ (lib.getExe pkgs.obsidian) ];
            "Mod+M".action.spawn = [ (lib.getExe pkgs.spotify) ];

            # --- Noctalia Keybinds ---
            "Mod+Space".action.spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call launcher toggle";
            "Mod+Shift+A".action.spawn-sh =
              "${lib.getExe self'.packages.noctalia} ipc call controlCenter toggle";
            "Mod+Shift+Comma".action.spawn-sh =
              "${lib.getExe self'.packages.noctalia} ipc call settings toggle";
            "Mod+Escape" = {
              hotkey-overlay-title = "Power Menu";
              action.spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call sessionMenu toggle";
            };

            # --- Media Keys --- #
            "XF86AudioRaiseVolume" = {
              allow-when-locked = true;
              action.spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call volume increase";
            };
            "XF86AudioLowerVolume" = {
              allow-when-locked = true;
              action.spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call volume decrease";
            };

            "XF86AudioMute" = {
              allow-when-locked = true;
              action.spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call volume muteOutput";
            };

            "XF86MonBrightnessUp" = {
              allow-when-locked = true;
              action.spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call brightness increase";
            };

            "XF86MonBrightnessDown" = {
              allow-when-locked = true;
              action.spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call brightness decrease";
            };

            "XF86AudioNext" = {
              allow-when-locked = true;
              action.spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call media next";
            };

            "XF86AudioPause" = {
              allow-when-locked = true;
              action.spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call media playPause";
            };

            "XF86AudioPlay" = {
              allow-when-locked = true;
              action.spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call media playPause";
            };

            "XF86AudioPrev" = {
              allow-when-locked = true;
              action.spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call media previous";
            };

            # --- Window Management ---
            "Mod+W".action.close-window = null;
            "Mod+A".action.toggle-overview = null;

            # --- Focus Windows --- #
            "Mod+Left".action.focus-column-left = null;
            "Mod+Right".action.focus-column-right = null;
            "Mod+Up".action.focus-window-up = null;
            "Mod+Down".action.focus-window-down = null;
            "Mod+h".action.focus-column-left = null;
            "Mod+l".action.focus-column-right = null;
            "Mod+k".action.focus-window-up = null;
            "Mod+j".action.focus-window-down = null;
            "Mod+Home".action.focus-column.first = null;
            "Mod+End".action.focus-column.first = null;

            # --- Move Windows --- #
            "Mod+Ctrl+Left".action.move-column-left = null;
            "Mod+Ctrl+Right".action.move-column-right = null;
            "Mod+Ctrl+Up".action.move-window-up = null;
            "Mod+Ctrl+Down".action.move-window-down = null;
            "Mod+Ctrl+h".action.move-column-left = null;
            "Mod+Ctrl+l".action.move-column-right = null;
            "Mod+Ctrl+k".action.move-window-up = null;
            "Mod+Ctrl+j".action.move-window-down = null;
            "Mod+Ctrl+Home".action.move-column-to-first = null;
            "Mod+Ctrl+End".action.move-column-to-last = null;

            # --- Focus Monitor --- #
            "Mod+Shift+Left".action.focus-monitor-left = null;
            "Mod+Shift+Down".action.focus-monitor-down = null;
            "Mod+Shift+Up".action.focus-monitor-up = null;
            "Mod+Shift+Right".action.focus-monitor-right = null;
            "Mod+Shift+H".action.focus-monitor-left = null;
            "Mod+Shift+J".action.focus-monitor-down = null;
            "Mod+Shift+K".action.focus-monitor-up = null;
            "Mod+Shift+L".action.focus-monitor-right = null;

            # --- Move Column to Monitor --- #
            "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = null;
            "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = null;
            "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = null;
            "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = null;
            "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = null;
            "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = null;
            "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = null;
            "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = null;

            # --- Focus Workspace --- #
            "Mod+Page_Down".action.focus-workspace-down = null;
            "Mod+Page_Up".action.focus-workspace-up = null;
            "Mod+U".action.focus-workspace-down = null;
            "Mod+I".action.focus-workspace-up = null;
            "Mod+1".action.focus-workspace = 1;
            "Mod+2".action.focus-workspace = 2;
            "Mod+3".action.focus-workspace = 3;
            "Mod+4".action.focus-workspace = 4;
            "Mod+5".action.focus-workspace = 5;
            "Mod+6".action.focus-workspace = 6;
            "Mod+7".action.focus-workspace = 7;
            "Mod+8".action.focus-workspace = 8;
            "Mod+9".action.focus-workspace = 9;

            # --- Move Column to Workspace --- #
            "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = null;
            "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = null;
            "Mod+Ctrl+U".action.move-column-to-workspace-down = null;
            "Mod+Ctrl+I".action.move-column-to-workspace-up = null;
            "Mod+Ctrl+1".action.move-column-to-workspace = 1;
            "Mod+Ctrl+2".action.move-column-to-workspace = 2;
            "Mod+Ctrl+3".action.move-column-to-workspace = 3;
            "Mod+Ctrl+4".action.move-column-to-workspace = 4;
            "Mod+Ctrl+5".action.move-column-to-workspace = 5;
            "Mod+Ctrl+6".action.move-column-to-workspace = 6;
            "Mod+Ctrl+7".action.move-column-to-workspace = 7;
            "Mod+Ctrl+8".action.move-column-to-workspace = 8;
            "Mod+Ctrl+9".action.move-column-to-workspace = 9;

            # --- Move Workspace --- #
            "Mod+Shift+Page_Down".action.move-workspace-down = null;
            "Mod+Shift+Page_Up".action.move-workspace-up = null;
            "Mod+Shift+U".action.move-workspace-down = null;
            "Mod+Shift+I".action.move-workspace-up = null;

            # --- Mouse Control --- #
            "Mod+WheelScrollLeft".action.focus-column-left = null;
            "Mod+WheelScrollDown".action.focus-workspace-down = null;
            "Mod+WheelScrollUp".action.focus-workspace-up = null;
            "Mod+WheelScrollRight".action.focus-column-right = null;

            "Mod+Ctrl+WheelScrollLeft".action.move-column-left = null;
            "Mod+Ctrl+WheelScrollDown".action.move-column-to-workspace-down = null;
            "Mod+Ctrl+WheelScrollUp".action.move-column-to-workspace-up = null;
            "Mod+Ctrl+WheelScrollRight".action.move-column-right = null;

            "Mod+Shift+WheelScrollUp".action.focus-column-left = null;
            "Mod+Shift+WheelScrollRight".action.focus-column-right = null;
            "Mod+Shift+Ctrl+WheelScrollDown".action.move-column-right = null;
            "Mod+Shift+Ctrl+WheelScrollUp".action.move-column-left = null;

            # --- Layouts --- #
            "Mod+Q".action.toggle-column-tabbed-display = null;
            "Mod+V".action.toggle-window-floating = null;
            "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = null;
            "Mod+Minus".action.set-column-width = "-10%";
            "Mod+Equal".action.set-column-width = "+10%";
            "Mod+Shift+Minus".action.set-window-height = "-10%";
            "Mod+Shift+Equal".action.set-window-height = "+10%";
            "Mod+Ctrl+C".action.center-visible-columns = null;
            "Mod+C".action.center-column = null;
            "Mod+BracketLeft".action.consume-or-expel-window-left = null;
            "Mod+BracketRight".action.consume-or-expel-window-right = null;
            "Mod+Comma".action.consume-window-into-column = null;
            "Mod+Period".action.expel-window-from-column = null;
            "Mod+R".action.switch-preset-column-width = null;
            "Mod+Shift+R".action.switch-preset-window-height = null;
            "Mod+Ctrl+R".action.reset-window-height = null;
            "Mod+F".action.maximize-column = null;
            "Mod+Shift+F".action.fullscreen-window = null;
            "Mod+Ctrl+F".action.expand-column-to-available-width = null;

            # --- Screenshot --- #
            "Print".action.screenshot = null;
            "Mod+Shift+S".action.screenshot = null;
            "Ctrl+Print".action.screenshot-screen = null;
            "Alt+Print".action.screenshot-window = null;

            # --- Niri Controls --- #
            "Mod+Shift+E".action.quit = null;
            "Ctrl+Alt+Delete".action.quit = { };
            "Mod+Shift+P".action.power-off-monitors = null;
          };
        };
      };
    };
}
