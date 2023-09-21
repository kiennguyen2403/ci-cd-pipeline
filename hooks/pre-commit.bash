#!/bin/bash

# Run unit tests before committing
echo "Running unit tests..."
npm test

# Capture the exit code of the tests
TEST_RESULT=$?

# Check if tests failed
if [ $TEST_RESULT -ne 0 ]; then
  echo "Unit tests failed. Commit aborted."
  exit 1
fi