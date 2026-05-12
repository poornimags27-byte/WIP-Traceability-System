<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);

include 'config.sample.php' ;

$conn = new mysqli($host, $username, $password, $dbname);

if ($conn->connect_error) {
    die(json_encode(['error' => $conn->connect_error]));
}

//$query = $_GET['query'] ?? null;
$query = $_REQUEST['query'] ?? null;
$response = [];

$tcpgm = "store.php -" . date("j/n/y");

/* =========================
   QUERY 4 - SAVE
========================= */
if ($query == 4) {

    $id      = $_POST['id'] ?? null;
    $barcode = $_POST['barcode'];
    $grn     = $_POST['grn'];
    $itmid   = $_POST['itmid'];
    $qty     = $_POST['qty'];

    // INSERT
    $stmt = $conn->prepare("INSERT INTO acsto (cacstbarcd, cacstgrnno, nacstitmid, nacstqty, cacstpgm) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param("ssiis", $barcode, $grn, $itmid, $qty, $tcpgm);
    $stmt->execute();

    $response = ["status" => "inserted"];
}

header('Content-Type: application/json');
echo json_encode($response);

$conn->close();
?>