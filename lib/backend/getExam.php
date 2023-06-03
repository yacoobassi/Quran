<?php 

include("connect.php");
include("secureFunction.php");

$instituteNum=filter('instituteNum') ;
$reginmentNum=filter('reginmentNum') ;
$date=filter('date') ;



$stmt = $con->prepare("SELECT *
FROM exam
WHERE instituteNum= ? AND regimentNum= ? And `date`= ?
ORDER BY `date` DESC
");
 
$stmt->execute(array($instituteNum,$reginmentNum,$date));
$data=$stmt->fetchAll(PDO::FETCH_ASSOC);
 echo json_encode(array("status" => "success","data"=>$data));
   