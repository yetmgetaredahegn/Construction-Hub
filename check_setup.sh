#!/bin/bash

# Setup Verification Script for Construction Hub

echo "=========================================="
echo "Construction Hub - Setup Verification"
echo "=========================================="
echo ""

ERRORS=0
WARNINGS=0

# Check Java
echo -n "Checking Java... "
if command -v java &> /dev/null; then
    JAVA_VERSION=$(java -version 2>&1 | head -1)
    echo "✓ $JAVA_VERSION"
else
    echo "✗ NOT FOUND"
    ERRORS=$((ERRORS + 1))
fi

# Check MySQL
echo -n "Checking MySQL... "
if command -v mysql &> /dev/null; then
    MYSQL_VERSION=$(mysql --version 2>&1 | head -1)
    echo "✓ $MYSQL_VERSION"
    
    # Test connection
    echo -n "  Testing MySQL connection... "
    if mysql -u root -proot -e "SELECT 1;" &>/dev/null; then
        echo "✓ Connection successful"
    else
        echo "✗ Connection failed (password may be incorrect)"
        echo "    Update DatabaseProvider.java if your MySQL password is different"
        WARNINGS=$((WARNINGS + 1))
    fi
else
    echo "✗ NOT FOUND"
    ERRORS=$((ERRORS + 1))
fi

# Check Tomcat
echo -n "Checking Tomcat... "
TOMCAT_HOME="$HOME/tomcat"
if [ -d "$TOMCAT_HOME" ]; then
    if [ -f "$TOMCAT_HOME/bin/catalina.sh" ]; then
        TOMCAT_VERSION=$($TOMCAT_HOME/bin/version.sh 2>&1 | grep "Server version" | cut -d: -f2 | xargs)
        echo "✓ Found at $TOMCAT_HOME ($TOMCAT_VERSION)"
    else
        echo "✗ Invalid installation at $TOMCAT_HOME"
        ERRORS=$((ERRORS + 1))
    fi
else
    echo "✗ NOT FOUND at $TOMCAT_HOME"
    ERRORS=$((ERRORS + 1))
fi

# Check Ant
echo -n "Checking Apache Ant... "
if command -v ant &> /dev/null; then
    ANT_VERSION=$(ant -version 2>&1 | head -1)
    echo "✓ $ANT_VERSION"
else
    echo "⚠ NOT FOUND (install with: sudo apt-get install ant)"
    echo "    You can use build.sh as alternative"
    WARNINGS=$((WARNINGS + 1))
fi

# Check required JAR files
echo -n "Checking required libraries... "
PROJECT_DIR="/home/yetmgeta/projects/Construction-Hub"
LIB_DIR="$PROJECT_DIR/lib"
REQUIRED_JARS=("jakarta.servlet-api-6.0.0.jar" "mysql-connector-j-9.1.0.jar" "jstl-1.2.jar")
MISSING=0

for jar in "${REQUIRED_JARS[@]}"; do
    if [ ! -f "$LIB_DIR/$jar" ]; then
        echo ""
        echo "  ✗ Missing: $jar"
        MISSING=$((MISSING + 1))
    fi
done

if [ $MISSING -eq 0 ]; then
    echo "✓ All required JAR files found"
else
    echo ""
    ERRORS=$((ERRORS + MISSING))
fi

# Check WEB-INF/lib
echo -n "Checking WEB-INF/lib... "
WEBINF_LIB="$PROJECT_DIR/web/WEB-INF/lib"
if [ -d "$WEBINF_LIB" ]; then
    JAR_COUNT=$(find "$WEBINF_LIB" -name "*.jar" | wc -l)
    if [ $JAR_COUNT -ge 3 ]; then
        echo "✓ Found $JAR_COUNT JAR files"
    else
        echo "⚠ Only $JAR_COUNT JAR files found (should be at least 3)"
        WARNINGS=$((WARNINGS + 1))
    fi
else
    echo "✗ Directory not found"
    ERRORS=$((ERRORS + 1))
fi

echo ""
echo "=========================================="
if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo "✓ All checks passed! You're ready to build and run."
    echo ""
    echo "Next steps:"
    echo "  1. Run: ./run.sh"
    echo "  2. Open: http://localhost:8080/SUQ/"
elif [ $ERRORS -eq 0 ]; then
    echo "⚠ Setup complete with $WARNINGS warning(s)"
    echo "You can proceed, but review warnings above"
else
    echo "✗ Found $ERRORS error(s) and $WARNINGS warning(s)"
    echo "Please fix the errors before proceeding"
fi
echo "=========================================="

