TicketApp — Twig Version

A Multi-Framework Ticket Management Web Application (Twig Implementation)

This is the Twig implementation of the HNG Frontend Stage 2 Task: Multi-Framework Ticket Web App.
It delivers a complete, responsive, and accessible ticket management experience — including authentication, dashboard analytics, and full CRUD operations — all powered by Twig, PHP, and Tailwind CSS.

🌐 Live Preview

(Add your deployment link here once hosted — e.g., Netlify, Vercel (with PHP hosting), or a simple Render deployment.)

⚙️ Tech Stack

Frontend Template Engine: Twig

Runtime: PHP 8+

Styling: Tailwind CSS (compiled with PostCSS)

Build Tools: Node.js + npm

Data Simulation: localStorage (token key = ticketapp_session)

Toast Notifications: Custom JS utility (toast.js)

📂 Folder Structure
twig-ticket-app/
│
├── public/
│   ├── css/
│   │   ├── input.css
│   │   └── styles.css
│   ├── js/
│   │   ├── auth-guard.js
│   │   ├── auth-login.js
│   │   ├── auth-logout.js
│   │   ├── auth-signup.js
│   │   ├── dashboard.js
│   │   ├── tickets.js
│   │   └── toast.js
│   └── index.php
│
├── templates/
│   ├── base.twig
│   ├── home.twig
│   ├── auth-login.twig
│   ├── auth-signup.twig
│   ├── dashboard.twig
│   └── tickets.twig
│
├── vendor/
├── composer.json
├── composer.lock
├── package.json
└── package-lock.json

🚀 Setup Instructions
1️⃣ Install Dependencies
npm install
composer install

2️⃣ Build Tailwind CSS
npm run build:css


(This compiles /public/css/styles.css from /public/css/input.css using Tailwind.)

3️⃣ Start the PHP Development Server
php -S localhost:8000 -t public


Then open your browser at:
👉 http://localhost:8000

🔐 Authentication System

User signup and login simulated via localStorage.

Active sessions are stored under key ticketapp_session.

Unauthenticated users are redirected to /auth/login.

On logout, the session is cleared and redirected to /.

📊 Dashboard

Displays total, open, and closed tickets.

Navigation to the ticket management page.

Logout button clears session instantly.

🎫 Ticket Management (CRUD)

Create: Add new ticket via modal form.

Read: List all saved tickets (from localStorage).

Update: Edit existing ticket inline.

Delete: Confirmation prompt before removal.

Validation:

title → required

status → enum (open, in_progress, closed)

Optional description and priority validated for type/length.

🎨 Design & Layout Rules

Max-width: 1440 px (centered content).

Hero section: CSS wave background with decorative circles.

Color scheme:

Open → Green

In Progress → Amber

Closed → Gray

Fully responsive: Mobile-first grid layouts.

Accessibility: Semantic HTML, focus states, sufficient contrast.

🔔 Notifications

Implemented via toast.js for real-time visual feedback on:

Login/signup success or failure

CRUD actions (create, update, delete)

Validation errors

Session timeouts

👤 Test Credentials
Email	Password
test@user.com
	123456

(You can also register new users on the signup page.)

🧠 State Management

All application state is stored in localStorage:

ticketapp_session → auth token

ticketapp_user → user profile

ticketapp_tickets → ticket list (JSON array)

📘 Notes on Accessibility

Semantic HTML structure

Descriptive labels for all form inputs

Visible focus indicators

ARIA-safe modal toggling

🧩 Known Issues

Data persistence limited to browser localStorage.

PHP server used for static file routing (no backend database).

📄 License

This project is open-source under the MIT License.