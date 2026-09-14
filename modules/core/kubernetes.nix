{ pkgs, ... }: {
  services.k3s = {
    enable = true;
    role = "server";
  };

  environment.systemPackages = with pkgs; [
    kubectl
    kubernetes-helm
  ];
}
