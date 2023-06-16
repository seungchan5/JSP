<%@page import="dto.Board"%>
<%@page import="dao.NewBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
<%
	NewBoardDao dao = new NewBoardDao();
	Board board = dao.selectOne(request.getParameter("num"));
%>

</head>
<body>
<h2>회원제 게시판 - 수정하기(Edit)</h2>
<form action="EditProcess.jsp" method="post">
    <table border="1" width="90%">
        <tr>
            <td>제목</td>
            <td>
                <input type="text" name="title" style="width: 90%;" value="<%=board.getTitle() %>"/> 
            </td>
        </tr>
        <tr>
            <td>내용</td>
            <td>
                <textarea name="content" style="width: 90%; height: 100px;"><%=board.getContent().replace("\r\n", "<br>") %></textarea>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <button type="submit">작성 완료</button>
                <button type="reset">다시 입력</button>
                <button type="button">목록 보기</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>