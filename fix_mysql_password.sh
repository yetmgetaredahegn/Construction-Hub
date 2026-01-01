#!/bin/bash

echo "=========================================="
echo "MySQL Password Configuration Helper"
echo "=========================================="
echo ""
echo "The application needs to connect to MySQL with the root password."
echo "Current configuration uses password: 'root'"
echo ""

# Try to detect if we can connect
echo "Testing current password..."
if mysql -u root -proot -e "SELECT 1;" 2>/dev/null; then
    echo "✓ Password 'root' works! No changes needed."
    exit 0
fi

echo "✗ Password 'root' does not work."
echo ""
echo "Options:"
echo "1. Enter your MySQL root password (will update the code)"
echo "2. Reset MySQL root password (requires sudo)"
echo "3. Exit and fix manually"
echo ""
read -p "Choose option (1/2/3): " choice

case $choice in
    1)
        echo ""
        read -sp "Enter your MySQL root password: " mysql_password
        echo ""
        echo ""
        
        # Test the password
        if mysql -u root -p"$mysql_password" -e "SELECT 1;" 2>/dev/null; then
            echo "✓ Password works!"
            echo ""
            echo "Updating DatabaseProvider.java..."
            
            # Escape special characters for sed
            escaped_password=$(printf '%s\n' "$mysql_password" | sed 's/[[\.*^$()+?{|]/\\&/g')
            
            # Update the password in the file
            sed -i "s/static String password = \".*\";/static String password = \"$escaped_password\";/" src/java/aos/dao/DatabaseProvider.java
            
            echo "✓ Password updated in DatabaseProvider.java"
            echo ""
            echo "Now you need to rebuild and redeploy:"
            echo "  1. bash build.sh"
            echo "  2. sudo cp dist/Construction-Hub.war /var/lib/tomcat10/webapps/"
            echo "  3. sudo systemctl restart tomcat10"
            echo ""
        else
            echo "✗ Password test failed. Please check your password."
        fi
        ;;
    2)
        echo ""
        echo "This will reset your MySQL root password."
        echo "WARNING: This requires sudo access."
        echo ""
        read -p "Enter new MySQL root password: " new_password
        echo ""
        
        cat << EOF > /tmp/reset_mysql.sh
#!/bin/bash
sudo systemctl stop mysql
sudo mysqld_safe --skip-grant-tables &
sleep 3
mysql -u root << MYSQL
USE mysql;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$new_password';
FLUSH PRIVILEGES;
EXIT;
MYSQL
sudo pkill mysqld
sleep 2
sudo systemctl start mysql

# Update code
cd /home/yetmgeta/projects/Construction-Hub
sed -i "s/static String password = \".*\";/static String password = \"$new_password\";/" src/java/aos/dao/DatabaseProvider.java
echo "✓ Password reset and code updated"
EOF
        chmod +x /tmp/reset_mysql.sh
        echo "Run this command to reset password:"
        echo "  bash /tmp/reset_mysql.sh"
        ;;
    3)
        echo "Exiting. Edit src/java/aos/dao/DatabaseProvider.java manually."
        exit 0
        ;;
    *)
        echo "Invalid choice"
        exit 1
        ;;
esac

