_: {
  programs.eza = {
    enable = true;

    enableFishIntegration = true;

    git = true;

    colors = "auto";
    icons = "auto";

    extraOptions = [
      "--group-directories-first"
      "--header"
      "--git-ignore"
      "--hyperlink=auto"
    ];
  };
}
