document.addEventListener('DOMContentLoaded', function() {
  const encryptedContents = document.querySelectorAll('.encrypted-content');
  
  encryptedContents.forEach(content => {
    const password = content.dataset.password;
    const form = content.querySelector('.encrypt-form');
    const input = content.querySelector('.encrypt-input');
    const button = content.querySelector('.encrypt-button');
    const text = content.querySelector('.encrypted-text');
    const error = content.querySelector('.encrypt-error');
    
    // Focus on input when form is shown
    input.focus();
    
    button.addEventListener('click', function() {
      if (input.value === password) {
        form.style.display = 'none';
        text.style.display = 'block';
        error.style.display = 'none';
        input.value = '';
        
        // Add success animation
        text.style.opacity = '0';
        text.style.transform = 'translateY(20px)';
        setTimeout(() => {
          text.style.transition = 'all 0.5s ease';
          text.style.opacity = '1';
          text.style.transform = 'translateY(0)';
        }, 100);
      } else {
        error.style.display = 'flex';
        input.value = '';
        input.focus();
        
        // Add shake animation
        form.style.animation = 'shake 0.5s ease-in-out';
        setTimeout(() => {
          form.style.animation = '';
        }, 500);
      }
    });
    
    input.addEventListener('keypress', function(e) {
      if (e.key === 'Enter') {
        button.click();
      }
    });
    
    // Clear error when user starts typing
    input.addEventListener('input', function() {
      if (error.style.display === 'flex') {
        error.style.display = 'none';
      }
    });
  });
});

// Add CSS animations
const style = document.createElement('style');
style.textContent = `
  @keyframes shake {
    0%, 100% { transform: translateX(0); }
    25% { transform: translateX(-5px); }
    75% { transform: translateX(5px); }
  }
  
  .encrypted-content {
    margin: 2rem 0;
    border: 1px solid #e1e5e9;
    border-radius: 8px;
    overflow: hidden;
  }
  
  .encrypt-form {
    padding: 2rem;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    text-align: center;
  }
  
  .encrypt-header {
    margin-bottom: 1.5rem;
  }
  
  .encrypt-header i {
    font-size: 2rem;
    margin-bottom: 1rem;
    display: block;
  }
  
  .encrypt-header h3 {
    margin: 0 0 0.5rem 0;
    font-size: 1.5rem;
  }
  
  .encrypt-header p {
    margin: 0;
    opacity: 0.9;
  }
  
  .encrypt-input-group {
    display: flex;
    gap: 0.5rem;
    max-width: 400px;
    margin: 0 auto;
  }
  
  .encrypt-input {
    flex: 1;
    padding: 0.75rem 1rem;
    border: none;
    border-radius: 4px;
    font-size: 1rem;
    outline: none;
  }
  
  .encrypt-button {
    padding: 0.75rem 1.5rem;
    background: rgba(255, 255, 255, 0.2);
    border: 1px solid rgba(255, 255, 255, 0.3);
    color: white;
    border-radius: 4px;
    cursor: pointer;
    font-size: 1rem;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    gap: 0.5rem;
  }
  
  .encrypt-button:hover {
    background: rgba(255, 255, 255, 0.3);
    transform: translateY(-1px);
  }
  
  .encrypt-error {
    margin-top: 1rem;
    padding: 0.75rem;
    background: rgba(255, 0, 0, 0.1);
    border: 1px solid rgba(255, 0, 0, 0.3);
    border-radius: 4px;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    justify-content: center;
  }
  
  .encrypted-text {
    padding: 2rem;
    background: #f8f9fa;
    border-top: 1px solid #e1e5e9;
  }
  
  .encrypted-text h1,
  .encrypted-text h2,
  .encrypted-text h3,
  .encrypted-text h4,
  .encrypted-text h5,
  .encrypted-text h6 {
    color: #333;
  }
  
  .encrypted-text p {
    color: #555;
    line-height: 1.6;
  }
  
  .encrypted-text code {
    background: #e9ecef;
    padding: 0.2rem 0.4rem;
    border-radius: 3px;
    font-size: 0.9em;
  }
  
  .encrypted-text pre {
    background: #f8f9fa;
    border: 1px solid #e9ecef;
    border-radius: 4px;
    padding: 1rem;
    overflow-x: auto;
  }
`;
document.head.appendChild(style); 