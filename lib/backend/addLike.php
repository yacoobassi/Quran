<?php 

include("connect.php");
include("secureFunction.php");

$num=filter('num') ;
$postNum=filter('postNum') ;



echo "postNum before: " . $postNum . "<br>";
$stmt = $con->prepare("INSERT INTO `postlikes`(`num`, `postNum`) VALUES (?, ?)");
$stmt->execute(array($num, $postNum));
echo "postNum after: " . $postNum . "<br>";


$rowCount = $stmt->rowCount();
  if ($rowCount == 1) {
    echo json_encode(array("status" => "success"));
  } else {
    echo json_encode(array("status" => "failed", "message" => "Unexpected number of rows affected."));
  }