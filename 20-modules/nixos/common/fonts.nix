{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.droid-sans-mono
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.hack
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
    nerd-fonts.zed-mono
    nerd-fonts.caskaydia-cove
    nerd-fonts.caskaydia-mono
    noto-fonts # most world scripts + symbols
    noto-fonts-cjk-sans # Chinese / Japanese / Korean
    noto-fonts-color-emoji # emoji
    unifont # last-resort fallback, covers almost everything
  ];
}
