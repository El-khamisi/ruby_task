# Chat System API

This repository implements a simple Rails project for task purposes. Since the project's purpose is task-based, I have made the production environment as easy as possible, just run `docker-compose up` and  and voilaaa

## What I use?

- Rails V7: Used as the web framework for building the API.
- MySQL: Serves as the persistent database for storing applications, chats, and messages.
- Redis: Utilized for background job processing and caching.
- ElasticSearch: Provides search functionality for messages.
- Docker & Docker Compose: Used to containerize the web application and other services, making deployment and environment setup straightforward and consistent.


## Getting started
```
docker compose up
```
- Endpoint will be found at `http://localhost:3000/api-docs/index.html`

