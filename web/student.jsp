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
                            <a class="nav-link" href="student_page">Home <span class="sr-only">(current)</span></a>
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
                        <input type="submit" class="form-control btn-success" value="Sign out" />
                    </div>
                </form>
            </nav>
        </div>
        <div class="body-container" style="min-height: 600px;">
            <div id="accordion">
                <div class="card">
                    <div class="card-header" id="headingOne" style="text-align: center;">
                        <h5 class="mb-0">
                            <button class="btn btn-link" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                <i class="fa fa-edit"></i> Take A Quiz
                            </button>
                        </h5>
                    </div>

                    <div id="collapseOne" class="collapse" aria-labelledby="headingOne" data-parent="#accordion" style="background-color: aliceblue">
                        <div class="card-body row">
                            <c:forEach items="${applicationScope.SUBJECT_STUDENT}" var="subject">
                                <div class="view">
                                    <div class="card" style="width: 15rem;font-size:14px; letter-spacing: 0.6px;">
                                        <img class="card-img-top" src="${subject.image}" alt="${subject.subjectID}">
                                        <div class="card-body">
                                            <h5 class="card-title">${subject.name}</h5>
                                            <p class="card-text">${subject.description}</p>
                                            <a href="load_quiz_room?subjectID=${subject.subjectID.trim()}&question_number=0&quiz_time=${subject.time_exam * 60}&answers_choosen=temp&reset=true" class="btn btn-primary">Take a quiz</a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
            <div id="accordion">
                <c:set var="list_submission" value="${requestScope.HISTORY}"></c:set>
                <div class="card">
                    <div class="card-header" id="headingOne" style="text-align: center;">
                        <h5 class="mb-0">
                            <button class="btn btn-link" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
                                    <i class="fas fa-history"></i> View History
                                </button>
                        </h5>
                    </div>

                    <div id="collapseTwo" class="collapse <c:if test="${not empty list_submission}"> show </c:if>" aria-labelledby="headingOne" data-parent="#accordion" style="background-color: aliceblue;">
                        <div class="card-body row">
                            <c:forEach items="${applicationScope.SUBJECT_STUDENT}" var="subject">
                                <div class="view">
                                    <div class="card" style="width: 15rem;font-size:14px; letter-spacing: 0.6px;">
                                        <img class="card-img-top" src="${subject.image}" alt="${subject.subjectID}">
                                        <div class="card-body">
                                            <h5 class="card-title">${subject.name}</h5>
                                            <a href="view_history?page=student&subjectID=${subject.subjectID.trim()}&pageIndex=1" class="btn btn-primary">View History</a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <c:if test="${not empty list_submission}">
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
                                        <li class="page-item <c:if test="${countPage eq param.pageIndex}">active</c:if>"><a class="page-link" href="view_history?page=student&subjectID=${param.subjectID}&pageIndex=${countPage}">${countPage}</a></li>
                                    </c:forEach>
                                </ul>
                            </nav>
                        </c:if>
                    </div>
                </div>

            </div>
        </div>
        <div class="footer-container" style="background-color: #e3f2fd; min-height: 200px;">

        </div>
        <!-- Optional CSS -->
        <style>
            .body-container .card-header .btn {
                font-weight: bold;
                font-size: 30px;
                text-decoration: none;
            }
            
            .body-container .card-header .btn:hover {
                font-size: 35px;
                letter-spacing: 1px;
                color: crimson;
                transition: all 280ms ease-in-out;
            }
            
            .body-container .card-header {
                border: 4px dotted darkmagenta;
            }
            
            .body-container {
                margin: 5% auto;
            }
            
            .body-container #collapseOne .card-body .view .card {
                margin: 5% auto;
                border-radius: 10%;
                box-shadow: 5px 5px 5px 5px gray;
                margin-left: 30%;
            }
            
            .body-container #collapseOne .card-body .view .card:hover {
                background-color: beige;
                transition: all 280ms ease-in-out;
            }
            
            .body-container #accordion {
                margin-top: 5%;
            }
            
            .body-container #collapseOne .card-body {
                grid-gap: 10%;
            }
            
            .body-container #collapseOne .card-body img {
                min-width: 30%;
                max-width: 30%;
                margin: 10px auto;
            }
            
            .body-container #collapseOne .card-body .card-title {
                text-align: center;
            }
            
            .body-container #collapseOne .card-body a {
                float: right;
                margin-right: 5%;
            }
            
            .body-container #collapseTwo .card-body .view .card {
                margin: 5% auto;
                border-radius: 10%;
                box-shadow: 5px 5px 5px 5px gray;
                margin-left: 30%;
            }
            
            .body-container #collapseTwo .card-body .view .card:hover {
                background-color: beige;
                transition: all 280ms ease-in-out;
            }
            
            .body-container #collapseTwo .card-body {
                grid-gap: 10%;
            }
            
            .body-container #collapseTwo .card-body img {
                min-width: 30%;
                max-width: 30%;
                margin: 10px auto;
            }
            
            .body-container #collapseTwo .card-body .card-title {
                text-align: center;
            }
            
            .body-container #collapseTwo .card-body a {
                margin-left: 20%;
                margin-top: 10%;
            }
        </style>
        <!-- Optional JavaScript -->
        <script>
        </script>
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>

    </html>