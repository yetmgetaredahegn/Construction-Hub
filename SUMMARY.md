# Construction Hub — Current Status & Fix Guide
# ============================================================

# ------------------------------------------------------------
# ✅ SYSTEM STATUS (Working)
# ------------------------------------------------------------
# ✔ Project builds without errors
# ✔ Apache Tomcat installed and running
# ✔ Application deploys successfully
# ✔ Login page loads in browser

# ------------------------------------------------------------
# ❌ CURRENT ISSUE
# ------------------------------------------------------------
# MySQL connection is failing due to an incorrect root password.
#
# Error:
#   Access denied for user 'root'@'localhost' (using password: YES)
#
# Cause:
#   Wrong MySQL password configured in:
#   src/java/aos/dao/DatabaseProvider.java

# ------------------------------------------------------------
# 🔧 FASTEST FIX (Recommended)
# ------------------------------------------------------------
# Reset MySQL root password using the provided script.

cd /home/yetmgeta/projects/Construction-Hub
./reset_mysql_password.sh

# After reset, rebuild and redeploy the application.

# ------------------------------------------------------------
# 🔁 MANUAL FIX (Alternative)
# ------------------------------------------------------------
# 1️⃣ Verify MySQL password manually
mysql -u root -p

# 2️⃣ Update password in:
#    src/java/aos/dao/DatabaseProvider.java
#    (line ~10)

# 3️⃣ Rebuild the project
bash build.sh

# 4️⃣ Redeploy to Tomcat (choose one)
sudo cp dist/Construction-Hub.war /var/lib/tomcat10/webapps/
# OR
./run.sh

# ------------------------------------------------------------
# 📍 ACCESS URLS
# ------------------------------------------------------------
# Default Tomcat:
# http://localhost:8080/Construction-Hub/
#
# Custom Tomcat:
# http://localhost:8081/Construction-Hub/

# ------------------------------------------------------------
# 📝 IMPORTANT FILES
# ------------------------------------------------------------
# Database connection:
#   src/java/aos/dao/DatabaseProvider.java
#
# Build script:
#   build.sh
#
# Build & run:
#   run.sh
#
# Reset MySQL password:
#   reset_mysql_password.sh
#
# Find MySQL password:
#   find_mysql_password.sh

# ------------------------------------------------------------
# 🔍 HELPFUL CHECKS (Extra Concepts)
# ------------------------------------------------------------
# Check MySQL service status
sudo systemctl status mysql

# Check Tomcat logs if deployment fails
tail -f /var/lib/tomcat10/logs/catalina.out

# Verify WAR file exists
ls dist/Construction-Hub.war

# ------------------------------------------------------------
# 🎯 AFTER FIXING MYSQL
# ------------------------------------------------------------
# ✔ Database 'construction_hub' is created automatically
# ✔ All required tables are auto-generated
# ✔ User registration & login will work
#
# 🔐 Default Admin Account:
#   Email:    admin@gmail.com
#   Password: admin

# ------------------------------------------------------------
# 🚀 STATUS
# ------------------------------------------------------------
# Application is READY once database connection succeeds.
# ============================================================
