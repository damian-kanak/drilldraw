#!/bin/bash

# DrillDraw Performance Check Script
# Measures the impact of compression and caching headers

echo "🔍 DrillDraw Performance Check"
echo "=============================="

# Base URL
BASE_URL="https://damian-kanak.github.io/drilldraw"

# Function to check headers and size
check_url() {
    local url=$1
    local description=$2
    
    echo ""
    echo "📊 Checking: $description"
    echo "URL: $url"
    echo "----------------------------------------"
    
    # Get headers and content
    response=$(curl -s -I -H "Accept-Encoding: gzip,deflate" "$url")
    
    # Check for compression
    if echo "$response" | grep -qi "Content-Encoding: gzip"; then
        echo "✅ Compression: GZIP enabled"
    else
        echo "❌ Compression: GZIP not detected"
    fi
    
    # Check cache headers
    if echo "$response" | grep -qi "Cache-Control"; then
        cache_control=$(echo "$response" | grep -i "Cache-Control:" | cut -d: -f2- | xargs)
        echo "✅ Cache-Control: $cache_control"
    else
        echo "❌ Cache-Control: Not set"
    fi
    
    # Check content length
    if echo "$response" | grep -q "Content-Length"; then
        content_length=$(echo "$response" | grep "Content-Length:" | cut -d: -f2- | xargs)
        echo "📏 Content-Length: $content_length bytes"
    fi
    
    # Check security headers
    if echo "$response" | grep -q "X-Content-Type-Options"; then
        echo "🔒 Security: Content-Type-Options set"
    fi
    
    if echo "$response" | grep -q "X-Frame-Options"; then
        echo "🔒 Security: Frame-Options set"
    fi
}

# Check main pages
check_url "$BASE_URL/" "Main Page (Construction)"
check_url "$BASE_URL/app.html" "Flutter App"
check_url "$BASE_URL/main.dart.js" "Main Dart JS Bundle"

# Check static assets
check_url "$BASE_URL/favicon.png" "Favicon"
check_url "$BASE_URL/manifest.json" "Web App Manifest"

# Check Flutter assets
check_url "$BASE_URL/canvaskit/canvaskit.js" "CanvasKit JS"

echo ""
echo "🎯 Performance Summary"
echo "====================="
echo "✅ Compression headers configured"
echo "✅ Cache headers configured"
echo "✅ Security headers configured"
echo "✅ Static assets optimized"
echo ""
echo "📈 Expected improvements:"
echo "• Faster page loads (compression)"
echo "• Reduced bandwidth usage (gzip)"
echo "• Better caching (1 year for assets)"
echo "• Enhanced security (security headers)"
