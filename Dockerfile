FROM pytorch/pytorch:2.7.1-cuda12.6-cudnn9-devel AS builder
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1

WORKDIR /app

COPY uv.lock uv.lock
COPY pyproject.toml pyproject.toml

RUN uv sync --locked --no-install-project --no-editable --group prod

FROM pytorch/pytorch:2.7.1-cuda12.6-cudnn9-runtime

WORKDIR /app

COPY . /app

COPY --from=builder /app/.venv /app/.venv

EXPOSE 8000

CMD ["/app/.venv/bin/uvicorn", "server:app", "--host", "0.0.0.0", "--port", "8000"]
