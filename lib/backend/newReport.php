<?php 

include("connect.php");
include("secureFunction.php");

$instituteNum =filter('instituteNum') ;
$regimentNum =filter('regimentNum') ;
$reportDate  =filter('reportDate') ;
$studenstNum=filter('studenstNum') ;
$daysNum=filter('daysNum') ;
$studyDays=filter('studyDays') ;
$startHour=filter('startHour') ;
$quranCheck=filter('quranCheck') ;
$studentsCheck=filter('studentsCheck') ;
$activity=filter('activity') ;
$rememberMark=filter('rememberMark') ;
$reviewMark=filter('reviewMark') ;
$tajoeed=filter('tajoeed') ;
$notes=filter('notes') ;


$check = $con->prepare("SELECT * FROM `report` WHERE `instituteNum` = ? AND `regimentNum` = ? And `reportDate`= ?");
$check ->execute(array($instituteNum,$regimentNum,$reportDate));

$rowCount = $check->rowCount();
if ($rowCount > 0) {

  $stmt1 = $con->prepare("UPDATE `report` SET `instituteNum`=?, `regimentNum`=?, `reportDate`=?, `studenstNum`=?, `daysNum`=?, `studyDays`=?, `startHour`=?, `quranCheck`=?, `studentsCheck`=?, `notes`=?, `activity`=?, `rememberMark`=?, `reviewMark`=?, `tajoeed`=? WHERE `instituteNum`=? AND `regimentNum`=? AND `reportDate`=?");
$stmt1->execute(array($instituteNum, $regimentNum, $reportDate, $studenstNum, $daysNum, $studyDays, $startHour, $quranCheck, $studentsCheck, $notes, $activity, $rememberMark, $reviewMark, $tajoeed, $instituteNum, $regimentNum, $reportDate));

    if ($rowCount == 1 ) {
      echo json_encode(array("status" => "success"));
    } else {
      echo json_encode(array("status" => "failed", "message" => "Unexpected number of rows affected."));
    }
} else {

$stmt = $con->prepare("INSERT INTO report(instituteNum, regimentNum, reportDate, studenstNum, daysNum, studyDays, startHour, quranCheck, studentsCheck, notes, activity, rememberMark, reviewMark, tajoeed) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
$stmt->execute(array($instituteNum, $regimentNum, $reportDate, $studenstNum, $daysNum, $studyDays, $startHour, $quranCheck, $studentsCheck, $notes, $activity, $rememberMark, $reviewMark, $tajoeed));

$rowCount = $stmt->rowCount();
  if ($rowCount == 1) {
    echo json_encode(array("status" => "success"));
  } else {
    echo json_encode(array("status" => "failed", "message" => "Unexpected number of rows affected."));
  }
}