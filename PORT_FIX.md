# Port Fix - Application Access

## The Issue

The script was incorrectly detecting port 8005 (Tomcat shutdown port) instead of the HTTP port (8081).

## Fixed!

The port detection has been fixed. Your application is accessible at:

**http://localhost:8081/SUQ/**

(If you're using the system Tomcat, use port 8080 instead)

## Important: Rebuild After Password Change

Since you updated the MySQL password to `deAlto#Crack#357`, you need to rebuild and redeploy:

```bash
cd /home/yetmgeta/projects/Construction-Hub

# Rebuild with new password
rm -f dist/SUQ.war
bash build.sh

# If using system Tomcat:
sudo cp dist/SUQ.war /var/lib/tomcat10/webapps/
sudo systemctl restart tomcat10
# Then access: http://localhost:8080/SUQ/

# OR if using custom Tomcat:
./run.sh
# Then access: http://localhost:8081/SUQ/
```

## Which Tomcat Are You Using?

You have TWO Tomcat instances:

1. **System Tomcat** (port 8080)
   - Location: `/var/lib/tomcat10/webapps/`
   - Access: http://localhost:8080/SUQ/
   - Restart: `sudo systemctl restart tomcat10`

2. **Custom Tomcat** (port 8081)
   - Location: `~/tomcat/webapps/`
   - Access: http://localhost:8081/SUQ/
   - Restart: `~/tomcat/bin/shutdown.sh && ~/tomcat/bin/startup.sh`

Choose one and stick with it! The run.sh script uses the custom Tomcat on port 8081.

