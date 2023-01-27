#!/bin/sh
# This builds the code coverage for a project based on files in the src directory

set -ex

# assumes a src folder under the current folder and a build folder to place the JSON in
gcovr --json build/coverage.json -s --filter src