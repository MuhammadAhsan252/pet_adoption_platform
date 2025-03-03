// category_controller.js
import { Controller } from 'stimulus';

export default class extends Controller {
  edit(event) {
    event.preventDefault();
    const categoryPath = event.currentTarget.getAttribute('href');

    fetch(categoryPath, { headers: { 'X-Requested-With': 'XMLHttpRequest' } })
      .then(response => response.text())
      .then(html => {
        // Replace the existing form/section with the fetched edit form
        const editSection = document.getElementById('editCategorySection');
        if (editSection) {
          editSection.innerHTML = html;
        }
      })
      .catch(error => {
        console.error('Error fetching category edit form:', error);
      });
  }
}
