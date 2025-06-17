document.addEventListener("DOMContentLoaded", function () {
  const dataDiv = document.getElementById("post_form_data");
  if (!dataDiv) return;
  let initialSelectedToys = [];

  if (dataDiv) {
    try {
      initialSelectedToys = JSON.parse(dataDiv.dataset.selectedToys);
    } catch (e) {
      console.error("初期データの読み込み失敗:", e);
    }
  }

  const imageInput = document.getElementById("image_input");
  const imagePreview = document.getElementById("image_preview");

  if (imageInput && imagePreview) {
    imageInput.addEventListener("change", function (event) {
      const file = event.target.files[0];
      if (!file || !file.type.startsWith("image/")) {
        imagePreview.src = "";
        imagePreview.style.display = "none";
        return;
      }

      const reader = new FileReader();
      reader.onload = function (e) {
        imagePreview.src = e.target.result;
        imagePreview.style.display = "block";
        imagePreview.classList.remove("d-none");
      };
      reader.readAsDataURL(file);
    });
  }

  initialSelectedToys = window.initialSelectedToys || initialSelectedToys;
  const userSelect = document.getElementById("user_select");
  const toySelect = document.getElementById("toy_select");
  const selectedTagsContainer = document.getElementById("selected_toys_tags");

  toySelect.innerHTML = "";
  const selectedToys = new Map();

  if (Array.isArray(initialSelectedToys)) {
    initialSelectedToys.forEach(toy => {
      selectedToys.set(String(toy.id), {
        name: toy.name,
        user_nickname: toy.user_nickname,
        user_username: toy.user_username
      });
    });
  }

  userSelect.addEventListener("change", function () {
    const userId = this.value;

    if (userId === "") {
      toySelect.innerHTML = "";
      return;
    }

    fetch(`/toys/by_user/${userId}`)
      .then(response => {
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response.json();
      })
      .then(toys => {
        toySelect.innerHTML = "";

        toys.forEach(toy => {
          const id = String(toy.id);
  
          const option = document.createElement("option");
          option.value = id;
          option.textContent = `${toy.name}(by ${toy.user_nickname}(${toy.user_username}))`;
          option.selected = selectedToys.has(id);
          toySelect.appendChild(option);
        });
      })
      .catch(error => {
        console.error("Failed to fetch toys:", error);
      });
  });

  toySelect.addEventListener("change", function () {
    Array.from(toySelect.selectedOptions).forEach(option => {
      const id = option.value;
      const label = option.textContent;
  
      const match = label.match(/^(.+?)\(by (.+?)\((.+?)\)\)$/);
      if (match) {
        const name = match[1];
        const user_nickname = match[2];
        const user_username = match[3];
  
        selectedToys.set(id, {
          name,
          user_nickname,
          user_username
        });
      }
    });
    renderSelectedTags();
  });

  // ぬいぐるみをタグで表示
  function renderSelectedTags() {
    selectedTagsContainer.innerHTML = "";

    const hiddenContainer = document.getElementById("hidden_selected_toys");
    hiddenContainer.innerHTML = "";

    selectedToys.forEach((toy, id) => {
      const tag = document.createElement("span");
      tag.textContent = `${toy.name}(by ${toy.user_nickname}(${toy.user_username}))`;
      tag.style.cssText = `
        background-color: #f0f0f0;
        border-radius: 16px;
        padding: 4px 12px;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        font-size: 16px;
      `;

      const removeBtn = document.createElement("button");
      removeBtn.innerHTML = "×";
      removeBtn.style.cssText = `
        background: none;
        border: none;
        color: #888;
        font-size: 16px;
        cursor: pointer;
      `;

      removeBtn.addEventListener("click", function () {
        selectedToys.delete(id);
        Array.from(toySelect.options).forEach(opt => {
          if (opt.value === id) opt.selected = false;
        });
        renderSelectedTags();
      });

      tag.appendChild(removeBtn);
      selectedTagsContainer.appendChild(tag);

      const hiddenInput = document.createElement("input");
      hiddenInput.type = "hidden";
      hiddenInput.name = "post[toy_ids][]";
      hiddenInput.value = id;
      hiddenContainer.appendChild(hiddenInput);

    });

    Array.from(toySelect.options).forEach(option => {
      option.selected = selectedToys.has(option.value);
    });
  }

  renderSelectedTags();
});