FROM python:3.11-slim        # 1) Image de base avec Python
WORKDIR /app                 # 2) Dossier de travail dans l'image
COPY app.py .                # 3) On copie notre code dedans
RUN pip install --no-cache-dir flask  # 4) On installe Flask
EXPOSE 8080                  # 5) Le port sur lequel l'app écoute
CMD ["python", "app.py"]     # 6) Commande qui démarre l'app
