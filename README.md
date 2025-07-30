# 🏗️ Personal Infrastructure

> 🚀 Infrastructure code, scripts, and configuration for my personal server deployment

[![AWS](https://img.shields.io/badge/AWS-Lightsail-FF9900?style=flat-square&logo=amazon-aws)](https://aws.amazon.com/lightsail/)
[![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?style=flat-square&logo=docker)](https://docs.docker.com/compose/)
[![Traefik](https://img.shields.io/badge/Traefik-v3.5.0-24A1C1?style=flat-square&logo=traefikproxy)](https://traefik.io/)
[![AlmaLinux](https://img.shields.io/badge/AlmaLinux-9.4-0F4266?style=flat-square&logo=almalinux)](https://almalinux.org/)

## 📋 Table of Contents

- [🔧 Prerequisites](#-prerequisites)
- [🚀 Quick Start](#-quick-start)
- [🏠 Server Setup](#-server-setup)
- [📦 Deployment](#-deployment)
- [🌐 Production Setup](#-production-setup)
- [🛠️ Useful Commands](#️-useful-commands)
- [🔒 Security Features](#-security-features)

## 🔧 Prerequisites

Before starting, ensure you have completed these setup steps:

### ☁️ AWS Setup
1. **📦 Setup ECR repository** to store Docker containers
2. **👤 Create service account** with container registry power user policy
3. **🔑 Configure AWS CLI** - run `aws configure` to enable container registry access
4. **🖥️ Create AWS Lightsail instance**:
   - 🔐 Provide SSH key during setup
   - 💰 Choose plan with IPv4 address (recommended: $12/month plan)
   - 🐧 Select AlmaLinux 9.4 as the OS

### 🔗 Network Configuration
5. **🌍 Configure DNS**:
   - Point your domain's DNS A record to your server IP
   - Verify with: `nslookup jonahjacobsen.com`
   - ✅ Proceed only after DNS propagation is complete
6. **⚙️ Configure SSH** - Add to `~/.ssh/config`:
```bash
Host server
  User ec2-user
  HostName jonahjacobsen.com
  IdentityFile ~/.ssh/id_rsa
```

## 🚀 Quick Start

### 1️⃣ Server Access & Repository Setup

**🔑 Generate SSH key on server** (if not exists):
```bash
ssh server
ssh-keygen -t ed25519
cat ~/.ssh/id_ed25519.pub
```

**🔗 Add public key to GitHub**:
- Copy the output from `cat ~/.ssh/id_ed25519.pub`
- Go to GitHub → Settings → SSH and GPG keys → New SSH key
- Paste and save the key

**📥 Clone repository on server**:
```bash
sudo dnf install git
git clone git@github.com:jjjacobsen/infra.git
cd infra
```

### 2️⃣ Bootstrap Installation

**🏗️ Run the bootstrap script**:
```bash
./bootstrap.sh
```

**🔄 For future updates**:
```bash
git pull
```

## 🏠 Server Setup

The `bootstrap.sh` script automatically installs and configures:

- 📦 **System packages** (curl, wget, git, unzip, tar)
- ☁️ **AWS CLI** for ECR authentication
- 🐳 **Docker & Docker Compose** for container orchestration
- 👥 **User permissions** (adds user to docker group)

## 📦 Deployment

### 🔐 ECR Authentication

**Required for private repository access**:
```bash
aws configure
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 475365909498.dkr.ecr.us-east-2.amazonaws.com
```

## 🌐 Production Setup

### ⚙️ Environment Variables

Create a `.env` file in the project root with the following variables:

```bash
# 🔐 Traefik Dashboard Authentication
TRAEFIK_ADMIN_USER=admin
TRAEFIK_ADMIN_PASSWORD=your_hashed_password_here
```

> ⚠️ **Security Note**: Generate a secure hashed password using: `htpasswd -nb admin your_password`

### 🚀 Launch Production

**🔒 Start with HTTPS & Let's Encrypt**:
```bash
docker compose --env-file .env up -d
```

## 🛠️ Useful Commands

### 📊 Monitoring & Logs
```bash
# 📜 View real-time logs
docker compose logs -f

# 🔍 Check container status
docker compose ps

# 📈 Monitor resource usage
docker stats
```

### 🔄 Updates & Maintenance
```bash
# 🆙 Quick update with script
./update.sh

# 🆙 Or manually pull latest images and restart
docker compose pull
docker compose --env-file .env up -d

# 🛑 Stop all services
docker compose down

# 🧹 Clean up unused resources
docker system prune -f
```

### 🔧 Troubleshooting
```bash
# 🔍 Debug specific service
docker compose logs service_name

# 🚪 Access container shell
docker compose exec service_name sh

# 📋 Inspect container configuration
docker compose config
```

## 🔒 Security Features

This infrastructure includes several security enhancements:

- 🛡️ **Rate Limiting**: Dashboard access is rate-limited (10 req/min, burst: 20)
- 🔐 **Basic Authentication**: Password-protected Traefik dashboard
- 🔒 **HTTPS**: Automatic SSL/TLS certificates via Let's Encrypt
- 🚦 **Automatic Redirects**: HTTP to HTTPS redirection
- 🔥 **Firewall**: Docker networks isolate services
- 📝 **Access Logs**: Comprehensive logging for monitoring

---

<div align="center">

**🎉 Happy Deploying!** 

*Built with ❤️ using Docker, Traefik, and AWS*

</div>
