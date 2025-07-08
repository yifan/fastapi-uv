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
	uv run uvicorn app:app --reload --host=0.0.0.0 --port=8080 

build:
	docker buildx build --platform linux/amd64 -t fastapi-app .

requirements.txt:
	uv export --no-hashes --group prod -o requirements.txt
