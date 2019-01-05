<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transi
tional//EN">
<html>
<head lang="en">
<meta charset="UTF-8">
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<title>付款成功页面</title>
<link rel="stylesheet" type="text/css"
	href="${APP_PATH}/static/css/amazeui.css" />
<link href="${APP_PATH}/static/css/admin.css" rel="stylesheet"
	type="text/css">
<link href="${APP_PATH}/static/css/demo.css" rel="stylesheet"
	type="text/css" />

<link href="${APP_PATH}/static/css/sustyle.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-1.11.1.min.js"></script>
<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function() {
		//点击提交订单按钮弹出模态框。
		$("#tradeitems").click(function() {
			$("#payModal2").modal('show');
		});
	});
</script>
</head>

<body>


	<!--顶部导航条 -->
	<div class="am-container header">
		<ul class="message-l">
			<div class="topMessage">
				<div class="menu-hd"></div>
			</div>
		</ul>
		<ul class="message-r">
			<div class="topMessage home">
				<div class="menu-hd">
					<a href="#" target="_top" class="h"></a>
				</div>
			</div>
			<div class="topMessage my-shangcheng">
				<div class="menu-hd MyShangcheng">
					<a href="index.jsp" target="_top"><i
						class="am-icon-user am-icon-fw"></i>返回商城首页</a>
				</div>
			</div>
			<div class="topMessage mini-cart"></div>
			<div class="topMessage favorite">
				<div class="menu-hd">
					<a href="#" target="_top"><i class="am-icon-heart am-icon-fw"></i><span>收藏夹</span></a>
				</div>
		</ul>
	</div>

	<!--悬浮搜索框-->

	<div class="nav white">
		<div class="logo">
			<img src="images/logo.png" />
		</div>
		<div class="logoBig">
			<li><img src="${APP_PATH }/static/images/logobig.png" /></li>
		</div>

		<div class="search-bar pr">
			<a name="index_none_header_sysc" href="#"></a>
			<form>
				<input id="searchInput" name="index_none_header_sysc" type="text"
					placeholder="搜索" autocomplete="off"> <input
					id="ai-topsearch" class="submit" value="搜索" index="1" type="submit">
			</form>
		</div>
	</div>

	<div class="clear"></div>



	<div class="take-delivery">
		<div class="status">
			<h3>您已成功付款</h3>
			<div class="successInfo">
				<ul>
					<li>付款金额<em style=font-size:20px>${sessionScope.Payprice}</em></li>
					<div class="user-info">
						<p>收货人：${sessionScope.username }</p>
						<p>联系电话：15871145629</p>
						<p>收货地址：湖北省 武汉市 武昌区 东湖路75号众环大厦</p>
					</div>
					请认真核对您的收货信息，如有错误请联系客服

				</ul>

			</div>
		</div>
	</div>


	<div class="footer">
		<div class="footer-hd">
			<p>
				<a href="#">恒望科技</a> <b>|</b> <a href="#">商城首页</a> <b>|</b> <a
					href="#">支付宝</a> <b>|</b> <a href="#">物流</a>
			</p>
		</div>
		<div class="footer-bd">
			<p>
				<a href="#">关于恒望</a> <a href="#">合作伙伴</a> <a href="#">联系我们</a> <a
					href="#">网站地图</a> <em>© 2015-2025 Hengwang.com 版权所有</em>
			</p>
		</div>
	</div>


</body>
</html>
