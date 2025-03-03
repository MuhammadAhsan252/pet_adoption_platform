// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"


$(document).on('turbo:load', function() {
    $('#admin').on('click', function() {
        $('#sidebarMenu').toggleClass('collapse');
    });

    function closeNavbar() {
        $(".btn-close").trigger("click");
    }

    $("a.scroll-link").on("click", function(event) {
        closeNavbar();
        if (this.hash !== "") {
          const hash = this.hash;
          $("html, body").animate(
            {
              scrollTop: $(hash).offset().top - 200
            },
            500 // Adjust the animation speed (in milliseconds) as needed
          );
        }
    });

    $('#category_select').on('change', function() {
        var categoryId = $(this).val();
        if (categoryId) {
          $.ajax({
            url: '/categories/' + categoryId + '/subcategories',
            type: 'GET',
            dataType: 'json',
            success: function(data) {
              $('#subcategory_select').empty();
              $('#subcategory_select').append($('<option>').text('Select Subcategory').attr('value', ''));
              $.each(data, function(key, value) {
                $('#subcategory_select').append($('<option>').text(value.name).attr('value', value.id));
              });
            }
          });
        } else {
          $('#subcategory_select').empty();
          $('#subcategory_select').append($('<option>').text('Select Category First').attr('value', ''));
        }
    });

    $('.fa-edit').on('click', function() {
    var editForm = $(this).closest('tr').find('.edit-category-form');
    var categoryName = $(this).closest('tr').find('.category-name');
    $('.edit-category-form').not(editForm).hide(); // Hide other forms
    $('.category-name').not(categoryName).show();
    editForm.toggle(); // Toggle the visibility of the clicked form
    categoryName.toggle();
    });

    $('.fa-times').on('click', function() {
        var editForm = $(this).closest('tr').find('.edit-category-form');
        var categoryName = $(this).closest('tr').find('.category-name');
        $('.edit-category-form').not(editForm).hide(); // Hide other forms
        $('.category-name').not(categoryName).show();
        editForm.toggle(); // Toggle the visibility of the clicked form
        categoryName.toggle();
    });


    $('.fa-edit').on('click', function() {
        var editForm = $(this).closest('tr').find('.edit-subcategory-form');
        var categoryName = $(this).closest('tr').find('.subcategory-name');
        $('.edit-subcategory-form').not(editForm).hide(); // Hide other forms
        $('.subcategory-name').not(categoryName).show();
        editForm.toggle(); // Toggle the visibility of the clicked form
        categoryName.toggle();
        });
    
    $('.fa-times').on('click', function() {
        var editForm = $(this).closest('tr').find('.edit-subcategory-form');
        var categoryName = $(this).closest('tr').find('.subcategory-name');
        $('.edit-subcategory-form').not(editForm).hide(); // Hide other forms
        $('.subcategory-name').not(categoryName).show();
        editForm.toggle(); // Toggle the visibility of the clicked form
        categoryName.toggle();
    });
});
