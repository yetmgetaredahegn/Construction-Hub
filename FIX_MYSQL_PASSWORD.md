# Fix MySQL Password Issue

## Problem
The application is getting a NullPointerException because the MySQL connection is failing due to incorrect password.

## Solution

You need to update the MySQL password in the code to match your actual MySQL root password.

### Step 1: Find Your MySQL Root Password

Try one of these methods:

**Method 1: Check if you have a password file or remember it**
```bash
# If you set it up, you might remember it
# Common defaults: empty password, "root", or your system password
```

**Method 2: Try connecting without password**
```bash
mysql -u root
# If this works, your password is empty
```

**Method 3: Reset MySQL root password (if needed)**
```bash
# Stop MySQL
sudo systemctl stop mysql

# Start MySQL in safe mode (skip grant tables)
sudo mysqld_safe --skip-grant-tables &

# Connect without password
mysql -u root

# In MySQL, run:
USE mysql;
UPDATE user SET authentication_string=PASSWORD('your_new_password') WHERE User='root';
FLUSH PRIVILEGES;
EXIT;

# Restart MySQL normally
sudo systemctl start mysql
```

### Step 2: Update the Code

Edit the file: `src/java/aos/dao/DatabaseProvider.java`

Change lines 9-10:

```java
static String userName = "root";
static String password = "your_actual_password_here";  // Change this!
```

**If your MySQL root has NO password (empty), use:**
```java
static String password = "";
```

### Step 3: Rebuild and Redeploy

After updating the password:

```bash
cd /home/yetmgeta/projects/Construction-Hub

# Rebuild
bash build.sh

# Redeploy to system Tomcat
sudo cp dist/Construction-Hub.war /var/lib/tomcat10/webapps/
sudo systemctl restart tomcat10
```

Or if using the custom Tomcat:
```bash
./run.sh
```

### Quick Test

After fixing, test the connection:
```bash
mysql -u root -p
# Enter your password when prompted
# If it works, that's the correct password to use in the code
```

## Common MySQL Root Passwords to Try:
- Empty (no password)
- `root`
- `password`
- `123456`
- Your system/Ubuntu password

