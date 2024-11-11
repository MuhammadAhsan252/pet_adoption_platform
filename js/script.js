document.addEventListener('DOMContentLoaded', function() {
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
});