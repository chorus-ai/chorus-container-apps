FROM jlesage/firefox:v24.12.1

# For Firefox Browser in ML workspace. Populate the bookmarks with resource web urls
COPY bookmarks/places.sqlite /config/profile/places.sqlite

# Fix DNS resolution of Duke shibboleth
COPY 10-add-hosts.sh /etc/cont-init.d/10-add-hosts.sh
