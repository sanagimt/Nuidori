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
  //画像プレビュー機能
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

  // ぬいぐるみを反映
  initialSelectedToys = window.initialSelectedToys || initialSelectedToys;
  // ユーザー選択時にぬいぐるみをリストに追加
  const userSelect = document.getElementById("user_select");
  const toySelect = document.getElementById("toy_select");
  const selectedTagsContainer = document.getElementById("selected_toys_tags");

  // 初期選択されているぬいぐるみをMapに保存
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

  // ユーザー選択時にぬいぐるみのリストを取得
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

        selectedToys.forEach((toy, id) => {
          const option = document.createElement("option");
          option.value = id;
          option.textContent = `${toy.name}(by ${toy.user_nickname}(${toy.user_username}))`;
          option.selected = true;
          toySelect.appendChild(option);
        });

        toys.forEach(toy => {
          const id = String(toy.id);
          if (!selectedToys.has(id)) {
            const option = document.createElement("option");
            option.value = id;
            option.textContent = `${toy.name}(by ${toy.user_nickname}(${toy.user_username}))`;
            toySelect.appendChild(option);
          }
        });
      })
      .catch(error => {
        console.error("Failed to fetch toys:", error);
      });
  });

  // セレクトボックスの変更時に選択されたぬいぐるみをMapに保存する
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

  // ぬいぐるみをタグで表示・削除可
  function renderSelectedTags() {
    selectedTagsContainer.innerHTML = "";

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
    });

    Array.from(toySelect.options).forEach(option => {
      option.selected = selectedToys.has(option.value);
    });
  }

  renderSelectedTags();
  // 選択済みのユーザーを自動読み込み
  if (userSelect.value !== "") {
    userSelect.dispatchEvent(new Event("change"));
  }
});