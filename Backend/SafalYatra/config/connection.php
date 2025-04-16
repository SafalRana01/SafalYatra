<?php
// Database connection details
$host = 'localhost'; // Database server
$user = 'root'; // Database username
$database = 'yatrasafal'; // Database name
$password = ''; // Database password

// Establishing a connection to the database
$connect = mysqli_connect($host, $user, $password, $database);

// Checking if the connection to the database was successful
if (!$connect) {
    // If the connection fails, it will output an error message with the connection error
    echo ("Connection Failed" . mysqli_connect_error());
} else {
}
