<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transi
tional//EN
">
<html>
<head lang="en">
<meta charset="UTF-8">

<title>购物车页面</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>

<link href="${APP_PATH}/static/css/amazeui.css" rel="stylesheet"
	type="text/css" />
<link href="${APP_PATH}/static/css/demo.css" rel="stylesheet"
	type="text/css" />
<link href="${APP_PATH}/static/css/cartstyle.css" rel="stylesheet"
	type="text/css" />
<link href="${APP_PATH}/static/css/optstyle.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		//结账按钮
		$("#pay_a").click(function() {
			arlert("wefwef");
			var username = $("#username").text();
			var isempty = $("#isempty").text();
			if (isempty == "") {
				alert("请先选择商品加入购物车");
				return false;
			} else if (username == "") {
				alert("您还没有登录，不能结账");
				return false;
			}
			return true;
		});

		//商品后边的删除按钮
		$(".delete").click(function() {
			//先获取商品名字
			var goodName = $(this).attr("id");
			//获取商品id
			var goodid = $(this).attr("name");
			if (confirm("确认删除【" + goodName + "】吗？")) {
				//确认，发送ajax请求删除即可
				$.ajax({
					url : "${APP_PATH}/remove/" + goodid,
					type : "DELETE",
				});
			}
		});


		//全选删除按钮
		$("#check_all").click(function() {
			$(".check_item").prop("checked", $(this).prop("checked"));
		});
		$(".check_item").click(function() {
			var flag = $(".check_item:checked").length == $(".check_item").length;
			$("#check_all").prop("checked", flag);
		});

		//点击全部删除，就批量删除
		$("#deleteBatch").click(function() {
			var del_idstr = "";
			$.each($(".check_item:checked"), function() {
				//组装商品id字符串
				del_idstr += $(this).attr("name") + "-";
			});

			//去除删除的id多余的-
			del_idstr = del_idstr.substring(0, del_idstr.length - 1);
			if (confirm("确认删除【选中项】吗？")) {
				//发送ajax请求删除
				$.ajax({
					url : "${APP_PATH}/remove_all/" + del_idstr,
					type : "DELETE",
					success : function() {
						location.reload();
					}
				});
			}
		});

		//ajax更改商品数量
		$(":text").change(function() {
			var quantityVal = $.trim(this.value);

			//校验更改的数字是否合法
			var quantity = -1
			var flag = false;
			var reg = /^\d+$/g;
			if (reg.test(quantityVal)) {
				quantity = parseInt(quantityVal);
				if (quantity >= 0) {
					flag = true;
				}
			}
			if (!flag) {
				alert("您输入的数量不合法");
				//将值变为原来的值
				$(this).val($(this).attr("class"));
				return;
			}

			var name = $(this).attr("name");
			//当输入0时即为删除
			if (quantity == 0) {
				var flag2 = confirm("确定要删除【" + name + "】吗?");
				if (flag2) {
					deleteone();
					return;
				} else {
					//将值变为原来的值
					$(this).val($(this).attr("class"));
					return;
				}
			}

			var flag = confirm("确定要修改【" + name + "】的数量吗?");

			if (!flag) {
				$(this).val($(this).attr("class"));
				return;
			}

			//发送ajax请求更改商品数量
			var goodid = $(this).attr("id");
			$.ajax({
				url : "${APP_PATH}/updateItemQuantity?goodid=" + goodid + "&quantityVal=" + quantityVal,
				success : function(result) {
					location.reload();
				}
			});
		});
	});

	//删除商品方法
	function deleteone() {
		//先获取商品名字
		var goodName = $(".delete").attr("id");
		//获取商品id
		var goodid = $(".delete").attr("name");
		//确认，发送ajax请求删除即可
		$.ajax({
			url : "${APP_PATH}/remove/" + goodid,
			type : "DELETE",
			success : function() {
				location.reload();
			}
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
					<a
						href="goods2?pn=${param.pageNum }&type=${param.type}&sales=${param.sales}&pricea=${param.pricea}&priced=${param.priced}"
						target="_top"><i class="am-icon-user am-icon-fw"></i>继续购物</a>
				</div>
			</div>
			<div class="topMessage mini-cart">
				<div class="menu-hd">
					<a id="mc-menu-hd" href="#" target="_top"><i
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
			<img src="${APP_PATH}/static/images/logo.png" />
		</div>
		<div class="logoBig">
			<li><img src="${APP_PATH}/static/images/logobig.png" /></li>
		</div>

		<div class="search-bar pr">
			<a name="index_none_header_sysc" href="#"></a>
			<form>
				<input id="searchInput" name="index_none_header_sysc" type="text"
					placeholder="搜索" autocomplete="off"> <input
					id="ai-topsearch" class="submit am-btn" value="搜索" index="1"
					type="submit">
			</form>
		</div>
	</div>

	<div class="clear"></div>

	<!--购物车 -->
	<div class="concent">
		<div id="cartTable">
			<div class="cart-table-th">
				<div class="wp">
					<div class="th th-chk">
						<div id="J_SelectAll1" class="select-all J_SelectAll"></div>
					</div>
					<div class="th th-item">
						<div class="td-inner">商品信息</div>
					</div>
					<div class="th th-price">
						<div class="td-inner">单价</div>
					</div>
					<div class="th th-amount">
						<div class="td-inner">数量</div>
					</div>
					<div class="th th-sum">
						<div class="td-inner">金额</div>
					</div>
					<div class="th th-op">
						<div class="td-inner">操作</div>
					</div>
				</div>
			</div>
			<div class="clear"></div>

			<tr class="item-list">
				<div class="bundle  bundle-last ">
					<div class="bundle-hd">
						<div class="bd-promos">
							<div class="bd-has-promo">
								您的购物车中共有:<span class="bd-has-promo-content">${sessionScope.ShoppingCart.goodsNumber }件商品</span>&nbsp;&nbsp;
							</div>
						</div>
					</div>
					<div class="clear"></div>
					<div class="bundle-main">



						<c:forEach items="${sessionScope.ShoppingCart.items }" var="item">
							<ul class="item-content clearfix">
								<li class="td td-chk">
									<div class="cart-checkbox ">
										<input class="check_item" id="J_CheckBox_170037950254"
											name="${item.goods.goodsid }" value="170037950254"
											type="checkbox"> <label for="J_CheckBox_170037950254"></label>
									</div>
								</li>
								<li class="td td-item">
									<div class="item-pic">
										<a target="_blank" class="J_MakePoint"> <img
											src="${APP_PATH }${item.goods.img}" width="63" height="80"
											class="itempic J_ItemImg"></a>
									</div>
									<div class="item-info">
										<div class="item-basic-info">
											<a target="_blank" class="item-title J_MakePoint"
												data-point="tbcart.8.11">${item.goods.name }</a>
										</div>
									</div>
								</li>
								<li class="td td-info">
									<div class="item-props item-props-can">
										<span class="sku-line">评价：${item.goods.remark }</span> <span
											class="sku-line">包装：箱装</span> <span tabindex="0"
											class="btn-edit-sku theme-login"></span> <i
											class="theme-login am-icon-sort-desc"></i>
									</div>
								</li>
								<li class="td td-price">
									<div class="item-price price-promo-promo">
										<div class="price-content">
											<div class="price-line">
												<em class="price-original">99.00</em>
											</div>
											<div class="price-line">
												<em class="J_Price price-now" tabindex="0">${item.goods.price }</em>
											</div>
										</div>
									</div>
								</li>
								<li class="td td-amount">
									<div class="amount-wrapper ">
										<div class="item-amount ">
											<div class="sl">
												<input class="${item.quantity }" type="text"
													value="${item.quantity }" name="${item.goods.name  }"
													size="1" id="${item.goods.goodsid}" />
											</div>
										</div>
									</div>
								</li>
								<li class="td td-sum">
									<div class="td-inner">
										<em tabindex="0" class="J_ItemSum number">${item.quantity *item.goods.price }</em>
									</div>
								</li>
								<li class="td td-op">
									<div class="td-inner">
										<a title="移入收藏夹" class="btn-fav" href="#"> 移入收藏夹</a> <a
											href="" id="${item.goods.name }"
											name="${item.goods.goodsid }" data-point-url="#"
											class="delete"> 删除</a>
									</div>
								</li>
							</ul>
						</c:forEach>




					</div>
				</div>
			</tr>


		</div>
		<div class="clear"></div>

		<div class="float-bar-wrapper">
			<div id="J_SelectAll2" class="select-all J_SelectAll">
				<div class="cart-checkbox">
					<input class="check-all check" id="check_all" name="select-all"
						value="true" type="checkbox"> <label for="J_SelectAllCbx2"></label>
				</div>
				<span>全选</span>
			</div>
			<div class="operations">
				<a href="#" hidefocus="true" id="deleteBatch">删除选中项</a>
			</div>
			<div class="float-bar-right">
				<div class="amount-sum">
					<span class="txt"></span> <em id="J_SelectedItemsCount"></em><span
						class="txt"></span>
					<div class="arrow-box">
						<span class="selected-items-arrow"></span> <span class="arrow"></span>
					</div>
				</div>
				<div class="price-sum">
					<span class="txt">合计:</span> <strong class="price">¥<em
						id="J_Total" class="${sessionScope.ShoppingCart.totalMoney }">${sessionScope.ShoppingCart.totalMoney }</em></strong>
				</div>
				<div class="btn-area">
					<a href="pay.jsp?type=${param.type }" id="pay_a"
						class="submit-btn submit-btn-disabled"
						aria-label="请注意如果没有选择宝贝，将无法结算"> <span id="pay_button10086">结&nbsp;算</span></a>
				</div>
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

	<!--操作页面-->

	<div class="theme-popover-mask"></div>

	<div class="theme-popover">
		<div class="theme-span"></div>
		<div class="theme-poptit h-title">
			<a href="javascript:;" title="关闭" class="close">×</a>
		</div>
		<div class="theme-popbod dform">
			<form class="theme-signin" name="loginform" action="" method="post">

				<div class="theme-signin-left">

					<li class="theme-options">
						<div class="cart-title">颜色：</div>
						<ul>
							<li class="sku-line selected">12#川南玛瑙<i></i></li>
							<li class="sku-line">10#蜜橘色+17#樱花粉<i></i></li>
						</ul>
					</li>
					<li class="theme-options">
						<div class="cart-title">包装：</div>
						<ul>
							<li class="sku-line selected">包装：裸装<i></i></li>
							<li class="sku-line">两支手袋装（送彩带）<i></i></li>
						</ul>
					</li>
					<div class="theme-options">
						<div class="cart-title number">数量</div>
						<dd>
							<input class="min am-btn am-btn-default" name="" type="button"
								value="-" /> <input class="text_box" name="" type="text"
								value="1" style="width:30px;" /> <input
								class="add am-btn am-btn-default" name="" type="button"
								value="+" /> <span class="tb-hidden">库存<span
								class="stock">1000</span>件
							</span>
						</dd>

					</div>
					<div class="clear"></div>
					<div class="btn-op">
						<div class="btn am-btn am-btn-warning">确认</div>
						<div class="btn close am-btn am-btn-warning">取消</div>
					</div>

				</div>
				<div class="theme-signin-right">
					<div class="img-info"></div>
					<div class="text-info">
						<span class="J_Price price-now">¥39.00</span> <span id="Stock"
							class="tb-hidden">库存<span class="stock">1000</span>件
						</span>
					</div>
				</div>

			</form>
		</div>
	</div>
	<!--引导 -->
	<div class="navCir">
		<li><a href="home.html" id="username"><i
				class="am-icon-home "></i>${sessionScope.username }</a></li>
		<li><a href="sort.html" id="isempty"><i class="am-icon-list"></i>${sessionScope.ShoppingCart.goodsNumber }</a></li>
		<li class="active"><a href="shopcart.html"><i
				class="am-icon-shopping-basket"></i>购物车</a></li>
		<li><a href="person/index.html"><i class="am-icon-user"></i>我的</a></li>
	</div>
</body>

</html>