#!/bin/bash

# Run unit tests before pushing
echo "Running unit tests before push..."
npm test

# Capture the exit code of the tests
TEST_RESULT=$?

# Check if tests failed
if [ $TEST_RESULT -ne 0 ]; then
  echo "Unit tests failed. Push aborted."
  exit 1
fi