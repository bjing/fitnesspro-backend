# FitnessPro
This app currently only provides RESTFUL endpoints for calculating BMR and TDEE for an individual.

The project uses [stack](https://docs.haskellstack.org/en/stable/README/) to manage the project.

## Building the project
```
stack build
```

## Running tests and coverage
```
stack test
stack test --coverage
```

## Starting an interactive shell (ghci) for testing purpose
```
stack ghci
```
If you want to start the server wihin ghci, simply run the `main` function under the ghci prompt.

## Running app server locally
```
stack exec fitnesspro-backend
```

## Enable/Disable Docker container support
Change option `enable` under `docker` in `stack.yml` to true if you want the app to run in a Docker container,
and false otherwise.
```
# Docker build setup
# All stack commands will run inside a Linux container
docker:
  enable: false
  run-args: ["--net=bridge", "-p", "8000:8000", "-p", "3000:3000"]
```
__Please note__ if Docker container support is enabled, your local IDE linting support may be hindered.

## Resource monitoring
### Through UI
To view real time stats around request and OS resource usage, simply visit http://localhost:8000.

### Through HTTP request
To query the above stats through HTTP request, simply invoke a GET call like the following
```
curl -H "Accept: application/json" http://localhost:8000/
```
and you will get a JSON response.
