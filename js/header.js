/*=============== SHOW MENU ===============*/
const navMenu = document.getElementById('navMenu'),
    navToggle = document.getElementById('menuToggle'),
    navClose = document.getElementById('navClose');

/*===== MENU SHOW =====*/
/* Valida si la constante existe */
if (navToggle) {
    navToggle.addEventListener('click', () => {
        navMenu.classList.add('show-menu');
    });
}

/*===== MENU HIDDEN =====*/
/* Valida si la constante existe */
if (navClose) {
    navClose.addEventListener('click', () => {
        navMenu.classList.remove('show-menu');
    });
}

/*=============== REMOVE MENU MOBILE ===============*/
/* Funcionalidad para cerrar el menú móvil cuando se hace clic en un enlace */
const navLinks = document.querySelectorAll('.nav__link');

function linkAction() {
    // Al hacer clic en cada nav__link, se elimina la clase show-menu
    navMenu.classList.remove('show-menu');
}
navLinks.forEach(n => n.addEventListener('click', linkAction));