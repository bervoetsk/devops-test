# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Install Git and build tools, clone the app
RUN apt-get update && \
    apt-get install -y git build-essential && \
    git clone https://github.com/bervoetsk/devops-test.git . && \
    apt-get remove -y git && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Create a virtual environment
RUN python3 -m venv venv
ENV PATH="/app/venv/bin:$PATH"

# Install dependencies + Gunicorn
RUN pip install --upgrade pip && \
    pip install -r requirements.txt && \
    pip install gunicorn

# Set environment variables
ENV FLASK_APP=crudapp.py
ENV FLASK_ENV=production

# Expose port used by Gunicorn
EXPOSE 8000

# Run Gunicorn as WSGI server (don't use flask run in production)
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "crudapp:app"]
