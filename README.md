# infra
Infrastructure code, scripts, and config for my personal server

### Some Pre-Work
1. Setup ECR repo to store containers
2. Create service account and give it the container registry power user policy
3. Setup awscli and run `aws configure` to push containers to registry
4. Create AWS lightsail instance
    - provide ssh key
    - choose plan that includes IPv4 address (I chose the $12 one)
    - AlmaLinux 9.4
5. Can now ssh to server with `ssh ec2-user@3.148.251.254`
6. Add entry to ~/.ssh/config
```
Host server
  User ec2-user
  HostName 3.148.251.254
  IdentityFile ~/.ssh/id_rsa
```


### Deploy Repo to Server

1. **Generate SSH key on server (if not exists):**
   ```bash
   ssh server
   ssh-keygen -t ed25519
   cat ~/.ssh/id_ed25519.pub
   ```

2. **Add the public key to your GitHub account:**
   - Copy the output from `cat ~/.ssh/id_ed25519.pub`
   - Go to GitHub → Settings → SSH and GPG keys → New SSH key
   - Paste the key and save

3. **Clone repo on server:**
   ```bash
   sudo dnf install git
   git clone git@github.com:jjjacobsen/infra.git
   cd infra
   ```

4. **Run bootstrap:**
   ```bash
   ./bootstrap.sh
   ```

5. **For future updates:**
   ```bash
   git pull
   ```
