<?php
ini_set('display_errors', 0);
error_reporting(E_ALL);

include 'config.php';

$conn = new mysqli($host, $username, $password, $dbname);

if ($conn->connect_error) {
    die(json_encode(['error' => $conn->connect_error]));
}

//$query = $_GET['query'] ?? null;
$query = $_REQUEST['query'] ?? null;
$response = [];

/* =========================
   QUERY 2 - LIST
========================= */
if ($query == 2) {

    $page = isset($_GET['pages']) ? (int)$_GET['pages'] : 1;
    $rowsPerPage = isset($_GET['rows']) ? (int)$_GET['rows'] : 10;

    $offset = ($page - 1) * $rowsPerPage;

    $total = $conn->query("SELECT COUNT(*) as cnt FROM acitm")->fetch_assoc()['cnt'];
    $totalPages = ceil($total / $rowsPerPage);

    $stmt = $conn->prepare("SELECT nacitmid, cacitmcd, cacitmnm FROM acitm LIMIT ?, ?");
    $stmt->bind_param("ii", $offset, $rowsPerPage);
    $stmt->execute();

    $res = $stmt->get_result();
    $data = [];

    while ($row = $res->fetch_assoc()) {
        $data[] = implode("^", [$row['nacitmid'], $row['cacitmcd'], $row['cacitmnm']]);
    }

    $response = [
        "currentPage" => $page,
        "rowsPerPage" => $rowsPerPage,
        "totalPages" => $totalPages,
        "data" => $data
    ];
}

/* =========================
   QUERY 3 - GET SINGLE
========================= */
if ($query == 3) {

    $id = isset($_GET['id']) ? (int)$_GET['id'] : 0;

    $stmt = $conn->prepare("SELECT nacitmid, cacitmcd, cacitmnm FROM acitm WHERE nacitmid = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();

    $res = $stmt->get_result();

    if ($row = $res->fetch_assoc()) {
        $response = [
            "success" => true,
            "data" => [
                $row['nacitmid'],
                $row['cacitmcd'],
                $row['cacitmnm'],
            ]
        ];
    } else {
        $response = [
            "success" => false
        ];
    }
}

/* =========================
   QUERY 4 - SAVE
========================= */
if ($query == 4) {

    $id = $_POST['id'] ?? null;
    $code = $_POST['code'];
    $name = $_POST['name'];

    if ($id) {
        // UPDATE
        $stmt = $conn->prepare("UPDATE acitm SET cacitmcd=?, cacitmnm=? WHERE nacitmid=?");
        $stmt->bind_param("ssi", $code, $name, $id);
        $stmt->execute();

        $response = ["status" => "updated"];
    } else {
        // INSERT
        $stmt = $conn->prepare("INSERT INTO acitm (cacitmcd, cacitmnm) VALUES (?, ?)");
        $stmt->bind_param("ss", $code, $name);
        $stmt->execute();

        $response = ["status" => "inserted"];
    }
}

header('Content-Type: application/json');
echo json_encode($response);

$conn->close();
?>