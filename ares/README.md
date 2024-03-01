# Ares Standalone Image

This Dockerfile packages the pre-built Ares release into a deployable image with demo data that can be brought up 
with the following command:

```bash
docker run --rm -p 7070:80 ghcr.io/chorus-ai/chorus-ares
```

Once executed, you should be able to view the ares webpage from your webbrowser at `0.0.0.0:7070` (unix/mac) or `127.0.0.1:7070` (Windows)

In order to include your own source releases in the application, you will need to:

1. Mount a local volume to `/usr/share/nginx/html/data`
   ```
   docker run --rm -p 7070:80 \
   -v ./data:/usr/share/nginx/html/data \
   ghcr.io/chorus-ai/chorus-ares
   ```
2. Run the [AresIndexer](https://github.com/OHDSI/AresIndexer/blob/main/extras/CodeToRun.R) process against your dataset
    - [Achilles Output](https://drive.google.com/drive/folders/1b2EhWZ08OvEjFj5A0uCAbR0SsbQan7e6?usp=drive_link)
    - [DQD Output](https://drive.google.com/drive/folders/134ZQEQEOQCbjjFRHqHoxI-gDdsZJ9Utl?usp=drive_link)
    - [DQD Overview](https://drive.google.com/drive/folders/16Z8ssUC0kolGJzjWqe2jd5ONFVef2neL?usp=drive_link)
    - [Ares Overview](https://drive.google.com/drive/folders/19gv_n-WFqoFAM-1MHNpRa5heEUbrjoOg?usp=drive_link)
    - [Contributing Ares Results Pt 1](https://drive.google.com/drive/folders/1LAmtp7kygnqr1vuGvKS3wmTvbn5gmNZ_?usp=drive_link)
3. Place the [output](https://github.com/chorus-ai/StandardsModule/discussions/86#discussioncomment-8411235) of that process in the local directory in (1)
4. Refresh the webpage/open in a private window
