# adamschepis.com

Personal homepage. Plain HTML and CSS, no build step, no dependencies.
Published to GitHub Pages at `aschepis.github.io`, served at **adamschepis.com**.

## Layout

```
public/          # everything that gets published
  index.html
  style.css
  CNAME          # custom domain, read by GitHub Pages on deploy
.github/workflows/pages.yml
```

Edit `public/index.html` for copy, `public/style.css` for type and color.

## Preview locally

```sh
python3 -m http.server -d public 8000
# http://localhost:8000
```

## Deploying

Every push to `main` runs `.github/workflows/pages.yml`, which uploads `public/`
as a Pages artifact and deploys it. No `gh-pages` branch involved.

One-time repo setup (already done): **Settings → Pages → Build and deployment →
Source: GitHub Actions**.

## DNS

`adamschepis.com` isn't pointed here yet — it needs apex A records at GoDaddy and
a one-time domain verification on the GitHub account. See [DNS.md](DNS.md).
