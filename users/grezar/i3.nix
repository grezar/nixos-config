{ config, pkgs, ... }:

{
  xsession = {
    enable = true;
    initExtra = ''
      ${pkgs.xlibs.xset}/bin/xset r rate 200 40
      ${pkgs.xorg.xrandr}/bin/xrandr -s '1920x1080'
      ${pkgs.spice-vdagent}/bin/spice-vdagent
    '';
  };

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = {
      startup = [
        {
          command = "alacritty";
        }
        {
          command = "${pkgs.feh}/bin/feh --bg-fill ~/.background-image";
        }
      ];
      terminal = "alacritty";
      gaps = {
        inner = 10;
      };
    };
  };
}
