FROM python:3.14-slim

WORKDIR /app

RUN pip install --no-cache-dir uv

COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev

COPY . .

ENV PYTHONUNBUFFERED=1

EXPOSE 5000

CMD ["uv", "run", "gunicorn", "-w", "2", "-b", "0.0.0.0:5000", "server:app"]