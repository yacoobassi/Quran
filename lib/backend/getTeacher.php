<?php 

include("connect.php");
include("secureFunction.php");

$instituteNum=filter('instituteNum') ;
$reginmentNum=filter('reginmentNum') ;




$stmt = $con->prepare("SELECT name
FROM teacherdata
WHERE num = (SELECT teacherNum FROM institutes WHERE num = ? AND regimentNum = ?);
");
 
$stmt->execute(array($instituteNum,$reginmentNum));
$data=$stmt->fetchAll(PDO::FETCH_ASSOC);



    echo json_encode(array("status" => "success","data"=>$data));
   