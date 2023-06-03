<?php 

include("connect.php");
include("secureFunction.php");

$post=filter('post') ;
$num=filter('num') ;
$comment=filter('comment') ;
$date=filter('date') ;


$stmt = $con->prepare("INSERT INTO `comments`(`num`, `comment`,`date`,`postNum`) VALUES (?,?,?, ?)");
$stmt->execute(array($num, $comment,$date, $post));
echo "postNum after: " . $postNum . "<br>";


$rowCount = $stmt->rowCount();
  if ($rowCount == 1) {
    echo json_encode(array("status" => "success"));
  } else {
    echo json_encode(array("status" => "failed", "message" => "Unexpected number of rows affected."));
  }