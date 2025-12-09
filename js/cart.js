class ShoppingCart {
    constructor() {
        this.init();
    }

    init() {
        this.bindEvents();
    }
    
    openCartModal() {
        document.getElementById('cartModal').style.display = 'block';
        document.body.style.overflow = 'hidden';
    }

    closeCartModal() {
        document.getElementById('cartModal').style.display = 'none';
        document.body.style.overflow = 'auto';
    }

    bindEvents() {
        // Seleccionar los elementos del Carrito
        const cartBtn = document.getElementById('cartIcon'); // Botón del carrito
        const closeBtn = document.getElementById('closeCart'); // Botón de cerrar
        
        // Eventos de los botones
        cartBtn.addEventListener('click', () => this.openCartModal()); // Evento de apertura
        closeBtn.addEventListener('click', () => this.closeCartModal()); // Evento de cierre

        // Cerrar modales al hacer clic fuera
        document.getElementById('cartModal').addEventListener('click', (e) => {
            // Cerrar el modal si se hace clic en el fondo
            if (e.target.id === 'cartModal') {
                this.closeCartModal();
            }
        });
    }
}

// Inicializar la aplicación cuando el DOM esté listo
document.addEventListener('DOMContentLoaded', () => {
    window.cart = new ShoppingCart();
});