# Quick Fix: Port Conflict Issue

## Issue
There's a system Tomcat running on port 8080, blocking our installation.

## Solution
I've changed our Tomcat to use port 8081 instead.

## Access Your Application

Your application is now available at:
**http://localhost:8081/SUQ/**

## Alternative: Use System Tomcat

If you prefer to use the system Tomcat on port 8080:

1. Deploy to system Tomcat:
   ```bash
   sudo cp dist/SUQ.war /var/lib/tomcat10/webapps/
   ```

2. Access at: http://localhost:8080/SUQ/

## Restore Port 8080 (if system Tomcat is stopped)

If you stop the system Tomcat and want to use port 8080:

```bash
sed -i 's/port="8081"/port="8080"/' ~/tomcat/conf/server.xml
~/tomcat/bin/shutdown.sh
~/tomcat/bin/startup.sh
```

