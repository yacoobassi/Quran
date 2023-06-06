<?php 

include("connect.php");
include("secureFunction.php");

$num=filter('num') ;



$stmt = $con->prepare("SELECT * FROM `institutes` WHERE teacherNum=$num
");
 
$stmt->execute();
$data=$stmt->fetchAll(PDO::FETCH_ASSOC);
 echo json_encode(array("status" => "success","data"=>$data));
   