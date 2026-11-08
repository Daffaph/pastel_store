<?php
include 'koneksi.php';

$data = json_decode(file_get_contents("php://input"), true);

if ($data) {
    $title = mysqli_real_escape_string($conn, $data['title']);
    $description = mysqli_real_escape_string($conn, $data['description']);
    $category = mysqli_real_escape_string($conn, $data['category']);
    $price = (double)$data['price'];
    $stock = (int)$data['stock'];
    $brand = mysqli_real_escape_string($conn, $data['brand']);
    $thumbnail = mysqli_real_escape_string($conn, $data['thumbnail']);

    $query = "INSERT INTO products (title, description, category, price, stock, brand, thumbnail) 
              VALUES ('$title', '$description', '$category', '$price', '$stock', '$brand', '$thumbnail')";
              
    if (mysqli_query($conn, $query)) {
        $data['id'] = mysqli_insert_id($conn);
        echo json_encode($data);
    } else {
        http_response_code(500);
        echo json_encode(["message" => "Gagal menyimpan data"]);
    }
}
?>