<%@page import="dangddt.account.AccountDAO"%>
<!doctype html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="en">

    <head>
        <title>Home</title>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.1/css/all.css" integrity="sha384-O8whS3fhG2OnA5Kas0Y9l3cfpmYjapjI0E4theH4iuMD+pLhbf6JI0jIMfYcK3yZ" crossorigin="anonymous">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>

    <body>
        <div class="header-container">
            <nav class="navbar navbar-expand-lg navbar-light" style="background-color: #e3f2fd;">
                <a class="navbar-brand" href="#">
                    <img src="icon/QUIZ-3D.png" width="100" height="50" class="d-inline-block align-top" alt="">
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNavDropdown" style="font-weight: bold;">
                    <ul class="navbar-nav">
                        <li class="nav-item active">
                            <a class="nav-link" href="admin_page">Home <span class="sr-only">(current)</span></a>
                        </li>
                    </ul>
                </div>
                <div style="margin-right: 20px">
                    <c:if test="${not empty sessionScope.ACCOUNT}">
                        <h5>Welcome, ${sessionScope.ACCOUNT.name}</h5>
                    </c:if>
                </div>
                <form action="logout">
                    <div>
                        <input type="submit" class="form-control btn btn-success" value="Sign out" />
                    </div>
                </form>
            </nav>
        </div>
        <div class="body-container" style="min-height: 800px;">
            <div class="tool-taskbar" >
                <!-- FORM SEARCH -->
                <form class="form-inline" style="margin-left: auto" action="view_history">
                    <input type="hidden" name="page" value="admin" />
                    <input type="hidden" name="search_by" value="name" />
                    <input class="form-control mr-sm-2" name="txtSearch" value="${param.txtSearch.trim()}" type="search" placeholder="Search" aria-label="Search">
                    <input type="hidden" name="pageIndex" value="1" />
                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                </form>
                <!-- FORM SUBJECT  -->
                <div class="btn-group" style="margin-left: 10px; margin-right: 200px">
                    <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Subject
                    </button>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="admin_history_page" style="font-weight: bold">Default</a>
                        <div class="dropdown-divider"></div>
                        <c:forEach items="${applicationScope.SUBJECT}" var="subject">
                            <a class="dropdown-item" href="view_history?page=admin&search_by=subject&subjectID=${subject.subjectID.trim()}&pageIndex=1">${subject.subjectID.trim()} - ${subject.name.trim()}</a>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <div class="view" style="margin-top: 5%">
                <!--DEFAULT-->
                <c:if test="${empty param.txtSearch and empty param.subjectID}">
                    <div class="view">
                        <c:if test="${empty requestScope.LIST_QUESTION}">
                            <div style="margin: 10%;text-align: center;font-weight: bold;text-transform: uppercase;font-size: 30px;opacity: 0.5">
                                <i style="font-size: 200px;color: red;" class="fas fa-search"></i>
                                <p>Please search keyword to view history</span>.</p>
                            </div>
                        </div>
                    </c:if>
                </c:if>
                <!--SEARCH BY NAME-->
                <c:if test="${not empty param.txtSearch and empty param.subjectID}">
                    <c:set var="list_submission" value="${requestScope.HISTORY}"></c:set>
                    <div>
                        <c:forEach items="${applicationScope.SUBJECT}" var="subject">
                            <c:if test="${subject.subjectID.trim() eq list_submission.get(0).subjectID.trim()}">
                                <c:set var="subjectName" value="${subject.name.trim()}"></c:set>
                            </c:if>
                        </c:forEach>
                        <table class="table" style="text-align: center">
                            <thead class="thead-dark">
                                <tr>
                                    <th scope="col">No.</th>
                                    <th scope="col">Time</th>
                                    <th scope="col">Student Name</th>
                                    <th scope="col">Quiz Name</th>
                                    <th scope="col">Correct Answers</th>
                                    <th scope="col">Score</th>
                                    <th scope="col">Review</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${list_submission}" var="submission" varStatus="counter">
                                    <tr>
                                        <td>${counter.count}</td>
                                        <td>${submission.time}</td>
                                        <c:forEach items="${requestScope.LIST_STUDENT}" var="student">
                                            <c:if test="${student.email.trim() eq submission.student_email.trim()}"><td>${student.name}</td></c:if>
                                        </c:forEach>
                                        <td>${subjectName} - ${submission.submissionID}</td>
                                        <td>${submission.total_answer_correct_submit} / ${submission.total_answer_correct_exam}</td>
                                        <td style="font-weight: bold">${submission.score}</td>
                                        <td><a href="review?submissionID=${submission.submissionID.trim()}&subject_name=${subjectName}&total_answer_correct_submit=${submission.total_answer_correct_submit}&total_answer_correct_exam=${submission.total_answer_correct_exam}&score=${submission.score}"> Review </a></td>
                                    </tr>
                                </c:forEach>
                        </table>
                    </div>
                    <nav aria-label="...">
                        <ul class="pagination pagination-sm" style="justify-content: center">
                            <c:forEach begin="1" end="${requestScope.NUM_PAGE}" var="countPage">
                                <li class="page-item <c:if test="${countPage eq param.pageIndex}"> active </c:if>"><a class="page-link" href="view_history?page=admin&search_by=name&txtSearch=${param.txtSearch}&pageIndex=${countPage}">${countPage}</a></li>
                                </c:forEach>
                        </ul>
                    </nav>
                </c:if>
                <!--SEARCH BY SUBJECT-->
                <c:if test="${empty param.txtSearch and not empty param.subjectID}">
                    <c:set var="list_submission" value="${requestScope.HISTORY}"></c:set>
                    <div>
                        <c:forEach items="${applicationScope.SUBJECT}" var="subject">
                            <c:if test="${subject.subjectID.trim() eq param.subjectID}">
                                <c:set var="subjectName" value="${subject.name.trim()}"></c:set>
                            </c:if>
                        </c:forEach>
                        <table class="table" style="text-align: center">
                            <thead class="thead-dark">
                                <tr>
                                    <th scope="col">No.</th>
                                    <th scope="col">Time</th>
                                    <th scope="col">Student Name</th>
                                    <th scope="col">Quiz Name</th>
                                    <th scope="col">Correct Answers</th>
                                    <th scope="col">Score</th>
                                    <th scope="col">Review</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${list_submission}" var="submission" varStatus="counter">
                                    <tr>
                                        <td>${counter.count}</td>
                                        <td>${submission.time}</td>
                                        <c:forEach items="${requestScope.LIST_STUDENT}" var="student">
                                            <c:if test="${student.email.trim() eq submission.student_email.trim()}"><td>${student.name}</td></c:if>
                                        </c:forEach>
                                        <td>${subjectName} - ${submission.submissionID}</td>
                                        <td>${submission.total_answer_correct_submit} / ${submission.total_answer_correct_exam}</td>
                                        <td style="font-weight: bold">${submission.score}</td>
                                        <td><a href="review?submissionID=${submission.submissionID.trim()}&subject_name=${subjectName}&total_answer_correct_submit=${submission.total_answer_correct_submit}&total_answer_correct_exam=${submission.total_answer_correct_exam}&score=${submission.score}"> Review </a></td>
                                    </tr>
                                </c:forEach>
                        </table>
                    </div>
                    <nav aria-label="...">
                        <ul class="pagination pagination-sm" style="justify-content: center">
                            <c:forEach begin="1" end="${requestScope.NUM_PAGE}" var="countPage">
                                <li class="page-item <c:if test="${countPage eq param.pageIndex}"> active </c:if>"><a class="page-link" href="view_history?page=admin&search_by=subject&subjectID=${param.subjectID}&pageIndex=${countPage}">${countPage}</a></li>
                                </c:forEach>
                        </ul>
                    </nav>
                </c:if>
            </div>
        </div>
        <div class="footer-container">
        </div>
        <style>
            .body-container .tool-taskbar{
                display: inline-flex;
                margin-top: 20px;
                margin-left: 20px;
            }
            .footer-container {
                background-color: #e3f2fd;
                position: absolute;
                width: 100%;
                height: 300px;
                text-align: center;
            }
        </style>
        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>

</html>