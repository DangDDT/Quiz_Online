<!doctype html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <html lang="en">

    <head>
        <title>Home</title>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!-- Bootstrap CSS -->
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
                        <input type="submit" class="form-control" value="Sign out" />
                    </div>
                </form>
            </nav>
        </div>
        <div class="body-container" style="min-height: 600px;">
            <table class="table">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">No.</th>
                        <th scope="col">Quiz Name</th>
                        <th scope="col">Correct Answers</th>
                        <th scope="col">Score</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <c:forEach items="${applicationScope.SUBJECT}" var="subject">
                            <c:if test="${subject.subjectID.trim() eq requestScope.SUBJECT.trim()}"><td>${subject.name.trim()}</td></c:if>
                        </c:forEach>
                        <td>${requestScope.NUM_CORRECT_ANSWER} / ${requestScope.NUM_EXAM_ANSWER}</td>
                        <td>${requestScope.SCORE}</td>
                    </tr>
            </table>
        </div>
        <div class="footer-container" style="background-color: #e3f2fd; min-height: 300px;">

        </div>
        <!-- Optional CSS -->
        <style>
            .body-container {
                margin: 5% 10% 5% 10%;
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