#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHON_BIN="${PYTHON_BIN:-python3.9}"
VENV_PATH="${VENV_PATH:-$HOME/backend-pics-venv}"
printf 'Setting up the capstone environment\n'
"$PYTHON_BIN" --version
"$PYTHON_BIN" -m venv "$VENV_PATH"
source "$VENV_PATH/bin/activate"
python -m pip install -r requirements-dev.txt
python -m pip check
printf 'Virtual environment: %s\n' "$VIRTUAL_ENV"
printf 'Capstone Environment Setup Complete\n'
