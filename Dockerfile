# Use the official lightweight Nginx Alpine image
FROM nginx:alpine

# Copy the custom corporate website index.html into Nginx web root directory
COPY index.html /usr/share/nginx/html/index.html

# Expose HTTP port 80
EXPOSE 80
