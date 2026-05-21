# GitHub + Cloud Run Automated Deployment Setup

This guide will help you set up automatic deployment to Google Cloud Run whenever you push to GitHub.

## 🎯 What You'll Get

✅ **Automatic deployments** - Push to GitHub → Website updates automatically  
✅ **Version control** - Track all changes to your website  
✅ **Easy updates** - Edit `index.html`, commit, push - done!  
✅ **Free hosting** - Cloud Run free tier is generous

---

## 📋 Prerequisites

- [x] GitHub account created
- [ ] Google Cloud account with billing enabled
- [ ] Git installed on your computer

**Install Git (if needed):**
- Windows: https://git-scm.com/download/win
- Mac: `brew install git`
- Linux: `sudo apt install git`

---

## 🚀 Setup Steps

### Step 1: Create Google Cloud Project & Service Account

1. **Go to Google Cloud Console:** https://console.cloud.google.com

2. **Create a new project** (or use existing):
   - Click project dropdown at top
   - Click "New Project"
   - Name: `thomas-francis-portfolio`
   - Click "Create"

3. **Enable Required APIs:**
   ```bash
   # Open Cloud Shell (terminal icon at top right) and run:
   gcloud services enable run.googleapis.com
   gcloud services enable cloudbuild.googleapis.com
   ```

4. **Create Service Account:**
   ```bash
   # In Cloud Shell, run these commands:
   
   # Set your project ID (replace with your actual project ID)
   PROJECT_ID="thomas-francis-portfolio"
   gcloud config set project $PROJECT_ID
   
   # Create service account
   gcloud iam service-accounts create github-actions \
     --display-name="GitHub Actions Service Account"
   
   # Grant permissions
   gcloud projects add-iam-policy-binding $PROJECT_ID \
     --member="serviceAccount:github-actions@${PROJECT_ID}.iam.gserviceaccount.com" \
     --role="roles/run.admin"
   
   gcloud projects add-iam-policy-binding $PROJECT_ID \
     --member="serviceAccount:github-actions@${PROJECT_ID}.iam.gserviceaccount.com" \
     --role="roles/storage.admin"
   
   gcloud projects add-iam-policy-binding $PROJECT_ID \
     --member="serviceAccount:github-actions@${PROJECT_ID}.iam.gserviceaccount.com" \
     --role="roles/iam.serviceAccountUser"
   
   # Create and download key
   gcloud iam service-accounts keys create key.json \
     --iam-account=github-actions@${PROJECT_ID}.iam.gserviceaccount.com
   
   # Display the key (you'll need this for GitHub)
   cat key.json
   ```

5. **Copy the entire JSON output** - you'll need it in Step 3

---

### Step 2: Create GitHub Repository

1. **Go to GitHub:** https://github.com

2. **Create new repository:**
   - Click the "+" icon (top right) → "New repository"
   - Repository name: `thomas-francis-portfolio`
   - Description: `Professional portfolio website`
   - Choose: **Private** (recommended) or Public
   - **Do NOT** initialize with README, .gitignore, or license
   - Click "Create repository"

3. **Copy the repository URL** - it will look like:
   ```
   https://github.com/YOUR-USERNAME/thomas-francis-portfolio.git
   ```

---

### Step 3: Add Secrets to GitHub

1. **Go to your GitHub repository**

2. **Click "Settings" tab** (top right)

3. **Click "Secrets and variables"** → **"Actions"** (left sidebar)

4. **Click "New repository secret"**

5. **Add TWO secrets:**

   **Secret #1: GCP_PROJECT_ID**
   - Name: `GCP_PROJECT_ID`
   - Value: Your Google Cloud project ID (e.g., `thomas-francis-portfolio`)
   - Click "Add secret"

   **Secret #2: GCP_SA_KEY**
   - Name: `GCP_SA_KEY`
   - Value: Paste the entire JSON key from Step 1 (the output from `cat key.json`)
   - Click "Add secret"

---

### Step 4: Push Your Code to GitHub

Open **Git Bash** (Windows) or **Terminal** (Mac/Linux) and run:

```bash
# Navigate to your website directory
cd "C:\Users\MANAT\OneDrive - Pegasystems Inc\Documents\Thomas\Personal\Personal Website"

# Initialize git repository
git init

# Add all files
git add .

# Create first commit
git commit -m "Initial commit: Thomas Francis Portfolio"

# Add GitHub as remote (replace YOUR-USERNAME)
git remote add origin https://github.com/YOUR-USERNAME/thomas-francis-portfolio.git

# Push to GitHub (this triggers deployment!)
git branch -M main
git push -u origin main
```

**GitHub will ask for authentication:**
- Username: Your GitHub username
- Password: Use a **Personal Access Token** (not your password)

**To create Personal Access Token:**
1. GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Generate new token → Select "repo" scope → Generate
3. Copy token and use it as password

---

