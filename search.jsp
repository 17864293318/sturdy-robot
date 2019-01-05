<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transi
tional//EN">
<html>
<head lang="en">
<meta charset="UTF-8">
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<title>搜索页面</title>

<link href="${APP_PATH}/static/css/amazeui.css" rel="stylesheet"
	type="text/css" />
<link href="${APP_PATH}/static/css/admin.css" rel="stylesheet"
	type="text/css" />

<link href="${APP_PATH}/static/css/demo.css" rel="stylesheet"
	type="text/css" />

<link href="${APP_PATH}/static/css/seastyle.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-1.11.1.min.js"></script>
<style type="text/css">
.active2 a {
	color: red;
	font-size: 20px;
}

.first  a {
	color: red;
}
</style>
<script type="text/javascript">
	var totalRecord,
		type2,
		currentPage;
	var sales = 0;
	var pricea = 0;
	var priced = 0;
	//1、页面加载完成以后，直接去发送ajax请求,要到分页数据
	$(function() {
		var pageNum = $(".pageNum2").text();
		var type = $("#type").text();
		sales = $(".sales_param").text();
		pricea = $(".pricea_param").text();
		priced = $(".priced_param").text();

		//去首页
		to_page(pageNum, type, sales, pricea, priced);

		//按销量排序
		$("#salessort").click(function() {
			to_page(1, type, 1, 0, 0);
			$(this).parent().addClass("first");
			$("#idsort").parent().removeClass("first");
			$("#pricea").parent().removeClass("first");
			$("#priced").parent().removeClass("first");
			sales = 1;
			pricea = 0;
			priced = 0;
		});
		//综合排序
		$("#idsort").click(function() {
			to_page(1, type, 0, 0, 0);
			$(this).parent().addClass("first");
			$("#salessort").parent().removeClass("first");
			$("#pricea").parent().removeClass("first");
			$("#priced").parent().removeClass("first");
			sales = 0;
			pricea = 0;
			priced = 0;
		});
		//价格从高到低
		$("#pricea").click(function() {
			to_page(1, type, 0, 1, 0);
			$(this).parent().addClass("first");
			$("#idsort").parent().removeClass("first");
			$("#salessort").parent().removeClass("first");
			$("#priced").parent().removeClass("first");
			pricea = 1;
			sales = 0;
			priced = 0;
		});
		//价格从低到高
		$("#priced").click(function() {
			to_page(1, type, 0, 0, 1);
			$(this).parent().addClass("first");
			$("#idsort").parent().removeClass("first");
			$("#salessort").parent().removeClass("first");
			$("#pricea").parent().removeClass("first");
			pricea = 0;
			sales = 0;
			priced = 1;
		});
	});

	//显示页数
	function to_page(pn, type, sales, pricea, priced) {
		if (sales == 1) {
			$("#salessort").parent().addClass("first");
		} else if (pricea == 1) {
			$("#pricea").parent().addClass("first");
		} else if (priced == 1) {
			$("#priced").parent().addClass("first");
		} else {
			$("#idsort").parent().addClass("first");
		}
		$.ajax({
			url : "${APP_PATH}/goods?pn=" + pn + "&type=" + type + "&sales=" + sales + "&pricea="
				+ pricea + "&priced=" + priced,
			type : "GET",
			success : function(result) {
				console.log(result);
				//1、显示商品
				build_goods_table(result);
				//2、显示分页信息
				build_page_info(result);
				//3、显示分页条数据
				build_page_nav(result);
			}
		});
	}

	//解析显示分页条，点击分页要能去下一页....
	function build_page_nav(result) {
		$("#ul_pages").empty();
		var type = $("#type").text();

		//构建元素
		var firstPageLi = $("<li></li>").append($("<a></a>").append("首页"));
		var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
		if (result.extend.PageInfo.hasPreviousPage == false) {
			firstPageLi.addClass("disabled");
			prePageLi.addClass("disabled");
		} else {
			//为元素添加点击翻页的事件
			firstPageLi.click(function() {
				to_page(1, type, sales, pricea, priced);
			});
			prePageLi.click(function() {
				to_page(result.extend.PageInfo.pageNum - 1, type, sales, pricea, priced);
			});
		}

		var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
		var lastPageLi = $("<li></li>").append($("<a></a>").append("末页"));
		if (result.extend.PageInfo.hasNextPage == false) {
			nextPageLi.addClass("disabled");
			lastPageLi.addClass("disabled");
		} else {
			nextPageLi.click(function() {
				to_page(result.extend.PageInfo.pageNum + 1, type, sales, pricea, priced);
			});
			lastPageLi.click(function() {
				to_page(999, type, sales, pricea,priced);
			});
		}

		//添加首页和前一页 的提示
		$("#ul_pages").append(firstPageLi).append(prePageLi);
		//1,2，3遍历给ul中添加页码提示
		//var navigatepageNums = result.extend.PageInfo.navigatepageNums;
		//navigatepageNums = [ 1, 2, 3, 4, 5 ];
		$.each(result.extend.PageInfo.navigatepageNums, function(index, item) {

			var numLi = $("<li></li>").append($("<a></a>").append(item));
			if (result.extend.PageInfo.pageNum == item) {
				numLi.addClass("active2");
			}
			numLi.click(function() {
				to_page(item, type, sales, pricea, priced);
			});
			$("#ul_pages").append(numLi);
		});
		//添加下一页和末页 的提示
		$("#ul_pages").append(nextPageLi).append(lastPageLi);
	}

	//解析并显示分页信息
	function build_page_info(result) {
		$("#span_search").empty();
		$("#span_search").append("当前第&nbsp;" + result.extend.PageInfo.pageNum + "&nbsp;页,共&nbsp;" +
			result.extend.PageInfo.pages + "&nbsp;页,共&nbsp;" +
			result.extend.PageInfo.total + "&nbsp;条记录");
		totalRecord = result.extend.PageInfo.total;
		currentPage = result.extend.PageInfo.pageNum;
		$("#mc-menu-hd").attr("href", "shopcart.jsp?pageNum=" + currentPage +
			"&type=" + type2 + "&sales=" + sales + "&pricea=" + pricea + "&priced=" + priced);
	}
	
		
	
	//解析并显示商品数据
	function build_goods_table(result) {
		//清空ul
		$("#ull").empty();
		var goods = result.extend.PageInfo.list;
		var pageNum = result.extend.PageInfo.pageNum;

		$.each(goods, function(index, item) {
			var news = item.news;
			var li = $("<li></li>");
			var div = $("<div></div>").addClass("i-pic limit");
			var a = $("<a></a>").attr("href", "introduction?goodid=" + item.goodsid + "&pageNum="
				+ pageNum + "&type=" + item.type + "&sales=" + sales + "&pricea=" + pricea + "&priced=" + priced);
			type2 = item.type;
			var img = $("<img/>").attr("src", "${APP_PATH}" + item.img);
			var p1 = $("<p></p>").addClass("title fl").append(item.name);

			if (item.important == 1) {
				p1.attr("style", "color:red").append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;【重要商品】");
			}

			var p2 = $("<p></p>").addClass("price fl").append($("<b></b>").append("￥")).append($("<strong></strong>")
				.append(item.price));
			var p3 = $("<p></p>").addClass("number fl").append($("<span style=font-size:9px></span>")
				.append(item.remark));
			var p4 = $("<p style=color:blue></p>").addClass("title fl").append(item.news + "成新" + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;销量：" + item.salesamount);

			div.append(a.append(img).append(p1).append(p2).append(p3).append(p4));
			li.append(div).appendTo($("#ull"));
		});
	}
	
	
	// 模糊查询
	function searchGoods() {
		
			var goodsName = $("#searchInput").val();
			$.ajax({
				url : "${APP_PATH}/getByPartName?index_none_header_sysc="+goodsName,
				type : "GET",
				success : function(result) {
// 					alert("正在搜索");
// 					alert(result);
					build_search_table(result);
				}
	});
	}
	
	//解析并显示商品数据
	function build_search_table(list) {
		//清空ul
// 		alert(list);
		$("#ull").empty();
		$.each(list, function(index, item) {
			var news = item.news;
			var li = $("<li></li>");
			var div = $("<div></div>").addClass("i-pic limit");
			var img = $("<img/>").attr("src", "${APP_PATH}" + item.img);
			var p1 = $("<p></p>").addClass("title fl").append(item.name);
			var a = $("<a></a>").attr("href", "introduction?goodid=" + item.goodsid + "&sales=" + sales + "&pricea=" + pricea + "&priced=" + priced);
			if (item.important == 1) {
				p1.attr("style", "color:red").append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;【重要商品】");
			}

			var p2 = $("<p></p>").addClass("price fl").append($("<b></b>").append("￥")).append($("<strong></strong>")
				.append(item.price));
			var p3 = $("<p></p>").addClass("number fl").append($("<span style=font-size:9px></span>")
				.append(item.remark));
			var p4 = $("<p style=color:blue></p>").addClass("title fl").append(item.news + "成新" + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;销量：" + item.salesamount);
			
			div.append(a.append(img).append(p1).append(p2).append(p3).append(p4));
// 			div.append(img);
// 			div.append(p1);
// 			div.append(p2);
// 			div.append(p3);
// 			div.append(p4);
			
			 li.append(div).appendTo($("#ull"));
			
			
	});
		}
	

	
</script>
</head>

<body>

	<!--顶部导航条 -->
	<div class="am-container header">
		<ul class="message-l">
			<div class="topMessage">
				<div class="menu-hd">

					<c:if test="${sessionScope.username==null }">
						<a href="login.jsp" target="_top" class="h">亲，请登录</a>
						<a href="regist.jsp" target="_top">免费注册</a>
					</c:if>
					<c:if test="${sessionScope.username!=null }">
						<a target="_top" class="h" style="color:green">您好，${sessionScope.username}</a>&nbsp;
						<a target="_top" class="h" id="logout_link" href="logout">退出登录</a>
					</c:if>
				</div>
			</div>
		</ul>
		<ul class="message-r">
			<div class="topMessage home">
				<div class="menu-hd">
					<a href="index.jsp" target="_top" class="h">商城首页</a>
				</div>
			</div>
			<div class="topMessage my-shangcheng">
				<div class="menu-hd MyShangcheng">
					<a href="#" target="_top"><i class="am-icon-user am-icon-fw"></i>个人中心</a>
				</div>
			</div>
			<div class="topMessage mini-cart">
				<div class="menu-hd">
					<a id="mc-menu-hd" target="_top"><i
						class="am-icon-shopping-cart  am-icon-fw"></i><span>购物车</span><strong
						id="J_MiniCartNum" class="h">${sessionScope.ShoppingCart.goodsNumber }</strong></a>
				</div>
			</div>
			<div class="topMessage favorite">
				<div class="menu-hd">
					<a href="#" target="_top"><i class="am-icon-heart am-icon-fw"></i><span>收藏夹</span></a>
				</div>
		</ul>
	</div>

	<!--悬浮搜索框-->

	<div class="nav white">
		<div class="logo">
			<img src="${APP_PATH }/static/images/logo.png" />
		</div>
		<div class="logoBig">
			<li><img src="${APP_PATH }/static/images/logobig.png" /></li>
		</div>

		<div class="search-bar pr">
			<a name="index_none_header_sysc" href="#"></a>
			<form>
				<input id="searchInput" name="index_none_header_sysc" type="text"
					placeholder="搜索" autocomplete="off"> <input
					id="ai-topsearch" onclick="searchGoods()" class="submit am-btn" value="搜索" index="1"
					type="button">
			</form>
		</div>
	</div>
	
	<div class="clear"></div>
	<b class="line"></b>
	<div class="search">
		<div class="search-list">
			<div class="nav-table">
				<div class="long-title">
					<span class="all-goods">服装精选</span>
				</div>
				<div class="nav-cont">

					<div class="nav-extra" style=color:red>
						<i class="am-icon-user-secret am-icon-md nav-user"></i><b></b>我的福利
						<i class="am-icon-angle-right" style="padding-left: 10px;"></i>
					</div>
				</div>
			</div>


			<div class="am-g am-g-fixed">
				<div class="am-u-sm-12 am-u-md-12">
					<div class="theme-popover">
						<div class="searchAbout"></div>
						<ul class="select">
							<p class="title font-normal">
								<span class="fl"></span> <span class="total fl" id="span_search"
									style=color:orange> </span>
							</p>
						</ul>

					</div>
					<div class="search-content">
						<div class="sort">
							<li><a title="综合" id="idsort">综合排序</a></li>
							<li><a title="销量" id="salessort">销量排序</a></li>
							<li><a title="价格由高到低" id="pricea">价格↑ </a></li>
							<li><a title="价格由低到高" id="priced">价格↓ </a></li>
						</div>
						<div class="clear"></div>

						<ul class="am-avg-sm-2 am-avg-md-3 am-avg-lg-4 boxes" id="ull">

						</ul>
					</div>
					<div class="search-side">
						<div class="side-title">热销推荐</div>

						<li>
							<div class="i-pic check">
								<img src="${APP_PATH }/static/images/mm1.jpg" />
								<p class="check-title">冬季保暖黑色裤子男</p>
								<p class="price fl">
									<b>¥</b> <strong>69.90</strong>
								</p>
								<p class="number fl">
									销量<span>1110</span>
								</p>

							</div>
						</li>
						<li>
							<div class="i-pic check">
								<img src="${APP_PATH }/static/images/mm2.jpg" />
								<p class="check-title">休闲哈伦裤</p>
								<p class="price fl">
									<b>¥</b> <strong>89.0</strong>
								</p>
								<p class="number fl">
									销量<span>1110</span>
								</p>
							</div>
						</li>

					</div>
					<div class="clear"></div>
					<!--分页 -->
					<ul class="am-pagination am-pagination-right" id="ul_pages">

					</ul>

				</div>
			</div>
			<div class="footer">
				<div class="footer-hd">
					<p>
						<a href="#">青岛大学</a> <b>|</b> <a href="#">商城首页</a> <b>|</b> <a
							href="#">支付宝</a> <b>|</b> <a href="#">物流</a>
					</p>
				</div>
				<div class="footer-bd">
					<p>
						<a href="#">关于我们</a> <a href="#">合作伙伴</a> <a href="#">联系我们</a> <a
							href="#">网站地图</a> <em></em>
					</p>

				</div>
			</div>
		</div>

	</div>


	<!--菜单 -->
	<div class=tip>
		<div id="sidebar">
			<div id="wrap">
				<div id="prof" class="item">
					<a href="#"> <span class="setting"></span>
					</a>
					<div class="ibar_login_box status_login">

						<div class="login_btnbox">
							<a href="#" class="login_order">我的订单</a> <a href="#"
								class="login_favorite">我的收藏</a>
						</div>
						<i class="icon_arrow_white"></i>
					</div>

				</div>
				<div id="shopCart" class="item">
					<a href="#"> <span class="message"></span>
					</a>
					<p>购物车</p>
					<p class="cart_num">0</p>
				</div>
				<div id="asset" class="item">
					<a href="#"> <span class="view"></span>
					</a>
					<div class="mp_tooltip">
						我的资产 <i class="icon_arrow_right_black"></i>
					</div>
				</div>

				<div id="foot" class="item">
					<a href="#"> <span class="zuji"></span>
					</a>
					<div class="mp_tooltip">
						我的足迹 <i class="icon_arrow_right_black"></i>
					</div>
				</div>

				<div id="brand" class="item">
					<a href="#"> <span class="wdsc"><img
							src="${APP_PATH }/static/images/wdsc.png" /></span>
					</a>
					<div class="mp_tooltip">
						我的收藏 <i class="icon_arrow_right_black"></i>
					</div>
				</div>

				<div id="broadcast" class="item">
					<a href="#"> <span class="chongzhi"><img
							src="${APP_PATH }/static/images/chongzhi.png" /></span>
					</a>
					<div class="mp_tooltip">
						我要充值 <i class="icon_arrow_right_black"></i>
					</div>
				</div>

				<div class="quick_toggle">
					<li class="qtitem"><a href="#"><span class="kfzx"></span></a>
						<div class="mp_tooltip">
							客服中心<i class="icon_arrow_right_black"></i>
						</div></li>
					<!--二维码 -->
					<li class="qtitem"><a href="#none"><span
							class="mpbtn_qrcode"></span></a>
						<div class="mp_qrcode" style="display:none;">
							<img src="${APP_PATH }/static/images/weixin_code_145.png" /><i
								class="icon_arrow_white"></i>
						</div></li>
					<li class="qtitem"><a href="#top" class="return_top"><span
							class="top"></span></a></li>
				</div>

				<!--回到顶部 -->
				<div id="quick_links_pop" class="quick_links_pop hide"></div>

			</div>

		</div>
		<div id="prof-content" class="nav-content">
			<div class="nav-con-close">
				<i class="am-icon-angle-right am-icon-fw"></i>
			</div>
			<div>我</div>
		</div>
		<div id="shopCart-content" class="nav-content">
			<div class="nav-con-close">
				<i class="am-icon-angle-right am-icon-fw"></i>
			</div>
			<div>购物车</div>
		</div>
		<div id="asset-content" class="nav-content">
			<div class="nav-con-close">
				<i class="am-icon-angle-right am-icon-fw"></i>
			</div>
			<div>资产</div>

			<div class="ia-head-list">
				<a href="#" target="_blank" class="pl">
					<div class="num">0</div>
					<div class="text">优惠券</div>
				</a> <a href="#" target="_blank" class="pl">
					<div class="num">0</div>
					<div class="text">红包</div>
				</a> <a href="#" target="_blank" class="pl money">
					<div class="num">￥0</div>
					<div class="text">余额</div>
				</a>
			</div>

		</div>
		<div id="foot-content" class="nav-content">
			<div class="nav-con-close">
				<i class="am-icon-angle-right am-icon-fw"></i>
			</div>
			<div>足迹</div>
		</div>
		<div id="brand-content" class="nav-content">
			<div class="nav-con-close">
				<i class="am-icon-angle-right am-icon-fw"></i>
			</div>
			<c:if test="${param.sales==null }">
				<span class="sales_param">0</span>
			</c:if>
			<c:if test="${param.sales!=null }">
				<span class="sales_param">${param.sales }</span>
			</c:if>

			<c:if test="${param.pricea==null }">
				<span class="pricea_param">0</span>
			</c:if>
			<c:if test="${param.pricea!=null }">
				<span class="pricea_param">${param.pricea }</span>
			</c:if>

			<c:if test="${param.priced==null }">
				<span class="priced_param">0</span>
			</c:if>
			<c:if test="${param.priced!=null }">
				<span class="priced_param">${param.priced }</span>
			</c:if>
		</div>
		<div id="broadcast-content" class="nav-content">
			<div class="nav-con-close">
				<i class="am-icon-angle-right am-icon-fw"></i>
			</div>
			<div>充值</div>
			<c:if test="${pageInfo.pageNum==null }">
				<span class="pageNum2">1</span>
			</c:if>
			<c:if test="${pageInfo.pageNum!=null }">
				<span class="pageNum2">${pageInfo.pageNum }</span>
			</c:if>
			<div id="type" class="theme-popover-mask">${param.type}</div>
		</div>
	</div>
	<script>
		window.jQuery || document.write('<script src="${APP_PATH}/static/js/jquery-1.11.1.min.js"><\/script>');
	</script>
	<script type="text/javascript"
		src="${APP_PATH}/static/js/quick_links.js"></script>


</body>

</html>