/*=============== MENU LOGIC ===============*/
document.addEventListener('DOMContentLoaded', () => {
    // Select elements
    const navToggle = document.getElementById('menuToggle');
    const headerMenu = document.querySelector('.header__menu');
    const navMenu = document.getElementById('navMenu');
    const menuIcon = document.querySelector('.header__nav-icon');

    // Check if elements exist
    if (!navToggle || !headerMenu || !navMenu || !menuIcon) {
        console.error('Uno o más elementos del menú no fueron encontrados. El script del header no se ejecutará.');
        return;
    }

    // functions
    const toggleMenu = () => {
        headerMenu.classList.toggle('header__menu--overlay-active');
        navMenu.classList.toggle('header__nav--is-open');
        navToggle.classList.toggle('is-active'); // Add this line
        menuIcon.classList.toggle('fa-bars');
        menuIcon.classList.toggle('fa-times');
    };

    const hideMenu = () => {
        if (headerMenu.classList.contains('header__menu--overlay-active')) {
            headerMenu.classList.remove('header__menu--overlay-active');
            navMenu.classList.remove('header__nav--is-open');
            navToggle.classList.remove('is-active'); // Add this line
            menuIcon.classList.add('fa-bars');
            menuIcon.classList.remove('fa-times');
        }
    };

    // Listener for toggling the menu
    navToggle.addEventListener('click', (e) => {
        // stop propagation to prevent document click listener from firing
        e.stopPropagation();
        toggleMenu();
    });

    // Listener to close the menu when a nav link is clicked
    navMenu.addEventListener('click', (e) => {
        if (e.target.classList.contains('header__nav-link')) {
            hideMenu();
        }
    });

    // Listener to close the menu when clicking outside
    document.addEventListener('click', (e) => {
        // if click is outside the menu and toggle button, hide the menu
        if (headerMenu.classList.contains('header__menu--overlay-active') && !navMenu.contains(e.target) && !navToggle.contains(e.target)) {
            hideMenu();
        }
    });
});