# Deploy — DigitalOcean App Platform

The dashboard is a single self-contained `index.html`, served in production by
**nginx** inside a Docker container.

## Files
| File            | Purpose                                                        |
|-----------------|----------------------------------------------------------------|
| `Dockerfile`    | Builds the nginx image and copies `index.html` into it.        |
| `nginx.conf`    | Server config: listens on `8080`, gzip, safe headers.          |
| `.dockerignore` | Keeps the build context tiny (only `index.html` ships).        |
| `.do/app.yaml`  | App Platform spec (service, port, GitHub source, health check).|

> This folder **is** the GitHub repo `nicolas04rodriguez-debug/KIA---Dashboards`
> that DigitalOcean builds from. GitHub Pages keeps working in parallel —
> `.nojekyll` stays and Pages ignores the Docker/YAML files.

## One-time setup
1. In the DigitalOcean dashboard, connect your GitHub account
   (**Settings → Developer / GitHub**), granting access to the
   `KIA---Dashboards` repo.
2. Install the CLI if you want to deploy from the terminal:
   `doctl auth init`.

## Deploy

### Option A — DigitalOcean dashboard (no CLI)
1. **Apps → Create App → GitHub →** pick `KIA---Dashboards`, branch `main`.
2. DO auto-detects `.do/app.yaml` (and the `Dockerfile`). Confirm the plan
   (**Basic, 1 vCPU / 0.5 GB, ~$5/mo**) and click **Create Resources**.
3. Wait for the build; you get a `*.ondigitalocean.app` URL.

### Option B — CLI
```bash
cd site
doctl apps create --spec .do/app.yaml        # first deploy
# later, to update an existing app:
doctl apps update <APP_ID> --spec .do/app.yaml
```

`deploy_on_push: true` means every `git push` to `main` triggers a redeploy.

## Test the image locally (optional)
```bash
cd site
docker build -t kia-dashboard .
docker run --rm -p 8080:8080 kia-dashboard
# open http://localhost:8080
```

## Custom domain (optional)
In the app's **Settings → Domains**, add your domain and follow the DNS
instructions (CNAME to the app). App Platform provisions HTTPS automatically.

## Notes
- The service listens on **8080** — keep `EXPOSE`, `nginx listen`, and
  `http_port` in sync if you change it.
- The access code (`KiaUrbex25`) still protects the data client-side, exactly
  as on GitHub Pages — hosting on App Platform doesn't change that.
