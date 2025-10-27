document.addEventListener("DOMContentLoaded", () => {
  // Auth guard
  const session = localStorage.getItem("ticketapp_session");
  const user = localStorage.getItem("ticketapp_user");

  if (!session || !user) {
    showToast("Please log in first.", "error");
    setTimeout(() => (window.location.href = "/auth/login"), 1000);
    return;
  }

  // Ticket logic
  const addBtn = document.getElementById("addTicketBtn");
  const modal = document.getElementById("ticketModal");
  const cancelBtn = document.getElementById("cancelBtn");
  const form = document.getElementById("ticketForm");
  const ticketList = document.getElementById("ticketList");

  // Ensure key exists
  if (!localStorage.getItem("ticketapp_tickets")) {
    localStorage.setItem("ticketapp_tickets", JSON.stringify([]));
  }

  const getTickets = () =>
    JSON.parse(localStorage.getItem("ticketapp_tickets")) || [];
  const saveTickets = (tickets) =>
    localStorage.setItem("ticketapp_tickets", JSON.stringify(tickets));

  const renderTickets = () => {
    const tickets = getTickets();
    ticketList.innerHTML = "";

    if (tickets.length === 0) {
      ticketList.innerHTML = `<p class="text-gray-500">No tickets yet. Click "New Ticket" to create one.</p>`;
      return;
    }

    tickets.forEach((t) => {
      const color =
        t.status === "open"
          ? "bg-green-100 text-green-700"
          : t.status === "in_progress"
          ? "bg-amber-100 text-amber-700"
          : "bg-gray-200 text-gray-700";

      ticketList.innerHTML += `
        <div class="bg-gray-200 rounded-l shadow p-4 flex flex-col justify-between">
          <div class="p-6">
            <h3 class="text-lg font-semibold mb-2">${t.title}</h3>
            <p class="text-sm text-gray-600 mb-3">${t.description || "No description"}</p>
            <span class="text-xs px-3 py-1 rounded-full ${color}">${t.status}</span>
          </div>
          <div class="flex justify-end gap-3 mt-4 px-4 mb-4">
            <button class="editBtn text-blue-600 text-sm hover:cursor-pointer" data-id="${t.id}">Edit</button>
            <button class="deleteBtn text-red-600 text-sm hover:cursor-pointer" data-id="${t.id}">Delete</button>
          </div>
        </div>
      `;
    });

    handleActions();
  };

  const handleActions = () => {
    document.querySelectorAll(".editBtn").forEach((btn) => {
      btn.addEventListener("click", (e) => {
        const id = e.target.dataset.id;
        const tickets = getTickets();
        const ticket = tickets.find((t) => t.id === id);
        if (!ticket) return;

        document.getElementById("title").value = ticket.title;
        document.getElementById("description").value = ticket.description;
        document.getElementById("status").value = ticket.status;
        modal.classList.remove("hidden");
        form.dataset.editId = id;
        document.getElementById("modalTitle").textContent = "Edit Ticket";
      });
    });

    document.querySelectorAll(".deleteBtn").forEach((btn) => {
      btn.addEventListener("click", (e) => {
        const id = e.target.dataset.id;
        if (confirm("Are you sure you want to delete this ticket?")) {
          let tickets = getTickets().filter((t) => t.id !== id);
          saveTickets(tickets);
          renderTickets();
          showToast("Ticket deleted successfully!", "warning");
        }
      });
    });
  };

  // Open modal
  addBtn.addEventListener("click", () => {
    modal.classList.remove("hidden");
  });

  // Close modal
  cancelBtn.addEventListener("click", () => {
    modal.classList.add("hidden");
    form.reset();
  });

  // Save new ticket
  form.addEventListener("submit", (e) => {
    e.preventDefault();

    const title = document.getElementById("title").value.trim();
    const description = document.getElementById("description").value.trim();
    const status = document.getElementById("status").value;
    const editId = form.dataset.editId;

    if (!title) {
      showToast("Title is required", "error");
      return;
    }

    let tickets = getTickets();

    if (editId) {
      tickets = tickets.map((t) =>
        t.id === editId ? { ...t, title, description, status } : t
      );
      form.dataset.editId = "";
      document.getElementById("modalTitle").textContent = "Add Ticket";
      showToast("Ticket updated successfully!");
    } else {
      const newTicket = {
        id: Date.now().toString(),
        title,
        description,
        status,
        createdAt: new Date().toISOString(),
      };
      tickets.push(newTicket);
      showToast("Ticket created successfully!");
    }

    saveTickets(tickets);
    form.reset();
    modal.classList.add("hidden");
    renderTickets();
  });

  // ✅ Render tickets on page load
  renderTickets();
});
