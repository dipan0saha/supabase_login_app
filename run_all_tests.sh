#!/bin/bash
echo "Running unit/widget tests..."
flutter test
echo "Running integration tests..."
flutter test integration_test --dart-define=SUPABASE_URL=$SUPABASE_URL --dart-define=SUPABASE_ANON_KEY=$SUPABASE_ANON_KEY
echo "All tests completed."