<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Bookery</title>
<%@ include file="../template/head.jspf" %>
</head>
<body>
<%@ include file="../template/menu.jspf" %>
	<!-- **********content start**********--> 
		<div class="row">

			<div class="col-xs-12 col-md-12 page-header">
				<h2>
					${book.title } <small>목차 -임시페이지</small>
				</h2>
			</div>
			<div class="col-md-3"></div>

			<div class="col-xs-12 col-md-6">
				<table class="table">
					<tr>
						<th>bid</th>
						<th>chapter</th>
					</tr>

					<c:forEach items="${bookChapters}" var="bean">
						<tr>
							<td>${bean.book_bid }</td>
							<td>${bean.toc }</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div class="col-md-3"></div>

		</div>
	<!--**********content end**********-->
<%@ include file="../template/footer.jspf" %>
</body>
</html>
