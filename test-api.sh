#!/bin/bash

# Test script for NestJS Auth API

API_URL="http://localhost:3000"

echo "🚀 Testing NestJS Auth API"
echo "========================="

# Test 1: Register a new user
echo "\n📝 Test 1: Register a new user"
REGISTER_RESPONSE=$(curl -s -X POST "$API_URL/auth/register" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "password123",
    "firstName": "Test",
    "lastName": "User"
  }')

echo "Response: $REGISTER_RESPONSE"

# Extract token from register response
TOKEN=$(echo $REGISTER_RESPONSE | grep -o '"access_token":"[^"]*' | cut -d'"' -f4)

if [ -n "$TOKEN" ]; then
  echo "✅ Registration successful! Token: ${TOKEN:0:20}..."
else
  echo "❌ Registration failed!"
fi

# Test 2: Login with the same user
echo "\n🔐 Test 2: Login with existing user"
LOGIN_RESPONSE=$(curl -s -X POST "$API_URL/auth/login" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "password123"
  }')

echo "Response: $LOGIN_RESPONSE"

# Extract token from login response
LOGIN_TOKEN=$(echo $LOGIN_RESPONSE | grep -o '"access_token":"[^"]*' | cut -d'"' -f4)

if [ -n "$LOGIN_TOKEN" ]; then
  echo "✅ Login successful! Token: ${LOGIN_TOKEN:0:20}..."
  TOKEN=$LOGIN_TOKEN
else
  echo "❌ Login failed!"
fi

# Test 3: Access protected profile endpoint
echo "\n👤 Test 3: Access protected profile"
if [ -n "$TOKEN" ]; then
  PROFILE_RESPONSE=$(curl -s -X GET "$API_URL/auth/profile" \
    -H "Authorization: Bearer $TOKEN")
  
  echo "Response: $PROFILE_RESPONSE"
  
  if echo "$PROFILE_RESPONSE" | grep -q "email"; then
    echo "✅ Profile access successful!"
  else
    echo "❌ Profile access failed!"
  fi
else
  echo "❌ No token available for profile test"
fi

# Test 4: Try to access profile without token (should fail)
echo "\n🚫 Test 4: Access profile without token (should fail)"
UNAUTH_RESPONSE=$(curl -s -X GET "$API_URL/auth/profile")
echo "Response: $UNAUTH_RESPONSE"

if echo "$UNAUTH_RESPONSE" | grep -q "Unauthorized"; then
  echo "✅ Unauthorized access properly blocked!"
else
  echo "❌ Security issue: Unauthorized access not blocked!"
fi

echo "\n🎉 API testing completed!"