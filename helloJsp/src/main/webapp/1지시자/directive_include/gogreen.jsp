<%@page import="utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    
    <link rel="stylesheet" href="css/style.css">
</head>
<body> 
    <div class="wrap">
        <!-- header.jsp -->
        
        <%@include file="header.jsp" %>
        <main>
            <aside id='leftside'>

            </aside>
            <div id='maincontent'>
                <ul>
                    <li><img src="images/main_img1.jpg" alt="">나무를 심는 사람들</li>
                    <li><img src="images/main_img2.jpg" alt="">아이들에게 녹색 미래를..</li>
                    <li><img src="images/main_img3.jpg" alt="">설악산을 사리는 길</li>
                    <li><img src="images/main_img4.jpg" alt="">사라지는 북극곰들</li>
                </ul>
            </div>

            <aside id='rightside'>
                <div class='side1'>
                    <!-- 로그인 실패 : 메세지 처리 -->
                   <!-- 로그인 성공 : 로그인 박스를 보여주지 않음
                               abc님 환영합니다. 출력
                   -->
                   <%
                   	// 쿠키에 저장된 아이디가 있다면 아이디를 텍스트필드에 value값으로 출력
                   	String userId = CookieManager.readCookie(request, "userId");
                   	
                      // 로그인 실패시 메세지 처리
                      String loginErr = request.getParameter("loginErr");
                      if("Y".equals(loginErr)){
                         out.print("<script>alert('아이디/비밀번호를 확인해주세요.')</script>");
                      }
                   %>
                   <!-- 로그인 : 
                         method를 post로 설정해서 아이디/비밀번호가 노출되는걸 막아줍니다. -->
                   <%
                   	
                   	String name = "";
                   	 if(session.getAttribute("id")!=null){
                   		name = (String)session.getAttribute("id");
                   	 }
                   
                     //String name = request.getParameter("name");
                   
                   if(name != null && !name.equals("")){
                      // 로그인 되었다고 판단
                      // out.print(name + "님 환영합니다.");
                     %>
                     
                     <%= name+"님 환영" %>
                     <button onclick="location.href='logout.jsp'">로그아웃</button>
                    
                   <%  
                   } else {
                   %>
                   <form action ="loginAction.jsp" method = "post">
                       <div class='loginbox'>
                           <div id='login'>
                               <input type="text" name="userid" id="userid" placeholder='ID를 입력해주세요.' value="<%=userId%>">
                               <input type="password" name="userpw" id="userpw" placeholder='PW를 입력해주세요.'>
                               
                           </div>
                           <div id='button'>
                           <input type="submit" value="로그인">
                           </div>
                       </div>
                       <div id='info'>
                       <!-- 선택되었을때만 서버에 넘어감
                       		선택안하고 값을 출력해보면 null이 출력 -->
                       <input type="checkbox" name="saveCheck" value="Y" <%=!userId.equals("")?"checked":""%>>아이디저장하기<br>
                           <a href="">회원가입</a>
                           <a href="">ID찾기</a>
                           <a href="">PW찾기</a>
                       </div>
                    </form>
                    <%} %>
                </div>

                <div class='side2'>
                    <img src="images/right_img.jpg" alt="">
                </div>

                <div class='side3'>
                    <img src="images/me_chat.jpg" alt="">
                </div>
            </aside>
        </main>        
        
        <!-- footer.jsp -->
        <%@include file="footer.jsp" %>
    </div>
</body>
</html>