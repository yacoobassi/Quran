<?php
include("connect.php");
include("secureFunction.php");

$num = filter('num');

// Select marks and estimate, sorted by date in descending order
$stmt = $con->prepare("SELECT *, 
    CASE WHEN mark >= 9 THEN 'ممتاز' 
         WHEN mark = 8 THEN 'جيد' 
         WHEN mark = 7 THEN 'مقبول' 
         ELSE 'ضعيف' 
    END AS estimate 
    FROM marks 
    WHERE studentNum= ? 
    ORDER BY date DESC");
$stmt->execute(array($num));
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Calculate average mark
$avg_stmt = $con->prepare("SELECT AVG(mark) as avg_mark FROM marks WHERE studentNum = ?");
$avg_stmt->execute(array($num));
$avg_data = $avg_stmt->fetch(PDO::FETCH_ASSOC);
$avg_mark = number_format($avg_data['avg_mark'], 1);

$count = $stmt->rowCount();

// Output data and average mark as JSON
echo json_encode(array("status" => "success", "count" => $count, "data" => $data, "avg_mark" => $avg_mark));
