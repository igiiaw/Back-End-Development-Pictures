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
