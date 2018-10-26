# nickclifford.me-v2 [![Build Status](https://travis-ci.org/nickbclifford/nickclifford.me-v2.svg?branch=master)](https://travis-ci.org/nickbclifford/nickclifford.me-v2)
The next iteration of my personal website.

## Setup
Run `shards install` to install all of the dependencies. Make sure that `libsass` is installed and in the `LD_LIBRARY_PATH` before trying to run the server. See [building instructions for `sass.cr`](https://github.com/straight-shoota/sass.cr#building-libsass) for more info.

## Running
Either directly run via `crystal index.cr` or compile via `crystal build [--release] index.cr` and run the resulting executable. Kemal will then start listening on port 3692.
