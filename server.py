import os

from flask import Flask, render_template, request
import requests
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)

@app.route("/")
def index():
    return render_template("index.html")
@app.route("/callback")
def callback():
    code = request.args.get("code")
    token = requests.post("https://slack.com/api/oauth.v2.access", data={
        "client_id": os.environ.get("CLIENT_ID"),
        "client_secret": os.environ.get("CLIENT_SECRET"),
        "code": code,
        "redirect_uri": os.environ.get("REDIRECT_URI")
    })
    data = token.json()
    token = data["authed_user"]["access_token"]
    requests.post("https://slack.com/api/users.profile.set",
        headers={"Authorization": "Bearer " + token},
        json={"profile": {
            "status_text": "Distinguished Blåhaj member. Join The Blåhaj today at blahaj.numycode.dev",
            "status_emoji": ":blobhaj_party:",
            "status_expiration": 0

        }}
    )
    return render_template("callback.html")
