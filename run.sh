#!/bin/bash

# Construction Hub - Run Script
# This script helps you build and run the Construction Hub application

set -e  # Exit on error

PROJECT_DIR="/home/yetmgeta/projects/Construction-Hub"
TOMCAT_HOME="$HOME/tomcat"
WAR_NAME="SUQ"

echo "=========================================="
echo "Construction Hub - Run Script"
echo "=========================================="
echo ""

# Check if Java is installed
if ! command -v java &> /dev/null; then
    echo "ERROR: Java is not installed. Please install Java JDK 8 or higher."
    exit 1
fi

echo "✓ Java found: $(java -version 2>&1 | head -1)"
echo ""

# Check if Tomcat exists
if [ ! -d "$TOMCAT_HOME" ]; then
    echo "ERROR: Tomcat not found at $TOMCAT_HOME"
    echo "Please install Tomcat first. See SETUP_GUIDE.md"
    exit 1
fi

echo "✓ Tomcat found at $TOMCAT_HOME"
echo ""

# Check if MySQL is running
if ! command -v mysql &> /dev/null; then
    echo "WARNING: MySQL client not found in PATH. Make sure MySQL server is running."
else
    echo "✓ MySQL client found"
fi
echo ""

# Navigate to project directory
cd "$PROJECT_DIR"

# Build the project
echo "Building the project..."
BUILD_SUCCESS=false

# Check if WAR already exists from a previous successful build
WAR_FILE="$PROJECT_DIR/dist/$WAR_NAME.war"
if [ -f "$WAR_FILE" ]; then
    echo "✓ WAR file already exists, skipping build"
    echo "  (Delete $WAR_FILE to force rebuild)"
    BUILD_SUCCESS=true
fi

if [ "$BUILD_SUCCESS" = false ]; then
    if command -v ant &> /dev/null; then
        echo "Attempting to build with Ant..."
        if ant clean dist > /tmp/ant_build.log 2>&1 && grep -q "BUILD SUCCESSFUL" /tmp/ant_build.log; then
            echo "✓ Project built successfully with Ant"
            BUILD_SUCCESS=true
        else
            echo "⚠ Ant build failed (common with NetBeans projects)"
            echo "  Falling back to alternative build method..."
            cat /tmp/ant_build.log | tail -5
        fi
    fi
    
    if [ "$BUILD_SUCCESS" = false ]; then
        if [ -f "$PROJECT_DIR/build.sh" ]; then
            echo "Using build.sh script..."
            if bash "$PROJECT_DIR/build.sh"; then
                echo "✓ Project built successfully (using build.sh)"
                BUILD_SUCCESS=true
            else
                echo "✗ Build failed with build.sh"
                exit 1
            fi
        else
            echo "ERROR: build.sh not found."
            exit 1
        fi
    fi
fi
echo ""

# Check if WAR file was created
WAR_FILE="$PROJECT_DIR/dist/$WAR_NAME.war"
if [ ! -f "$WAR_FILE" ]; then
    echo "ERROR: WAR file not found at $WAR_FILE"
    echo "Build may have failed. Check the output above."
    exit 1
fi

echo "✓ WAR file created: $WAR_FILE"
echo ""

# Stop Tomcat if running
echo "Stopping Tomcat if running..."
if [ -f "$TOMCAT_HOME/bin/shutdown.sh" ]; then
    $TOMCAT_HOME/bin/shutdown.sh 2>/dev/null || true
    sleep 2
fi

# Remove old deployment
echo "Removing old deployment..."
rm -rf "$TOMCAT_HOME/webapps/$WAR_NAME"*
echo ""

# Deploy new WAR file
echo "Deploying application to Tomcat..."
cp "$WAR_FILE" "$TOMCAT_HOME/webapps/"
echo "✓ Application deployed"
echo ""

# Start Tomcat
echo "Starting Tomcat..."
$TOMCAT_HOME/bin/startup.sh
echo ""

# Wait a bit for Tomcat to start
echo "Waiting for Tomcat to start..."
sleep 5

# Check which port Tomcat is using (look for HTTP connector, not shutdown port)
TOMCAT_PORT=$(grep -A 2 'Connector.*protocol="HTTP' "$TOMCAT_HOME/conf/server.xml" | grep -o 'port="[0-9]*"' | head -1 | grep -o '[0-9]*' || echo "8081")
if [ -z "$TOMCAT_PORT" ]; then
    # Default to 8081 if not found
    TOMCAT_PORT="8081"
fi

echo "=========================================="
echo "Application should be available at:"
echo "  http://localhost:$TOMCAT_PORT/$WAR_NAME/"
echo ""
echo "Default Admin Login:"
echo "  Email: admin@gmail.com"
echo "  Password: admin"
echo ""
echo "To stop Tomcat, run:"
echo "  $TOMCAT_HOME/bin/shutdown.sh"
echo "=========================================="

