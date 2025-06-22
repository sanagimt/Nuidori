function setupCommentFormListeners() {
  const textarea = document.getElementById("comment_textarea");
  const counter = document.getElementById("char_count");
  const submitBtn = document.getElementById("submit_comment");

  if (!textarea || !counter || !submitBtn) return;

  const MAX_LENGTH = 100;

  if (textarea._listenerAdded) return;

  function updateState() {
    const len = textarea.value.length;
    counter.textContent = len;
    submitBtn.disabled = len === 0 || len > MAX_LENGTH;
  };

  textarea.addEventListener("input", updateState);
  textarea._listenerAdded = true;

  updateState();
}

window.setupCommentFormListeners = setupCommentFormListeners;
document.addEventListener("DOMContentLoaded", setupCommentFormListeners);
document.addEventListener("turbolinks:load", setupCommentFormListeners);