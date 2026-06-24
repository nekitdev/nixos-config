_: {
  programs.helix = {
    enable = true;

    settings = {
      theme = "onedark";

      editor = {
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };

        auto-save = {
          focus-lost = true;
        };
      };
    };

    languages = {
      language = [
        {
          name = "typst";
          file-types = [ "typ" ];
          language-servers = [ "tinymist" ];
        }
        {
          name = "nix";
          file-types = [ "nix" ];
          language-servers = [ "nixd" ];
        }
      ];
    };
  };
}
