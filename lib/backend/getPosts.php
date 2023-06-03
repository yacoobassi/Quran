<?php 
include("connect.php");
include("secureFunction.php");

$instituteNum = filter('instituteNum');
$reginmentNum = filter('reginmentNum');
$num = filter('num');

$stmt = $con->prepare("SELECT post.*, teacherdata.name, (SELECT COUNT(*) FROM `postlikes` WHERE `postNum` = post.`count` AND `num` = ?) > 0 as isLiked
FROM `post` 
INNER JOIN `teacherdata` ON post.teacher = teacherdata.num 
WHERE post.`instituteNum` = ? AND post.`reginmentNum` = ?
ORDER BY post.date DESC
");
$stmt->execute(array($num, $instituteNum, $reginmentNum));
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count = $stmt->rowCount(); 
echo json_encode(array("status" => "success", "data" => $data, "count" => $count));
