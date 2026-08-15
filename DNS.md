# Pointing adamschepis.com at GitHub Pages

Do these in order. Step 1 is at your domain registrar / DNS host, step 2 is on GitHub.

## 1. Records to add

At the **apex** (`adamschepis.com`, sometimes shown as `@` or blank host), add
four `A` records — all four, they're GitHub's load balancer:

| Type | Host | Value           | TTL  |
|------|------|-----------------|------|
| A    | @    | 185.199.108.153 | 3600 |
| A    | @    | 185.199.109.153 | 3600 |
| A    | @    | 185.199.110.153 | 3600 |
| A    | @    | 185.199.111.153 | 3600 |

And the IPv6 equivalents (optional but recommended):

| Type | Host | Value                | TTL  |
|------|------|----------------------|------|
| AAAA | @    | 2606:50c0:8000::153  | 3600 |
| AAAA | @    | 2606:50c0:8001::153  | 3600 |
| AAAA | @    | 2606:50c0:8002::153  | 3600 |
| AAAA | @    | 2606:50c0:8003::153  | 3600 |

For `www`, one CNAME:

| Type  | Host | Value                 | TTL  |
|-------|------|-----------------------|------|
| CNAME | www  | aschepis.github.io.   | 3600 |

Two things that commonly break this:

- **Delete any existing A / AAAA / ALIAS / CNAME at the apex first** (parking
  pages and registrar "forwarding" records both count). Conflicting apex records
  are the usual cause of the site not resolving.
- **Do not** CNAME the apex to `aschepis.github.io` unless your DNS host offers
  ALIAS/ANAME flattening. A plain CNAME at the apex is invalid and will break MX
  (email) for the domain.

## 2. Set the custom domain on GitHub

`public/CNAME` already contains `adamschepis.com`, so the deploy tells Pages the
domain. Confirm at **Settings → Pages** on `aschepis/aschepis.github.io`:

- Custom domain: `adamschepis.com`
- Wait for the DNS check to go green (minutes to an hour after the records
  propagate), then tick **Enforce HTTPS**. The certificate is issued by GitHub
  via Let's Encrypt and renews automatically — it can't be issued until DNS
  resolves, so this checkbox stays greyed out until step 1 lands.

## 3. Verify

```sh
dig +short adamschepis.com            # → the four 185.199.x.153 addresses
dig +short www.adamschepis.com        # → aschepis.github.io + those addresses
curl -sI https://adamschepis.com | head -1   # → HTTP/2 200
```

Propagation is usually minutes, but allow up to 24h if the old records had a
long TTL.

## Note while DNS is pending

Once a custom domain is set, `https://aschepis.github.io` **301-redirects** to
`https://adamschepis.com`. That's expected — the site will look broken from the
github.io URL until the DNS records above resolve.

## Optional: domain verification

**GitHub → Settings → Pages → Add a domain** gives you a `_github-pages-challenge-aschepis`
TXT record to add. Verifying stops anyone else from taking over the domain on
Pages if the repo is ever deleted. Not required for the site to work.
