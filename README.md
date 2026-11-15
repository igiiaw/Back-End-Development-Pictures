# Back-End-Development-Pictures

Flask Pictures service for the IBM Back-end Application Development Capstone.

## Run

```sh
pip install -r requirements-dev.txt
python -m flask --app backend run --port 8081
python -m pytest -v
```

Endpoints: GET `/health`, GET `/count`, GET `/picture`, GET `/picture/<id>`, POST `/picture`, PUT `/picture/<id>`, DELETE `/picture/<id>`.

The service starts with the supplied ten-picture dataset. Changes are stored in process memory, as in the course exercise. The Docker image runs one worker on port 3000.

All 11 original course tests pass. Based on the IBM course starter; see LICENSE.

## Environment Setup Confirmation

- Repository created from the official IBM course template, retaining its LICENSE and history.
- `bash bin/setup.sh` executed successfully with **Python 3.9.25** in a disposable Linux validation container.
- The script created and activated **backend-pics-venv** at `/root/backend-pics-venv`.
- Installation of requirements-dev.txt completed; Flask 3.1.3, Gunicorn 23.0.0 and pytest 8.4.2 were installed.
- `python -m pip check` reported `No broken requirements found.`
- The setup finished with `Capstone Environment Setup Complete`.
- To repeat: install Python 3.9 with venv support, then run `bash bin/setup.sh` from the repository. Override PYTHON_BIN or VENV_PATH when necessary.

The container image used to deploy the service continues to use Python 3.12.
