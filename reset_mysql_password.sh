#!/bin/bash

echo "=========================================="
echo "MySQL Root Password Reset Script"
echo "=========================================="
echo ""
echo "This script will reset your MySQL root password."
echo ""
read -p "Enter NEW MySQL root password: " NEW_PASSWORD
echo ""
read -p "Confirm NEW MySQL root password: " CONFIRM_PASSWORD
echo ""

if [ "$NEW_PASSWORD" != "$CONFIRM_PASSWORD" ]; then
    echo "✗ Passwords do not match!"
    exit 1
fi

echo "Resetting MySQL root password..."
echo ""
echo "Step 1: Stopping MySQL..."
sudo systemctl stop mysql

echo "Step 2: Starting MySQL in safe mode..."
sudo mysqld_safe --skip-grant-tables --skip-networking &
MYSQL_PID=$!
sleep 3

echo "Step 3: Resetting password..."
sudo mysql -u root << EOF
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$NEW_PASSWORD';
FLUSH PRIVILEGES;
EXIT;
EOF

echo "Step 4: Stopping safe mode MySQL..."
sudo kill $MYSQL_PID 2>/dev/null
sleep 2
sudo pkill mysqld_safe 2>/dev/null
sleep 1

echo "Step 5: Starting MySQL normally..."
sudo systemctl start mysql
sleep 2

echo "Step 6: Testing new password..."
if mysql -u root -p"$NEW_PASSWORD" -e "SELECT 1;" 2>/dev/null; then
    echo "✓ Password reset successful!"
    echo ""
    echo "Updating DatabaseProvider.java..."
    cd /home/yetmgeta/projects/Construction-Hub
    
    # Escape special characters for sed
    escaped_password=$(printf '%s\n' "$NEW_PASSWORD" | sed 's/[[\.*^$()+?{|]/\\&/g')
    sed -i "s/static String password = \".*\";/static String password = \"$escaped_password\";/" src/java/aos/dao/DatabaseProvider.java
    
    echo "✓ Code updated with new password!"
    echo ""
    echo "Next steps:"
    echo "  1. bash build.sh"
    echo "  2. sudo cp dist/Construction-Hub.war /var/lib/tomcat10/webapps/"
    echo "  3. sudo systemctl restart tomcat10"
    echo ""
    echo "OR if using custom Tomcat:"
    echo "  ./run.sh"
else
    echo "✗ Password reset failed. Please try manually."
    echo "See: DATABASE_FIX_INSTRUCTIONS.md"
fi

