myApp.collapseMenu = function () {
    let navbar = document.getElementById("navbarText");

    if (navbar != null) {
        bootstrap.Collapse.getInstance(navbar).hide();

    }

}