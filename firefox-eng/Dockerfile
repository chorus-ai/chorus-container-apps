FROM jlesage/firefox:v24.12.1

# For Firefox Browser in ML workspace. Populate the bookmarks with resource web urls
COPY bookmarks/places.sqlite /config/profile/places.sqlite

# Fix DNS resolution of Duke shibboleth
RUN echo "\n152.3.72.35     shib.oit.duke.edu\n" >> /etc/hosts
