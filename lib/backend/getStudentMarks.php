<?php 
include("connect.php");
include("secureFunction.php");

$num = filter('num');
$instituteNum = filter('instituteNum');
$reginmentNum = filter('reginmentNum');
$date = filter('date');

$stmt = $con->prepare("
SELECT c.`day`, cs.`date`, c.`study`, c.`review`, cs.`studyMark`, cs.`reviewMark`, 
    CASE cs.`exist` 
        WHEN 0 THEN 'حاضر'
        WHEN 1 THEN 'غايب'
        ELSE ''
    END AS `exist`
FROM `class` c
    INNER JOIN `classstudents` cs
        ON c.`date` = cs.`date`
        AND c.`instituteNum` = cs.`instituteNum`
        AND c.`reginmentNum` = cs.`regimentNum`
    WHERE cs.`studentNum` = :num
        AND cs.`regimentNum` = :reginmentNum
        AND cs.`instituteNum` = :instituteNum
        AND YEAR(cs.`date`) = YEAR(:date)
        AND MONTH(cs.`date`) = MONTH(:date)
");
$stmt->execute(array(
    'num' => $num,
    'instituteNum' => $instituteNum,
    'reginmentNum' => $reginmentNum,
    'date' => $date
));
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count = $stmt->rowCount(); 
echo json_encode(array("status" => "success", "data" => $data, "count" => $count));
