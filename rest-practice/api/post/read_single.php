<?php
  header('Access-Control-Allow-Origin: *');
  header('Content-Type: application/json');

  include_once('../../config/Database.php');
  include_once('../../models/Post.php');

  $database = new Database();
  $db = $database->connect();

  $blogpost = new Post($db);
  $blogpost->id = isset($_GET['id']) ? $_GET['id'] : die();
  $blogpost->read_single();

  $post_arr = array(
    'id' => $blogpost->id,
    'title' => $blogpost->title,
    'body' => $blogpost->body,
    'author' => $blogpost->author,
    'category_id' => $blogpost->category_id,
    'category_name' => $blogpost->category_name,
  );

  print_r(json_encode($post_arr));
?>