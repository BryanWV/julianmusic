myApp.collapseMenu = function () {
    let navbar = document.getElementById("myNavbar");

    if (navbar != null) {
        bootstrap.Collapse.getInstance(navbar).hide();


    }



}