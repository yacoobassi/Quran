<?php

include("connect.php");
include("secureFunction.php");

$num = filter('num');
$postNum = filter('postNum');

$stmt = $con->prepare("DELETE FROM postLikes WHERE num = $num AND postNum = $postNum;
");
$stmt->execute();

$rowCount = $stmt->rowCount();

echo json_encode(array("status" => "success", "count" => $rowCount));
