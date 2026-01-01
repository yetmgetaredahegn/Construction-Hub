# Fix Database Connection Error (500 Internal Server Error)

## The Problem

You're getting this error:
```
Cannot invoke "java.sql.Connection.createStatement()" because connection is null
```

This means the MySQL connection failed. The code is trying to connect with:
- Username: `root`
- Password: `root`

But your MySQL root password is different.

## Quick Fix

### Option 1: Use the Helper Script (Easiest)

```bash
cd /home/yetmgeta/projects/Construction-Hub
./fix_mysql_password.sh
```

This will guide you through:
1. Entering your MySQL password (it will update the code automatically)
2. Or resetting the MySQL password
3. Then rebuild and redeploy

### Option 2: Manual Fix

**Step 1: Find your MySQL root password**

Try to connect:
```bash
mysql -u root -p
# Enter your password when prompted
```

**Step 2: Update the code**

Edit: `src/java/aos/dao/DatabaseProvider.java`

Change line 10:
```java
static String password = "your_actual_password_here";
```

If your MySQL has NO password, use empty string:
```java
static String password = "";
```

**Step 3: Rebuild and redeploy**

```bash
# Rebuild
bash build.sh

# Redeploy to system Tomcat
sudo cp dist/SUQ.war /var/lib/tomcat10/webapps/

# Restart Tomcat
sudo systemctl restart tomcat10
```

### Option 3: Reset MySQL Root Password

If you forgot your MySQL password, reset it:

```bash
# Stop MySQL
sudo systemctl stop mysql

# Start MySQL in safe mode
sudo mysqld_safe --skip-grant-tables &

# Wait a moment, then connect
sleep 3
mysql -u root

# In MySQL prompt, run:
USE mysql;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'newpassword';
FLUSH PRIVILEGES;
EXIT;

# Kill safe mode MySQL
sudo pkill mysqld

# Start MySQL normally
sudo systemctl start mysql

# Test
mysql -u root -pnewpassword -e "SELECT 1;"
```

Then update `DatabaseProvider.java` with the new password and rebuild.

## After Fixing

1. The application will automatically create the `suq` database on first use
2. All tables (users, products, orders, etc.) will be created automatically
3. You can then sign up and use the application

## Verify It's Working

After fixing and redeploying, check the Tomcat logs:
```bash
sudo tail -f /var/log/tomcat10/catalina.out
```

You should NOT see database connection errors. If signup works, you're all set!

