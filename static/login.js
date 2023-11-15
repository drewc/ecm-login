const ready = fn => document.readyState !== 'loading' ? fn() : document.addEventListener('DOMContentLoaded', fn);

ready(function() {
//     const form = document.getElementById("loginForm");
//     form.addEventListener("submit", function (event) {
// 	// event.preventDefault();
// 	login_user()
//     })

   const failure = new URLSearchParams(window.location.search).get("_f")
   if (typeof failure == "string") {
     document.getElementById("Invalid").style.display = "block"
   }
 })

function login_user ( form_id = "loginForm") {
  alert('Login' + form_id)
}
