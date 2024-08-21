<?php


$servername = "localhost";
$username ="root";
$password = "";
$dbname = "chat";
// Create connection
$con = mysqli_connect($servername, $username, $password, $dbname);
$code = '';
if(isset($_POST['code'])){
    $code= $_POST['code'];
}
$result= mysqli_query($con,"select * from `student` where `code`='$code'");

$count = $result->num_rows;

if($count > 0){
    $sql = "SELECT * FROM `student` WHERE `code`='$code'";
    $result = $con->query($sql);
    if ($result->num_rows > 0) {
        // Fetch user data and return as a JSON response
        $user = $result->fetch_assoc();
        echo json_encode($user);
    }
    
 }else{
    
    echo json_encode (array("result"=>"not here"));
 }


?>

