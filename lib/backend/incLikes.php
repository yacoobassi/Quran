<?php
include("connect.php");
include("secureFunction.php");

$count = filter('count');

$stmt = $con->prepare("UPDATE `post` SET `date`=`date`,`likesNum` = `likesNum` +1 WHERE `count` = :count");

$stmt->bindParam(':count', $count, PDO::PARAM_INT);
$stmt->execute();

$rowCount = $stmt->rowCount();

echo json_encode(array("status" => "success", "count" => $rowCount));
?>
