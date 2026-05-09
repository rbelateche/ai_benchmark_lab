# AI Integration Benchmark Lab

Benchmark an LLM agent completing identical tasks through three integration methods:

| Method | Transport | Best for |
|--------|-----------|----------|
| **REST API** | HTTP | Production services, high throughput |
| **CLI** | subprocess | Local automation, scripting |
| **MCP server** | MCP protocol | Autonomous agents, tool discovery |

## What is measured

- **Latency** — time from request to result
- **Token consumption** — prompt + completion tokens per strategy
- **Resource usage** — RAM, CPU, network traffic
- **Reliability** — retries, timeouts, schema failures

## Project structure

```
ai_benchmark_lab/
├── api/              # FastAPI REST layer
├── cli/              # Typer CLI layer
├── core/             # Shared business logic & models
│   └── tasks/        # Pure task implementations
├── mcp_server/       # MCP server & tools
│   └── tools/
├── agent/            # LLM agent + strategy runners
│   └── strategies/
├── benchmarks/       # Scenario runners & SQLite storage
│   └── scenarios/
├── metrics/          # Prometheus + OpenTelemetry
├── dashboard/        # React + Recharts frontend
└── tests/
```

## Setup

```bash
pip install uv
uv pip install --system -e ".[dev]"
```

## Development workflow

```bash
make install        # install all dependencies
make lint           # ruff check
make format         # ruff format
make typecheck      # mypy
make test           # pytest
make ci             # run all checks (lint + format-check + typecheck + test)
```

> Run `make ci` before every commit.

## Running

```bash
# Start API server
uvicorn api.main:app --reload

# Use the CLI
ai-bench search --path . --pattern TODO
ai-bench git-search --keyword FIX
ai-bench shell --cmd "ls -la"

# Start MCP server
python -m mcp_server.server

# Run benchmarks
python -m benchmarks.runner

# Start dashboard
cd dashboard && npm run dev
```