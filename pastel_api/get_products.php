<?php
include 'koneksi.php';

$result = mysqli_query($conn, "SELECT * FROM products ORDER BY id DESC");
$products = [];

while ($row = mysqli_fetch_assoc($result)) {
    $row['id'] = (int)$row['id'];
    $row['price'] = (double)$row['price'];
    $row['stock'] = (int)$row['stock'];
    $products[] = $row;
}

echo json_encode(["products" => $products]);
?>