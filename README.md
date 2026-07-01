# Budget Pro

A 5-page expense & budget tracker (Dashboard, Budgets, Transactions, Insights, Budget Chat)
that saves your entries to a free Supabase database, ready to host free on GitHub Pages.

New in this version:
- **Export to Excel** — a one-click button (in the sidebar, mobile top bar, and on the
  Transactions page) exports every transaction you've ever logged to a `.xlsx` file.
- **Fresh tips on every refresh** — the savings tips on the Dashboard and Insights pages
  are pulled from a pool relevant to your spending and shuffled each time the page loads.
- **Budget Chat** — a new page where you can ask things like "how am I doing this month?",
  "suggest a budget", "where can I save money?", or "set budget for Rent to 15000", and get
  answers computed live from your own transactions (no external AI service required).

## 1. Create your database (Supabase — free)

1. Go to **https://supabase.com** → sign up → **New project** (pick any name/password/region, free tier).
2. Wait ~2 minutes for it to spin up.
3. Left sidebar → **SQL Editor** → **New query** → paste the contents of `supabase-setup.sql` → **Run**.
   This creates the `transactions` and `budgets` tables.
4. Left sidebar → **Project Settings** → **API**. Copy:
   - **Project URL**
   - **anon public** key
5. Open `js/config.js` in this folder and paste them in:
   ```js
   window.SUPABASE_URL = "https://xxxxxxxx.supabase.co";
   window.SUPABASE_ANON_KEY = "eyJhbGciOi...";
   ```
6. Save the file.

That's it for the database — no backend server to run. The pages talk to Supabase directly.

> **Note on privacy:** this app has no login screen. Anyone who has your site's
> link can view and add entries (that's what makes it work with zero setup).
> Don't share the link publicly. If you'd like a login screen later, Supabase
> supports free email/password auth and I can wire that in.

## 2. Try it locally first (optional)

Just double-click `index.html` to open it in a browser, or serve the folder with
any static file server. Add a test entry and refresh — if it's still there, the
database connection works.

## 3. Host it free on GitHub Pages

1. Create a new **public** GitHub repository (e.g. `expense-diary`).
2. Upload all the files in this folder (`index.html`, `budgets.html`,
   `transactions.html`, `insights.html`, `chat.html`, the `css/` and `js/` folders,
   `supabase-setup.sql`, this `README.md`) — either via the GitHub web UI
   ("Add file" → "Upload files") or with git:
   ```bash
   git init
   git add .
   git commit -m "Budget Pro"
   git branch -M main
   git remote add origin https://github.com/<your-username>/budget-pro.git
   git push -u origin main
   ```
3. In the repo: **Settings** → **Pages** → under "Build and deployment",
   set **Source** to "Deploy from a branch", **Branch** to `main` / `(root)` → **Save**.
4. Wait a minute, then your site is live at:
   `https://<your-username>.github