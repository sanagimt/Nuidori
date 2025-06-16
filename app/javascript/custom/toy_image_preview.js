document.addEventListener("DOMContentLoaded", () => {
  const input = document.getElementById("toy_image_input");
  const preview = document.getElementById("preview_image");
  const clearButton = document.getElementById("clear_image_button");
  const removeImageField = document.getElementById("remove_image_field");

  if (!input || !preview || !clearButton || !removeImageField) return;

  input.addEventListener("change", () => {
    const file = input.files[0];
    if (file && file.type.startsWith("image/")) {
      const reader = new FileReader();
      reader.onload = e => {
        preview.src = e.target.result;
        preview.classList.remove("d-none");
      };
      reader.readAsDataURL(file);
      removeImageField.value = "0";
    } else {
      preview.src = "";
      preview.classList.add("d-none");
    }
  });

  clearButton.addEventListener("click", () => {
    input.value = "";
    preview.src = "";
    preview.classList.add("d-none");
    removeImageField.value = "1";
  });
});