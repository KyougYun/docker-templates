FROM kibana:latest

# Install required packages
RUN apt-get update; \
    apt-get install -y \
    netcat \
    supervisor

# Install elastic sense plugin
RUN kibana plugin --install elastic/sense
RUN kibana plugin --install kibana/timelion

# Add entrypoint
COPY entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh

# Kibana: copy config files to container
ADD config/kibana.yml /opt/kibana/config/kibana.yml

# Supervisord: copy config files to container
ADD config/supervisord.conf /etc/supervisor/supervisord.conf

# Set command
CMD ["/tmp/entrypoint.sh"]
