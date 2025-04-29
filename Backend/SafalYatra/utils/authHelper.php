<?php

include "../config/connection.php";


function getUserId($token)
{
    $sql = "select user_id from access_tokens where token = '$token'";
    global $connect;
    $result = mysqli_query($connect, $sql);

    if (!$result) {
        return null;
    }
    $user = mysqli_fetch_assoc($result);
    return $user['user_id'];
}

function getOperatorId($token)
{
    $sql = "select operator_id from access_tokens where token = '$token'";
    global $connect;
    $result = mysqli_query($connect, $sql);

    if (!$result) {
        return null;
    }
    $operator = mysqli_fetch_assoc($result);
    return $operator['operator_id'];
}

function getAdminId($token)
{
    $sql = "select admin_id from access_tokens where token = '$token'";
    global $connect;
    $result = mysqli_query($connect, $sql);

    if (!$result) {
        return null;
    }
    $admin = mysqli_fetch_assoc($result);
    return $admin['admin_id'];
}


function getDriverId($token)
{
    $sql = "select driver_id from access_tokens where token = '$token'";
    global $connect;
    $result = mysqli_query($connect, $sql);

    if (!$result) {
        return null;
    }
    $driver = mysqli_fetch_assoc($result);
    return $driver['driver_id'];
}
