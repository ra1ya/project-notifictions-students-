<?php


$servername = "localhost";
$username ="root";
$password = "";
$dbname = "chat";
// Create connection
$con = mysqli_connect($servername, $username, $password, $dbname);


$username = '';
$password='';
if(isset($_POST['username'])){
    $username= $_POST['username'];
}
if(isset($_POST['password'])){
    $password = $_POST['password'];
}

$result= mysqli_query($con,"select * from `admin` where `username`='$username' AND `password`='$password'");
$count = $result->num_rows;

if($count > 0){
    $sql = "select * from `admin` where `username`='$username' AND `password`='$password'";
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