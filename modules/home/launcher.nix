_:
let
  text = "ffffffff";
  counter = "0000ffff";
  selected = "0000ff7f";
  matched = "00ff00ff";
  translucent = "0000007f";
in
{
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        font = "Fira Mono:size=14";
        message = "launch";
        hide-before-typing = "yes";
        match-mode = "fzf";
        match-counter = "yes";
        width = 80;
        lines = 15;
        tabs = 4;
      };
      colors = {
        background = translucent;
        selection = selected;
        match = matched;
        selection-match = matched;

        inherit text;

        message = text;
        prompt = text;
        placeholder = text;
        input = text;
        selection-text = text;

        inherit counter;

        border = text;
      };
      border = {
        width = 4;
        radius = 10;
      };
    };
  };
}
