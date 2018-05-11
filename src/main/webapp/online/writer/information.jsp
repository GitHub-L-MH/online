<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${pageContext.request.contextPath}/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css"
          rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/css/detail.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <style type="text/css">

    </style>
    <script type="text/javascript">
    </script>
    <title>Insert title here</title>
</head>
<body>
<div class="top_box">
    <h2 align="center">用户信息展示</h2>
</div>
<div class="main_box">
    <div style="width:100%; height:20px;"></div>
    <form action="${pageContext.request.contextPath}/user/updateUser" method="post" id="registerform">
        <input type="hidden" id="id" value="">
        <div class="main">
            <div style="width:100%; height:40px;"></div>
            <div class="main1">
                <div class="main1l">
                    <div class="main1ln">用户名<a>*</a>
                    </div>
                </div>
                <div class="main1r">
                    <input id="loginId" name="userName" class="main1rn" placeholder="登录名由字母、数字、下划线组成" type="text">
                </div>
            </div>
            <div class="main1" style="margin-top:20px;">
                <div class="main1l">
                    <div class="main1ln">性别<a>*</a>
                    </div>
                </div>
                <div class="main1r">
                    <input id="password2" name="sex" class="main1rn" placeholder="男或者女" type="password">
                </div>
            </div>
            <div class="main1">
                <div class="main1l">
                    <div class="main1ln">姓名<a>*</a>
                    </div>
                </div>
                <div class="main1r">
                    <input id="name" name="name" class="main1rn" placeholder="请输入姓名" type="text">
                </div>
            </div>
            <div class="main1">
                <div class="main1l">
                    <div class="main1ln">Email<a>*</a>
                    </div>
                </div>
                <div class="main1r">
                    <input id="email" name="email" class="main1rn" placeholder="如：hao123@163.com" type="text">

                </div>

            </div>


            <div class="main1">
                <div class="main1l">
                    <div class="main1ln">移动电话<a>*</a>
                    </div>
                </div>
                <div class="main1r">
                    <input id="mobile" name="phone" class="main1rn" placeholder="如：1381408xxxx" type="text">
                </div>
            </div>

            <div class="main1">
                <div class="main1l">
                    <div class="main1ln">单位名称<a>*</a>
                    </div>
                </div>
                <div class="main1r">
                    <input id="unit" name="unit" class="main1rn" placeholder="单位名称" type="text">
                </div>
            </div>
            <div class="main1">
                <div class="main1l">
                    <div class="main1ln">联系地址<a>*</a>
                    </div>
                </div>
                <div class="main1r">
                    <input id="address" name="address" class="main1rn" placeholder="地址" type="text">
                </div>
            </div>
            <div class="anniu" align="center">
                <div><input class="anniul" value="立即修改" type="submit"></div>
            </div>
        </div>
    </form>
</div>
</body>
</html>