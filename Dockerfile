# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install git and other system dependencies, then clone the repository
RUN apt-get update && apt-get install -y git build-essential && \
    git clone https://github.com/gurkanakdeniz/example-flask-crud.git . && \
    apt-get remove -y git && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Create and activate a virtual environment
RUN python3 -m venv venv
ENV PATH="/app/venv/bin:$PATH"

# Upgrade pip and install dependencies, including gunicorn
RUN pip install --upgrade pip && \
    pip install -r requirements.txt && \
    pip install gunicorn

# Set environment variables
ENV FLASK_APP=crudapp.py
ENV FLASK_ENV=production

# Run database migrations
RUN flask db upgrade

# Expose port 80 for the app
EXPOSE 80

# Run Gunicorn WSGI server
CMD ["gunicorn", "--bind", "0.0.0.0:80", "crudapp:app"]
