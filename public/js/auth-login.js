document.addEventListener("DOMContentLoaded", () => {
  const loginForm = document.getElementById("loginForm");

  if (loginForm) {
    loginForm.addEventListener("submit", (e) => {
      e.preventDefault();

      const email = document.getElementById("email").value.trim();
      const password = document.getElementById("password").value.trim();

      const storedUser = JSON.parse(localStorage.getItem("ticketapp_user"));

      if (!storedUser) {
        showToast("No account found. Please sign up first.", "error");
        return;
      }

      if (email === storedUser.email && password === storedUser.password) {
        const token = Math.random().toString(36).substring(2);
        localStorage.setItem("ticketapp_session", token);

        showToast("Login successful! Redirecting...", "success");

        // Delay redirect slightly for the toast to show
        setTimeout(() => {
          window.location.href = "/dashboard";
        }, 1200);
      } else {
        showToast("Invalid email or password.", "error");
      }
    });
  }
});
