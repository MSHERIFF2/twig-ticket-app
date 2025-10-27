document.addEventListener("DOMContentLoaded", () => {
  const session = localStorage.getItem("ticketapp_session");
  const user = localStorage.getItem("ticketapp_user");

  if (!session || !user) {
    showToast("Please log in first.", "error");
    setTimeout(() => (window.location.href = "/auth/login"), 1000);
    return;
  }

  const { email } = JSON.parse(user);
  document.getElementById("userEmail").textContent = email;

  // Load tickets
  const tickets = JSON.parse(localStorage.getItem("ticketapp_tickets") || "[]");
  const open = tickets.filter((t) => t.status === "open").length;
  const inProgress = tickets.filter((t) => t.status === "in_progress").length;
  const closed = tickets.filter((t) => t.status === "closed").length;

  document.getElementById("openCount").textContent = open;
  document.getElementById("inProgressCount").textContent = inProgress;
  document.getElementById("closedCount").textContent = closed;

  // Logout
  document.getElementById("logoutBtn").addEventListener("click", () => {
    localStorage.removeItem("ticketapp_session");
    showToast("Logged out successfully.", "success");
    setTimeout(() => (window.location.href = "/auth/login"), 1000);
  });
});
