<?php 

include("connect.php");
include("secureFunction.php");

$num=filter('num') ;
$finishedParts=filter('finishedParts') ;
$currentPart=filter('currentPart') ;
$nextExam=filter('nextExam') ;
$grade=filter('grade') ;
$birth=filter('birth') ;
$fatherPhone=filter('fatherPhone') ;
$motherPhone=filter('motherPhone') ;
$house=filter('house') ;
$instituteNum =filter('instituteNum') ;
$instituteName =filter('instituteName') ;



$stmt = $con->prepare("INSERT INTO `studentsdata`(`num`, `currentPart`, `nextExam`, `grade`, `birth`, `fatherPhone`, `motherPhone`, `house`, `finishedParts`, `co`, `school`, `id`) VALUES (?,?,?,?,?,?,?,?,?,'-','-','-')");

$stmt->execute(array($num, $currentPart, $nextExam, $grade, $birth, $fatherPhone, $motherPhone, $house,$finishedParts));

$rowCount = $stmt->rowCount();
  if ($rowCount == 1) {
    echo json_encode(array("status" => "success"));
  } else {
    echo json_encode(array("status" => "failed", "message" => "Unexpected number of rows affected."));
  }