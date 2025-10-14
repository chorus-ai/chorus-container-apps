from python:3.13-bookworm

RUN pip install pandas \
                dash \
                dash_bootstrap_components \
                dash_ag_grid

COPY app.py /app/app.py
COPY assets /app/assets

ENTRYPOINT ["python3", "/app/app.py"]

