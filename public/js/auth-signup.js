document.addEventListener("DOMContentLoaded", () => {
  const signupForm = document.getElementById("signupForm");

  if (signupForm) {
    signupForm.addEventListener("submit", (e) => {
      e.preventDefault();

      const email = document.getElementById("email").value.trim();
      const password = document.getElementById("password").value.trim();
      const confirm = document.getElementById("confirmPassword").value.trim();

      if (!email || !password || !confirm) {
        showToast("All fields are required.", "error");
        return;
      }

      if (password !== confirm) {
        showToast("Passwords do not match.", "error");
        return;
      }

      // Save user
      const user = { email, password };
      localStorage.setItem("ticketapp_user", JSON.stringify(user));

      showToast("Account created successfully!", "success");

      // Redirect after a brief delay
      setTimeout(() => {
        window.location.href = "/auth/login";
      }, 1200);
    });
  }
});
