<?php 

include("connect.php");
include("secureFunction.php");

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



$stmt = $con->prepare("INSERT INTO `teacherdata`(`name`, `id`, `country`, `birth`, `social`, 
`currentJob`, `lastJob`, `study`, `university`, `certificate`,
 `tajoeedLevel`, `tajoeedYear`, `mosque`, `personTeachYou`, 
 `region`, `Yourphone`, `housePhone`, `remark`, `num`) 
 VALUES  (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

$stmt->execute(array($name, $id, $country, $birth, $social, $currentJob, 
$lastJob, $study, $university, $certificate, $tajoeedLevel,
 $tajoeedYear, $mosque, $personTeachYou, $region, $Yourphone, $housePhone, $remark, $num));

$rowCount = $stmt->rowCount();
  if ($rowCount == 1) {
    echo json_encode(array("status" => "success"));
  } else {
    echo json_encode(array("status" => "failed", "message" => "Unexpected number of rows affected."));
  }