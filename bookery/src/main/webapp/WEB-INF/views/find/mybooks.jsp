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
					내 서재 <small>책 목록</small>
				</h2>
			</div>
			<div class="col-xs-12 col-md-12">
				<table class="table">
					<tr>
						<th>bid</th>
						<th>title</th>
					</tr>

					<c:forEach items="${books }" var="bean">
						<tr>
							<td><a
								href="${pageContext.request.contextPath }/find/chapters.bit?book_id=${bean.bid }">${bean.bid }</a></td>
							<td>${bean.title }</td>
						</tr>
					</c:forEach>
				</table>
			</div>

		</div>

	</div>
	</div>
	<!-- container -->
	<%@ include file="../template/footer.jspf"%>
</body>
</html>
