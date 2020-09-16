<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ include file="../template/head.jspf"%>
<body>
	<%@ include file="../template/menu.jspf"%>
	<!-- ************************************ ↑ nav-bar **************************************** -->

	<div class="container-fluid">

		<div class="row" id="content">

			<div class="col-xs-12 col-md-12 page-header">
				<h2>
					${book.title } <small>목차</small>
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
	</div>
	</div>
	<!-- container -->

	<%@ include file="../template/footer.jspf"%>
</body>
</html>