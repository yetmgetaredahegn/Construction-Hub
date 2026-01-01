#!/bin/bash

# Alternative build script using javac directly
# This can be used if Ant is not available

PROJECT_DIR="/home/yetmgeta/projects/Construction-Hub"
SRC_DIR="$PROJECT_DIR/src/java"
WEB_DIR="$PROJECT_DIR/web"
BUILD_DIR="$PROJECT_DIR/build/web"
LIB_DIR="$PROJECT_DIR/lib"
WAR_NAME="Construction-Hub"

echo "Building Construction Hub..."

# Create build directories
mkdir -p "$BUILD_DIR/WEB-INF/classes"
mkdir -p "$BUILD_DIR/WEB-INF/lib"
mkdir -p "$PROJECT_DIR/dist"

# Copy web resources
echo "Copying web resources..."
cp -r "$WEB_DIR"/* "$BUILD_DIR/" 2>/dev/null || true

# Copy libraries to WEB-INF/lib
echo "Copying libraries..."
cp "$LIB_DIR/jakarta.servlet-api-6.0.0.jar" "$BUILD_DIR/WEB-INF/lib/" 2>/dev/null || true
cp "$LIB_DIR/mysql-connector-j-9.1.0.jar" "$BUILD_DIR/WEB-INF/lib/" 2>/dev/null || true
cp "$LIB_DIR/jstl-1.2.jar" "$BUILD_DIR/WEB-INF/lib/" 2>/dev/null || true

# Build classpath
CLASSPATH="$BUILD_DIR/WEB-INF/lib/*:$LIB_DIR/*"

# Compile Java source files
echo "Compiling Java source files..."
JAVA_FILES=$(find "$SRC_DIR" -name "*.java")
if [ -z "$JAVA_FILES" ]; then
    echo "✗ No Java source files found in $SRC_DIR"
    exit 1
fi

javac -d "$BUILD_DIR/WEB-INF/classes" -cp "$CLASSPATH" $JAVA_FILES 2>&1

if [ $? -eq 0 ]; then
    echo "✓ Compilation successful"
else
    echo "✗ Compilation failed - check errors above"
    exit 1
fi

# Create WAR file
echo "Creating WAR file..."
cd "$BUILD_DIR"
jar cf "$PROJECT_DIR/dist/$WAR_NAME.war" *

if [ -f "$PROJECT_DIR/dist/$WAR_NAME.war" ]; then
    echo "✓ WAR file created: $PROJECT_DIR/dist/$WAR_NAME.war"
else
    echo "✗ WAR file creation failed"
    exit 1
fi

echo ""
echo "Build complete!"

