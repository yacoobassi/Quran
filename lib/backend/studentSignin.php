


<?php 

 
include("connect.php");
include("secureFunction.php");

$num=filter('num') ;
$password=filter('password') ;




$stmt = $con->prepare("SELECT * FROM students WHERE `num`=? and `password`=?");
$stmt->execute(array($num ,$password));


$rowCount = $stmt->rowCount();
  if ($rowCount == 1) {
    echo json_encode(array("status" => "success"));
  } else {
    echo json_encode(array("status" => "failed", "message" => "Unexpected number of rows affected."));
  }