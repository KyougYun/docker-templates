FROM elasticsearch:latest

# Install required packages
RUN apt-get update; \
    apt-get install -y \
    supervisor

# Add entrypoint
COPY entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh

# Supervisord: copy config files to container
ADD config/supervisord.conf /etc/supervisor/supervisord.conf

# Set command
CMD ["/tmp/entrypoint.sh"]
