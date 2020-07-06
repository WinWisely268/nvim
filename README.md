# vimfiles

[![Build Status](https://github.com/fsouza/vimfiles/workflows/Build/badge.svg)](https://github.com/fsouza/vimfiles/actions?query=branch:main+workflow:Build)

[mergify]: https://mergify.io
[mergify-status]: https://img.shields.io/endpoint.svg?url=https://dashboard.mergify.io/badges/fsouza/vimfiles&style=flat

## Getting started

If you want to use this repository, you'll need to download and install it, and
also install all its dependencies.

### Using with Neovim

All you need to do is clone the repository in your ``$VIMHOME`` and then
initialize the submodules:

```
% git clone --recurse-submodules https://github.com/fsouza/vimfiles.git ${HOME}/.config/nvim
% make -f ${HOME}/.config/nvim/Makefile bootstrap
```

### Using with Vim

Not really possible, sorry x)
