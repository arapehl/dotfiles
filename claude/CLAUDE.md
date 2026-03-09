# CLAUDE.md — Development Project Guidelines

## Core Philosophy: Security by Design

**Security is not an afterthought. It is the foundation.**

- **Default to secure**: Every default must be the most secure option; opt-in to less restrictive behavior explicitly.
- **Least privilege**: Code, services, users, and processes get only the minimum permissions required.
- **Defense in depth**: Layer defenses — never rely on a single control.
- **Fail securely**: Failures must not expose data, grant unintended access, or leave the system insecure.
- **Zero trust**: Always verify — never assume trust based on network location or prior authentication.
- **Minimize attack surface**: Disable unused features, close unused ports, remove dead code, reduce dependencies.

---

## Tech Stack

**Backend:** Node.js · TypeScript · GraphQL
**Frontend:** React · TypeScript
**Database:** PostgreSQL

---

## Implementation Standards

### Authentication & Authorization
- Use proven auth libraries (`passport.js`, `Auth0`, `Clerk`) — never roll your own crypto or auth.
- Enforce MFA for all privileged accounts and sensitive operations.
- Validate authorization on every request, server-side. Never trust the client.
- Use short-lived JWTs (≤15 min); issue refresh tokens via secure HttpOnly cookies — never `localStorage`.
- Implement token rotation and revocation with a denylist or opaque server-side session tracking.

### Input & Output
- Treat all external input as untrusted — validate, sanitize, and encode at every boundary.
- Use `zod` or `class-validator` for runtime validation on all incoming data (REST, GraphQL, env vars).
- Encode output for its context (HTML, JSON, shell) to prevent injection.
- Never construct SQL via string concatenation — always use parameterized queries or a query builder.

### Data Protection
- Encrypt sensitive data at rest and in transit — no exceptions. Enforce TLS 1.2+ including staging.
- Never log sensitive data (passwords, tokens, PII, secrets).
- Data minimization: collect and store only what is strictly needed; define retention policies upfront.
- Hash passwords with `bcrypt` or `argon2` — never MD5, SHA-1, or plain SHA-256.

### Secrets Management
- No secrets in source code, committed `.env` files, or build artifacts. Add `.env*` to `.gitignore` immediately.
- Use a secrets manager (AWS Secrets Manager, HashiCorp Vault, Doppler) for production.
- Rotate secrets regularly and immediately on suspected compromise.
- Validate all required env vars at startup using a `zod` schema against `process.env`.

### Dependencies
- Audit third-party dependencies before adding — check maintenance status and known CVEs.
- Run `npm audit` in every CI/CD pipeline; fail the build on high/critical vulnerabilities.
- Pin versions (`package-lock.json` committed, no loose `^` wildcards for production-critical packages).
- Use Dependabot or Renovate for automated updates; remove unused dependencies promptly.

### Infrastructure & Configuration
- Disable debug modes, verbose errors, and stack traces in production.
- Apply security headers via `helmet`: `Content-Security-Policy`, `Strict-Transport-Security`, `X-Frame-Options`, `X-Content-Type-Options`, `Referrer-Policy`.
- Configure CORS explicitly — never wildcard (`*`) origins in production.
- Rate-limit all API endpoints with `express-rate-limit` or equivalent.

### Email Templates
- Never interpolate user-controlled strings directly into HTML email templates. Always escape with an `escapeHtml()` helper (`&`, `<`, `>`, `"`, `'`) before interpolation.
- Plain-text email bodies do not require escaping, but must not be used to render HTML.

### Logging & Monitoring
- Log security-relevant events: auth attempts, access control failures, input validation failures, unusual patterns.
- Use a structured logger (`pino` or `winston`) — never `console.log` in production.
- Never log request bodies that may contain credentials, tokens, or PII.
- Alert on anomalous behavior; ship logs to a centralized, append-only, tamper-resistant store.

---

## Stack-Specific Security Guidelines

### Node.js & TypeScript
- Enable `"strict": true` in `tsconfig.json`.
- Never use bracket notation with dynamic keys (`obj[key]`) — use `Map` with `.get()`/`.set()` instead to avoid Generic Object Injection vulnerabilities (`eslint-plugin-security` rule `detect-object-injection`).
- Never use `eval()`, `new Function()`, or `vm.runInNewContext()` with untrusted input.
- Avoid `child_process.exec()` with user-supplied data; prefer `execFile()` with explicit argument arrays.
- Set `NODE_ENV=production` in production.
- Handle unhandled promise rejections and uncaught exceptions explicitly.
- Keep Node.js on an active LTS release; patch promptly on security advisories.
- Guard against prototype pollution — validate before any `merge`, `extend`, or `clone` on untrusted objects.

### React (Frontend)
- Never use `dangerouslySetInnerHTML` with untrusted data; sanitize with `DOMPurify` if HTML rendering is required. Plain-text fields must never be rendered as HTML — use `whitespace-pre-wrap` instead.
- Any `<button>` element styled to look like a link (text-only color, no background/border/rounded) must include the `cursor-pointer` Tailwind class. Browsers do not apply `cursor: pointer` to `<button>` by default in all contexts.
- Never store tokens, session info, or PII in `localStorage` or `sessionStorage`.
- Store auth tokens in memory (React state/context); use HttpOnly cookies for refresh tokens.
- Treat all URL and route params as untrusted input — validate and sanitize before use.
- Never embed secrets or API keys in the client bundle.
- Use `VITE_` / `REACT_APP_` env vars only for non-sensitive, public configuration.
- Define a strict `Content-Security-Policy` disallowing inline scripts and restricting script sources.

