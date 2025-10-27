// Redirect users who are not logged in
document.addEventListener("DOMContentLoaded", () => {
  const token = localStorage.getItem("ticketapp_session");

  // If no token, redirect to login
  if (!token) {
    alert("You must be logged in to access this page.");
    window.location.href = "/auth/login";
  }
});
