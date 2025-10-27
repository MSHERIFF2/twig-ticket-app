function showToast(message, type = "success") {
  const container = document.getElementById("toastContainer");
  if (!container) return;

  const colors =
    type === "error"
      ? "bg-red-600 text-white"
      : type === "warning"
      ? "bg-amber-500 text-white"
      : "bg-green-600 text-white";

  const toast = document.createElement("div");
  toast.className = `${colors} px-4 py-2 rounded-lg shadow-lg text-sm animate-fadeIn`;
  toast.textContent = message;

  container.appendChild(toast);

  // Fade out after 3 seconds
  setTimeout(() => {
    toast.classList.add("opacity-0", "transition", "duration-500");
    setTimeout(() => toast.remove(), 500);
  }, 3000);
}
