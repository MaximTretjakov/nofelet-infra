# Nofelet Infrastructure

Infrastructure repository for deploying and maintaining the Nofelet platform.

This repository contains the complete server infrastructure configuration required to run Nofelet in production using Docker Compose.

## Services

The following services are managed by this repository:

* Nofelet Web
* Nofelet Chat
* Nofelet Signaling
* CoTURN
* PostgreSQL
* Fail2Ban
* Netdata

Application source code is stored in separate repositories:

* nofelet-web
* nofelet-chat
* nofelet-signaling

Docker images are automatically built and published to GitHub Container Registry (GHCR).

---

## Repository Structure

```text
.
├── docker-compose.yml
├── .env.example
├── scripts/
├── fail2ban/
├── coturn/
```

### scripts/

Infrastructure management scripts.

Examples:

* install.sh

### fail2ban/

Fail2Ban configuration and filters.

### coturn/

CoTURN configuration files.

### netdata/

Netdata monitoring configuration.

---

## Requirements

* Ubuntu 24.04 LTS (recommended)
* Docker
* Docker Compose Plugin
* Git

---

## Initial Server Setup

Clone repository:

```bash
git clone https://github.com/<your-account>/nofelet-infra.git

cd nofelet-infra
```

Create environment file:

```bash
cp .env.example .env
```

Edit configuration:

```bash
nano .env
```

Install dependencies:

```bash
./scripts/install.sh
```

Start services:

```bash
docker compose up -d
```

Verify status:

```bash
docker compose ps
```

---

## Logs

View all logs:

```bash
docker compose logs -f
```

View service logs:

```bash
docker compose logs -f nofelet-signaling
```

---

## Security

The repository intentionally excludes all production secrets.

Never commit:

* .env
* private keys
* TLS certificates
* production passwords
* API tokens

Use `.env.example` as a template for creating local or production configuration files.

---

## Disaster Recovery

To deploy on a new server:

```bash
git clone <repository>
cp .env.example .env
nano .env
./scripts/install.sh
docker compose up -d
```

Target recovery time: less than 15 minutes.
