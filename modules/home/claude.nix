{ currentPi, ... }:
if currentPi then
  { }
else
  {
    programs.claude-code = {
      enable = true;
    };
  }
