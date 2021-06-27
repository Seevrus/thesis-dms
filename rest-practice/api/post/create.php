<?php
  header('Access-Control-Allow-Origin: *');
  header('Content-Type: application/json');
  header('Access-Control-Allow-Methods: POST');
  header('Access-Control-Allow-Headers: Access-Control-Allow-Headers,Access-Control-Allow-Methods,Authorization,Content-Type,X-Requested-With');

  include_once('../../config/Database.php');
  include_once('../../models/Post.php');

  $database = new Database();
  $db = $database->connect();

  $blogpost = new Post($db);
  $data = json_decode(file_get_contents("php://input"));

  $blogpost->title = $data->title;
  $blogpost->body = $data->body;
  $blogpost->author = $data->author;
  $blogpost->category_id = $data->category_id;

  if ($blogpost->create()) {
    echo json_encode(
      array(
        'message' => 'Post created'
      )
    );
  }
  else {
    echo json_encode(
      array(
        'message' => 'Post NOT created'
      )
    );
  }