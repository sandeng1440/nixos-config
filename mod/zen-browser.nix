{pkgs, inputs, ...}:{
  environment.systemPackages = [
    inputs.zen-browser.packages."x86_64-linux".default
  ];
}
