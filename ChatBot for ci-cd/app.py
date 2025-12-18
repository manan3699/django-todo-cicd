from flask import Flask, render_template, request, jsonify
from openai import OpenAI
import os

app = Flask(__name__)

client = OpenAI(
    api_key="---" 
)

@app.route("/")
def index():
    return render_template("chatbot.html")

@app.route("/chat", methods=["POST"])
def chat():
    user_message = request.json.get("message", "")

    try:
        response = client.chat.completions.create(
            model="gpt-4o-mini",  # CHEAP & ACCURATE
            messages=[
                {
                    "role": "system",
                    "content": "You are a helpful assistant specialized in CI/CD pipelines and Google Cloud Platform (GCP). Answer simply and clearly."
                },
                {
                    "role": "user",
                    "content": user_message
                }
            ],
            max_tokens=150
        )

        reply = response.choices[0].message.content
        return jsonify({"reply": reply})

    except Exception as e:
        print("OpenAI Error:", e)  # VERY IMPORTANT
        return jsonify({"reply": "Error: Unable to get response from OpenAI."}), 500

if __name__ == "__main__":
    app.run(debug=True)


