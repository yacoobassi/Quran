<?php 

include("connect.php");
include("secureFunction.php");

$num=filter('num') ;



$stmt = $con->prepare("DELETE FROM `student` WHERE num=$num");
$stmt->execute();

$stmt1 = $con->prepare("DELETE FROM `comments` WHERE num=$num");
$stmt1->execute();



$rowCount = $stmt->rowCount();
  if ($rowCount == 1) {
    echo json_encode(array("status" => "success"));
  } else {
    echo json_encode(array("status" => "failed", "message" => "Unexpected number of rows affected."));
  }