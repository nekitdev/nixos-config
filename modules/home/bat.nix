{ pkgs, ... }: {
  programs.bat = {
    enable = true;

    config = {
      pager = "less --quit-if-one-screen";
      style = "full";
      theme = "OneDark";
    };

    extraPackages = with pkgs.bat-extras; [
      batdiff
      batgrep
      batman
      batpipe
    ];
  };
}
