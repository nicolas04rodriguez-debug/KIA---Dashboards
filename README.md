# KIA · Secondary Market Intelligence — Dashboard

A self-contained, password-gated dashboard (leads + interactive car heat map for
Bogotá D.C.). Everything runs in the browser; there is no backend.

**Security:** both the leads and the heat-map location data are AES-encrypted.
Opening the page shows only a login; nothing sensitive is in the page source
until the correct access code is entered. The access code is **not** stored in
this repository — share it privately with your team.

## Deploy to GitHub Pages (free)

1. Create a **new repository** on GitHub (public is fine — the data is encrypted).
   Do **not** initialize it with a README.
2. From this `site/` folder, connect it and push:
   ```bash
   git remote add origin https://github.com/<your-user>/<your-repo>.git
   git branch -M main
   git push -u origin main
   ```
3. On GitHub: **Settings → Pages → Build and deployment → Source: "Deploy from a
   branch" → Branch: `main` / `/ (root)` → Save.**
4. Wait ~1 minute. Your live URL will be:
   `https://<your-user>.github.io/<your-repo>/`

To update the site later, replace `index.html`, then `git commit` + `git push`.

## Files
- `index.html` — the dashboard (2.8 MB, fully self-contained, encrypted).
- `.nojekyll` — tells GitHub Pages to serve the file as-is (no Jekyll processing).
