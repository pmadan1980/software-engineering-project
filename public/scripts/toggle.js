let profileButton = document.getElementById("profile-picture");

function toggleOptions() {
    let options = document.getElementById("profile-options");
    let style = getComputedStyle(options);
    let isHidden = style.display == "none"
    console.log(isHidden);
    if (isHidden){
        options.style.display = "block";
    } else {
        options.style.display = "none";
    }
}

profileButton.addEventListener("click", toggleOptions);