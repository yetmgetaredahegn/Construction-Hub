# Construction Hub - Setup Guide

This guide will help you set up and run the Construction Hub application on your Linux system.

## Prerequisites

You should have:
- ✅ Java JDK 8 or higher (you have JDK 21)
- ✅ MySQL Server installed
- ✅ Apache Tomcat (we'll help you install this)

## Step 1: Install Apache Tomcat

If Tomcat is not installed, you can install it using one of these methods:

### Method 1: Download and Extract (Recommended)
```bash
cd ~
wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.39/bin/apache-tomcat-10.1.39.tar.gz
tar -xzf apache-tomcat-10.1.39.tar.gz
mv apache-tomcat-10.1.39 tomcat
rm apache-tomcat-10.1.39.tar.gz
```

### Method 2: Using Package Manager
```bash
sudo apt-get update
sudo apt-get install tomcat10 tomcat10-admin
```

## Step 2: Configure MySQL Database

The application will automatically create the database named `suq` when it first runs. However, you need to ensure MySQL is running and the root user credentials match.

**Default credentials in the code:**
- Username: `root`
- Password: `root`

If your MySQL root password is different, you need to update the file:
`src/java/aos/dao/DatabaseProvider.java`

Change lines 9-10 to match your MySQL credentials:
```java
static String userName = "root";  // Change if needed
static String password = "root";  // Change to your MySQL root password
```

**To check/start MySQL:**
```bash
sudo systemctl status mysql
# If not running:
sudo systemctl start mysql
```

## Step 3: Install Apache Ant (Build Tool)

The project uses Apache Ant for building. Install it:

```bash
sudo apt-get update
sudo apt-get install ant
```

Verify installation:
```bash
ant -version
```

## Step 4: Build the Project

Navigate to the project directory and build it:

**Method 1: Using Ant (Recommended)**
```bash
cd /home/yetmgeta/projects/Construction-Hub
ant clean
ant dist
```

**Method 2: Using the build script**
If Ant is not installed, you can use the provided build script:
```bash
cd /home/yetmgeta/projects/Construction-Hub
bash build.sh
```

This will create a WAR file named `SUQ.war` in the `dist` directory.

## Step 5: Deploy to Tomcat

### Option A: Manual Deployment

1. Copy the WAR file to Tomcat's webapps directory:
```bash
cp dist/SUQ.war ~/tomcat/webapps/
```

2. Start Tomcat:
```bash
~/tomcat/bin/startup.sh
```

3. The application will be available at:
   - http://localhost:8080/SUQ/

### Option B: Using the Run Script

Use the provided `run.sh` script (see below).

## Step 6: Access the Application

1. Open your web browser
2. Navigate to: `http://localhost:8080/SUQ/`
3. You should see the login page

## Default Admin Credentials

- Email: `admin@gmail.com`
- Password: `admin`

## Stopping Tomcat

To stop Tomcat, run:
```bash
~/tomcat/bin/shutdown.sh
```

## Troubleshooting

### Port 8080 Already in Use
If port 8080 is already in use, you can change it:
1. Edit `~/tomcat/conf/server.xml`
2. Find the line: `<Connector port="8080"...>`
3. Change `8080` to another port (e.g., `8081`)
4. Restart Tomcat

### Database Connection Errors
- Ensure MySQL is running: `sudo systemctl status mysql`
- Check MySQL credentials in `DatabaseProvider.java`
- Verify MySQL allows connections: `mysql -u root -p`

### ClassNotFoundException
- Ensure all JAR files are in `web/WEB-INF/lib/`
- Check that `jakarta.servlet-api-6.0.0.jar` is present (not the old `servlet-api-2.5.jar`)

### Application Not Found (404)
- Check Tomcat logs: `~/tomcat/logs/catalina.out`
- Verify the WAR file was deployed: `ls ~/tomcat/webapps/`
- Check the context path in `web/META-INF/context.xml`

