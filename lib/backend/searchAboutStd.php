
<?php
include("connect.php");
include("secureFunction.php");

$num = filter('num');
$name = filter('name');

$stmt = $con->prepare("SELECT *
FROM `student`
INNER JOIN `studentsdata` ON `student`.`num` = `studentsdata`.`num`
WHERE `student`.`instituteNum` = (SELECT `instituteNum` FROM `teachers` WHERE `teachers`.`num` = ?) 
AND `student`.`reginmentNum` = (SELECT `reginmentNum` FROM `teachers` WHERE `teachers`.`num` = ?)
AND `studentsdata`.`name` LIKE ?");
 
$stmt->execute(array($num, $num,$name));
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode(array("status" => "success", "data" => $data));
