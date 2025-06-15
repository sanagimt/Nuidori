document.addEventListener("DOMContentLoaded", () => {
  const input = document.getElementById("toy_image_input");
  const preview = document.getElementById("preview_image");

  if (!input || !preview) return;

  input.addEventListener("change", event => {
    const file = event.target.files[0];
    if (file && file.type.startsWith("image/")) {
      const reader = new FileReader();
      reader.onload = e => {
        preview.src = e.target.result;
        preview.classList.remove("d-none");
      };
      reader.readAsDataURL(file);
    } else {
      preview.src = "";
      preview.classList.add("d-none");
    }
  });
});