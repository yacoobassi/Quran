<?php 

include("connect.php");
include("secureFunction.php");

$password=filter('password') ;
$name=filter('name') ;
$id=filter('id') ;
$country=filter('country') ;
$birth=filter('birth') ;
$social=filter('social') ;
$currentJob=filter('currentJob') ;
$lastJob=filter('lastJob') ;
$study=filter('study') ;
$university=filter('university') ;
$certificate=filter('certificate') ;
$tajoeedLevel=filter('tajoeedLevel') ;
$tajoeedYear =filter('tajoeedYear') ;
$mosque =filter('mosque') ;
$personTeachYou =filter('personTeachYou') ;
$region =filter('region') ;
$Yourphone =filter('Yourphone') ;
$housePhone =filter('housePhone') ;
$remark =filter('remark') ;
$num =filter('num') ;



$stmt = $con->prepare("UPDATE `teacherdata` SET `name`=?,`id`=?,`country`=?,`birth`=?,`social`=?,`currentJob`=?,`lastJob`=?,`study`=?,`university`=?,`certificate`=?,`tajoeedLevel`=?,`tajoeedYear`=?,`mosque`=?,`personTeachYou`=?,`region`=?,`Yourphone`=?,`housePhone`=?,`remark`=? WHERE `num`= ?");

$stmt->execute(array($name, $id, $country, $birth, $social, $currentJob, 
$lastJob, $study, $university, $certificate, $tajoeedLevel,
 $tajoeedYear, $mosque, $personTeachYou, $region, $Yourphone, $housePhone, $remark, $num));

$rowCount = $stmt->rowCount();
$stmt1= $con->prepare("UPDATE `teachers` SET `password`=$password WHERE num=$num");
$stmt1->execute();
  if ($rowCount == 1) {
    echo json_encode(array("status" => "success"));
  } else {
    echo json_encode(array("status" => "failed", "message" => "Unexpected number of rows affected."));
  }