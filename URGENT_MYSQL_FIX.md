# URGENT: MySQL Password Issue

## Current Problem

Your MySQL root password `deAlto#Crack#357` is **INCORRECT**. The application cannot connect to MySQL.

Error in logs:
```
Access denied for user 'root'@'localhost' (using password: YES)
```

## Quick Fix Options

### Option 1: Reset MySQL Password (Recommended)

Run the reset script:
```bash
cd /home/yetmgeta/projects/Construction-Hub
./reset_mysql_password.sh
```

This will:
1. Ask you to set a NEW password
2. Reset MySQL root password to your new password
3. Update the code automatically
4. Tell you to rebuild and redeploy

### Option 2: Find Your Current Password

If you know your MySQL password but forgot what you set:

```bash
# Try connecting interactively
mysql -u root -p
# Enter your password when prompted
# If it works, that's your password!
```

Then update `src/java/aos/dao/DatabaseProvider.java` line 10 with the correct password.

### Option 3: Use Empty Password (If MySQL allows it)

Some MySQL installations allow root without password. Try:

```bash
mysql -u root
# If this works, update DatabaseProvider.java line 10 to:
# static String password = "";
```

## After Fixing Password

Once you have the correct password set in `DatabaseProvider.java`:

1. **Rebuild:**
   ```bash
   bash build.sh
   ```

2. **Deploy to System Tomcat:**
   ```bash
   sudo cp dist/SUQ.war /var/lib/tomcat10/webapps/
   sudo systemctl restart tomcat10
   ```

3. **OR deploy to Custom Tomcat:**
   ```bash
   ./run.sh
   ```

4. **Test:**
   - System Tomcat: http://localhost:8080/SUQ/
   - Custom Tomcat: http://localhost:8081/SUQ/

## Manual Password Reset (If script doesn't work)

If the reset script fails, do it manually:

```bash
# 1. Stop MySQL
sudo systemctl stop mysql

# 2. Start in safe mode
sudo mysqld_safe --skip-grant-tables --skip-networking &

# 3. Wait a moment
sleep 3

# 4. Connect and reset
sudo mysql -u root
# Then in MySQL prompt:
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'your_new_password';
FLUSH PRIVILEGES;
EXIT;

# 5. Kill safe mode
sudo pkill mysqld_safe
sleep 2

# 6. Start MySQL normally
sudo systemctl start mysql

# 7. Test
mysql -u root -p'your_new_password' -e "SELECT 1;"
```

Then update `DatabaseProvider.java` and rebuild!

