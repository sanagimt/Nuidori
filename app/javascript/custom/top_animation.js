document.addEventListener("turbolinks:load", () => {
  const fadeElements = document.querySelectorAll(".top-fade-in");

  const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.classList.add("top-fade-in-is-active");
      }
    });
  });

  fadeElements.forEach((el) => observer.observe(el));
});