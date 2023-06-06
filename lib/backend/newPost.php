

 <?php 

include("connect.php");
include("secureFunction.php");



$image64=base64_decode(filter('image64')) ;
$date=filter('date') ;
$comment=filter('comment') ;
$reginmentNum=filter('reginmentNum') ;
$instituteNum=filter('instituteNum') ;
$commentsNum=filter('commentsNum') ;
$imageName=filter('imageName') ;
$teacher=filter('teacher') ;
$likesNum=filter('likesNum') ;

$stmt = $con->prepare("INSERT INTO `post`(`teacher`, `date`, `comment`, `image`, `reginmentNum`, `instituteNum`, `commentsNum`, `likesNum`) VALUES (?,?,?,?,?,?,?,?)");
 
$stmt->execute(array($teacher,$date,$comment,$imageName,$reginmentNum,$instituteNum, $commentsNum,$likesNum));

$count=$stmt->rowCount();
if($count>0){
file_put_contents("..\\..\\images/post\\".$imageName,$image64);

echo json_encode(array("status" => "success"));
}