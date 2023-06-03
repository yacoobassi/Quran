<?php 

include("connect.php");
include("secureFunction.php");

$day=filter('day') ;
$classNum=filter('classNum') ;
$part=filter('part') ;
$study=filter('study') ;
$review=filter('review') ;
$tajoeed=filter('tajoeed') ;
$teacherExist=filter('teacherExist') ;
$end=filter('end') ;
$instituteNum=filter('instituteNum') ;
$reginmentNum=filter('reginmentNum') ;
$date=filter('date') ;

$stmt = $con->prepare("UPDATE `class` SET `day`=:day, `date`=:date, `classNum`=:classNum, `part`=:part, `study`=:study, `review`=:review, `tajoeed`=:tajoeed, `teacherExist`=:teacherExist, `start`=`start`, `end`=:end, `instituteNum`=:instituteNum, `reginmentNum`=:reginmentNum WHERE instituteNum = :instituteNum AND reginmentNum = :reginmentNum AND `date` = :date");

$stmt->execute(array(
  ':day' => $day,
  ':date' => $date,
  ':classNum' => $classNum,
  ':part' => $part,
  ':study' => $study,
  ':review' => $review,
  ':tajoeed' => $tajoeed,
  ':teacherExist' => $teacherExist,
  ':end' => $end,
  ':instituteNum' => $instituteNum,
  ':reginmentNum' => $reginmentNum
));

$rowCount = $stmt->rowCount();
if ($rowCount == 1) {
  echo json_encode(array("status" => "success"));
} else {
  echo json_encode(array("status" => "failed", "message" => "Unexpected number of rows affected."));
}
