#!/bin/bash
echo "Running unit/widget tests..."
flutter test
echo "Running integration tests..."
flutter test integration_test
echo "All tests completed."