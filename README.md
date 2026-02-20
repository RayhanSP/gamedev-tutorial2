# Tutorial 2

**Nama:** Rayhan Syahdira Putra
**NIM:** 2306275903

---

### 1. Apa saja pesan log yang dicetak pada panel Output?

**Jawaban:**
Pesan log mencetak informasi mengenai inisialisasi core system Godot, yang meliputi versi engine (v4.6), rendering backend yang digunakan (Vulkan 1.4 dengan metode Forward+), serta deteksi hardware grafis (Intel Arc 140V). Dalam dokumentasi Godot, baris "Platform initialized" menandakan bahwa RenderingServer dan DisplayServer telah berhasil memuat driver yang diperlukan tanpa error, sehingga Main Loop permainan siap dijalankan di atas perangkat keras yang terdeteksi tersebut.

```text
Godot Engine v4.6.stable.official.89cea1439 - [https://godotengine.org](https://godotengine.org)
Vulkan 1.4.323 - Forward+ - Using Device #0: Intel - Intel(R) Arc(TM) 140V GPU (16GB)

Platform initialized
```

### 2. Coba gerakkan landasan ke batas area bawah, lalu gerakkan kembali ke atas hingga hampir menyentuh batas atas. Apa saja pesan log yang dicetak pada panel Output?

**Jawaban:**
Output ini merupakan hasil dari fungsi debugging (seperti print()) yang diletakkan di dalam skrip untuk memverifikasi alur logika permainan secara runtime. Pesan ini mengonfirmasi bahwa state permainan telah berubah sesuai skenario, di mana objek pemain berhasil memanuver landasan dari batas bawah kembali ke titik target di atas tanpa mengalami game over.

```text
Reached objective!
```

### 3. Buka scene MainLevel dengan tampilan workspace 2D. Apakah lokasi scene ObjectiveArea memiliki kaitan dengan pesan log yang dicetak pada panel Output pada percobaan sebelumnya?

**Jawaban:**
Ya, ini mekanisme collision detection pada Godot. ObjectiveArea merupakan node bertipe Area2D yang memiliki batas fisik (CollisionShape), ketika node BlueShip (objek pemain) memasuki area geometri tersebut, Godot memicu sinyal, yang kemudian ditangkap oleh skrip untuk mengeksekusi output "Reached objective!", menandakan bahwa interaksi spasial antar-objek telah terpenuhi.

### 4. Scene BlueShip dan StonePlatform sama-sama memiliki sebuah child node bertipe Sprite2D. Apa fungsi dari node bertipe Sprite2D?

**Jawaban:**
Fungsi utama dari node `Sprite2D` adalah untuk merender grafik 2D (seperti gambar PNG, JPG, atau WEBP) ke dalam layar permainan. Dalam arsitektur Godot, `Sprite2D` mewarisi properti dari `Node2D` dan `CanvasItem`, yang berarti selain berfungsi sebagai representasi visual semata, node ini juga menerima parameter transformasi (posisi, rotasi, skala) dari parent-nya. Hal ini memastikan bahwa gambar yang ditampilkan akan selalu bergerak sinkron mengikuti perubahan posisi dari objek fisika yang menjadi induknya.

### 5. Root node dari scene BlueShip dan StonePlatform menggunakan tipe yang berbeda. BlueShip menggunakan tipe RigidBody2D, sedangkan StonePlatform menggunakan tipe StaticBody2D. Apa perbedaan dari masing-masing tipe node?

**Jawaban:**
Perbedaan terletak pada bagaimana Godot memerlakukan kedua node tersebut. `RigidBody2D` adalah node  yang pergerakannya disimulasikan tanpa perlu kita atur posisinya secara manual melalui kode. `StaticBody2D` dirancang untuk objek lingkungan yang statis,tidak merespons gaya fisika apa pun, namun benda dinamis lain dapat berinteraksi dan bertabrakan dengannya.

### 6. Ubah nilai atribut Mass pada tipe RigidBody2D secara bebas di scene BlueShip, lalu coba jalankan scene MainLevel. Apa yang terjadi?

**Jawaban:**
Ketika nilai atribut Mass pada `RigidBody2D` ditingkatkan, objek `BlueShip` terasa jauh lebih berat dan lambat saat digerakkan. Sesuai dengan hukum fisika yang disimulasikan Godot, gaya dorong yang sama akan menghasilkan akselerasi yang lebih kecil pada objek bermassa besar. Akibatnya, respons pergerakan kapal terhadap input pemain menjadi jauh lebih berat dan lamban.

### 7. Ubah nilai atribut Disabled milik node CollisionShape2D pada scene StonePlatform, lalu coba jalankan scene MainLevel. Apa yang terjadi?

**Jawaban:**
Setelah atribut Disabled dicentang, `StonePlatform` tidak dapat lagi menahan objek `BlueShip` sehingga kapal akan tembus dan jatuh ke bawah layar. Node `CollisionShape2D` pada dasarnya berfungsi untuk mendefinisikan batas fisik dari sebuah objek di dalam simulasi. Dengan menonaktifkannya, kita menghapus `StaticBody2D` tersebut dari sistem perhitungan collision detection Godot, sehingga mengabaikan interaksi tabrakan antara kedua benda tersebut.

### 8. Pada scene MainLevel, coba manipulasi atribut Position, Rotation, dan Scale milik node BlueShip secara bebas. Apa yang terjadi pada visualisasi BlueShip di Viewport?

**Jawaban:**
Visualisasi `BlueShip` di Viewport akan langsung berubah bentuk, orientasi, maupun lokasinya mengikuti manipulasi atribut pada tab Inspector. Perubahan transform pada parent ini akan langsung diturunkan dan diaplikasikan ke seluruh child nodes di bawahnya, sehingga tampilan visual dan hitbox objek di dunia 2D diperbarui secara seketika.

### 9. Pada scene MainLevel, perhatikan nilai atribut Position node PlatformBlue, StonePlatform, dan StonePlatform2. Mengapa nilai Position node StonePlatform dan StonePlatform2 tidak sesuai dengan posisinya di dalam scene (menurut Inspector) namun visualisasinya berada di posisi yang tepat?

**Jawaban:**
Godot menggunakan sistem koordinat relatif yang berbasis pada hierarki Scene Tree. Nilai Position yang tertera pada Inspector untuk node anak (`StonePlatform` dan `StonePlatform2`) adalah koordinat lokal, yaitu posisi yang diukur berdasarkan origin dari node induknya (`PlatformBlue`), bukan dari koordinat global keseluruhan dunia permainan. Oleh karena itu, posisi visual nyata mereka di layar adalah hasil kalkulasi dari posisi global parent ditambah dengan offset posisi lokal child tersebut.