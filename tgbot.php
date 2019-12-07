<?php 


header("Content-Type: application/json");

$content = file_get_contents("php://input");
$update  = json_decode($content, true);

if(!$update) {
  exit;
}

$message   = isset($update['message']) ? $update['message'] : "";
$messageId = isset($message['message_id']) ? $message['message_id'] : "";
$chatId    = isset($message['chat']['id']) ? $message['chat']['id'] : "";
$firstname = isset($message['chat']['first_name']) ? $message['chat']['first_name'] : "";
$lastname  = isset($message['chat']['last_name']) ? $message['chat']['last_name'] : "";
$username  = isset($message['chat']['username']) ? $message['chat']['username'] : "";
$date      = isset($message['date']) ? $message['date'] : "";
$text      = isset($message['text']) ? $message['text'] : "";
$userId    = isset($message['from']['id']) ? $message['from']['id'] : "";
$matches = array();
if (preg_match( '/.*drive.google.com\/open\?id=.{33}$/', $text,$matches ))
{  
    preg_match( '/\?id=.{33}$/', $text,$matches );
    $response = "获取成功,直链为:\nhttps://gdlink.432100.xyz/".$matches[0] ;
    $parameters           = array('chat_id' => $chatId, "text" => iconv('GB2312', 'UTF-8', $response));
    $parameters["method"] = "sendMessage";
    echo json_encode($parameters);
}
elseif (preg_match( '/\/link.*drive.google.com\/open\?id=.{33}$/', $text,$matches ))
{  
    preg_match( '/\?id=.{33}$/', $text,$matches );
    $response = "获取成功,直链为:\nhttps://gdlink.432100.xyz/".$matches[0] ;
    $parameters           = array('chat_id' => $chatId, "text" => iconv('GB2312', 'UTF-8', $response));
    $parameters["method"] = "sendMessage";
    echo json_encode($parameters);
}
elseif (preg_match( '/.*drive.google.com.*\/file\/d\/.{33}\//', $text,$matches ))
{
    preg_match( '/\/file\/d\/.{33}/', $text,$matches );
    $response = "获取成功,直链为:\nhttps://gdlink.432100.xyz/?id=".substr($matches[0],-33);
    $parameters           = array('chat_id' => $chatId, "text" => iconv('GB2312', 'UTF-8', $response));
    $parameters["method"] = "sendMessage";
    echo json_encode($parameters);
}
elseif (preg_match( '/\/link.*drive.google.com.*\/file\/d\/.{33}\//', $text,$matches ))
{
    preg_match( '/\/file\/d\/.{33}/', $text,$matches );
    $response = "获取成功,直链为:\nhttps://gdlink.432100.xyz/?id=".substr($matches[0],-33);
    $parameters           = array('chat_id' => $chatId, "text" => iconv('GB2312', 'UTF-8', $response));
    $parameters["method"] = "sendMessage";
    echo json_encode($parameters);
}
elseif ($text=="/start")
{
    $response = "欢迎使用,请向我发送文件链接开始提取直链!";
    $parameters           = array('chat_id' => $chatId, "text" => iconv('GB2312', 'UTF-8', $response));
    $parameters["method"] = "sendMessage";
    echo json_encode($parameters, JSON_UNESCAPED_UNICODE);
}
elseif ($text=="/link")
{
    $response = "请在/link后面加上文件链接!";
    $parameters           = array('chat_id' => $chatId, "text" => iconv('GB2312', 'UTF-8', $response));
    $parameters["method"] = "sendMessage";
    echo json_encode($parameters, JSON_UNESCAPED_UNICODE);
}
elseif (preg_match( '/.*drive.google.com\/drive\/.\/.\/folders\/.{33}/', $text ))
{
    $response = "抱歉,仅支持单文件直链提取,不支持目录链接!";
    $parameters           = array('chat_id' => $chatId, "text" => iconv('GB2312', 'UTF-8', $response));
    $parameters["method"] = "sendMessage";
    echo json_encode($parameters);
}
else
{
    $response = "链接格式错误!" ;
    $parameters           = array('chat_id' => $chatId, "text" => iconv('GB2312', 'UTF-8', $response));
    $parameters["method"] = "sendMessage";
    echo json_encode($parameters);
}



?>

