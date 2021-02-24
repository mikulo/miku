<?php


function main_handler($event, $context){
    $event = json_decode(json_encode($event), true);
    $ht = $event['queryString']['ht'];

    if ($ht == "h")
    {
        $id = $event['queryString']['id'];
        $url = "http://caiyun.feixin.10086.cn/sh/$id";
        return [
            'isBase64Encoded' => false,
            'statusCode' => 301,
            'headers' => [ 'Location' => $url ],
            'body' => null
        ];
    }
    elseif ($ht == "t")
    {
        $dt = $event['queryString']['dt'];
        $expired = $event['queryString']['expired'];
        $sk = $event['queryString']['sk'];
        $ufi = $event['queryString']['ufi'];
        $zyc = $event['queryString']['zyc'];
        $token = $event['queryString']['token'];
        $sig = $event['queryString']['sig'];
        $url = "http://download.cloud.189.cn/file/downloadFile.action?dt=$dt&expired=$expired&sk=$sk&ufi=$ufi&zyc=$zyc&token=$token&sig=$sig";
        return [
            'isBase64Encoded' => false,
            'statusCode' => 301,
            'headers' => [ 'Location' => $url ],
            'body' => null
        ];
    }
    else
    {
        $html = "Wrong or missing parameter!";
        return [
            'isBase64Encoded' => false,
            'statusCode' => 200,
            'headers' => [ 'Content-Type' => 'text/html' ],
            'body' => $html
        ];
    }
}

?>
