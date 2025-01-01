{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
    sha256 = "1lvws93d1hq36lf1j1cfq6lzh1cgjrad8jhjw7vr987my5cfv450";
  };
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.pedro = {
    # This should be the same value as `system.stateVersion` in
    # your `configuration.nix` file.
    home.stateVersion = "24.11";

    home.file = {
      
      # Add Calibri font to Evolution
      ".local/share/evolution/webkit-editor-plugins/body-font.js" = {
        text = ''
          'use strict';

          var localhostBodyFontPlugin = {
             name : "localhostBodyFontPlugin",
             setup : function(doc) {
                if (doc.body) {
                    doc.body.setAttribute("style", "font-family: Calibri,sans-serif; font-size: 11.0pt;")
                }
             }
          };

          EvoEditor.RegisterPlugin(localhostBodyFontPlugin);
        '';
      };        
    };
  };
}
