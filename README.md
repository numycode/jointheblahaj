# Join The Blåhaj
![Is it working? Probably.](https://img.shields.io/badge/is_it_working-probably-green) ![Time spent working on project](https://hackatime.hackclub.com/api/v1/badge/U0A6U9MEA5D/numycode/jointheblahaj)

Join The Blåhaj is a Flask and Tailwind CSS app for [Hack Club](https://hackclub.com) [Haj4Ever](https://haj4ever.hackclub.com) that uses a Slack App to change your status with authorization!

## Run with Docker
Run with:
```bash
docker compose up -d --build
```

It is mapped to localhost:5000 by default, reverse proxy it/Cloudflare tunnel it to make it publicly accessible (or whatever method you like!). .env file required, make a copy of .env.example to make your .env file.

## AI notice
The Dockerfile and Docker Compose file were AI written, and AI assistance throughout to teach me Tailwind and a bit about Flask. None of the HTML, CSS, and Python were AI generated though.