
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<link rel="stylesheet" type="text/css" href="css/footer.css"/>
		<style type="text/css">
		body,p{
	       margin: 0;
		}
		b{
			font-weight: normal;
		}
		ul,ol,dl,dt,dd,li{
			list-style: none;
			margin: 0;
			padding: 0;
		}
		a{
			text-decoration: none;
			color:#706e6e ;
		}
		em{
			font-style: normal;
		}
		input,textarea,button{
			border: none;
			background: transparent;
		}
		input:focus,textarea:focus{
			outline: none;
		}
			.box{
				width: 100%;
				background: #F4F4F4;
				overflow: hidden;
			}
			.head{
				width: 1200px;
				margin: 45px auto 25px;
				overflow: hidden;
				
			}
			.head .logo-zc{
				float: left;
			}
			.welcome{
				display: inline-block;
				line-height: 52px;
				float: left;
				margin-left: 60px;
				font-family: "微软雅黑";
				font-size: 18;
				color: #494747;
			}
			.cont-zc{
				width: 1200px;
				height: 500px;
				background: #FFFFFF;
				border-top: 3px solid  #D63A3B;
				margin: 0 auto;
			}
			.cont-zc ul{
				margin-top:50px;
			}
			.cont-zc ul li label{
				font-size: 14px;
				color: #666666;
				text-align: right;
				width: 50px;
				display: inline-block;
			}
			
			.cont-zc ul li{
				margin-bottom: 22px;
				margin-left: 390px;
			}
			.cont-zc ul .yz{
				position: relative;
			}
			.cont-zc ul .yz p{
				background: url(img/yz.png);
				position: absolute;
				right: 405px;
				top:10px;
				width: 87px;
				height: 28px;
			}
			
			.cont-zc input{
				margin-left: 10px;
			}
			.cont-zc .one,.cont-zc .two,.cont-zc .three,.cont-zc .four{
				width: 338px;
				height: 44px;
				border: 1px solid #dddddd;
				padding-left: 10px;
			}
			.cont-zc ul li .five{
				margin-left: 65px;
				vertical-align: middle;
			}
			.cont-zc ul li .six{
				cursor: pointer;
				width: 350px;
				height: 50px;
				background: #D63A3B;
				font-size: 16px;
				color: #fffffc;
				margin-left:65px ;
			}
			
			.cont-zc span{font-size: 12px;
			 color: #666666;
			 vertical-align: middle;
			 display: inline-block;
			 display: none;
			
			}
			.cont-zc input:focus+span{
				display: inline-block;
			}
			.yuedu{
				font-size: 12px;
				color: #666666;
				display: inline-block;
			}
			.xieyi{
				color: #1b66c7;
			}
		</style>
		
		
		
		<script type="text/javascript"></script>
		<script type="text/javascript">
		
		var a = 0;
		</script>
		
	</head>
	<body>
		<div class="box">
		<jsp:include page="model/header1.jsp"></jsp:include>
		
			<div class="head">
				<div class="logo-zc">
				
			    </div>
			    <span class="welcome">
				        欢迎登录鲜生购
			    </span>
			    
			</div>
			<div class="cont-zc">
			
			     <form action="login" method="post" >
				<ul>
					<li>
						<label>用户名</label>
						<input class="one" type="text" name="email" placeholder="请输入邮箱号"/>
						<span></span>
						
							
					</li>
					<li>
						<label>密码</label>
						<input class="two" type="password" name="password" value=""placeholder="请输入密码"/>
						<span></span>
					</li>
					<li class="yz">
						<label>验证码</label>
						<input class="three" type="text"  value=""placeholder="请输入验证码" style="width: 260px"  />
						 <img  src="rcode/img" onclick="src='rcode/img?a='+(a++)" >
					</li>
					
					
					<li>
						<a href="#"><input class="six"type="submit" onclick="" value="登录"/></a>
					</li>
			</ul>
				</form>
			</div>
			<footer>
				<div class="up">
					<ul class="cont">
						<li class="l1"><a href=""><span class="s1"></span><i class="i1">顺丰包邮</i></a></li>
						<li class="l1"><a href=""><span class="s2"></span><i class="i1">同城次日到达</i></a></li>
						<li class="l1"><a href=""><span class="s3"></span><i class="i1">7天无理由退换货</i></a></li>
						<li class="l1"><a href=""><span class="s4"></span><i class="i1">线下体验店</i></a></li>
						<li class="l2">
							<p class="p1">24小时全国服务热线</p>
							<p class="p2">400-888-8888</p>
							<p class="p3"><a href=""><span class="s5"></span><i class="i2">联系客服</i></a></p>
						</li>
						
					</ul>
					<div class="clear"></div>
				</div>
				<div class="down">
					<div class="one">
						<ol>
							<dt><a href="">购物指南</a></dt>
							<dd><a href="">购物流程</a></dd>
							<dd><a href="">支付方式</a></dd>
						</ol>
						<ol>
							<dt><a href="">购物指南</a></dt>
							<dd><a href="">购物流程</a></dd>
							<dd><a href="">支付方式</a></dd>
						</ol>
						<ol>
							<dt><a href="">购物指南</a></dt>
							<dd><a href="">购物流程</a></dd>
							<dd><a href="">支付方式</a></dd>
						</ol>
						<ol>
							<dt><a href="">购物指南</a></dt>
							<dd><a href="">购物流程</a></dd>
							<dd><a href="">支付方式</a></dd>
						</ol>
						<ol>
							<dt><a href="">购物指南</a></dt>
							<dd><a href="">购物流程</a></dd>
							<dd><a href="">支付方式</a></dd>
						</ol>
						
						<div class="ew1">
							<p><img src="img/er.png"/></p>
							<p>鲜生购公众号</p>
							
						</div>
						<div class="ew2">
							<p><img src="img/er.png"/></p>
							<p>鲜生购APP</p>
						</div>
					</div>
					<div class="clear"></div>
					<div class="two"></div>
					<div class="three">
						<span>网络文化经营许可证：19333520156</span>
						<span>鲁公网安备：25854651152</span>
						<span>违法和不良信息举报电话：110</span>
						<span>消费者维权电话：12305</span>
						<p>Copyright&nbsp;©&nbsp;2010-2020&nbsp;xianshenggou.com&nbsp;版权所有</p>
					</div>
			
	        </footer>	
			
		</div>
	</body>
</html>
