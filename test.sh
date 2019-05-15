hdr () {
    echo -e "\n\n## $@ ##\n"
}

hdr Vagrant setup
vagrant up
vagrant ssh-config > .vagrant_ssh
vssh () {
    ssh -F .vagrant_ssh $@
}

helloPath=$(nix-store -r $(nix-instantiate '<nixpkgs>' -A hello))
$helloPath/bin/hello -g "Hello from hello!"

hdr "Method 1: Fails with export + import :("
(
set -x
nix-store --export $helloPath | vssh compute-node -- nix-store --import
)

hdr "Method 2: Succeeds with nix-copy-closure!"
(
set -x
NIX_SSHOPTS="-F $PWD/.vagrant_ssh" nix-copy-closure --to compute-node $helloPath
)

hdr "(Resetting with --gc for next test run...)"
vssh compute-node -- nix-store --gc
