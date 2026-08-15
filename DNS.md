# Pointing adamschepis.com at GitHub Pages

The site is live at **https://aschepis.github.io/**. Three things stand between
that and `adamschepis.com`. Do them in order — step 1 is required before step 3
will be accepted.

DNS for this domain is at **GoDaddy** (`ns49/ns50.domaincontrol.com`), so the
records below go in GoDaddy's DNS manager:
`godaddy.com` → Domain Portfolio → `adamschepis.com` → **DNS** → Manage Zone.

## Current state

| Record                | Now                          | Needs to be                |
|-----------------------|------------------------------|----------------------------|
| `adamschepis.com` (@) | *no A records*               | four GitHub A records       |
| `www`                 | CNAME → `aschepis.github.io.` | already correct — leave it |

So the apex is the only DNS record actually missing.

## 1. Verify the domain on your GitHub account (required here)

GitHub currently refuses `adamschepis.com` as a custom domain: *"already taken"*
— some other Pages site (likely an old, since-forgotten one) still has it
configured. Verifying ownership releases it to you and blocks future takeovers.

1. Go to **https://github.com/settings/pages** → **Add a domain**.
2. Enter `adamschepis.com`. GitHub shows a TXT record like:

   | Type | Host                                  | Value                    |
   |------|---------------------------------------|--------------------------|
   | TXT  | `_github-pages-challenge-aschepis`    | *(the token GitHub shows)* |

3. Add that TXT record at GoDaddy, wait a minute, then click **Verify**.

Check it landed before hitting Verify:

```sh
dig +short TXT _github-pages-challenge-aschepis.adamschepis.com
```

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

## 3. Set the custom domain on the repo

Once step 1 verifies, go to
**https://github.com/aschepis/aschepis.github.io/settings/pages** → Custom domain
→ `adamschepis.com` → Save. Or from the terminal:

```sh
gh api -X PUT repos/aschepis/aschepis.github.io/pages -f cname=adamschepis.com
```

Then wait for the DNS check to go green and tick **Enforce HTTPS**. The
certificate comes from Let's Encrypt via GitHub and renews itself; the checkbox
stays greyed out until the A records in step 2 resolve.

`public/CNAME` in this repo already contains `adamschepis.com`, so the setting
stays consistent across deploys.

## 4. Verify

```sh
dig +short adamschepis.com                    # → the four 185.199.x.153 addresses
curl -sI https://adamschepis.com | head -1    # → HTTP/2 200
curl -sI https://www.adamschepis.com | head -1 # → 301 to the apex
```

Propagation is usually minutes. GoDaddy's default TTL is 1 hour, so allow that
long; certificate issuance can add another 15–30 minutes after DNS resolves.

## Note while this is pending

Once the custom domain is set (step 3), `https://aschepis.github.io` starts
**301-redirecting** to `https://adamschepis.com`. If you do step 3 before step 2,
the site will look broken from both URLs until the A records land. Doing them in
order avoids that window.
