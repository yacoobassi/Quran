<?php 

include("connect.php");
include("secureFunction.php");

$day=filter('day') ;
$date=filter('date') ;
$classNum=filter('classNum') ;
$part=filter('part') ;
$study=filter('study') ;
$review=filter('review') ;
$tajoeed=filter('tajoeed') ;
$teacherExist=filter('teacherExist') ;
$start=filter('start') ;
$end=filter('end') ;
$instituteNum=filter('instituteNum') ;
$reginmentNum=filter('reginmentNum') ;


$check = $con->prepare("SELECT * FROM `class` WHERE `instituteNum` = ? AND `reginmentNum` = ? And `date`= ?");
$check ->execute(array($instituteNum,$reginmentNum,$date));

$rowCount = $check->rowCount();
if ($rowCount > 0) {

    $stmt1 = $con->prepare("UPDATE `class` SET `day`=?,`classNum`=?,`part`=?,`study`= ?,`review`=?,`tajoeed`=?,`teacherExist`= ?,`start`=?,`end`=? WHERE `instituteNum`= ? AND `reginmentNum`=? AND `date`=?");
    $stmt1->execute(array($day, $classNum, $part, $study, $review, $tajoeed, $teacherExist, $start, $end, $instituteNum, $reginmentNum,$date));

    if ($rowCount == 1 ) {
      echo json_encode(array("status" => "success"));
    } else {
      echo json_encode(array("status" => "failed", "message" => "Unexpected number of rows affected."));
    }
} else {

    $stmt1 = $con->prepare("INSERT INTO `class`(`day`, `date`, `classNum`, `part`, `study`, `review`, `tajoeed`, `teacherExist`, `start`, `end`, `instituteNum`, `reginmentNum`) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)");
    $stmt1->execute(array($day, $date, $classNum, $part, $study, $review, $tajoeed, $teacherExist, $start, $end, $instituteNum, $reginmentNum));
    
    
    $rowCount1 = $stmt1->rowCount();
    $rowCount3=0;
    $rowCount4=0;
    $sql1 = $con->prepare("SELECT num FROM `group` WHERE instituteNum = $instituteNum AND regimentNum = $reginmentNum");
    $sql1->execute();
    
    
    if ($sql1->rowCount() > 0) {
    
      while ($row1 = $sql1->fetch(PDO::FETCH_ASSOC)) {
            $num = $row1["num"];
            $sql2 = $con->prepare("SELECT num, groupNum FROM student WHERE groupNum = :num");
            $sql2->bindParam(':num', $num);
            $sql2->execute();
    
            if ($sql2->rowCount() > 0) {
    
              while ($row2 = $sql2->fetch(PDO::FETCH_ASSOC)) {
                    $studentNum = $row2["num"];
                    $groupNum = $row2["groupNum"];
                    $sql3 = $con->prepare("INSERT INTO `classstudents`(`instituteNum`, `regimentNum`, `group`, `studyMark`, `reviewMark`, `tajoeed`, `studentNum`, `date`,`exist`) VALUES (1, 19, ?, ' ', ' ', ' ', ?, STR_TO_DATE(?, '%Y/%m/%d'),0)");
    
    if ($sql3->execute(array($groupNum, $studentNum, $date))) {
        $rowCount3=1;
    }

    $sql4 = $con->prepare("INSERT INTO `reportavarege`(`sala`, `notes`, `student`, `instituteNum`, `regimentNum`, `date`, `act`) VALUES (?,?,?,?,?,?,?)");
  
    if (  $sql4->execute(array(" ", "", $studentNum, $instituteNum, $reginmentNum, $date, " "))) {
      $rowCount4=1;
  }
                    
                }
            }
        }
    }
    
    

      if ($rowCount1 == 1 && $rowCount3==1 && $rowCount4==1 ) {
        echo json_encode(array("status" => "success"));
      } else {
        echo json_encode(array("status" => "failed", "message" => "Unexpected number of rows affected."));
      }
    
    
      
  }


