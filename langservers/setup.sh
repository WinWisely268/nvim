#!/usr/bin/env bash

set -eu

ROOT=$(cd "$(dirname "${0}")" && pwd -P)

function install_ocaml_lsp {
	if ! command -v opam &>/dev/null; then
		echo skipping ocaml-lsp
		return
	fi
	opam update -y
	opam install -y dune ocamlformat
	pushd "$ROOT/ocaml-lsp" &&
		opam install --deps-only -y . &&
		dune build @install &&
		popd
}

function install_rust_analyzer {
	local suffix
	if ! command -v cargo &>/dev/null; then
		echo skipping rust-analyzer
		return
	fi
	if [[ $OSTYPE == darwin* ]]; then
		suffix=mac
	elif [[ $OSTYPE == linux* ]]; then
		suffix=linux
	fi
	curl -sLo "${ROOT}/bin/rust-analyzer" "https://github.com/rust-analyzer/rust-analyzer/releases/download/nightly/rust-analyzer-${suffix}"
	chmod +x "${ROOT}/bin/rust-analyzer"
}

function install_servers_from_npm {
	npm ci
}

function install_efm_ls {
	if ! command -v go &>/dev/null; then
		echo skipping efm
		return
	fi
	(
		# shellcheck disable=SC2030,SC2031
		export GO111MODULE=on GOBIN="${ROOT}/bin"
		cd /tmp &&
			go get github.com/mattn/efm-langserver@master
	)
}

function install_gopls {
	if ! command -v go &>/dev/null; then
		echo skipping gopls
		return
	fi
	(
		# shellcheck disable=SC2030,SC2031
		export GO111MODULE=on GOBIN="${ROOT}/bin"
		cd /tmp &&
			go get golang.org/x/tools/gopls@master golang.org/x/tools@master &&
			go get golang.org/x/tools/cmd/goimports@master &&
			go get honnef.co/go/tools/cmd/staticcheck@master
	)
}

function install_lua_lsp {
	if ! command -v ninja &>/dev/null; then
		echo skipping lua-lsp
		return
	fi
	if [[ $OSTYPE == darwin* ]]; then
		ninja_file=ninja/macos.ninja
	elif [[ $OSTYPE == linux* ]]; then
		ninja_file=ninja/linux.ninja
	else
		echo "install_lua_lsp: unuspported OSTYPE=${OSTYPE}"
		return
	fi
	pushd "${ROOT}/lua-language-server" &&
		cd 3rd/luamake &&
		ninja -f "${ninja_file}" &&
		cd ../.. &&
		./3rd/luamake/luamake rebuild &&
		popd
}

pushd "$ROOT"
git submodule update --init --recursive
install_servers_from_npm &
install_ocaml_lsp &
install_rust_analyzer &
install_efm_ls &
install_gopls &
install_lua_lsp &
wait
popd
