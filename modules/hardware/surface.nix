{ config, lib, pkgs, ... }:

{
  boot.extraModulePackages = [
    config.boot.kernelPackages.v4l2loopback
  ];
  
  boot.kernelModules = [ "v4l2loopback" ];
  
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS" exclusive_caps=1
  '';
  
  hardware.graphics.enable = true;
  hardware.opentabletdriver.enable = true;
}
