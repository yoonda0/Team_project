<%@ page pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="css/header.css">
<header class="header-wrapper">
	<div class="logo-wrapper">
		<a class="logo-link" aria-label="로고" href="<%=request.getContextPath() + "/main.jsp"%>">
			<img class="logo" alt="Logo" src="img/logo.svg"/>
		</a>
	</div>
	<nav class="container sticky-wrapper">
		<ul class="category-wrapper nav nav-tabs col-md-4">
			<li class="category-item">
				<a class="category" href="#">
					<span>★무료 배송 기획전★</span>
				</a>
			</li>
			<li class="category-item"><a class="category" href="#">강아지</a></li>
			<li class="category-item"><a class="category" href="#">고양이</a></li>
			<li class="category-item"><a class="category" href="#">아울렛</a></li>
		</ul>
		<div class="col-md-5 col-md-offset-3 search-wrapper">
			<form action="search.do" method="post">
				<div class="search-form">
					<input type="text" name="q" class="search-input" placeholder="원하는 상품을 검색해보세요.">
					<button aria-label="검색하기" class="search-btn">
						<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 30 30"><path d="M13 3C7.489 3 3 7.489 3 13s4.489 10 10 10a9.947 9.947 0 0 0 6.322-2.264l5.971 5.971a1 1 0 1 0 1.414-1.414l-5.97-5.97A9.947 9.947 0 0 0 23 13c0-5.511-4.489-10-10-10zm0 2c4.43 0 8 3.57 8 8s-3.57 8-8 8-8-3.57-8-8 3.57-8 8-8z"/>
						</svg>
					</button>
				</div>
			</form>
		</div>
	</nav>
</header>
<script src="js/header.js"></script>