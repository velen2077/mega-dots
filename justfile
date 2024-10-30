# Justfile

build-test:
    sudo nix build .#nixosConfigurations.endgame.config.system.build.vm --extra-experimental-features "nix-command flakes"
run-test:
    rm -f ./endgame.qcow2
    ./result/bin/run-endgame-vm