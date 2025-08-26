FROM nginx:latest

# Copy website files
COPY . /usr/share/nginx/html

# Expose port
EXPOSE 80

# Use default command
# (nginx is already set to run in foreground in the base image)