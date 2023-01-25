#!/bin/sh

set -ex

# assumes a src folder under the current folder and a build folder to place the JSON in
gcovr --json build/coverage.json -s --filter src