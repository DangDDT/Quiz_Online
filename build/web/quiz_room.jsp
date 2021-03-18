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
        <c:set var="question" value="${requestScope.QUESTION}"></c:set>
        <c:set var="list_choosen" value="${sessionScope.LIST_ANSWER_CHOOSEN.get(question.questionID.trim())}"></c:set>
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
                                <a class="nav-link" href="student_page">Home<span class="sr-only">(current)</span></a>
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
        <div class="body-container container" style="min-height: 500px;">
            <div class="row row-container">
                <div class="col-4 overview">
                    <div class="btn-toolbar justify-content-between" role="toolbar" aria-label="Toolbar with button groups" style="grid-gap: 15px;">
                        <c:forEach begin="1" end="${sessionScope.EXAM.size()}" var="question_num">
                            <form action="load_quiz_room">
                                <input type="hidden" name="subjectID" value="${question.subjectID.trim()}" />
                                <input type="hidden" name="question_number" value="${question_num-1}" />
                                <input type="hidden" name="questionID" value="${question.questionID.trim()}" />
                                <input type="hidden" name="answers_choosen" class="answers_choosen" value="" />
                                <input type="hidden" name="time_string" value="" />
                                <input type="hidden" name="reset" value="false" />
                                <input class="quiz_time" name="quiz_time" type="hidden" value="${param.quiz_time}"></input>
                                <button type="submit" class="form-control-sm btn btn-secondary">${question_num}</button>
                            </form>
                        </c:forEach>
                    </div>
                    <div class="time-counter" id="time-counter">
                        <div>
                            Time Remaining: <span id="time" style="font-weight: bold;">${param.time_string}</span>
                        </div>
                        <input type="hidden" id="current_time" value="${param.quiz_time}"></input>
                    </div>
                </div>
                <div class="col-1 space"></div>
                <div class="col-7 content">
                    <div class="question">
                        <span style="font-weight: bold">Question ${param.question_number+1}: </span> ${question.question_content}
                    </div>
                    <div class="answers_content">
                        <c:set var="answers" value="${question.answers}"></c:set>
                        <c:forEach items="${answers}" var="answer">
                            <div class="row row-answer-checkbox">
                                <c:if test="${requestScope.QUESTION_1 eq 'false'}"><input type="checkbox" class="form-control-sm form-control col-1 checkbox" id="${answer.answerID.trim()}" name="answer" value="${answer.answerID.trim()}" onclick="click${answer.answerID.trim()}()" <c:if test="${list_choosen.contains(answer.answerID.trim())}">checked</c:if>></c:if>
                                <c:if test="${requestScope.QUESTION_1 eq 'true'}"><input type="radio" class="form-control-sm form-control col-1 checkbox" id="${answer.answerID.trim()}" name="answer" value="${answer.answerID.trim()}" onclick="click${answer.answerID.trim()}()" <c:if test="${list_choosen.contains(answer.answerID.trim())}">checked</c:if>></c:if>
                                <script>
                                        function click${answer.answerID.trim()}() {
                                            var target = document.getElementsByClassName('answers_choosen');
                                            var checkbox = document.getElementsByClassName('checkbox');
                                            var checked_box = "";
                                            for (i = 0; i < checkbox.length; i++) {
                                                if (checkbox[i].checked === true) {
                                                    checked_box = checked_box + "-" + checkbox[i].value;
                                                }
                                            }
                                            for (i = 0; i < target.length; i++) {
                                                document.getElementsByClassName('answers_choosen')[i].value = checked_box;
                                            }
                                        }
                                </script>
                                <label class="col-11" for="${answer.answerID.trim()}">${answer.answer_content}</label>
                                <br>
                            </div>
                        </c:forEach>
                        <div style="display: flex; margin-top: 50px; margin-bottom: 50px">
                            <form action="load_quiz_room">
                                <input type="hidden" name="subjectID" value="${question.subjectID.trim()}" />
                                <input type="hidden" name="question_number"
                                        <c:if test="${param.question_number eq 0}">value="${sessionScope.EXAM.size()-1}"</c:if> 
                                              <c:if test="${param.question_number ne 0}">value="${param.question_number-1}"</c:if>/>
                                <input type="hidden" name="questionID" value="${question.questionID.trim()}" />
                                <input type="hidden" name="answers_choosen" class="answers_choosen" value="" />
                                <input type="hidden" name="time_string"  value=""/>
                                <input type="hidden" name="reset" value="false" />
                                <input class="quiz_time" id="prevous" name="quiz_time" type="hidden" value="${param.quiz_time}"></input>
                                <button type="submit" class="form-control-sm btn btn-secondary">Prevous</button>
                                </form>
                                <form action="load_quiz_room" style="margin: 0px 77%;">
                                    <input type="hidden" name="subjectID" value="${question.subjectID.trim()}" />
                                <input type="hidden" name="question_number" 
                                       <c:if test="${param.question_number eq sessionScope.EXAM.size()-1}">value="0"</c:if> 
                                              <c:if test="${param.question_number ne sessionScope.EXAM.size()-1}">value="${param.question_number+1}"</c:if>/>
                                <input type="hidden" name="questionID" value="${question.questionID.trim()}" />
                                <input type="hidden" name="answers_choosen" class="answers_choosen" value="" />
                                <input type="hidden" name="time_string" value="" />
                                <input type="hidden" name="reset" value="false" />
                                <input class="quiz_time" id="next" name="quiz_time" type="hidden" value="${param.quiz_time}"></input>
                                <button type="submit" class="form-control-sm btn btn-secondary">Next</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="finish-exam">
                    <a href="submit_exam"><button class="form-control-lg form-control" style="margin-top:10%; font-weight: bold">Finish Quiz</button></a>
                </div>
            </div>
            <div class="footer-container" style="background-color: #e3f2fd; min-height: 250px;">

            </div>
            <!-- Optional JavaScript -->
            <script>
                var upgradeTime = document.getElementById('current_time').value - 3;
                var seconds = upgradeTime;

                function timer() {
                    var hours = Math.floor(seconds / 60 / 60);
                    var minutesLeft = Math.floor(seconds - (hours * 3600));
                    var minutes = Math.floor(minutesLeft / 60);
                    var remainingSeconds = seconds % 60;

                    function pad(n) {
                        return (n < 10 ? "0" + n : n);
                    }
                    for (i = 0; i < ${sessionScope.EXAM.size()}; i++) {
                        document.getElementsByClassName('quiz_time')[i].value = seconds;
                    }
                    document.getElementById('prevous').value = seconds;
                    document.getElementById('next').value = seconds;
                    document.getElementById('time').innerHTML = pad(hours) + ":" + pad(minutes) + ":" + pad(remainingSeconds);
                    var count = document.getElementsByName('time_string');
                    for (i = 0; i < count.length; i++) {
                        document.getElementsByName('time_string')[i].value = pad(hours) + ":" + pad(minutes) + ":" + pad(remainingSeconds);
                    }
                    if (seconds <= 20) {
                        document.getElementById('time-counter').style.backgroundColor = 'red';
                    }
                    if (seconds === 0) {
                        clearInterval(countdownTimer);
                        document.getElementById('time').innerHTML = "Time out!!!";



                    } else {
                        seconds--;
                    }
                }
                var countdownTimer = setInterval('timer()', 1000);
                function Redirect() {
                    window.location = "submit_exam";
                }
                setTimeout('Redirect()', (seconds + 3) * 1000);
        </script>
        <script type="text/javascript">
            window.onload = function () {
                document.onkeydown = function (e) {
                    return (((e.which || e.keyCode) !== 116) && ((e.which || e.keyCode) !== 82));
                };
            }
        </script>
        <script>

        </script>
        <!-- Optional CSS -->
        <style>
            .finish-exam a:hover{
                text-decoration: none;
            }
            .finish-exam button:hover{
                background-color: #50a3a2;
            }
            .body-container {
                margin: 5% auto;
            }

            .body-container .row-container {
                min-height: fit-content;
            }

            .body-container .row-container .row-answer-checkbox {
                margin-top: 20px;
            }

            .body-container .row .overview {
                border: 2px solid gray;
                height: max-content;
            }

            .body-container .row .overview .time-counter {
                margin-top: 10%;
                margin-bottom: 10%
            }

            .body-container .row .overview .btn {
                margin-top: 30px;
                background-color: transparent;
                color:black;
                width: 50px;
            }
            .body-container .row .overview .btn:hover {
                margin-top: 30px;
                background-color: #53e3a6;
                color:black;
                width: 50px;
            }

            .body-container .row .content {
                border: 2px solid gray;
            }

            .body-container .row .content .question {
                margin-top: 5%;
            }

            .body-container .row .content .answers_content {
                margin-top: 5%;
            }
        </style>

        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>

</html>