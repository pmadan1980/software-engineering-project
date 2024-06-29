let toggleIconButton = document.getElementById("password-toggle-icon")

function togglePassword(){
    let passwordField = document.getElementById("password");
    let icon = toggleIconButton.firstChild.nextSibling;
    let isHidden = passwordField.type == "password";
    if (isHidden){
        passwordField.type = "text";
        icon.src = "images/visibility.svg";
    } else {
        passwordField.type = "password";
        icon.src = "images/visibility_off.svg";
    }
}

toggleIconButton.addEventListener("click", togglePassword);
