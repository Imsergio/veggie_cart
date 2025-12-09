class Products {
    constructor() {
        this.showDualCurrency = false; // Mostrar solo moneda base por defecto
        this.exchangeRate = 18.50; // Valor por defecto
        this.init();
    }
    
    init() {
        this.renderProducts();
    }
    
    // Productos por defecto si falla la conexión
    async getDefaultProducts() {
        try {
            const response = await fetch('js/default_products.json');
            const data = await response.json();
            return data.products || [];
        } catch (error) {
            console.error('Error loading default products from JSON:', error);
            return []; // Retorna un arreglo vacío si incluso el archivo local falla
        }
    }

    // Renderizar productos en la página
    async renderProducts() {
        const productsGrid = document.getElementById('productsContent');
        const products = await this.getDefaultProducts(); // Cargar productos por defecto
        
        productsGrid.innerHTML = products.map(product => `
                    <article class="products__card">
                        <img src="${product.image}" alt="${product.name}" class="products__card__image">
                        <h3 class="products__card__title">${product.name}</h3>
                        <p class="products__card__description">${product.description}</p>
                        <div class="products__card__price-dual">
                            <span class="products__card__price--usd">${product.price} USD</span>
                            <span class="products__card__price--mxn">${product.price} MXN</span>
                        </div>
                        <button class="products__card__btn btn btn--primary">
                            <i class="fas fa-cart-plus"></i>
                            Agregar al carrito
                        </button>
                    </article>`).join('');
    }

}

// Inicializar la aplicación cuando el DOM esté listo
document.addEventListener('DOMContentLoaded', () => {
    window.products = new Products();
});
