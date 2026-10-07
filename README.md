# 🛍️ Mini Catalog

Flutter kullanılarak geliştirilmiş, ürün listeleme, ürün detaylarını görüntüleme ve temel sepet işlemlerini içeren modern bir mini katalog uygulamasıdır.

Bu proje, Flutter ve Dart kullanılarak mobil uygulama geliştirme temellerini uygulamalı olarak göstermek amacıyla hazırlanmıştır.

---

## 📱 Proje Özellikleri

- 🏠 Modern ana sayfa
- 🔎 Ürün arama ve filtreleme
- 🛍️ Ürünleri GridView ile listeleme
- 🖼️ Ürün görsellerini görüntüleme
- 📦 Ürün detay sayfası
- 🧭 Navigator ve Route Arguments kullanımı
- 🛒 Sepete ürün ekleme
- 🗑️ Sepetten ürün silme
- 💰 Sepet toplamını hesaplama
- 🛍️ Boş sepet ekranı
- 🌐 API üzerinden dinamik ürün verisi
- 🎨 Ortak uygulama teması
- 🧩 Reusable ProductCard widget yapısı
- 📁 Düzenli proje klasör yapısı

---

## 🛠️ Kullanılan Teknolojiler

- Flutter 3.47.6
- Dart 3.13.5
- Material 3
- Android Studio
- Visual Studio Code
- Android Emulator

---

## 🌐 Veri Kaynağı

Uygulamadaki ürün verileri eğitim amacıyla aşağıdaki API üzerinden alınmaktadır:

**WANTAPI**

`https://wantapi.com/products.php`

Banner görseli:

`https://wantapi.com/assets/banner.png`

> Bu API ve görseller eğitim ve demo amacıyla kullanılmaktadır.

---

## 📸 Ekran Görüntüleri

### Ana Sayfa

![Ana Sayfa](screenshots/home.png)

### Ürün Detay

![Ürün Detay](screenshots/product-detail.png)

### Sepet

![Sepet](screenshots/cart.png)

### Boş Sepet

![Boş Sepet](screenshots/empty-cart.png)

---

## 📂 Proje Klasör Yapısı

```text
lib/
├── main.dart
│
├── models/
│   └── product.dart
│
├── pages/
│   ├── home_page.dart
│   ├── product_detail_page.dart
│   └── cart_page.dart
│
├── services/
│   ├── api_service.dart
│   └── cart_service.dart
│
├── widgets/
│   └── product_card.dart
│
└── theme/
    └── app_theme.dart