FROM node:22-slim AS asset-builder

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY templates ./templates
COPY static ./static
RUN npx @tailwindcss/cli -i ./static/input.css -o ./static/style.css --minify
RUN npx html-minifier-terser \
    --input-dir ./templates --output-dir ./templates-min --file-ext html \
    --collapse-whitespace --remove-comments --remove-optional-tags \
    --remove-redundant-attributes --remove-script-type-attributes \
    --remove-tag-whitespace --use-short-doctype --minify-css true --minify-js true

FROM python:3.14-slim

WORKDIR /app

RUN pip install --no-cache-dir uv

COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev

COPY . .
COPY --from=asset-builder /app/static/style.css ./static/style.css
COPY --from=asset-builder /app/templates-min ./templates

ENV PYTHONUNBUFFERED=1

EXPOSE 5000

CMD ["uv", "run", "gunicorn", "-w", "2", "-b", "0.0.0.0:5000", "server:app"]