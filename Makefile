PYTHON_DIRS = api cli core mcp_server agent benchmarks metrics

.PHONY: install lint format format-check typecheck test ci

install:
	pip install uv
	uv pip install -e ".[dev]"

lint:
	uv run ruff check $(PYTHON_DIRS)

format:
	uv run ruff format $(PYTHON_DIRS)

format-check:
	uv run ruff format --check $(PYTHON_DIRS)

typecheck:
	uv run mypy $(PYTHON_DIRS)

test:
	uv run pytest tests/ -v --tb=short --cov=. --cov-report=xml --ignore=dashboard || { e=$$?; [ $$e -eq 5 ]; }

ci: lint format-check typecheck test
