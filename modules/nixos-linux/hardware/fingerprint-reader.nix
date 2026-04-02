{ config, pkgs, ... }:

{
  # Enable the fingerprint reader
  services.fprintd.enable = true;

  # To setup your finger print for use with the system run
  # `fprintd-enroll -f right-index-finger`
  # `fprintd-enroll -f left-index-finger`
}
