{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    # fira
    fira-code
    fira-mono
    fira-sans
    # icons
    font-awesome
    material-icons
    # math
    cm_unicode
    # nerd
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
  ];
}
