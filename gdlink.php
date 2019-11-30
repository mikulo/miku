<html>
<body>

<?php 
//谷歌直链大文件方法代码来源为:https://github.com/donwa/GoogleDriveDirect
//定义ip国家子函数,如果从中国访问,返回1，否则返回0
function get_ip_lookup($ip=null){
    $res = @file_get_contents('http://ip.taobao.com/service/getIpInfo.php?ip=' . $ip);
    if (strpos($res,"中国")==false)
    {
    	return 0;
    }
    else
    {
    	return 1;
    }
    
}
//添加cf直链网址到数组
$address = array("https://link.leng.workers.dev/link/",
				 "https://link.leng1.workers.dev/link/",
				 "https://link.leng2.workers.dev/link/",
				 "https://link.leng3.workers.dev/link/"
			
);
$id = $_GET["id"];
$mode = $_GET["mode"];
$ip = $_SERVER["REMOTE_ADDR"];
if (get_ip_lookup($ip) == 1)
{
	$mode = "0";
}
else
{	if ($mode=="1")
	{
		$mode = "0";	
	}
	else
	{
		$mode = "1";
	}

}
if ($id == "")
{
	echo "请在url上加上参数!";
}
elseif($mode=="0")
{	
	//获取随机站点
	$num = rand(0,count($address)-1);
	$link = "$address[$num]$id";
	//echo $num+1;
	header("Location: $link");
	exit;
}
elseif($mode=="1")
{	
	//使用谷歌官方直链
	include('fetch.php');
	if(empty($_GET['id'])){
		exit('no file id');
	}
	//get confirm
	$resp = fetch::get('https://drive.google.com/uc?export=download&id='.$id);
	//  <25M
	if(!empty($resp->headers['Location'])){
		header('location: '.$resp->headers['Location']);
		echo $resp->content;
	}
	list($tmp, $confirm) = explode('download&amp;confirm=', $resp->content);
	list($confirm, $tmp) = explode('&amp;id=', $confirm);
    if(empty($confirm)){
		exit('get confirm error');
	}
	
	//get download link
	$url = "https://drive.google.com/uc?export=download&confirm={$confirm}&id={$id}";
	$resp = fetch::get($url);
	if(!empty($resp->headers['Location'])){
		header('location: '.$resp->headers['Location']);
		echo $resp->content;
	}else{
	    exit('no download link');
	}
}

?>
<br>


</body>
</html>
