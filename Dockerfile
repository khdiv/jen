FROM httpd:alpine

# Copy my_page.html from the build context to the /var/www/html/ directory in the container
#COPY my_page.html /var/www/html/

# Expose port 80 for incoming web traffic
EXPOSE 80