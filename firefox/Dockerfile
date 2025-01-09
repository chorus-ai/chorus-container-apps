FROM jlesage/firefox:latest

# Replace noVNC ui script with a version disabling the clipboard
COPY ui.js /opt/noVNC/app/ui.js

# For Firefox Browser in ML workspace. Populate the bookmarks with resource web urls
COPY bookmarks/places.sqlite /config/profile/places.sqlite