### Step 5: Watch Deployment Happen! 🎉

1. **Go to your GitHub repository**

2. **Click "Actions" tab** (top)

3. **You'll see "Deploy to Cloud Run" running**

4. **Click on the workflow** to watch progress

5. **When complete**, you'll see your website URL in the summary!

---

## 🔄 How to Update Your Website

Making changes is now super easy:

```bash
# 1. Edit your file
# Open index.html in any text editor, make changes, save

# 2. Navigate to directory (if not already there)
cd "C:\Users\MANAT\OneDrive - Pegasystems Inc\Documents\Thomas\Personal\Personal Website"

# 3. Commit and push
git add .
git commit -m "Updated contact information"
git push

# That's it! GitHub Actions automatically deploys to Cloud Run
```

---

## 🎨 Common Updates

### Update Contact Info

Edit `index.html`, search for:
```html
<a href="mailto:tfmanavalan@gmail.com">tfmanavalan@gmail.com</a>
```

### Update Career Stats

Search for:
```html
<div class="stat">
    <span class="stat-number">20+</span>
```

### Add New Achievement

Find the `highlights-grid` section and add:
```html
<div class="highlight-card">
    <div class="highlight-icon">🎯</div>
    <h3>Your Achievement Title</h3>
    <div class="metric">$50M</div>
    <p><strong>Description</strong> - Details here</p>
</div>
```

---

## 🛠️ Troubleshooting

### Deployment Failed?

**Check GitHub Actions logs:**
1. Go to Actions tab
2. Click the failed workflow
3. Click the failed job
4. Read error message

**Common issues:**

**Error: "Permission denied"**
- Make sure GCP_SA_KEY secret is correct
- Check service account has proper roles

**Error: "Project not found"**
- Verify GCP_PROJECT_ID secret is correct
- Make sure project exists in GCP

**Error: "API not enabled"**
```bash
# Run in Cloud Shell:
gcloud services enable run.googleapis.com
gcloud services enable cloudbuild.googleapis.com
```

### Git Issues

**Error: "remote origin already exists"**
```bash
git remote remove origin
git remote add origin https://github.com/YOUR-USERNAME/thomas-francis-portfolio.git
```

**Error: "Authentication failed"**
- Use Personal Access Token, not password
- Make sure token has "repo" scope

---

## 🌐 Custom Domain (Optional)

Want to use `thomasfrancis.com` instead of the Cloud Run URL?

1. **In Google Cloud Console:**
   - Go to Cloud Run
   - Click your service
   - Click "Manage Custom Domains"
   - Follow instructions

2. **Add DNS records** at your domain provider

---

## 📊 Monitor Your Website

**View logs:**
```bash
gcloud run logs read thomas-francis-portfolio --region us-central1
```

**View in Cloud Console:**
- https://console.cloud.google.com/run
- Click your service
- See metrics, logs, revisions

---

## 💰 Cost

**Expected cost: $0/month** 

Cloud Run free tier includes:
- 2 million requests/month
- 360,000 GB-seconds/month
- 180,000 vCPU-seconds/month

A portfolio website with moderate traffic stays well within free tier!

---

## 🔒 Security

**Make repository private?**
- Go to repository Settings → Danger Zone → Change visibility → Private

**The website will still be public** (as configured), but source code is private.

---

## 📁 Project Structure

```
Personal Website/
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions workflow
├── index.html                  # Your website
├── Dockerfile                  # Container config
├── nginx.conf                  # Web server config
├── .gitignore                  # Git ignore file
├── .gcloudignore              # GCloud ignore file
├── README.md                   # Local deployment docs
└── GITHUB_SETUP.md            # This file
```

---

## 🎓 Git Cheat Sheet

```bash
# Check status
git status

# See what changed
git diff

# Add specific file
git add index.html

# Add all files
git add .

# Commit with message
git commit -m "Your message here"

# Push to GitHub (triggers deployment)
git push

# View commit history
git log

# Undo last commit (keeps changes)
git reset --soft HEAD~1

# Discard all local changes
git checkout .
```

---

## 📞 Support

**Thomas Francis**  
Email: tfmanavalan@gmail.com  
Phone: +1-416-879-1731

**Helpful Resources:**
- GitHub Actions: https://docs.github.com/en/actions
- Cloud Run: https://cloud.google.com/run/docs
- Git: https://git-scm.com/doc

---

## ✅ Checklist

- [ ] Google Cloud project created
- [ ] Service account created with proper permissions
- [ ] Service account key downloaded
- [ ] GitHub repository created
- [ ] GitHub secrets added (GCP_PROJECT_ID, GCP_SA_KEY)
- [ ] Git installed locally
- [ ] Code pushed to GitHub
- [ ] GitHub Actions workflow ran successfully
- [ ] Website is live!

---

**Ready to go live? Follow the steps above and you'll have your portfolio deployed in minutes! 🚀**
