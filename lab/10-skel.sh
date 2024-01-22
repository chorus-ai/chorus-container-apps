if [ -n "$(find . -maxdepth 0 -empty)" ]; then
    cp -r /etc/skel/. .
fi
