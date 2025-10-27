document.getElementById("logoutBtn").addEventListener("click", () => {
    localStorage.removeItem("ticketapp_session");
   showToast("You have been logged out.");
    window.location.href = "/";
  });