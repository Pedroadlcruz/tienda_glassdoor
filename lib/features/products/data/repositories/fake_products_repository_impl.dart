import '../../domain/repositories/products_repository.dart';
import '../models/product.dart';

class FakeProductsRepositoryImpl implements ProductsRepository {
  // Mock data for demonstration
  final List<Product> _products = [
    // 🍎 Apple Products
    const Product(
      id: '1',
      name: 'iPhone 15 Pro Max',
      description:
          'El iPhone más avanzado con chip A17 Pro, cámara de 48MP, acción de botón y diseño de titanio. Incluye USB-C y hasta 29 horas de reproducción de video.',
      price: 1199.99,
      imageUrl:
          'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=400',
      category: 'Electronics',
      stock: 25,
      rating: 4.9,
      reviewCount: 1247,
    ),
    const Product(
      id: '2',
      name: 'MacBook Pro 14" M3',
      description:
          'Potencia profesional con chip M3, hasta 22 horas de batería, pantalla Liquid Retina XDR y hasta 96GB de memoria unificada.',
      price: 1999.99,
      imageUrl:
          'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400',
      category: 'Electronics',
      stock: 12,
      rating: 4.9,
      reviewCount: 567,
    ),
    const Product(
      id: '3',
      name: 'AirPods Pro 2nd Gen',
      description:
          'Auriculares inalámbricos con cancelación activa de ruido adaptativa, audio espacial personalizado y hasta 6 horas de reproducción.',
      price: 249.99,
      imageUrl:
          'https://images.unsplash.com/photo-1606220945770-b5b6c2c55bf1?w=400',
      category: 'Electronics',
      stock: 50,
      rating: 4.8,
      reviewCount: 2341,
    ),
    const Product(
      id: '4',
      name: 'iPad Pro 12.9" M2',
      description:
          'Tablet más potente con chip M2, pantalla Liquid Retina XDR, compatibilidad con Apple Pencil y Magic Keyboard.',
      price: 1099.99,
      imageUrl:
          'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=400',
      category: 'Electronics',
      stock: 18,
      rating: 4.8,
      reviewCount: 892,
    ),
    const Product(
      id: '5',
      name: 'Apple Watch Ultra 2',
      description:
          'Reloj de aventura con GPS dual, altímetro, brújula y hasta 36 horas de batería. Ideal para deportes extremos.',
      price: 799.99,
      imageUrl:
          'https://images.unsplash.com/photo-1434493789847-2f02dc6ca35d?w=400',
      category: 'Electronics',
      stock: 15,
      rating: 4.9,
      reviewCount: 445,
    ),

    // 🏃‍♂️ Sports & Fitness
    const Product(
      id: '6',
      name: 'Nike Air Jordan 1 Retro',
      description:
          'Zapatillas icónicas con diseño clásico, suela de goma duradera y construcción premium en cuero.',
      price: 169.99,
      imageUrl:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400',
      category: 'Sports',
      stock: 45,
      rating: 4.7,
      reviewCount: 2156,
    ),
    const Product(
      id: '7',
      name: 'Adidas Ultraboost Light',
      description:
          'Zapatillas de running con tecnología Light Boost, Primeknit+ y confort superior para largas distancias.',
      price: 189.99,
      imageUrl:
          'https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=400',
      category: 'Sports',
      stock: 38,
      rating: 4.8,
      reviewCount: 1234,
    ),
    const Product(
      id: '8',
      name: 'Wilson Pro Staff Tennis Racket',
      description:
          'Raqueta de tenis profesional con tecnología Spin Effect, marco de grafito y empuñadura de cuero.',
      price: 129.99,
      imageUrl:
          'https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=400',
      category: 'Sports',
      stock: 30,
      rating: 4.6,
      reviewCount: 567,
    ),
    const Product(
      id: '9',
      name: 'Lululemon Align Yoga Mat',
      description:
          'Mat de yoga premium de 5mm con tecnología antideslizante, diseño reversible y bolsa de transporte incluida.',
      price: 89.99,
      imageUrl:
          'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=400',
      category: 'Sports',
      stock: 65,
      rating: 4.8,
      reviewCount: 892,
    ),
    const Product(
      id: '10',
      name: 'Bowflex SelectTech Dumbbells',
      description:
          'Mancuernas ajustables de 5-52.5kg con sistema de cambio rápido, diseño ergonómico y garantía de por vida.',
      price: 399.99,
      imageUrl:
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400',
      category: 'Sports',
      stock: 12,
      rating: 4.9,
      reviewCount: 234,
    ),

    // 🎮 Gaming & Entertainment
    const Product(
      id: '11',
      name: 'PlayStation 5 Console',
      description:
          'Consola de nueva generación con SSD ultra-rápido, ray tracing y controlador DualSense con retroalimentación háptica.',
      price: 499.99,
      imageUrl:
          'https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=400',
      category: 'Electronics',
      stock: 8,
      rating: 4.9,
      reviewCount: 3456,
    ),
    const Product(
      id: '12',
      name: 'Nintendo Switch OLED',
      description:
          'Consola híbrida con pantalla OLED de 7", audio mejorado, almacenamiento de 64GB y dock con puerto LAN.',
      price: 349.99,
      imageUrl:
          'https://images.unsplash.com/photo-1578303512597-81e6cc155b3e?w=400',
      category: 'Electronics',
      stock: 22,
      rating: 4.7,
      reviewCount: 1892,
    ),
    const Product(
      id: '13',
      name: 'Sony WH-1000XM5 Headphones',
      description:
          'Auriculares over-ear con cancelación de ruido líder en la industria, 30 horas de batería y audio de alta resolución.',
      price: 399.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400',
      category: 'Electronics',
      stock: 28,
      rating: 4.8,
      reviewCount: 1567,
    ),

    // 🏠 Home & Lifestyle
    const Product(
      id: '14',
      name: 'Dyson V15 Detect Vacuum',
      description:
          'Aspiradora inalámbrica con tecnología Laser Detect, hasta 60 minutos de autonomía y filtro HEPA completo.',
      price: 699.99,
      imageUrl:
          'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400',
      category: 'Electronics',
      stock: 15,
      rating: 4.8,
      reviewCount: 678,
    ),
    const Product(
      id: '15',
      name: 'Instant Pot Duo Plus',
      description:
          'Olla de cocción múltiple con 9 funciones, pantalla LED, 15 programas y capacidad de 6L.',
      price: 129.99,
      imageUrl:
          'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400',
      category: 'Electronics',
      stock: 42,
      rating: 4.6,
      reviewCount: 2341,
    ),

    // 🚴‍♂️ Outdoor & Adventure
    const Product(
      id: '16',
      name: 'Garmin Fenix 7 Sapphire',
      description:
          'Reloj GPS de aventura con mapas topográficos, monitoreo de salud avanzado y hasta 18 días de batería.',
      price: 899.99,
      imageUrl:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400',
      category: 'Sports',
      stock: 8,
      rating: 4.9,
      reviewCount: 234,
    ),
    const Product(
      id: '17',
      name: 'GoPro Hero 11 Black',
      description:
          'Cámara de acción con sensor de 27MP, estabilización HyperSmooth 5.0 y video 5.3K/60fps.',
      price: 399.99,
      imageUrl:
          'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=400',
      category: 'Electronics',
      stock: 35,
      rating: 4.7,
      reviewCount: 892,
    ),
    const Product(
      id: '18',
      name: 'Patagonia Down Jacket',
      description:
          'Chaqueta de plumas con tecnología 800-fill, resistente al agua, ligera y perfecta para aventuras al aire libre.',
      price: 229.99,
      imageUrl:
          'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=400',
      category: 'Sports',
      stock: 55,
      rating: 4.8,
      reviewCount: 567,
    ),

    // 💻 Computing & Accessories
    const Product(
      id: '19',
      name: 'Samsung 49" Odyssey G9 Monitor',
      description:
          'Monitor gaming curvo con resolución 5120x1440, 240Hz, 1ms y tecnología Quantum Dot.',
      price: 999.99,
      imageUrl:
          'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=400',
      category: 'Electronics',
      stock: 6,
      rating: 4.9,
      reviewCount: 123,
    ),
    const Product(
      id: '20',
      name: 'Logitech MX Master 3S Mouse',
      description:
          'Mouse ergonómico con sensor de 8000 DPI, scroll MagSpeed, hasta 70 días de batería y conexión inalámbrica.',
      price: 99.99,
      imageUrl:
          'https://images.unsplash.com/photo-1615663245857-ac93bb7c39e7?w=400',
      category: 'Electronics',
      stock: 75,
      rating: 4.7,
      reviewCount: 2341,
    ),

    // 🎧 Audio & Music
    const Product(
      id: '21',
      name: 'Bose QuietComfort 45',
      description:
          'Auriculares over-ear con cancelación de ruido líder, 24 horas de batería, audio equilibrado y confort excepcional.',
      price: 329.99,
      imageUrl:
          'https://images.unsplash.com/photo-1484704849700-f032a568e944?w=400',
      category: 'Electronics',
      stock: 40,
      rating: 4.8,
      reviewCount: 1567,
    ),
    const Product(
      id: '22',
      name: 'JBL Flip 6 Portable Speaker',
      description:
          'Altavoz portátil resistente al agua IPX7, 12 horas de reproducción, sonido potente y diseño compacto.',
      price: 129.99,
      imageUrl:
          'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=400',
      category: 'Electronics',
      stock: 85,
      rating: 4.6,
      reviewCount: 892,
    ),

    // 🏠 Smart Home
    const Product(
      id: '23',
      name: 'Philips Hue Smart Bulb Starter Kit',
      description:
          'Kit de inicio con 3 bombillas inteligentes, bridge y control remoto. Compatible con Alexa y Google Home.',
      price: 199.99,
      imageUrl:
          'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=400',
      category: 'Electronics',
      stock: 60,
      rating: 4.7,
      reviewCount: 1234,
    ),
    const Product(
      id: '24',
      name: 'Ring Video Doorbell Pro',
      description:
          'Timbre inteligente con video HD, visión nocturna, detección de movimiento y comunicación bidireccional.',
      price: 249.99,
      imageUrl:
          'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400',
      category: 'Electronics',
      stock: 35,
      rating: 4.8,
      reviewCount: 678,
    ),

    // 🏃‍♀️ Fitness & Health
    const Product(
      id: '25',
      name: 'Peloton Bike+',
      description:
          'Bicicleta de spinning inteligente con pantalla HD de 24", entrenamientos en vivo y métricas avanzadas.',
      price: 2495.00,
      imageUrl:
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400',
      category: 'Sports',
      stock: 12,
      rating: 4.9,
      reviewCount: 456,
    ),
    const Product(
      id: '26',
      name: 'Fitbit Sense 2',
      description:
          'Reloj inteligente con monitoreo de estrés, ECG, SpO2, GPS y hasta 6 días de batería.',
      price: 299.99,
      imageUrl:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400',
      category: 'Electronics',
      stock: 45,
      rating: 4.7,
      reviewCount: 789,
    ),

    // 🎮 Gaming Accessories
    const Product(
      id: '27',
      name: 'Razer BlackWidow V3 Pro',
      description:
          'Teclado mecánico gaming inalámbrico con switches Green, RGB Chroma y hasta 200 horas de batería.',
      price: 229.99,
      imageUrl:
          'https://images.unsplash.com/photo-1541140532154-b024d705b90a?w=400',
      category: 'Electronics',
      stock: 25,
      rating: 4.8,
      reviewCount: 567,
    ),
    const Product(
      id: '28',
      name: 'SteelSeries Arctis Pro Wireless',
      description:
          'Auriculares gaming con audio de alta fidelidad, micrófono retráctil y hasta 20 horas de batería.',
      price: 349.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400',
      category: 'Electronics',
      stock: 30,
      rating: 4.9,
      reviewCount: 345,
    ),

    // 🏠 Kitchen & Appliances
    const Product(
      id: '29',
      name: 'Vitamix 5200 Blender',
      description:
          'Licuadora profesional con motor de 2.2 HP, 64 oz de capacidad y 10 velocidades variables.',
      price: 449.99,
      imageUrl:
          'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400',
      category: 'Electronics',
      stock: 20,
      rating: 4.9,
      reviewCount: 234,
    ),
    const Product(
      id: '30',
      name: 'Breville Barista Express',
      description:
          'Máquina de espresso semiautomática con molinillo integrado, caldera de 15 bar y vaporizador de leche.',
      price: 699.99,
      imageUrl:
          'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400',
      category: 'Electronics',
      stock: 15,
      rating: 4.8,
      reviewCount: 123,
    ),
  ];

  @override
  Future<List<Product>> getProducts() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _products;
  }

  @override
  Future<Product?> getProductById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _products.where((product) => product.category == category).toList();
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final lowercaseQuery = query.toLowerCase();
    return _products.where((product) {
      return product.name.toLowerCase().contains(lowercaseQuery) ||
          product.description.toLowerCase().contains(lowercaseQuery) ||
          product.category.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }
}
