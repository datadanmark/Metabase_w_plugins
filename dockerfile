FROM metabase/metabase:latest

USER root
RUN apk add --no-cache curl bash 2>/dev/null || (apt-get update && apt-get install -y curl bash && rm -rf /var/lib/apt/lists/*)

COPY download-drivers.sh /app/download-drivers.sh
RUN chmod +x /app/download-drivers.sh

ENV MB_PLUGINS_DIR=/plugins

ENTRYPOINT ["/app/download-drivers.sh"]
CMD ["/app/run_metabase.sh"]
