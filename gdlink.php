<html>
<body>

<?php 
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
//定义cf返回code函数
function getcode($url){
    $ch = curl_init($url);
    curl_setopt($ch,CURLOPT_RETURNTRANSFER,1);
    curl_exec($ch);
    $httpcode = curl_getinfo($ch,CURLINFO_HTTP_CODE); 
    curl_close($ch);
    return $httpcode;
}

//添加cf直链网址到数组
$address = array("https://link.leng0.workers.dev",
				 "https://link.leng1.workers.dev",
				 "https://link.leng2.workers.dev",
				 "https://link.leng3.workers.dev",
				 "https://link.leng5.workers.dev",
				 "https://link.leng6.workers.dev",
				 "https://link.leng7.workers.dev",
				 "https://link.leng8.workers.dev",
				 "https://link.leng9.workers.dev",
				 "https://link.leng10.workers.dev"
			
);

$id = $_GET["id"];
$mode = $_GET["mode"];
$ip = $_SERVER["REMOTE_ADDR"];
if (get_ip_lookup($ip) == 1)
{
	$mode = "cf";
}
else
{	
	if ($mode=="")
	{
		$mode = "dict";	
	}
	else
	{
		$mode = "cf";
	}

}
if ($id == "")
{
	echo "请在url上加上参数!<br>格式如下:<br>https://gdlink.432100.xyz/?id=文件id<br>获取直链前应将文件设置全网分享(教育版和团队盘可以在PC网页设置)<br>自动识别ip地址<br>国内ip访问强制使用cf中转<br>国外ip访问默认使用谷歌官方直链<br>国外ip访问如果需要使用cf中转需要按如下格式访问:<br>https://gdlink.432100.xyz/?id=文件id&mode=cf<br>或<br>https://gdlink.432100.xyz/?id=文件id&mode=0";
}
elseif($mode=="cf")
{	
	//获取随机站点
	$num = rand(0,count($address)-1);
	$link = "$address[$num]/link/$id";
	header("Location: $link");
	exit;/*		
	while (true)
	{	//判断cf站点是否可用，不可用继续随机挑选到可用为止
		if (getcode($address[$num])== 200)
		{
			$link = "$address[$num]/link/$id";
			//echo $num+1;
			header("Location: $link");
			exit;	
		}
		else
		{
			$num = rand(0,count($address)-1);
		}
	}*/


}
elseif($mode=="dict")
{	
	//使用谷歌官方直链
	//获取随机站点
	$num = rand(0,count($address)-1);
	$link = "$address[$num]/link/$id?output=redirect";
	header("Location: $link");
	exit;/*	
	while (true)
	{	//判断cf站点是否可用，不可用继续随机挑选到可用为止
		if (getcode($address[$num])== 200)
		{
			$link = "$address[$num]/link/$id?output=redirect";
			//echo $num+1;
			header("Location: $link");
			exit;	
		}
		else
		{
			$num = rand(0,count($address)-1);
		}
	}	*/
	/*备用方案
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
	}*/
}

?>
<br>


</body>
</html>
