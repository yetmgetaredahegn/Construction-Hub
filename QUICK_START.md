# Quick Start Guide - Construction Hub

## Prerequisites Check

Before starting, ensure you have:
- ✅ Java JDK (you have JDK 21)
- ✅ MySQL Server installed and running
- ⚠️ Apache Tomcat (we'll help install)
- ⚠️ Apache Ant (needed for building)

## Quick Setup Steps

### 1. Install Ant (if not installed)
```bash
sudo apt-get update
sudo apt-get install ant
```

### 2. Install Tomcat (if not installed)
Tomcat should already be installed at `~/tomcat`. If not:
```bash
cd ~
wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.39/bin/apache-tomcat-10.1.39.tar.gz
tar -xzf apache-tomcat-10.1.39.tar.gz
mv apache-tomcat-10.1.39 tomcat
rm apache-tomcat-10.1.39.tar.gz
```

### 3. Check MySQL
Ensure MySQL is running and accessible:
```bash
# Check MySQL status
sudo systemctl status mysql

# If not running, start it:
sudo systemctl start mysql

# Test connection (default password is 'root')
mysql -u root -proot -e "SELECT 1;"
```

If your MySQL root password is different from 'root', update:
- File: `src/java/aos/dao/DatabaseProvider.java`
- Lines 9-10: Change username/password

### 4. Build and Run (Easy Way)

Use the provided run script:
```bash
cd /home/yetmgeta/projects/Construction-Hub
./run.sh
```

### 5. Build and Run (Manual Way)

```bash
cd /home/yetmgeta/projects/Construction-Hub

# Build
ant clean dist
# OR if Ant not available:
# bash build.sh

# Deploy
cp dist/Construction-Hub.war ~/tomcat/webapps/

# Start Tomcat
~/tomcat/bin/startup.sh
```

### 6. Access the Application

Open your browser and go to:
```
http://localhost:8080/Construction-Hub/
```

**Default Admin Login:**
- Email: `admin@gmail.com`
- Password: `admin`

## Stop the Application

To stop Tomcat:
```bash
~/tomcat/bin/shutdown.sh
```

## Common Issues

### Port 8080 Already in Use
Change Tomcat port in `~/tomcat/conf/server.xml` (find `<Connector port="8080"`)

### Database Connection Error
- Check MySQL is running: `sudo systemctl status mysql`
- Verify credentials in `DatabaseProvider.java`
- Test connection: `mysql -u root -proot`

### 404 Error
- Check Tomcat logs: `tail -f ~/tomcat/logs/catalina.out`
- Verify WAR file exists: `ls -lh ~/tomcat/webapps/Construction-Hub.war`

### Build Errors
- Ensure all JAR files are in `web/WEB-INF/lib/`
- Check Java version: `java -version` (should be 8+)
- Verify Ant is installed: `ant -version`

## Database Tables

The application automatically creates these tables on first use:
- `users` - User accounts
- `products` - Product catalog
- `orders` - Order records
- `notifications` - User notifications
- `cart` - Shopping cart items (created when needed)

No manual database setup required - just ensure MySQL is running!

