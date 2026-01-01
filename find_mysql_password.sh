#!/bin/bash

echo "=========================================="
echo "MySQL Password Finder/Setter"
echo "=========================================="
echo ""

# Try to connect without password first
echo "Testing connection without password..."
if mysql -u root -e "SELECT 1;" 2>/dev/null; then
    echo "✓ SUCCESS! MySQL root has NO password (empty password)"
    echo ""
    echo "Updating DatabaseProvider.java to use empty password..."
    cd /home/yetmgeta/projects/Construction-Hub
    sed -i 's/static String password = ".*";/static String password = "";/' src/java/aos/dao/DatabaseProvider.java
    echo "✓ Code updated!"
    echo ""
    echo "Now rebuild and redeploy:"
    echo "  bash build.sh"
    echo "  sudo cp dist/Construction-Hub.war /var/lib/tomcat10/webapps/  (or use ./run.sh for custom Tomcat)"
    echo "  sudo systemctl restart tomcat10"
    exit 0
fi

echo "✗ No password connection failed"
echo ""

# Try common passwords
echo "Trying common passwords..."
COMMON_PASSWORDS=("root" "password" "123456" "" "mysql" "admin")
for pwd in "${COMMON_PASSWORDS[@]}"; do
    if [ -z "$pwd" ]; then
        continue  # Already tested
    fi
    echo -n "  Trying '$pwd'... "
    if mysql -u root -p"$pwd" -e "SELECT 1;" 2>/dev/null; then
        echo "✓ SUCCESS! Password is: $pwd"
        echo ""
        echo "Updating DatabaseProvider.java..."
        cd /home/yetmgeta/projects/Construction-Hub
        # Escape special characters for sed
        escaped_pwd=$(printf '%s\n' "$pwd" | sed 's/[[\.*^$()+?{|]/\\&/g')
        sed -i "s/static String password = \".*\";/static String password = \"$escaped_pwd\";/" src/java/aos/dao/DatabaseProvider.java
        echo "✓ Code updated!"
        echo ""
        echo "Now rebuild and redeploy:"
        echo "  bash build.sh"
        echo "  sudo cp dist/Construction-Hub.war /var/lib/tomcat10/webapps/  (or use ./run.sh for custom Tomcat)"
        echo "  sudo systemctl restart tomcat10"
        exit 0
    else
        echo "✗ Failed"
    fi
done

echo ""
echo "=========================================="
echo "Could not find correct password automatically"
echo "=========================================="
echo ""
echo "You need to either:"
echo ""
echo "1. Reset MySQL root password:"
echo "   See: DATABASE_FIX_INSTRUCTIONS.md"
echo ""
echo "2. Manually enter your password:"
echo "   mysql -u root -p"
echo "   (Enter your password when prompted)"
echo "   If it works, update DatabaseProvider.java with that password"
echo ""
echo "3. Use the interactive fix script:"
echo "   ./fix_mysql_password.sh"
echo ""

