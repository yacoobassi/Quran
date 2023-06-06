<?php
include("connect.php");
include("secureFunction.php");

$num = filter('num');
$instituteNum = filter('instituteNum');
$regimentNum = filter('regimentNum');

$stmt = $con->prepare("SELECT t.*, i.name AS institute_name, tt.password
                      FROM teacherdata AS t
                      JOIN institutes AS i ON t.num = i.teacherNum
                      JOIN teachers AS tt ON t.num = tt.num
                      WHERE t.num = ? AND i.regimentNum = ? AND i.num = ?");
$stmt->execute(array($num, $regimentNum, $instituteNum));
$data = $stmt->fetch(PDO::FETCH_ASSOC);

// Fetch all institutes for the teacher
$stmt2 = $con->prepare("SELECT * FROM institutes WHERE teacherNum = ?");
$stmt2->execute(array($num));
$institutes = $stmt2->fetchAll(PDO::FETCH_ASSOC);

$rowCount = $stmt->rowCount();

echo json_encode(array("status" => "success", "data" => $data, "institutes" => $institutes));
?>
