# Pointing adamschepis.com at GitHub Pages

DNS for this domain is at **GoDaddy** (`ns49/ns50.domaincontrol.com`):
`godaddy.com` → Domain Portfolio → `adamschepis.com` → **DNS** → Manage Zone.

## Current state

| Piece                     | State                                            |
|---------------------------|--------------------------------------------------|
| Domain verified on GitHub | ✅ `protected_domain_state: verified`            |
| Custom domain on the repo | ✅ `adamschepis.com`                             |
| `www` CNAME               | ✅ → `aschepis.github.io.`                       |
| Apex A records            | ✅ all four resolving                            |
| Site serving over HTTP    | ✅ `http://adamschepis.com` → 200                |
| **TLS certificate**       | ⏳ **`dns_changed` — issuance pending**          |
| Enforce HTTPS             | ⏳ blocked until the certificate is issued       |

The DNS work is finished. The only outstanding item is the Let's Encrypt
certificate, which GitHub requests automatically.

## 1. ~~Verify the domain~~ — done

The `_github-pages-challenge-aschepis` TXT record is in place and GitHub has
verified ownership, which released the domain from whatever Pages site had
previously claimed it. **Leave that TXT record in the zone** — removing it
un-verifies the domain, and it is what lets the custom domain be re-set without
re-verifying.

## 2. ~~Add the apex A records at GoDaddy~~ — done

All four are live (`dig +short adamschepis.com`):

| Type | Name | Value           |
|------|------|-----------------|
| A    | @    | 185.199.108.153 |
| A    | @    | 185.199.109.153 |
| A    | @    | 185.199.110.153 |
| A    | @    | 185.199.111.153 |

AAAA records are still optional and not currently set:

```
2606:50c0:8000::153   2606:50c0:8001::153
2606:50c0:8002::153   2606:50c0:8003::153
```

If the apex ever stops resolving, the two usual causes are a leftover GoDaddy
parking record at `@` (`Parked` / `_domainconnect`) or a domain Forwarding rule
fighting the A records. Never CNAME the apex — it is invalid and breaks email.

## 3. ~~Set the custom domain on the repo~~ — done

```sh
gh api -X PUT repos/aschepis/aschepis.github.io/pages -f cname=adamschepis.com
```

`public/CNAME` also contains `adamschepis.com`, so every deploy re-asserts it.

## 4. Turn on HTTPS — pending

Check the certificate state:

```sh
gh api repos/aschepis/aschepis.github.io/pages \
  --jq '{cert: .https_certificate.state, https_enforced}'
```

Once `cert` reads `approved`:

```sh
gh api -X PUT repos/aschepis/aschepis.github.io/pages -F https_enforced=true
```

The checkbox at **Settings → Pages** stays greyed out until then.

### If the certificate stalls at `dns_changed`

Issuance normally completes 15–30 minutes after the DNS resolves. While it is
pending, GitHub serves its fallback `*.github.io` wildcard certificate on the
Pages IPs, so browsers report

```
no alternative certificate subject name matches target host name 'adamschepis.com'
```

That error means "no certificate yet", not "misconfigured DNS". Things worth
ruling out, all of which are currently clean:

```sh
dig +short CAA adamschepis.com                   # empty — Let's Encrypt unrestricted
curl -sI http://adamschepis.com/                 # 200 from Server: GitHub.com
curl -sI http://adamschepis.com/.well-known/acme-challenge/test   # reachable, not intercepted
```

If it is still stuck after a day, force a fresh request by clearing and
re-setting the custom domain — the verification TXT makes this safe:

```sh
gh api -X PUT repos/aschepis/aschepis.github.io/pages -f cname=''
gh api -X PUT repos/aschepis/aschepis.github.io/pages -f cname=adamschepis.com
```

Note that `https_certificate.expires_at` has been reporting `2026-09-21` across
resets, which looks like a stale certificate record held over from whichever
Pages site previously claimed this domain. If the clear-and-re-set does not
shift the state, that leftover is the likely cause and needs GitHub Support —
it is not reachable from the API.

## 5. Verify

```sh
dig +short adamschepis.com                     # → the four 185.199.x.153 addresses
curl -sI https://adamschepis.com | head -1     # → HTTP/2 200
curl -sI https://www.adamschepis.com | head -1 # → 301 to the apex
```

## Effect on the other github.io project sites

This repo is the **user** site. GitHub Pages' rule is that once a user site has
a custom domain, every project page on the account is served from that domain
and the `github.io` URLs redirect to it:

```
https://aschepis.github.io/emaillinks/  →  301  →  https://adamschepis.com/emaillinks/
```

This is by design and cannot be turned off while the custom domain is set here.
The project repos need no changes of their own — `aschepis/emaillinks` has
`cname: null` and is served correctly at the new path.

The consequence is that a broken certificate on `adamschepis.com` breaks *every*
project site, not just this one. It bites hardest on repos with
`https_enforced: true` (`emaillinks` is one): plain HTTP is redirected to HTTPS,
which then fails the certificate check, leaving no working URL at all. This repo
currently has `https_enforced: false`, which is the only reason the homepage
still loads over HTTP while the certificate is pending.
