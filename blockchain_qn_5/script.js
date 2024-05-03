document.addEventListener('DOMContentLoaded', function() {
    const accordionItems = document.querySelectorAll('.accordion-item');
  
    accordionItems.forEach(item => {
      const title = item.querySelector('.accordion-title');
      const content = item.querySelector('.accordion-content');
  
      title.addEventListener('click', function() {
        const isOpen = item.classList.contains('open');
  
        // Close all accordion items
        accordionItems.forEach(item => {
          item.classList.remove('open');
          item.querySelector('.accordion-content').classList.remove('show');
        });
  
        // If clicked item is not already open, open it
        if (!isOpen) {
          item.classList.add('open');
          content.classList.add('show');
        }
      });
    });
  });
  