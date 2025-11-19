APP=fastapi-app

.PHONY: test requirements.txt
init:
	@echo "✅ Installing pre-commit hooks..."
	@pre-commit install
	@echo "✅ Initializing Git LFS..."
	@git lfs install
	@echo "🎉 Done!"

test:
	uv run pytest

dev:
	uv run uvicorn app.app:app \
	  --reload \
	  --reload-dir app \
	  --reload-include "*.yaml" \
	  ----host=0.0.0.0 \
	  --port=8000

build:
	git archive --format=tar HEAD | docker build --platform linux/amd64 -t $(APP) -f Dockerfile -

requirements.txt:
	uv export --no-dev --no-hashes --group prod -o requirements.txt
