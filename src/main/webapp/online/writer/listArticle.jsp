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
<link href="jquery/bs_datetimepicker/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="jquery/bs_datetimepicker/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="jquery/bs_datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>

<script type="text/javascript" src="jquery/bs_pagination/js/jquery.bs_pagination.min.js"></script>
<script type="text/javascript" src="jquery/bs_pagination/js/localization/en.js"></script>
<link rel="stylesheet" type="text/css" href="jquery/bs_pagination/css/jquery.bs_pagination.min.css">
<style type="text/css">
</style>
<script type="text/javascript">

	$(function(){
		
		//以下日历插件在FF中存在兼容问题，在IE浏览器中可以正常使用。
		/*
		$("#startTime").datetimepicker({
			minView: "month",
			language:  'zh-CN',
			format: 'yyyy-mm-dd',
	        autoclose: true,
	        todayBtn: true,
	        pickerPosition: "bottom-left"
		});
		
		$("#endTime").datetimepicker({
			minView: "month",
			language:  'zh-CN',
			format: 'yyyy-mm-dd',
	        autoclose: true,
	        todayBtn: true,
	        pickerPosition: "bottom-left"
		});
		*/
		//当页面加载完成之后，对容器调用工具函数
		$('.mydate').datetimepicker({
			  language: 'zh-CN',//显示中文
			  format: 'yyyy-mm-dd',//显示格式
			  minView: "month",//设置只显示到月份
			  initialDate: new Date(),//初始化当前日期
			  autoclose: true,//选中自动关闭
			  todayBtn: true,//显示今日按钮
			  clearBtn:true//是否显示清空按钮
	    });
		
		//定制字段
		$("#definedColumns > li").click(function(e) {
			//防止下拉菜单消失
	        e.stopPropagation();
	    });
		
		
		$("#addBtn").click(function(){
			//重置表单
			$("#createActivityForm")[0].reset();
			//$("#createActivityModal").modal("show")
			$.ajax({
				url:"workbench/activity/marketActivityAddController.do",
				type:"post",
				success:function(data){
					$("#create-marketActivityOwner").html("<option>--请选择--</option>")
					//alert(data)
					$(data).each(function(){
						//alert('${u.id}')
						if(this.id=='${u.id}'){
							$("#create-marketActivityOwner").append("<option value='"+this.id+"' selected>"+this.name+"</option>")	
						}else{
							$("#create-marketActivityOwner").append("<option value='"+this.id+"'>"+this.name+"</option>")
						}
					})
					$("#createActivityModal").modal("show")
				}
			})
		})
		
		 
		$("#saveBtn").click(function(){
	
		
		var owner=$("#create-marketActivityOwner").val()
		var type=$("#create-marketActivityType").val()
		var name=$.trim($("#create-marketActivityName").val())
		var state=$("#create-marketActivityState").val()
		var startDate=$("#create-marketActivitystartDate").val()
		var endDate=$("#create-marketActivityendDate").val()
		var budgetCost=$.trim($("#create-marketActivitybudgetCost").val())
		var actualCost=$.trim($("#create-marketActivityactualCost").val())
		var description=$.trim($("#create-marketActivitydescription").val())
		//表单验证
		if(name==null||name.length==0){
			alert("名称不能为空");
			return;
		}
		if(startDate!=null&&startDate.length>0&&endDate!=null&&endDate.length>0){
			if(endDate<startDate){
				alert("结束时间不能晚于开始时间");
				return;
			}
		}
		var regExp=/^([1-9][0-9]*|0)$/;
		if(budgetCost!=null&&budgetCost.length>0){
			if(!regExp.test(budgetCost)){
				alert("预算成本只能为非负整数")
				return;
			}
		}
		if(actualCost!=null&&actualCost.length>0){
			if(!regExp.test(actualCost)){
				alert("实际成本只能为非负整数")
				return;
			}
		}
		
		
		$.ajax({
			url:"workbench/activity/SaveCreateMarketActivitiesController.do",
			data:{
				owner:owner,
				type:type,
				name:name,
				state:state,
				startDate:startDate,
				endDate:endDate,
				budgetCost:budgetCost,
				actualCost:actualCost,
				description:description
			},
			type:"post",
			success:function(data){
				//alert(data.success)
				if(data.success){
					$("#createActivityModal").modal("hide");
				}else{
					alert("创建失败");
					$("#createActivityModal").modal("show");
				}
			}
		})
         
	}) 

	        //页面加载完成之后显示第一页数据
	        display(1,10);
		
		//查询按钮添加事件
		$("#queryBtn").click(function(){
			display(1,$("#pageNoDiv").bs_pagination('getOption', 'rowsPerPage'));
		})
		
		//当页面加载完成之后，默认"添加字段"下所有checkbox都选中
		$("#definedColumns input[type='checkbox']").prop("checked",true);
		//给"添加字段"下的所有checkbox添加单击事件
		$("#definedColumns input[type='checkbox']").click(function(){
			if(this.checked){
				$("td[name="+this.name+"]").show();
			}else{
				$("td[name="+this.name+"]").hide();
			}
		})
		//给"全选"按钮添加单击事件
		$("#sel_all").click(function(){
			$("#activityListBody input[type='checkbox']").prop("checked",this.checked);
		});
		//给列表中所有的checkbox添加单击事件
		$("#activityListBody").on("click","input[type='checkbox']",function(){
			if($("#activityListBody input[type='checkbox']").size()==$("#activityListBody input[type='checkbox']:checked").size()){
				$("#sel_all").prop("checked",true);
			}else{
				$("#sel_all").prop("checked",false);
			}
		})
		
		//删除操作
		
		//点击删除按钮时的触发事件
		 $("#deleteBtn").click(function(){
			//收集参数
			var ids=$("#activityListBody input[type='checkbox']:checked");
			if(ids.length==0){
				alert("请选择要删除的记录");
				return;
			}
			var param="";
			$.each(ids,function(index,obj){
				param+="id="+obj.value+"&";
			});
			param=param.substr(0,param.length-1);
			if(window.confirm("确定删除吗")){
				//发送请求
			    $.ajax({
					url:"workbench/activity/DeleteActivityByIdsController.do",
					type:"post",
					data:param,
					success:function(data){
						if(data.success){
							display(1,$("#pageNoDiv").bs_pagination('getOption', 'rowsPerPage'));
						}else{
							alert("删除失败");
						}
					}
			    })	
			}
		 
		})                       
		
		//获取要修改操作的内容
		//为编辑按钮添加点击事件
	    $("#editBtn").click(function(){
	    	//获得参数
			var aid=$("#activityListBody input[type='checkbox']:checked");
	    	if(aid.length==0){
	    		alert("请选择要编辑的记录")
	    		return;
	    	}
	    	if(aid.length>1){
	    		alert("只能选择一条记录")
	    		return;
	    	}
	    	var id=aid.val();
	    	//alert(id)
			//发送请求
			$.ajax({
				url:"workbench/activity/EditActivityController.do",
				type:"post",
				data:{
					id:id
				},
				success:function(data){
					//设置所有者
					var htmlStr=""
					$.each(data.list,function(index,obj){
						if(obj.id==data.m.owner){
							htmlStr+="<option value='"+obj.id+"' selected>"+obj.name+"</option>"
						}else{
							htmlStr+="<option value='"+obj.id+"'>"+obj.name+"</option>"
						}
					})
					$("#edit-marketActivityOwner").html(htmlStr)
					
					$("#edit-marketActivityId").val(data.m.id)
					$("#edit-marketActivityActualCost").val(data.m.actualCost)
					$("#edit-marketActivityBudgetCost").val(data.m.budgetCost)
					$("#edit-marketActivityStartDate").val(data.m.startDate)
					$("#edit-marketActivityEndDate").val(data.m.endDate)
					$("#edit-marketActivityName").val(data.m.name)
					$("#edit-marketActivityDescription").val(data.m.description)
					$("#edit-marketActivityType").val(data.m.type)
					$("#edit-marketActivityState").val(data.m.state)
					//打开修改的模态窗口
					$("#editActivityModal").modal("show");
					
				}
			})
	    })
	    
	    //为更新按钮添加单击事件
	    $("#updateBtn").click(function(){
	    	//获取数据
	    	var id=$("#edit-marketActivityId").val()
	    	var owner=$("#edit-marketActivityOwner").val()
	    	var type=$("#edit-marketActivityType").val()
	    	var state=$("#edit-marketActivityState").val()
	    	var description=$("#edit-marketActivityDescription").val()
	    	var startDate=$("#edit-marketActivityStartDate").val()
	    	var endDate=$("#edit-marketActivityEndDate").val()
	    	var name=$("#edit-marketActivityName").val()
	    	var actualCost=$("#edit-marketActivityActualCost").val()
	    	var budgetCost=$("#edit-marketActivityBudgetCost").val()
	    	//发送请求
	    	$.ajax({
	    		url:"workbench/SaveEditActivitiesController.do",
	    		type:"post",
	    		data:{
	    			id:id,
	    			owner:owner,
	    			type:type,
	    			state:state,
	    			description:description,
	    			name:name,
	    			startDate:startDate,
	    			endDate:endDate,
	    			actualCost:actualCost,
	    			budgetCost:budgetCost
	    		},
	    		success:function(data){
	    			if(data.success){
	    				//刷新列表
	    				display($("#pageNoDiv").bs_pagination('getOption', 'currentPage'),$("#pageNoDiv").bs_pagination('getOption', 'rowsPerPage'))
	    				$("#editActivityModal").modal("hide");
	    			}else{
	    				alert("修改失败")
	    				$("#editActivityModal").modal("show");
	    			}
	    		}
	    	})
	    })
	    
	    //给导出按钮添加单击事件
	    $("#exportBtn").click(function(){
	    	//收集参数
	    	 var name=$("#query-name").val();
             var owner=$("#query-owner").val();
             var type=$("#query-type").val();
             var state=$("#query-state").val();
             var startDate=$("#query-startDate").val();
             var endDate=$("#query-endDate").val();
	         //发送请求
	        window.location.href="workbench/ExportActivityController.do?name="+name+"&owner="+owner+"&type="+type+"&state="+state+"&startDate="+startDate+"$endDate="+endDate
	    })
	    
	    //为导入按钮添加事件
	    $("#importBtn").click(function(){
	    	var fileName=$("#file").val()
	    	var suffix=fileName.substr(fileName.lastIndexOf(".")+1).toLowerCase();
	    	if(!(suffix=="xls"||suffix=="xlsx")){
	    		alert("只能上传xls或者xlsx格式的文件")
	    		return
	    	}
	    	if($("#file")[0].files[0].size>5*1024*1024){
	    		alert("文件最大不能超过5M")
	    	}
	    	//发送请求
	    	//FormData是ajax提供的一个借口，它可以模拟键值对提交数据
	    	//FormData不仅能提交文本数据也能提交二进制数据
	    	var formData=new FormData()   //创建对象
	    	formData.append("myfile",$("#file")[0].files[0])
	    	$.ajax({
	    		url:"workbench/ImportActivityController.do",
	    		type:"post",
	    		processData:false,//用来配合contentType使用的
	    		contentType:false,//ajax默认情况下在发送数据之前都会把所有的数据统一进行编码，设置成false可以阻止
	    		data:formData,
	    		success:function(data){
	    			if(data.success){
	    				alert("成功导入"+data.count+"条数据")
	    				//刷新列表
	    				display(1,$("#pageNoDiv").bs_pagination('getOption', 'rowsPerPage'));
	    			    //关闭模态窗口
	    			    $("#importActivityModal").modal("hide")
	    			}else{
	    				alert("成功导入前"+data.count+"条数据，其余数据请检查文件格式")
	    				$("#importActivityModal").modal("show")
	    			}
	    		}
	    	})
	    })
	    
	});
	
	function display(pageNo,pageSize){
		$("#activityListBody").html("")
		//var pageNo=1;
	    //var pageSize=10;
        var name=$("#query-name").val();
        var owner=$("#query-owner").val();
        var type=$("#query-type").val();
        var state=$("#query-state").val();
        var startDate=$("#query-startDate").val();
        var endDate=$("#query-endDate").val();
        //alert(123)
        //发送请求
        $.ajax({
        	url:"workbench/activity/QreryMarketActivityByCountController.do",
        	data:{
        		pageNo:pageNo,
        		pageSize:pageSize,
        		name:name,
        		owner:owner,
        		type:type,
        		state:state,
        		startDate:startDate,
        		endDate:endDate
        	},
        	type:"post",
        	success:function(data){
        		//设置总条数
        		$("#totalCount").html(data.count);
        		/* $(data.list).each(function(){
        			//alert(123)
        			$("#activityListBody").append("<tr><td><input type='checkbox' value='"+this.id+"' /></td><td><a style='text-decoration: none; cursor: pointer;' onclick='window.location.href=\"detail.html\";'>"+this.name+"</a></td><td>"+this.type+"</td><td>"+this.state+"</td><td>"+this.startDate+"</td><td>"+this.endDate+"</td><td>"+this.owner+"</td><td>"+this.budgetCost+"</td><td>"+this.actualCost+"</td><td>"+this.createBy+"</td><td>"+this.createTime+"</td><td>"+this.editBy+"</td><td>"+this.editTime+"</td><td>"+this.description+"</td></tr>");
        		}) */
        		
        		var htmlStr="";
        		$.each(data.list,function(index,obj){
        			htmlStr+="<tr class='active'>"
        			htmlStr+="<td><input type='checkbox'  value='"+obj.id+"'/></td>"
        			htmlStr+="<td name='name'><a style='text-decoration: none; cursor: pointer;' onclick='window.location.href=\"workbench/QueryActivitiesFotDetailByIdController.do?id="+obj.id+"\";'>"+obj.name+"</a></td>"
        			if($("#definedColumns input[name='type']").prop("checked")){
						htmlStr+="<td name='type'>"+obj.type+"</td>";
					}else{
						htmlStr+="<td name='type' style='display:none'>"+obj.type+"</td>";
					}
        			htmlStr+="<td name='state'>"+obj.state+"</td>"
        			htmlStr+="<td name='startDate'>"+obj.startDate+"</td>"
        			htmlStr+="<td name='endDate'>"+obj.endDate+"</td>"
        			htmlStr+="<td name='owner'>"+obj.owner+"</td>"
        			htmlStr+="<td name='budgetCost'>"+obj.budgetCost+"</td>"
        			htmlStr+="<td name='actualCost'>"+obj.actualCost+"</td>"
        			htmlStr+="<td name='createBy'>"+obj.createBy+"</td>"
        			htmlStr+="<td name='createTime'>"+obj.createTime+"</td>"
        			htmlStr+="<td name='editBy'>"+obj.editBy+"</td>"
        			htmlStr+="<td name='editTime'>"+obj.editTime+"</td>"
        			htmlStr+="<td name='description'>"+obj.description+"</td>"
        			htmlStr+="</tr>"
        		})
        		$("#activityListBody").html(htmlStr)
        		
        		//隔行换色
        		$("#activityListBody tr:even").addClass("active")
        		
        		 //显示翻页信息
        		//计算总页数
        		var totalPages=1;
        		if(data.count%pageSize==0){
        			totalPages=data.count/pageSize;
        		}else{
        			totalPages=parseInt(data.count/pageSize)+1;
        		}
                
                $("#pageNoDiv").bs_pagination({
        			  currentPage:pageNo,//当前页号
        			  rowsPerPage:pageSize,//每页显示条数
        			  totalRows:data.count,//总条数
        		      totalPages: totalPages,//总页数
        		      
        		      visiblePageLinks:2, //最多显示的卡片数
        		      
        		      showGoToPage:true, //是否显示跳转到第几页
        		      showRowsPerPage:true,//是否显示每页显示条数
        		      showRowsInfo:true,//是否显示记录信息
        		      //用来监听页号切换的事件，event就是代表这个事件，pageObj代表页信息
        		      onChangePage: function(event,pageObj) { // returns page_num and rows_per_page after a link has clicked
        		    	  //alert(pageObj.currentPage);
        		     	  //alert(pageObj.rowsPerPage);
        		     	  display(pageObj.currentPage,pageObj.rowsPerPage);
        		      }
        		  });
        	}
        })  
	}
	
