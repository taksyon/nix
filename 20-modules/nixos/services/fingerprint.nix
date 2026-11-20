{ ... }:

{
  # Fingerprint auth via fprintd. The Yoga 9i Aura's Goodix 27c6:650c is a
  # match-on-chip sensor supported by mainline libfprint (goodixmoc driver),
  # so no proprietary TOD driver is needed.
  #
  # Enroll after switching (prints are stored on the sensor + /var/lib/fprint):
  #   fprintd-enroll            # right index finger by default
  #   fprintd-enroll -f left-index-finger
  #   fprintd-verify            # test
  services.fprintd.enable = true;

  # Enabling fprintd turns on pam_fprintd for every PAM service by default.
  # Keep it for sudo / su / polkit prompts (touch sensor OR type password),
  # but not for the login screen: a fingerprint login can't unlock the keyring,
  # and SDDM waits on the sensor before accepting a typed password.
  security.pam.services = {
    sddm.fprintAuth = false;
    login.fprintAuth = false;
  };
}
