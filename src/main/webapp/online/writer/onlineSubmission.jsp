<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + 	request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="css/detail.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<style type="text/css">

</style>
<script type="text/javascript">
</script>
<title>Insert title here</title>
</head>
<body>
	<div class="top_box">
		<h2  align="center">在线投稿</h2>
	</div>
	<div class="main_box">
		<div style="width:100%; height:20px;"></div>
		<form action="doregister.do" method="post" id="registerform">
	<input id="appmark" name="appmark" class="db_input" value="${appmark}" type="hidden">
	<input id="enc_name" name="userName" type="hidden"> 
	<input id="enc_password" name="password" type="hidden"> 
    <div class="main">
        <div style="width:100%; height:40px;"></div>
        <div class="main1">
        	<div class="main1l">
            	<div class="main1ln">文件名<a>*</a>
                </div>
            </div>
            <div class="main1r">
            	<input id="loginId" class="main1rn" placeholder="登录名由文字组成" type="text">
            </div>
        </div>
        <div class="main1" style="margin-top:20px;">
        	<div class="main1l">
            	<div class="main1ln">类型<a>*</a>
                </div>
            </div>
            <div class="main1r">
            	<select class="main1rn">
            		<option>--请选择--</option>
            		<option>新闻</option>
            		<option>言情</option>
            		<option>都市</option>
            	</select>
            </div>
        </div>
        <div class="main1">
        	<div class="main1l">
            	<div class="main1ln">描述<a>*</a>
                </div>
            </div>
            <div class="main1r">
            	<input id="name" name="name" class="main1rn" placeholder="描述由字母、数字、下划线或中文组成" type="text">
            </div>
        </div>
        <div class="main1">
        	<div class="main1l">
            	<div class="main1ln">文章标题<a>*</a>
                </div>
            </div>
            <div class="main1r">
            	<input id="email" name="email" class="main1rn" placeholder="标题由字母、数字、下划线或中文组成" type="text">
            	
            </div>
            
        </div>
      
        <div class="main1">
        	<div class="main1l">
            	<div class="main1ln">移动电话<a>*</a>
                </div>
            </div>
            <div class="main1r">
            	<input id="mobile" name="mobile" class="main1rn" placeholder="如：1381408xxxx" type="text">
            </div>
        </div>
    
        <div class="main1">
        	<div class="main1l">
            	<div class="main1ln">单位名称<a>*</a>
                </div>
            </div>
            <div class="main1r">
            	<input id="mobile" name="mobile" class="main1rn" placeholder="单位名称" type="text">
            </div>
        </div>
        <div class="main1">
        	<div class="main1l">
            	<div class="main1ln">联系地址<a>*</a>
                </div>
            </div>
            <div class="main1r">
            	<input id="mobile" name="mobile" class="main1rn" placeholder="地址" type="text">
            </div>
        </div>
        <div class="main1">
        	<div class="main1l">
            	<div class="main1ln">上传文件<a>*</a>
                </div>
            </div>
            <div class="main1r">
            	<input id="mobile"  name="mobile" class="main1rn" placeholder="地址" type="file">
            </div>
        </div>
    	<div class="anniu" align="center">
        	<div><input class="anniul" value="立即保存" type="submit"></div>
        </div>
    </div>
    </form>
	</div>
</body>
</html>