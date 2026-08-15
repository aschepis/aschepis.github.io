# Pointing adamschepis.com at GitHub Pages

DNS for this domain is at **GoDaddy** (`ns49/ns50.domaincontrol.com`):
`godaddy.com` → Domain Portfolio → `adamschepis.com` → **DNS** → Manage Zone.

## Current state

| Piece                       | State                                         |
|-----------------------------|-----------------------------------------------|
| Domain verified on GitHub   | ✅ done — `protected_domain_state: verified`  |
| Custom domain on the repo   | ✅ set to `adamschepis.com`                   |
| `www` CNAME                 | ✅ → `aschepis.github.io.`                    |
| **Apex A records**          | ❌ **missing — this is the only thing left**  |
| Enforce HTTPS               | ⏳ can't be turned on until the apex resolves |

Until the A records land, the site is unreachable: `aschepis.github.io` now
301-redirects to `adamschepis.com`, which has nowhere to go.

## 1. ~~Verify the domain~~ — done

The `_github-pages-challenge-aschepis` TXT record is in place and GitHub has
verified ownership, which released the domain from whatever Pages site had
previously claimed it. **Leave that TXT record in the zone** — removing it
un-verifies the domain.

## 2. Add the apex A records at GoDaddy

All four — they're GitHub's load balancer, not alternatives:

| Type | Name | Value           | TTL |
|------|------|-----------------|-----|
| A    | @    | 185.199.108.153 | 1h  |
| A    | @    | 185.199.109.153 | 1h  |
| A    | @    | 185.199.110.153 | 1h  |
| A    | @    | 185.199.111.153 | 1h  |

IPv6, optional but recommended — same `@` host:

```
AAAA  @  2606:50c0:8000::153
AAAA  @  2606:50c0:8001::153
AAAA  @  2606:50c0:8002::153
AAAA  @  2606:50c0:8003::153
```

Two things that commonly break this:

- **Delete any other record at `@` first.** GoDaddy ships a parking A record
  (often `Parked` / `_domainconnect`) and any "Forwarding" rule set on the domain
  will fight these. Conflicting apex records are the usual cause of the site not
  resolving.
- **Don't CNAME the apex.** A plain CNAME at `@` is invalid and breaks email for
  the domain. The A records above are the supported way to point an apex at Pages.

## 3. ~~Set the custom domain on the repo~~ — done

Already set:

```sh
gh api -X PUT repos/aschepis/aschepis.github.io/pages -f cname=adamschepis.com
```

`public/CNAME` also contains `adamschepis.com`, so the setting stays consistent
across deploys.

## 4. Turn on HTTPS (after step 2)

Once the A records resolve, GitHub issues a Let's Encrypt certificate — usually
within 15–30 minutes. Then tick **Enforce HTTPS** at
**https://github.com/aschepis/aschepis.github.io/settings/pages**, or:

```sh
gh api -X PUT repos/aschepis/aschepis.github.io/pages -F https_enforced=true
```

The checkbox stays greyed out until the certificate is issued.

## 5. Verify

```sh
dig +short adamschepis.com                     # → the four 185.199.x.153 addresses
curl -sI https://adamschepis.com | head -1     # → HTTP/2 200
curl -sI https://www.adamschepis.com | head -1 # → 301 to the apex
```

Propagation is usually minutes. GoDaddy's default TTL is 1 hour, so allow that
long; certificate issuance can add another 15–30 minutes after DNS resolves.

## If you need the site reachable before the A records land

The custom domain is already set, so `aschepis.github.io` redirects to a domain
that doesn't resolve yet. To restore the github.io URL in the meantime, clear the
custom domain and re-set it later:

```sh
gh api -X PUT repos/aschepis/aschepis.github.io/pages -f cname=''
```
