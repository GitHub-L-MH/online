<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
    	function login(){
    		var userName=$("#username").val();
            var passWord=$("#password").val();
            var flag = $("#type").val();
            $.ajax({
            	url:"${pageContext.request.contextPath}/user/login",
            	data:{'userName':userName,'passWord':passWord,'flag':flag},
            	type:"post",
            	success:function(data){
            		if(data.errorMessage == "ok"){
            			if(1 == flag){
            				window.location.href = "${pageContext.request.contextPath}/online/editor/index.jsp";
            			}else if(2 == flag){
            				window.location.href = "${pageContext.request.contextPath}/online/professor/index.jsp";
            			}else{
            				window.location.href = "${pageContext.request.contextPath}/online/writer/index.jsp";
            			}
            			
            		}
            	},
    			error:function(){
    				alert("系统繁忙，请稍后再试");
    			}
            	
            })
    		
    	}
</script>
<title>登录</title>
</head>
<body>
<body>
	<div style="position: absolute; top: 30px; left: 100px; widows: 100%; height: 100%;">
		<img src="image/index.jpg" style="width: 80%; height: 80%; position: relative; top: 50px;">
	</div>
	<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
		<div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">&nbsp;&nbsp;Online </div>
	</div>
	
	<div style="position: absolute; top: 120px; right: 100px;width:450px;height:400px;border:1px solid #D5D5D5">
		<div style="position: absolute; top: 0px; right: 60px;">
			<div class="page-header">
				<h2 align="center">期刊在线投稿系统</h2>
			</div>
			<form action="workbench/index.html" class="form-horizontal" role="form">
				<div class="form-group form-group-lg">
					<div style="width: 350px;">
						<input class="form-control" type="text" placeholder="用户名" id="username" >
					</div>
					<div style="width: 350px; position: relative;top: 20px;">
						<input class="form-control" type="password" placeholder="密码" id="password" ><br>
					</div>
					<div style="width: 350px; position: relative;top: 20px;">
						<select class="form-control" type="select" id="type" name="type"><br>
                            <option value="0">--请选择类型--</option>
                            <option value="1">作家</option>
                            <option value="2">专家</option>
                            <option value="3">主编</option>
                        </select><br>
					</div>
				</div>
			</form>
			<div style="float:left;width:210px">
			    <button  class="btn btn-primary btn-lg btn-block" id="loginBtn" onclick="login()" style="width: 100px; position: relative;top: 30px;">登录</button>
			</div>
			    <button  class="btn btn-primary btn-lg btn-block" id="registBtn" style="width: 100px; position: relative;top: 30px;">注册</button>
		</div>
	</div>
</body>
</html>