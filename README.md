# Thomas Francis Portfolio - Google Cloud Run Deployment

Professional portfolio website showcasing 20+ years of enterprise AI and solution consulting leadership.

## 🚀 Quick Deploy to Google Cloud Run

### Prerequisites
1. Google Cloud account with billing enabled
2. gcloud CLI installed: https://cloud.google.com/sdk/docs/install
3. A Google Cloud project

### One-Command Deploy

```bash
# Navigate to this directory
cd "C:\Users\MANAT\OneDrive - Pegasystems Inc\Documents\Thomas\Personal\Personal Website"

# Deploy (Cloud Run will build and deploy automatically)
gcloud run deploy thomas-francis-portfolio \
  --source . \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --port 8080
```

That's it! You'll get a URL like: `https://thomas-francis-portfolio-XXXX.run.app`

---

## 📋 Step-by-Step Instructions

### 1. Install gcloud CLI (if not already installed)

**Windows:**
Download from: https://cloud.google.com/sdk/docs/install

**Mac/Linux:**
```bash
curl https://sdk.cloud.google.com | bash
exec -l $SHELL
```

### 2. Login and Configure

```bash
# Login to Google Cloud
gcloud auth login

# List your projects
gcloud projects list

# Set your project (replace with your actual project ID)
gcloud config set project YOUR-PROJECT-ID
```

### 3. Enable Required APIs

```bash
# Enable Cloud Run and Cloud Build APIs
gcloud services enable run.googleapis.com
gcloud services enable cloudbuild.googleapis.com
```

### 4. Deploy Your Website

```bash
# From the Personal Website directory, run:
gcloud run deploy thomas-francis-portfolio \
  --source . \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --port 8080 \
  --memory 256Mi \
  --cpu 1 \
  --max-instances 10
```

**What happens:**
- Cloud Run builds a Docker container from your files
- Deploys it to Google's infrastructure
- Gives you an HTTPS URL automatically
- Scales automatically based on traffic

### 5. Get Your URL

After deployment completes, you'll see output like:
```
Service URL: https://thomas-francis-portfolio-abc123-uc.a.run.app
```

That's your live website! 🎉

---

## 🌐 Custom Domain (Optional)

Want to use your own domain like `thomasfrancis.com`?

### Step 1: Map Domain
```bash
gcloud run domain-mappings create \
  --service thomas-francis-portfolio \
  --domain yourdomain.com \
  --region us-central1
```

### Step 2: Add DNS Records
Google will give you DNS records to add to your domain provider (GoDaddy, Namecheap, etc.)

---

## 🔄 Update Your Website

Made changes to `index.html`? Just redeploy:

```bash
gcloud run deploy thomas-francis-portfolio \
  --source . \
  --region us-central1 \
  --allow-unauthenticated \
  --port 8080
```

---

## 💰 Cost Estimate

**Cloud Run Pricing (Free Tier):**
- 2 million requests/month - FREE
- 360,000 GB-seconds/month - FREE
- 180,000 vCPU-seconds/month - FREE

For a personal portfolio with light traffic, **you'll likely stay free forever!**

After free tier:
- ~$0.00002400 per request
- $0.00002400 per GB-second

**Example:** 10,000 visits/month = Still FREE ✅

---

## ⚙️ Advanced Configuration

### Change Region

Available regions:
- `us-central1` (Iowa) - Default
- `us-east1` (South Carolina)
- `us-west1` (Oregon)
- `europe-west1` (Belgium)
- `asia-northeast1` (Tokyo)

```bash
gcloud run deploy thomas-francis-portfolio \
  --source . \
  --region YOUR-PREFERRED-REGION \
  --allow-unauthenticated \
  --port 8080
```

### Make Website Private

Require authentication:
```bash
gcloud run deploy thomas-francis-portfolio \
  --source . \
  --region us-central1 \
  --no-allow-unauthenticated \
  --port 8080
```

### Increase Resources

For high traffic:
```bash
gcloud run deploy thomas-francis-portfolio \
  --source . \
  --region us-central1 \
  --memory 512Mi \
  --cpu 2 \
  --max-instances 100 \
  --allow-unauthenticated \
  --port 8080
```

---

## 🛠️ Troubleshooting

### Check Service Status
```bash
gcloud run services describe thomas-francis-portfolio --region us-central1
```

### View Logs
```bash
gcloud run logs read thomas-francis-portfolio --region us-central1
```

### Delete Service
```bash
gcloud run services delete thomas-francis-portfolio --region us-central1
```

### Common Issues

**Error: "Project not found"**
```bash
gcloud projects list
gcloud config set project YOUR-ACTUAL-PROJECT-ID
```

**Error: "API not enabled"**
```bash
gcloud services enable run.googleapis.com
gcloud services enable cloudbuild.googleapis.com
```

**Error: "Permission denied"**
Make sure you're logged in:
```bash
gcloud auth login
```

---

## 📁 Files in This Directory

- `index.html` - Your portfolio website (single file, self-contained)
- `Dockerfile` - Container configuration for Cloud Run
- `nginx.conf` - Web server configuration
- `.gcloudignore` - Files to ignore during deployment
- `README.md` - This file

---

## 🎯 What This Website Includes

✅ Professional design with smooth animations  
✅ Mobile-responsive (looks great on phones/tablets)  
✅ Career highlights with metrics  
✅ Experience timeline  
✅ Core expertise sections  
✅ Contact information  
✅ Smooth scroll navigation  
✅ Fast loading (single HTML file)  

---

## 🔐 Security Notes

- Website is public by default (anyone can view)
- No sensitive data is stored
- HTTPS is enabled automatically by Cloud Run
- All traffic is encrypted

---

## 📞 Support

**Thomas Francis**  
Email: tfmanavalan@gmail.com  
Phone: +1-416-879-1731  
Location: Toronto, Canada  

**Google Cloud Run Documentation**  
https://cloud.google.com/run/docs

---

## 📝 Quick Reference Commands

```bash
# Deploy
gcloud run deploy thomas-francis-portfolio --source . --region us-central1 --allow-unauthenticated --port 8080

# View service
gcloud run services describe thomas-francis-portfolio --region us-central1

# Get URL
gcloud run services describe thomas-francis-portfolio --region us-central1 --format='value(status.url)'

# View logs
gcloud run logs read thomas-francis-portfolio --region us-central1

# Delete
gcloud run services delete thomas-francis-portfolio --region us-central1
```

---

**Built with ❤️ for enterprise leaders**

Good luck with your deployment! 🚀
