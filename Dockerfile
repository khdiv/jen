# Use the official Apache image
FROM httpd:alpine

# Copy your HTML file to the default web server directory
COPY /var/lib/jenkins/workspace/docker-push/my_page.html /var/www/html/

# Expose port 80 for incoming web traffic
EXPOSE 80