</script>
<title>Insert title here</title>
</head>
<body>
<!-- 创建市场活动的模态窗口 -->
	<div class="modal fade" id="createActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">创建市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form" id="createActivityForm">
					
						<div class="form-group">
							<label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-marketActivityOwner">
								  
								</select>
							</div>
							<label for="create-marketActivityType" class="col-sm-2 control-label">类型</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-marketActivityType">
								  <c:if test="${!empty tlist }">
								     <option></option>
								     <c:forEach items="${tlist }" var="t">
								         <option value="${t.id }">${t.value }</option>
								     </c:forEach>
								  </c:if>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-marketActivityName">
							</div>
							<label for="create-marketActivityState" class="col-sm-2 control-label">状态</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-marketActivityState">
								  <c:if test="${!empty slist }">
								     <option></option>
								     <c:forEach items="${slist }" var="s">
								         <option value="${s.id }">${s.value }</option>
								     </c:forEach>
								  </c:if>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control mydate" id="create-marketActivitystartDate" readonly="readonly">
							</div>
							<label for="create-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control mydate" id="create-marketActivityendDate" readonly="readonly">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-actualCost" class="col-sm-2 control-label">实际成本</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-marketActivityactualCost">
							</div>
							<label for="create-budgetCost" class="col-sm-2 control-label">预算成本</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-marketActivitybudgetCost">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-marketActivitydescription"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveBtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改市场活动的模态窗口 -->
	<div class="modal fade" id="editActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
					     <input type="hidden" id="edit-marketActivityId">
						<div class="form-group">
							<label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-marketActivityOwner">
								  
								</select>
							</div>
							<label for="edit-marketActivityType" class="col-sm-2 control-label">类型</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-marketActivityType">
								    <c:if test="${!empty tlist }">
								     <option></option>
								     <c:forEach items="${tlist }" var="t">
								         <option value="${t.id }">${t.value }</option>
								     </c:forEach>
								  </c:if>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-marketActivityName">
							</div>
							<label for="edit-marketActivityState" class="col-sm-2 control-label">状态</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-marketActivityState">
								  <c:if test="${!empty slist }">
								     <option></option>
								     <c:forEach items="${slist }" var="s">
								         <option value="${s.id }">${s.value }</option>
								     </c:forEach>
								  </c:if>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-marketActivityStartDate" >
							</div>
							<label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-marketActivityEndDate" >
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-actualCost" class="col-sm-2 control-label">实际成本</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-marketActivityActualCost" >
							</div>
							<label for="edit-budgetCost" class="col-sm-2 control-label">预算成本</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-marketActivityBudgetCost" >
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-marketActivityDescription"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateBtn">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- 导入市场活动的模态窗口 -->
	<div class="modal fade" id="importActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">导入市场活动</h4>
				</div>
				<div class="modal-body" style="height: 350px;">
					<div style="position: relative;top: 20px; left: 50px;">
						请选择要上传的文件：<small style="color: gray;">[仅支持.xls或.xlsx格式]</small>
					</div>
					<div style="position: relative;top: 40px; left: 50px;">
						<input type="file" id="file">
					</div>
					<div style="position: relative; width: 400px; height: 320px; left: 45% ; top: -40px;" >
						<h3>重要提示</h3>
						<ul>
							<li>给定文件的第一行将视为字段名。</li>
							<li>请确认您的文件大小不超过5MB。</li>
							<li>从XLS/XLSX文件中导入全部重复记录之前都会被忽略。</li>
							<li>复选框值应该是1或者0。</li>
							<li>日期值必须为MM/dd/yyyy格式。任何其它格式的日期都将被忽略。</li>
							<li>日期时间必须符合MM/dd/yyyy hh:mm:ss的格式，其它格式的日期时间将被忽略。</li>
							<li>默认情况下，字符编码是UTF-8 (统一码)，请确保您导入的文件使用的是正确的字符编码方式。</li>
							<li>建议您在导入真实数据之前用测试文件测试文件导入功能。</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>稿件管理</h3>
			</div>
		</div>
	</div>
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
		<div style="width: 130%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" type="text" id="query-name">
				    </div>
				  </div>
				  
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">类型</div>
					  <select class="form-control" id="query-type">
					  	  <c:if test="${!empty tlist }">
								     <option></option>
								     <c:forEach items="${tlist }" var="t">
								         <option value="${t.id }">${t.value }</option>
								     </c:forEach>
								  </c:if>
					  </select>
				    </div>
				    <div class="input-group">
				      <div class="input-group-addon">状态</div>
					  <select class="form-control" id="query-state">
					  	<c:if test="${!empty slist }">
								     <option></option>
								     <c:forEach items="${slist }" var="s">
								         <option value="${s.id }">${s.value }</option>
								     </c:forEach>
								  </c:if>
					  </select>
				    </div>
				  </div>
				  
				  <br>
				  
				  <div class="form-group">
				    
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">开始日期</div>
					  <input class="form-control form-control mydate" type="text" id="query-startDate" />
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">结束日期</div>
					  <input class="form-control form-control mydate" type="text" id="queryendDate">
				    </div>
				  </div>
				  
				  <button type="button" class="btn btn-default" id="queryBtn">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" data-toggle="modal" id="addBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" data-toggle="modal" id="editBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
					

			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input id="sel_all" type="checkbox" /></td>
							<td name="name">文件名称</td>
							<td name="type">类型</td>
							<td name="type">大小</td>
							<td name="actualCost">状态</td>
							<td name="startDate">上传时间</td>
							<td name="editTime">修改时间</td>
							<td name="description" width="10%">描述</td>
						</tr>
					</thead>
					<tbody id="activityListBody">
						
					</tbody>
				</table>
				<div id="pageNoDiv"></div>
			</div>
			
	</div>
</body>
</html>