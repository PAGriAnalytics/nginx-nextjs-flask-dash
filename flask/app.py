# app.py
from flask import Flask
import dash_app1
import dash_app2

from flask_cors import CORS

app = Flask(__name__)
CORS(app)
# Инициализация Dash-приложений
dash_app1.init_dash(app)
dash_app2.init_dash(app)


# # Основная страница Flask-приложения
# @app.route('/')
# def index():
#     return render_template('index.html')

# if __name__ == '__main__':
#     app.run(host='0.0.0.0', port=8050)
