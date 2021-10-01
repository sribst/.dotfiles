#! /bin/bash
red='\e[31m'
green='\e[32m'
reset='\e[0m'
blink='\e[5m'

version_path="$1"
# version_path=$(echo "$1" | sed 's/.*proto_\([0-9]\{3\}\)_.*/\1/')
version_hash=$(jq -r .hash <"$version_path"/lib_protocol/TEZOS_PROTOCOL)

voted_path="$2"
# voted_path=$(echo "$2" | sed 's/.*proto_\([0-9]\{3\}\)_.*/\1/')
voted_hash=$(jq -r .hash <"$voted_path"/lib_protocol/TEZOS_PROTOCOL)


nb_block="$3"

eval `./src/bin_client/tezos-init-sandboxed-client.sh 1`
echo -e "${green}activate $version_path : $version_hash ${reset}"
activate-protocol "$1"

echo -e "${red}${blink}proposal${reset}"
echo -e "${green}submit proposal ${reset}"
tezos-client submit proposals for bootstrap1 "$voted_hash"

# tezos-client originate contract rooted transferring 1,000 from bootstrap1 running ./tests_python/contracts/opcodes/big_map_mem_nat.tz --init "Pair {} None" --burn-cap 0.382 &

bake-x "$nb_block"

echo -e "${red}${blink}testing vote${reset}"
echo -e "${green}submit ballot ${reset}"
tezos-client submit ballot for bootstrap1 "$voted_hash" yea
tezos-client submit ballot for bootstrap2 "$voted_hash" yea
tezos-client submit ballot for bootstrap3 "$voted_hash" yea
tezos-client submit ballot for bootstrap4 "$voted_hash" yea
tezos-client submit ballot for bootstrap5 "$voted_hash" yea

bake-x "$nb_block"
echo -e "${red}${blink}testing${reset}"
bake-x "$nb_block"

echo -e "${red}${blink}promotion vote vote${reset}"
echo -e "${green}submit ballot ${reset}"
tezos-client submit ballot for bootstrap1 "$voted_hash" yea
tezos-client submit ballot for bootstrap2 "$voted_hash" yea
tezos-client submit ballot for bootstrap3 "$voted_hash" yea
tezos-client submit ballot for bootstrap4 "$voted_hash" yea
tezos-client submit ballot for bootstrap5 "$voted_hash" yea

# bake-x "$nb_block"
# echo -e "${red}${blink}promotion${reset}"

bake-x $( (nb_block - 1) )

echo -e "${red}${blink}activation block${reset}"
echo -e "${green} show voting period ${reset}"
tezos-client show voting period

# bake-x 1
# bake-x
# tezos-client show voting period

# tezos-client originate contract big_map transferring 1,000 from bootstrap1 running ./tests_python/contracts/opcodes/big_map_to_self.tz --init '{ Elt "hahaha" 0 }' --burn-cap 0.558 &
