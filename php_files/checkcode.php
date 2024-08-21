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
if ($result->num_rows > 0) {
    // Fetch user data and return as a JSON response
    $user = $result->fetch_assoc();
    echo json_encode($user);
} else {
    // Return an error message
    echo json_encode(array('error' => 'Invalid email or password'));
}
?>