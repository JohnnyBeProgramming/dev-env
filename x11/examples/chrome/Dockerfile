FROM jess/chrome

#RUN apt-get update && apt-get install -y fonts-noto && rm -rf /var/lib/apt/lists/* && rm -rf /src/*.deb

# Autorun chrome
ENTRYPOINT [ "google-chrome" ]
CMD [ "--v", "3", "--no-sandbox", "--user-data-dir=/data" ]