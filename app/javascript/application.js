// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"

// ✅ Ensure Bootstrap is properly imported
import "bootstrap/dist/css/bootstrap.min.css";

document.addEventListener("DOMContentLoaded", function () {
    const stars = document.querySelectorAll(".star-link");
    const confirmButton = document.getElementById("confirm-rating");
    const restaurantId = document.getElementById("star-rating").dataset.restaurantId;
    let selectedRating = 0;
  
    function highlightStars(rating) {
      stars.forEach((star, index) => {
        star.classList.toggle("selected", index < rating);
      });
    }
  
    stars.forEach(star => {
      star.addEventListener("click", function (event) {
        event.preventDefault();
        selectedRating = parseInt(this.dataset.value);
        highlightStars(selectedRating);
        confirmButton.style.display = "block";
      });
    });
  
    confirmButton.addEventListener("click", function () {
      if (selectedRating === 0) {
        document.getElementById("rating-message").innerText = "⚠ Please select a rating!";
        return;
      }
  
      fetch(`/restaurants/${restaurantId}/rate`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
        },
        body: JSON.stringify({ rating: selectedRating })
      })
      .then(response => response.json())
      .then(data => {
        if (data.average) {
          document.getElementById("average-rating").innerText = data.average;
          document.getElementById("rating-message").innerText = "⭐ Thank you for rating!";
          confirmButton.style.display = "none";
        } else {
          document.getElementById("rating-message").innerText = "❌ " + data.error;
        }
      })
      .catch(error => {
        console.error("❌ Error:", error);
        document.getElementById("rating-message").innerText = "❌ Error submitting rating.";
      });
    });
  });
  