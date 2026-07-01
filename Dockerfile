FROM nginx:alpine

# Copy your website into nginx folder
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80 inside container
EXPOSE 80
