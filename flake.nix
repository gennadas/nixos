{
  inputs = {
    nixpgks.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11"; # Add this
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixpkgs-stable, nixos-hardware, home-manager, ... } @inputs: {
    nixosConfigurations = {
      "g" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit nixpkgs-stable; };
        modules = [
          ./hardware-configuration.nix
          #nixos-hardware.nixosModules.microsoft-surface-pro-intel
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              users.g = { pkgs, ...}: {
                home = {
                  username = "g";
                  homeDirectory = "/home/g";
                  stateVersion = "24.11";
                  packages = with pkgs; [
                    neovim
                    codeblocks
                    obsidian
                    brightnessctl
                    vscode
                    rofi
                    wofi
                    prismlauncher
                    fastfetch
                    telegram-desktop
                    blueman
                    gcc
                    gdb
                    clang-tools
                    nemo
                    qbittorrent
                    vlc
                    brave
                    ripgrep
                    fd
                    lazygit
                    fzf
                    grim
                    (python3.withPackages (python-pkgs: [
                      python-pkgs.pandas
                      python-pkgs.numpy
                      python-pkgs.matplotlib
                    ]))
                    lua
                    luajitPackages.luarocks
                    discord
                    #dissent
                    #webcord
                    #webcord-vencord
                  ];
                };
                home.pointerCursor = {
                  name = "Adwaita";
                  package = pkgs.adwaita-icon-theme;
                  size = 24;
                  x11 = {
                    enable = true;
                    defaultCursor = "Adwaita";
                  };
                  sway.enable = true;
                };
                programs.home-manager.enable = true;
                programs.vim = {
                  enable = true;
                  extraConfig = ''
                    colorscheme desert
                    set cin aw ai is ts=2 sw=2 tm=50 nu noeb ru cul nowrap so=10
                    set listchars=tab:>·,trail:~,extends:>,precedes:<,space:·,nbsp:!
                    sy on
                    highlight SpecialKey ctermfg=grey guifg=grey
                  '';
                };
                programs.obs-studio = {
                  enable = true;
                  plugins = with pkgs.obs-studio-plugins; [
                    wlrobs
                    obs-backgroundremoval
                    obs-pipewire-audio-capture
                    obs-vaapi
                    obs-gstreamer
                    obs-vkcapture
                  ];
                };
                /*
                wayland.windowManager.sway = {
                  enable = true;
                  wrapperFeatures.gtk = true;
                  config = rec {
                    modifier = "Mod4";
                    terminal = "kitty";
                    startup = [
                      {command = "kitty";}
                    ];
                    input = {
                      "*".xkb_layout = "us,ru";
                      "*".xkb_options = "grp:win_space_toggle";
                      "type:touchpad" = {
                        natural_scroll = "enabled";
                        tap = "enabled";
                        click_method = "clickfinger";
                        dwt = "disabled";
                      };
                    };
                  };
                };
                */
              };
            };
          }
          ({ config, pkgs, nixpkgs-stable, ... }: {
            _module.args.pkgs-stable = import nixpkgs-stable {
              inherit (pkgs) system;
              config.allowUnfree = true;
            };
            networking.hostName = "surface";
            networking.networkmanager.enable = true;
            boot.loader.systemd-boot.enable = true;
            boot.loader.efi.canTouchEfiVariables = true;
            i18n.defaultLocale = "C.UTF-8";

            users.users.g = {
              isNormalUser = true;
              description = "g";
              extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
              initialPassword = "j";
            };
            programs.virt-manager.enable = true;
            virtualisation.libvirtd.enable = true;
            virtualisation.spiceUSBRedirection.enable = true;
            programs = {
              /*
              sway = {
                enable = true;
                wrapperFeatures.gtk = true;
              };
              */
              hyprland = {
                enable = true;
              };

              dconf.profiles.user.databases = [{
                #https://discourse.nixos.org/t/help-setting-some-boring-dark-theme/61891/4
                settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
              }];
              firefox.enable = true;
              amnezia-vpn.enable = true;
              steam.enable = true;
            };
            environment.systemPackages = [
              config._module.args.pkgs-stable.webcord
              config._module.args.pkgs-stable.webcord-vencord
              config._module.args.pkgs-stable.vesktop
              pkgs.vim
              pkgs.git
              pkgs.curl
              pkgs.wget
              pkgs.foot
              pkgs.swaylock
              pkgs.swayidle
              pkgs.wl-clipboard
              pkgs.mako
              pkgs.alacritty
              pkgs.kitty
              pkgs.zapret
              pkgs.wireguard-go
              pkgs.wireguard-tools
              pkgs.v4l-utils #https://www.reddit.com/r/NixOS/comments/1bono0c/obs_virtual_camera/
            ];
            environment.sessionVariables = {
              #https://discourse.nixos.org/t/help-setting-some-boring-dark-theme/61891/4
              GTK_THEME = "Adwaita:dark";
              QT_QPA_PLATFORMTHEME = "qt6ct";
            };
            xdg.portal = {
              enable = true;
              wlr.enable = true;
              extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland ];
              config.common.default = "*";
            };
            #https://www.reddit.com/r/NixOS/comments/1bono0c/obs_virtual_camera/
            boot.extraModulePackages = [
              config.boot.kernelPackages.v4l2loopback
            ];
            boot.kernelModules = [ "v4l2loopback" ];
            boot.extraModprobeConfig = ''
              options v4l2loopback devices=1 video_nr=1 card_label="OBS" exclusive_caps=1
            '';
            security.polkit.enable = true;
            security.rtkit.enable = true;
            hardware.graphics.enable = true;
            hardware.opentabletdriver.enable = true;
            #hardware.microsoft-surface.kernelVersion = "stable"; #https://github.com/NixOS/nixos-hardware/issues/1600
            fonts.enableDefaultPackages = true;
            services.pipewire = {
              enable = true;
              wireplumber.enable = true;
              alsa.enable = true;
              pulse.enable = true;
            };
            services.zapret = {
              enable = true;
              udpSupport = true;
              udpPorts = [ "443" "19294:19344" "50000:50100" ];
              params = [
                "--filter-udp=443 --hostlist=/opt/zapret/ipset/zapret-hosts-user.txt --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic=/opt/zapret/files/fake/quic_initial_www_google_com.bin --new"
                "--filter-udp=19294-19344,50000-50100 --filter-l7=discord,stun --dpi-desync=fake --dpi-desync-repeats=6 --new"
                "--filter-tcp=80 --hostlist=/opt/zapret/ipset/zapret-hosts-user.txt --dpi-desync=fake,multisplit --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new"
                "--filter-tcp=2053,2083,2087,2096,8443 --hostlist-domains=discord.media --dpi-desync=fake,fakedsplit --dpi-desync-repeats=6 --dpi-desync-fooling=ts --dpi-desync-fakedsplit-pattern=0x00 --dpi-desync-fake-tls=/opt/zapret/files/fake/tls_clienthello_www_google_com.bin --new"
                "--filter-tcp=443 --hostlist=/opt/zapret/ipset/zapret-hosts-user.txt --dpi-desync=fake,fakedsplit --dpi-desync-repeats=6 --dpi-desync-fooling=ts --dpi-desync-fakedsplit-pattern=0x00 --dpi-desync-fake-tls=/opt/zapret/files/fake/tls_clienthello_www_google_com.bin"
              ];
            };
            #services.zapret = {
            #  enable = true;
            #  udpSupport = true;
            #  udpPorts = [ "50000:50099" ];
            #  params = [
            #    "--dpi-desync=multidisorder --dpi-desync-split-pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1"
            #  ];
            #};
            nixpkgs.config.allowUnfree = true;
            nix.settings.experimental-features = [ "nix-command" "flakes" ];
            system.stateVersion = "24.11";
          })
        ];
      };
    };
  };
}



