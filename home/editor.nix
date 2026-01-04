{ pkgs, lib, ... }:

{
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
}
