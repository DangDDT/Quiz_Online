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
                        <c:if test="${sessionScope.ACCOUNT.role eq 'student'}">
                            <li class="nav-item active">
                                <a class="nav-link" href="student_page">Home <span class="sr-only">(current)</span></a>
                            </li>
                        </c:if>
                        <c:if test="${sessionScope.ACCOUNT.role eq 'admin'}">
                            <li class="nav-item active">
                                <a class="nav-link" href="admin_page">Home <span class="sr-only">(current)</span></a>
                            </li>
                            <li class="nav-item active">
                                <a class="nav-link" href="admin_history_page">View History <span class="sr-only">(current)</span></a>
                            </li>
                        </c:if>
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
            <c:set var="questions" value="${requestScope.REVIEW}"></c:set>
            <h1>REVIEW: <span style="color:red">${param.submissionID} - ${param.subject_name}</span></h1>
            <table class="table">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">No.</th>
                        <th scope="col">Question</th>
                        <th scope="col">Your Answer</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${questions}" var="question" varStatus="counter">
                        <tr>
                            <td>${counter.count}</td>
                            <td>${question.question_content}<br/>
                                <ul>
                                    <c:forEach items="${requestScope.ANSWER.get(question.questionID)}" var="answer">
                                        <li>${answer.answer_content}
                                            <c:if test="${answer.isCorrect eq 'true'}"><i style="color:green" class="fas fa-check"></i></c:if>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </td>
                            <td>
                                <ul>
                                    <c:forEach items="${question.questionID_answerContent.get(question.questionID)}" var="your_answer">
                                        <li>${your_answer.answer_content.trim()}
                                            <c:if test="${your_answer.isCorrect eq 'true'}"><i style="color:green" class="fas fa-check"></i></c:if>
                                            <c:if test="${your_answer.isCorrect eq 'false'}"><i style="color:red" class="fas fa-times"></i></c:if>
                                            </li>
                                    </c:forEach>
                                </ul>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <h2>Your Result: <span style="font-weight: bold; color:green">${param.total_answer_correct_submit} / ${param.total_answer_correct_exam}</span></h2>
            <h2>Your Score: <span style="font-weight: bold; color:green" >${param.score}</span></h2>
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