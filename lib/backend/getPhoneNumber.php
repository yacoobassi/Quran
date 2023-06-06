<?php
include("connect.php");
include("secureFunction.php");

$num = filter('num');

$stmt = $con->prepare("SELECT sd.`fatherPhone`, sd.`motherPhone`, s.`password`
                      FROM `studentsdata` AS sd
                      JOIN `student` AS s ON sd.num = s.num
                      WHERE s.num = :num");
$stmt->bindParam(':num', $num, PDO::PARAM_INT);
$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode(array("status" => "success", "data" => $data));
?>
