<?php 

include("connect.php");
include("secureFunction.php");

$num =filter('num') ;
$name=filter('name') ;
$id=filter('id') ;
$grade=filter('grade') ;
$birth=filter('birth') ;
$fatherPhone=filter('fatherPhone') ;
$motherPhone=filter('motherPhone') ;
$school=filter('school') ;
$instituteNum=filter('instituteNum') ;
$reginmentNum=filter('reginmentNum') ;





$stmt = $con->prepare("UPDATE `studentsdata` SET `num`=`num`,`currentPart`=`currentPart`,`nextExam`=`nextExam`,`grade`=?,`birth`=?,`fatherPhone`=?,`motherPhone`=?,`house`=`house`,`finishedParts`=`finishedParts`,`co`=`co`,`school`=? ,`id`=? WHERE `num`= ?");

$stmt->execute(array($grade,$birth,$fatherPhone,$motherPhone,$school,$id,$num));


$stmt1 = $con->prepare("UPDATE `student` SET `name`= ? WHERE `num`= ?");
$stmt1->execute(array($name,$num));

$rowCount = $stmt->rowCount();
  if ($rowCount == 1) {
    echo json_encode(array("status" => "success"));
  } else {
    echo json_encode(array("status" => "failed", "message" => "Unexpected number of rows affected."));
  }