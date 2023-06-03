 <?php 

 
include("connect.php");
include("secureFunction.php");

$userName=filter('name') ;
$num=filter('num') ;
$password=filter('password') ;
$groupNum =filter('groupNum') ;
$reginmentNum  =filter('reginmentNum') ;
$instituteNum  =filter('instituteNum') ;




$stmt = $con->prepare("INSERT INTO `student`(`num`, `name`, `password`, `instituteNum`, `reginmentNum`, `groupNum`) VALUES (?, ?, ?, ?, ? ,?)");
 
$stmt->execute(array($num, $userName, $password,$instituteNum,$reginmentNum, $groupNum));



$rowCount = $stmt->rowCount();
  if ($rowCount == 1) {
    echo json_encode(array("status" => "success"));
  } else {
    echo json_encode(array("status" => "failed", "message" => "Unexpected number of rows affected."));
  }