### GraphQL
- **Disable introspection in production.**
- Implement query depth limiting (`graphql-depth-limit`) and complexity analysis (`graphql-query-complexity`).
- Rate-limit the GraphQL endpoint.
- Return generic error messages to clients in production; log full errors server-side.
- Enforce field-level and resolver-level authorization — parent resolution does not imply child access.
- Validate and sanitize all GraphQL arguments with `zod` before passing to business logic or the database. **TypeScript type casts (`as SomeType`) are not runtime validation** — always use `z.parse()`/`z.safeParse()` for enum fields such as user roles.
- Strip HTML from plain-text fields on the server before storage as defense-in-depth (`replace(/<[^>]*>/g, '')`), even if the frontend already treats them as plain text.
- Use `DataLoader` to batch and cache database calls — uncontrolled N+1 queries are a data-exfiltration risk.
- Use persisted queries in production to lock the API to approved operations.
- Disable the GraphQL playground in production.

### PostgreSQL
- Connect as a dedicated app user with minimum required privileges — never a superuser.
- Grant only needed permissions (`SELECT`, `INSERT`, `UPDATE`, `DELETE` on specific tables). Never `GRANT ALL ON DATABASE`.
- Always use parameterized queries or a query builder (`pg` with `$1`, Prisma, Drizzle, TypeORM). **No raw string interpolation in SQL.**
- Enable `ssl: true` with `rejectUnauthorized: true` in the connection config.
- Use row-level security (RLS) for multi-tenant data isolation.
- Never expose the PostgreSQL port to the public internet.
- Back up regularly and test restoration procedures.
- Monitor `pg_stat_statements` for slow queries and unusual access patterns; rotate credentials on schedule and on any suspected compromise.

---

## Development Workflow

### Code Quality
- Run `eslint --fix` on every file after making changes to it.
- **Component/page structure**: Any page or component that contains subcomponents must live in a folder named after itself (e.g., `pages/CandidateDetailPage/CandidateDetailPage.tsx`), with subcomponents in a `components/` subdirectory alongside it, and an `index.ts` at the folder root that re-exports the main component. Simple leaf components with no subcomponents may remain as single files.
- **GraphQL file co-location**: `.graphql` files must live in a `graphql/` subfolder inside the folder of the `.tsx` file that primarily consumes them — not in a shared top-level `graphql/` directory. A query or mutation used by a single page lives in that page's `graphql/` folder (e.g., `pages/CandidateDetailPage/graphql/Candidate.graphql`). A query used by a component inside a page's `components/` subfolder lives in that component subfolder's `graphql/` directory (e.g., `pages/OpportunityDetailPage/components/graphql/CreatePipelineStage.graphql`). When a query is shared across multiple consumers, place it with its primary consumer and import it via a relative path from the secondary consumers.
- **Test file co-location**: `.test.tsx` files must live next to the `.tsx` file they test — not in a separate `__tests__/` directory.

### Testing with Apollo MockedProvider
- **Always mock every query a component tree fires** — including queries from child components. A `MockedProvider mocks={[]}` on a component that fires any query will produce "No more mocked responses" warnings and `act(...)` warnings.
- **Match variables exactly** — Apollo's mock matcher uses deep equality on request variables. Derive the expected variables from how the component calls `useQuery` (e.g., `undefined` values are stripped, so `{ search: undefined }` becomes `{}`).
- **Shared query mocks** — define named mock constants at the top of the test file (e.g., `const tagsMock = { request: ..., result: ... }`) and reuse them across tests rather than inlining per test.
- **Refetch / mutation side-effects** — if a mutation triggers a query refetch, provide a second copy of that query's mock. Unused extra mocks are silently ignored; missing mocks produce warnings.
- **Subcomponent queries** — when a page renders a subcomponent that fires its own query (e.g., `RecommendedCandidatesPanel`), add that subcomponent's query mock to every test that renders the parent page.

### Branching & Pull Requests
- Never commit directly to `main`. All changes go through a branch linked to a GitHub issue.
- Every PR must include tests. PRs without tests will not be merged.
- PRs should be small and focused; descriptions must close the related issue(s).
- **Every PR description must include an OWASP Top 10 review section.** For each of the 10 categories, note whether it is applicable to the change and, if so, how it is addressed. Mark categories explicitly as N/A when they do not apply — do not omit them. The CI `Security (OWASP)` workflow will warn if the PR body contains no OWASP reference.

### Security Checklist (Before → During → Ship)
- **Before**: Identify trust boundaries; perform lightweight STRIDE threat modeling for features touching auth, data, or external systems; define acceptance criteria that include security requirements.
- **During**: Run `tsc --noEmit` and ESLint with `eslint-plugin-security` locally and in CI; use `husky` + `lint-staged` pre-commit hooks; code reviews must explicitly ask: *"Could this be abused? Is authorization checked at every layer?"*
- **Before shipping**: Resolve all `npm audit` high/critical findings; test auth and access control negative cases; confirm no secrets or stack traces are reachable; verify GraphQL introspection is off, playground is disabled, and depth/complexity limits are active; review against OWASP Top 10.

---

## Priorities

1. **Security** — Non-negotiable. No feature ships if it introduces an unmitigated security risk.
2. **Correctness** — The system behaves as intended.
3. **Reliability** — Stable and recovers gracefully.
4. **Performance** — Fast enough for its users.
5. **Maintainability** — Clean, documented, easy to evolve.

---

*Security is everyone's responsibility. Flag anything that looks wrong — no matter how small.*
