<?php 
include("connect.php");
include("secureFunction.php");

$instituteNum = filter('instituteNum');
$reginmentNum = filter('reginmentNum');
$date = filter('date');
// ...

$stmt = $con->prepare("
SELECT s.name, m.date, m.mark,
    CASE 
      WHEN m.mark >= 9 THEN 'ممتاز'
      WHEN m.mark >= 8 THEN 'جيد جدا'
      WHEN m.mark >= 7 THEN 'جيد'
      WHEN m.mark >= 5 THEN 'مقبول'
      ELSE 'ضعيف'
    END AS estimate,
    m.notes,
    m.tajoeedMinus,
    IFNULL((SELECT mark 
            FROM marks 
            WHERE studentNum = m.studentNum 
              AND instituteNum = m.instituteNum 
              AND reginmentNum = m.reginmentNum 
              AND date > m.date
            ORDER BY date DESC
            LIMIT 1), 'لا يوجد') AS lastExam
  FROM marks m 
  JOIN student s ON m.studentNum = s.num 
  WHERE m.reginmentNum = ? AND m.instituteNum = ? AND m.date = ?
  ORDER BY m.date DESC, m.mark DESC
");

$stmt->execute(array($reginmentNum, $instituteNum, $date));
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Assign order to students with the same mark
$rank = 1;
$prevMark = null;
$prevOrder = null;

foreach ($data as &$row) {
  if ($row['mark'] !== $prevMark) {
    $prevMark = $row['mark'];
    $row['order'] = $rank++;
    $prevOrder = $row['order'];
  } else {
    $row['order'] = $prevOrder;
  }
}

// Encode the JSON response and output it
$response = array("status" => "success", "data" => $data);
echo json_encode($response);
