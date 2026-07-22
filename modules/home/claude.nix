{ currentPi, ... }: {
  programs.claude-code = {
    enable = !currentPi;
  };
}
