# Construction Hub - Current Status & Fix Guide
# =============================================================

# SYSTEM STATUS (Working)
# -------------------------------------------------------------
# [OK] Project builds without errors
# [OK] Apache Tomcat installed and running
# [OK] Application deploys successfully
# [OK] Login page loads in browser


# CURRENT ISSUE
# -------------------------------------------------------------
# MySQL connection is failing due to an incorrect root password.
#
# Error:
#   Access denied for user 'root'@'localhost' (using password: YES)
#
# Cause:
#   Incorrect MySQL password configured in:
#   src/java/aos/dao/DatabaseProvider.java


# FASTEST FIX (Recommended)
# -------------------------------------------------------------
# Reset MySQL root password using the provided script.

cd /home/yetmgeta/projects/Construction-Hub
./reset_mysql_password.sh

# After reset, rebuild and redeploy the application.


# MANUAL FIX (Alternative)
# -------------------------------------------------------------
# Step 1: Verify MySQL password
mysql -u root -p

# Step 2: Update password in:
#   src/java/aos/dao/DatabaseProvider.java
#   (around line 10)

# Step 3: Rebuild the project
bash build.sh

# Step 4: Redeploy to Tomcat
sudo cp dist/Construction-Hub.war /var/lib/tomcat10/webapps/
# OR
./run.sh


# ACCESS URLS
# -------------------------------------------------------------
# Default Tomcat : http://localhost:8080/Construction-Hub/
# Custom Tomcat  : http://localhost:8081/Construction-Hub/


# IMPORTANT FILES
# -------------------------------------------------------------
# Database config : src/java/aos/dao/DatabaseProvider.java
# Build script    : build.sh
# Run script      : run.sh
# MySQL reset     : reset_mysql_password.sh
# MySQL finder   : find_mysql_password.sh


# HELPFUL CHECKS
# -------------------------------------------------------------
# Check MySQL service
sudo systemctl status mysql

# Check Tomcat logs
tail -f /var/lib/tomcat10/logs/catalina.out

# Verify WAR file
ls dist/Construction-Hub.war


# AFTER MYSQL IS FIXED
# -------------------------------------------------------------
# - Database 'construction_hub' is created automatically
# - All required tables are auto-generated
# - User registration & login will work
#
# Default Admin Account:
#   Email    : admin@gmail.com
#   Password : admin


# FINAL STATUS
# -------------------------------------------------------------
# Application is READY once MySQL connection succeeds.
# =============================================================
