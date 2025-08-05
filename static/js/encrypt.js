document.addEventListener("DOMContentLoaded", function() {
  const encryptedContents = document.querySelectorAll(".encrypted-content");
  
  encryptedContents.forEach(content => {
    const password = content.dataset.password;
    const form = content.querySelector(".encrypt-form");
    const input = content.querySelector(".encrypt-input");
    const button = content.querySelector(".encrypt-button");
    const text = content.querySelector(".encrypted-text");
    const error = content.querySelector(".encrypt-error");
    
    input.focus();
    
    button.addEventListener("click", function() {
      if (input.value === password) {
        form.style.display = "none";
        text.style.display = "block";
        error.style.display = "none";
        input.value = "";
        
        text.style.opacity = "0";
        text.style.transform = "translateY(20px)";
        setTimeout(() => {
          text.style.transition = "all 0.5s ease";
          text.style.opacity = "1";
          text.style.transform = "translateY(0)";
        }, 100);
      } else {
        error.style.display = "flex";
        input.value = "";
        input.focus();
        
        form.style.animation = "shake 0.5s ease-in-out";
        setTimeout(() => {
          form.style.animation = "";
        }, 500);
      }
    });
    
    input.addEventListener("keypress", function(e) {
      if (e.key === "Enter") {
        button.click();
      }
    });
    
    input.addEventListener("input", function() {
      if (error.style.display === "flex") {
        error.style.display = "none";
      }
    });
  });
});
