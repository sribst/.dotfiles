#! /usr/bin/env bash

src/bin_node/tezos-sandboxed-node.sh 1 &

src/tooling/lint.sh
src/lib_protocol_compiler/test/rejections.sh
src/bin_client/tezos-init-sandboxed-client.sh
src/bin_client/bash-completion.sh
src/lib_shell/test/generate_locator_plot.sh
tests_python/scripts/repeat_test.sh
scripts/version.sh
scripts/install_build_deps.sh
scripts/check_opam_test.sh
scripts/opam-pin.sh
scripts/opam-remove.sh
scripts/docker/entrypoint.sh
scripts/docker/entrypoint.inc.sh
scripts/snapshot_alpha.sh
scripts/create_docker_image.sh
scripts/update_opam_test.sh
scripts/tezos-docker-manager.sh
scripts/opam-check.sh
scripts/instrument_dune_bisect.sh
scripts/update_unit_test.sh
scripts/opam-upgrade.sh
scripts/update_opam_repo.sh
scripts/user_activated_upgrade.sh
scripts/update_hashes.sh
scripts/opam-unpin.sh
scripts/opam-test-all.sh
scripts/mainnet.sh
scripts/baker-version-stats.sh
scripts/ci/docker_registry_tag.sh
scripts/ci/docker_registry_read.sh
scripts/ci/create_docker_image.build.sh
scripts/ci/docker_registry.inc.sh
scripts/ci/create_docker_image.minimal.sh
scripts/ci/docker_registry_delete.sh
scripts/update_integration_test.sh
scripts/carthagenet.sh
scripts/link_protocol.sh
scripts/prepare_migration_test.sh
scripts/install_build_deps.raw.sh
