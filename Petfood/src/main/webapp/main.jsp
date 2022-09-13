<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="shortcut icon" href="#">
		<%@ include file="common-css.jsp"%>
		<%@ include file="common-js.jsp"%>
		<link rel="stylesheet" type="text/css" href="css/banner.css">
		<link rel="stylesheet" type="text/css" href="css/slide.css">
		<link rel="stylesheet" type="text/css" href="css/sidebar.css">
		<link rel="stylesheet" type="text/css" href="css/modal.css">
		<link rel="stylesheet" type="text/css" href="css/section.css">
		<link rel="stylesheet" type="text/css" href="css/article.css">
		<title>${title}</title>
	</head>
	<body class="body">
		<jsp:include page="header.jsp">
			<jsp:param name="category" value="${category}"/>
		</jsp:include>
		<jsp:include page="sidebar.jsp">
			<jsp:param name="isLogin" value="${isLogin}"/>
		</jsp:include>
		<script src="js/sidebar.js"></script>
		<script type="text/javascript" src="js/modal.js"></script>
		<main class="content">
			<jsp:include page="banner-slide.jsp">
				<jsp:param name="banners" value="${banners}"/>
			</jsp:include>
			<div class="main-content">
				<jsp:include page="section.jsp">
					<jsp:param name="sectionName" value="Best 상품"/>
					<jsp:param name="product" value="${product}"/>
				</jsp:include>
				<jsp:include page="banner.jsp">
					<jsp:param value="banner_1.jpg" name="bannerImage"/>
					<jsp:param 
						value="Let's Happy Dance. 하림 펫 푸드" 
						name="bannerCaption"/>
					<jsp:param 
						value="#" name="bannerLink"/>
				</jsp:include>
				<jsp:include page="section.jsp">
					<jsp:param name="sectionName" value="강아지 카테고리 인기 상품"/>
					<jsp:param name="product" value="${product}"/>
				</jsp:include>
				<jsp:include page="banner.jsp">
					<jsp:param value="banner_2.jpg" name="bannerImage"/>
					<jsp:param 
						value="캐츠랑 20kg 40,000원 + 무배! 배너가 있을때만 이 가격!" 
						name="bannerCaption"/>
					<jsp:param 
						value="#" name="bannerLink"/>
				</jsp:include>
				<jsp:include page="section.jsp">
					<jsp:param name="sectionName" value="신상품"/>
					<jsp:param name="product" value="${product}"/>
				</jsp:include>
			</div>
		</main>
		<%@ include file="footer.jsp" %>
	</body>
</html>