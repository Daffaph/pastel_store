<?php
include 'koneksi.php';
$data = json_decode(file_get_contents("php://input"), true);

if (isset($_GET['id']) && $data) {$id = (int)$_GET['id'];$title = mysqli_real_escape_string($conn,$data['title']);
    $description = mysqli_real_escape_string($conn, $data['description']);$category = mysqli_real_escape_string($conn,$data['category']);
    $price = (double)$data['price'];
    $stock = (int)$data['stock'];
    $brand = mysqli_real_escape_string($conn, $data['brand']);$thumbnail = mysqli_real_escape_string($conn,$data['thumbnail']);

    $query = "UPDATE products SET title='$title', description='$description', category='$category', price='$price', stock='$stock', brand='$brand', thumbnail='$thumbnail' WHERE id=$id";
              
    if (mysqli_query($conn,$query)) {
        $data['id'] =$id;
        echo json_encode($data);
    } else {
        http_response_code(500);
        echo json_encode(["message" => "Gagal memperbarui data"]);
    }
}
?>