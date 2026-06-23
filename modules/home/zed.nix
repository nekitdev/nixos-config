_: {
  programs.zed-editor = {
    enable = true;

    extensions = [
      "nix"
      "csharp"
      "toml"
      "typst"
      "emmet"
      "html"
      "xml"
      "vue"
      "typos"
      "pest"
      "capnp"
      "git-firefly"
      "make"
      "just"
      "dockerfile"
      "colored-zed-icons-theme"
    ];

    userSettings = {
      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      autosave = "on_focus_change";

      buffer_font_size = 16;
      buffer_font_family = "Fira Mono";
      buffer_font_weight = 500; # medium

      close_on_file_delete = true;

      features.edit_prediction_provider = "copilot";

      theme = {
        mode = "system";
        light = "One Light";
        dark = "One Dark";
      };

      icon_theme = "Colored Zed Icons Theme Dark";

      lsp = {
        nix.binary.path_lookup = true;

        rust-analyzer = {
          binary.path_lookup = true;
          initialization_options.check.command = "clippy";
        };

        omnisharp.binary.path_lookup = true;
      };

      ui_font_size = 16;
    };
  };
}
