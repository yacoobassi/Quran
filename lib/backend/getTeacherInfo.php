<?php 
include("connect.php");
include("secureFunction.php");

$num = filter('num');

$stmt = $con->prepare("SELECT t.*, i.name  AS institute_name
                      FROM teacherdata AS t  
                      JOIN institutes AS i ON t.num = i.teacherNum 
                      WHERE t.num = ?");
$stmt->execute(array($num));
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

$rowCount = $stmt->rowCount();

  echo json_encode(array("status" => "success", "data" => $data));

