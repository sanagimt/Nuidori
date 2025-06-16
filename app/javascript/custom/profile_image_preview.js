document.addEventListener("DOMContentLoaded", () => {
  const input = document.getElementById("profile_image_input");
  const preview = document.getElementById("profile_image_preview");
  const clearButton = document.getElementById("clear_profile_image_button");
  const removeImageField = document.getElementById("remove_profile_image_field");

  if (!input || !preview || !clearButton || !removeImageField) return;

  input.addEventListener("change", () => {
    const file = input.files[0];
    if (file && file.type.startsWith("image/")) {
      const reader = new FileReader();
      reader.onload = e => {
        preview.src = e.target.result;
        preview.classList.remove("d-none");
        preview.style.display = "block"; // 必要なら残す
      };
      reader.readAsDataURL(file);
      removeImageField.value = "0";
    } else {
      preview.src = "";
      preview.classList.add("d-none");
      preview.style.display = "none"; // 必要なら残す
    }
  });

  clearButton.addEventListener("click", () => {
    input.value = "";
    preview.src = "";
    preview.classList.add("d-none");
    preview.style.display = "none"; // 必要なら残す
    removeImageField.value = "1";
  });
});