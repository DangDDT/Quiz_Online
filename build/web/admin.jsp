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
        <c:if test="${empty param.txtSearch and empty param.status and empty param.subjectID}">
            <c:set var="current_page" value="admin_page"></c:set>
        </c:if>
        <c:if test="${not empty param.txtSearch and empty param.status and empty param.subjectID}">
            <c:set var="current_page" value="search_by_name?txtSearch=${param.txtSearch}&pageIndex=${param.pageIndex}"></c:set>
        </c:if>
        <c:if test="${empty param.txtSearch and not empty param.status and empty param.subjectID}">
            <c:set var="current_page" value="search_by_status?status=${param.status}&pageIndex=${param.pageIndex}"></c:set>
        </c:if>
        <c:if test="${empty param.txtSearch and empty param.status and not empty param.subjectID}">
            <c:set var="current_page" value="search_by_subject?subjectID=${param.subjectID}&pageIndex=${param.pageIndex}"></c:set>
        </c:if>
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

            <div class="tool-taskbar">

                <nav class="navbar navbar-light bg-light">

                    <!-- Button trigger modal -->
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createQuestion" style="margin-left: 40%;">Create New Question</button>
                    <!-- Modal -->
                    <div class="modal fade" id="createQuestion" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content">
                                <form action="create_question">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLongTitle">Create New Question</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="form-group row">
                                            <label for="inputQuestionContent" class="col-sm-2 col-form-label col-form-label-sm">Question: </label>
                                            <div class="col-sm-10">
                                                <input type="text" name="question_content" class="form-control form-control-sm" id="new_question" placeholder="Input question content" required>
                                            </div>
                                        </div>
                                        <div>
                                            <div class="form-group row">
                                                <label for="inputQuestionContent" class="col-sm-2 col-form-label col-form-label-sm">Subject: </label>
                                                <div class="col-sm-10">
                                                    <select name="subjectID" class="form-control form-control-sm">
                                                        <c:forEach items="${applicationScope.SUBJECT}" var="subject">
                                                            <option value="${subject.subjectID.trim()}">${subject.name}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div>
                                            <p style="font-size: 11px;font-weight: bold;text-align: right; margin-right: 10px;">Correct Answer</p>
                                        </div>
                                        <c:forEach begin="1" end="4" var="counter">
                                            <div class="form-group row">
                                                <label for="inputAnswer${counter}" class="col-sm-3 col-form-label col-form-label-sm">Option ${counter}: </label>
                                                <div class="col-sm-6">
                                                    <input type="hidden" name="answerID_content" id="${counter}_hidden" value="" />
                                                    <input type="text" class="form-control form-control-sm text-add" id="${counter}_input" placeholder="Input option ${counter}" onkeyup="change${counter}()" onchange="checkDuplicate()" required>
                                                </div>
                                                <script>
                                                    var _checkDuplicate = false;
                                                    var _checkCheckBox = false;
                                                    function change${counter}() {
                                                        var input_text = document.getElementById("${counter}_input").value;
                                                        document.getElementById("${counter}_hidden").value = "${counter}-" + input_text;
                                                    }
                                                    function checkDuplicate() {
                                                        var array = document.getElementsByClassName("text-add");
                                                        var count = new Int16Array(array.length);
                                                        for (i = 0; i < array.length; i++) {
                                                            for (j = 0; j < array.length; j++) {
                                                                if (document.getElementsByClassName("text-add")[i].value !== "") {
                                                                    if (document.getElementsByClassName("text-add")[i].value === document.getElementsByClassName("text-add")[j].value) {
                                                                        count[i]++;
                                                                    }
                                                                }
                                                            }
                                                        }

                                                        for (i = 0; i < array.length; i++) {
                                                            if (count[i] > 1) {
                                                                _checkDuplicate = false;
                                                                document.getElementById('button-add').disabled = true;
                                                                document.getElementById("message-add").innerHTML = "You cannot input answers which are duplicated !!!";
                                                                return;
                                                            }
                                                        }
                                                        document.getElementById("message-add").innerHTML = "";
                                                        _checkDuplicate = true;
                                                        console.log(_checkDuplicate);
                                                        disable_add();
                                                    }

                                                </script>
                                                <input type="checkbox" class="form-control-sm col-sm-3 checkbox-add" name="correct_answer" value="${counter}" onclick="
                                                        var check_box = document.getElementsByClassName('checkbox-add');
                                                        var count_checkbox = 0;
                                                        for (i = 0; i < check_box.length; i++) {
                                                            if (document.getElementsByClassName('checkbox-add')[i].checked === true) {
                                                                count_checkbox++;
                                                            }
                                                        }
                                                        if (count_checkbox > 0) {
                                                            _checkCheckBox = true;
                                                            document.getElementById('message-checkbox').style.color = 'green';
                                                            document.getElementById('message-checkbox').innerHTML = ' (Complete) ';
                                                        } else {
                                                            _checkCheckBox = false;
                                                            document.getElementById('message-checkbox').style.color = 'red';
                                                            document.getElementById('message-checkbox').innerHTML = ' (Incomplete) ';
                                                        }
                                                        console.log(_checkCheckBox);
                                                        disable_add();
                                                       ">
                                                <script>
                                                    function disable_add() {
                                                        if (_checkCheckBox === true && _checkDuplicate === true) {
                                                            document.getElementById('button-add').disabled = false;
                                                        } else {
                                                            document.getElementById('button-add').disabled = true;
                                                        }
                                                    }
                                                </script>
                                            </div>
                                        </c:forEach>
                                        <p style="margin-left: 5px; font-weight: bold; color:black; font-size: 12px">* Please select at least 1 correct answer --- Status: <span id="message-checkbox" style="color:red"> (Incomplete) </span></p>
                                    </div>
                                    <div class="modal-footer">
                                        <p id="message-add" style="margin-left: 10px; font-weight: bold; color:red; font-size: 12px"></p>
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        <button type="submit" id="button-add" class="btn btn-primary" disabled>Add</button>
                                    </div>
                                    <input type="hidden" name="current_page" value="${current_page}" />
                                </form>
                            </div>
                        </div>
                    </div>
                    <!-- FORM SEARCH -->
                    <form class="form-inline" style="margin-left: auto" action="search_by_name">
                        <input class="form-control mr-sm-2" name="txtSearch" value="${param.txtSearch}" type="search" placeholder="Search" aria-label="Search">
                        <input type="hidden" name="pageIndex" value="1" />
                        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                    </form>
                    <!-- FORM STATUS OF QUESTION -->
                    <div class="btn-group" style="margin-left: 10px">
                        <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Status
                        </button>
                        <form>
                            <div class="dropdown-menu">
                                <a class="dropdown-item" href="search_by_status?status=active&pageIndex=1">Active</a>
                                <a class="dropdown-item" href="search_by_status?status=inactive&pageIndex=1">Inactive</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="admin_page" style="font-weight: bold">Default</a>
                            </div>
                        </form>
                    </div>
                    <!-- FORM SUBJECT  -->
                    <div class="btn-group" style="margin-left: 10px; margin-right: 200px">
                        <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Subject
                        </button>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="#" style="font-weight: bold">Default</a>
                            <div class="dropdown-divider"></div>
                            <c:forEach items="${applicationScope.SUBJECT}" var="subject">
                                <a class="dropdown-item" href="search_by_subject?subjectID=${subject.subjectID.trim()}&pageIndex=1">${subject.subjectID.trim()} - ${subject.name.trim()}</a>  
                            </c:forEach>
                        </div>
                    </div>
                    <div>
                        <a href="admin_history_page" class="form-control btn btn-secondary">History Quiz<a/>
                    </div>
                </nav>
            </div>
            <c:if test="${not empty requestScope.MESSAGE}">
                <div class="notifycation" style="background-color: #E3F2CD">
                    <p style="font-weight: bold"><i style="margin: 20px;color: blue;"class="fas fa-check-circle"></i>${requestScope.MESSAGE}</p>
                </div>
            </c:if>
            <!--DEFAULT-->
            <c:if test="${empty param.txtSearch and empty param.status and empty param.subjectID}">
                <div class="view">
                    <c:if test="${empty requestScope.LIST_QUESTION}">
                        <div style="margin: 10%;text-align: center;font-weight: bold;text-transform: uppercase;font-size: 30px;opacity: 0.5">
                            <i style="font-size: 200px;color: red;" class="fas fa-search"></i>
                            <p>Please search the questions to manage</span>.</p>
                        </div>
                    </c:if>
                </div>
            </c:if>
            <!--SEARCH THEO NAME-->
            <c:if test="${not empty param.txtSearch && empty param.status && empty param.subjectID}">
                <div class="view">
                    <c:if test="${empty requestScope.LIST_QUESTION}">
                        <div style="margin: 10%;text-align: center;font-weight: bold;text-transform: uppercase;font-size: 30px;opacity: 0.5">
                            <i style="font-size: 200px;color: red;" class="far fa-sad-tear"></i>
                            <p>No existed questions with <span style="color:red">'${param.txtSearch}'</span>.</p>
                        </div>
                    </c:if>
                    <c:forEach items="${applicationScope.SUBJECT}" var="subject">
                        <div>
                            <c:if test="${not empty requestScope.LIST_QUESTION.get(subject.subjectID)}">
                                <h1>${subject.subjectID} - ${subject.name}</h1>
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th scope="col">No.</th>
                                                <th scope="col">Question ID</th>
                                                <th scope="col">Question</th>
                                                <th scope="col">Answers</th>
                                                <th scope="col">Correct Answer</th>
                                                <th scope="col">Update</th>
                                                <th scope="col">Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${requestScope.LIST_QUESTION.get(subject.subjectID)}" var="question" varStatus="counter">
                                                <c:set value="${question.status eq 'false'}" var="isDeleted" />
                                                <tr <c:if test="${isDeleted}">class="textblur"</c:if>>
                                                    <td>${counter.count}</td>
                                                    <td>${question.questionID}</td>
                                                    <td>${question.question_content}</td>
                                                    <td>
                                                        <ul>
                                                            <c:forEach items="${question.answers}" var="answer">
                                                                <li>${answer.answer_content}</li>
                                                                </c:forEach>
                                                        </ul>
                                                    </td>
                                                    <td>
                                                        <ul>
                                                            <c:forEach items="${question.answers}" var="answer">
                                                                <c:if test="${answer.isCorrect eq 'true'}">
                                                                    <li>${answer.answer_content}</li>
                                                                    </c:if>
                                                                </c:forEach>
                                                        </ul>
                                                    </td>
                                                    <td style="text-align: center">
                                                        <c:if test="${isDeleted eq 'true'}">
                                                            <form action="restore_question" method="POST">
                                                                <input type="hidden" name="current_page" value="${current_page}" />
                                                                <button type="submit" style="background-color: #ffff66; border-color: #ffff66; color: black; font-weight: bold;" class="btn btn-primary" name="questionID" value="${question.questionID.trim()}">
                                                                    <i class="fa fa-redo"></i> Restore
                                                                </button>
                                                            </form>
                                                        </c:if>
                                                        <c:if test="${isDeleted eq 'false'}">
                                                            <!-- Button trigger modal -->
                                                            <button type="button" style=" font-weight: bold" class="btn btn-primary" data-toggle="modal" data-target="#updateButton${question.questionID.trim()}">
                                                                <i class="fa fa-edit"></i>Update
                                                            </button>

                                                            <!-- Modal -->
                                                            <div class="modal fade" id="updateButton${question.questionID.trim()}" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                                                <div class="modal-dialog modal-dialog-centered" role="document">
                                                                    <div class="modal-content">
                                                                        <form action="update_question" method="GET">
                                                                            <div class="modal-header">
                                                                                <h5 class="modal-title" id="exampleModalLongTitle">Update question</h5>
                                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                                    <span aria-hidden="true">&times;</span>
                                                                                </button>
                                                                            </div>
                                                                            <c:if test="${question.isUsed eq 'false'}">
                                                                                <div class="modal-body" >
                                                                                    <div class="form-group row">
                                                                                        <label for="inputQuestionID" class="col-sm-2 col-form-label col-form-label-sm">QuestionID: </label>
                                                                                        <div class="col-sm-10">
                                                                                            <input type="text" name="questionID" style="font-weight: bold" class="form-control-plaintext form-control-sm" id="${question.questionID}" readonly value="${question.questionID.trim()}">
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="form-group row">
                                                                                        <label for="inputQuestionContent" class="col-sm-2 col-form-label col-form-label-sm">Question: </label>
                                                                                        <div class="col-sm-10">
                                                                                            <input  type="text" name="question_content" class="form-control form-control-sm" id="${question.question_content.trim()}" value="${question.question_content.trim()}" required>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div>
                                                                                        <div class="form-group row">
                                                                                            <label for="inputQuestionContent" class="col-sm-2 col-form-label col-form-label-sm">Question: </label>
                                                                                            <div class="col-sm-10">
                                                                                                <select name="subjectID" class="form-control form-control-sm">
                                                                                                    <c:forEach items="${applicationScope.SUBJECT}" var="subject">
                                                                                                        <c:if test="${subject.subjectID.trim() eq question.subjectID.trim()}">
                                                                                                            <option value="${subject.subjectID.trim()}">${subject.name}</option>
                                                                                                        </c:if>
                                                                                                    </c:forEach>
                                                                                                    <c:forEach items="${applicationScope.SUBJECT}" var="subject">
                                                                                                        <c:if test="${subject.subjectID.trim() ne question.subjectID.trim()}">
                                                                                                            <option value="${subject.subjectID.trim()}">${subject.name}</option>
                                                                                                        </c:if>
                                                                                                    </c:forEach>
                                                                                                </select>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div>
                                                                                        <p style="font-size: 11px;font-weight: bold;text-align: right; margin-right: 10px;">Correct Answer</p>
                                                                                    </div>
                                                                                    <c:forEach items="${question.answers}" var="answer" varStatus="counter">
                                                                                        <div class="form-group row">
                                                                                            <label for="inputAnswer${answer.answerID.trim()}" class="col-sm-3 col-form-label col-form-label-sm">Option ${counter.count}: </label>
                                                                                            <div class="col-sm-6">
                                                                                                <input type="hidden" name="answerID_content" id="${answer.answerID.trim()}_hidden" value="${answer.answerID.trim()}-${answer.answer_content.trim()}" />
                                                                                                <input type="text"  class="form-control form-control-sm text-${question.questionID.trim()}" id="${answer.answerID.trim()}_input" value="${answer.answer_content.trim()}" onkeyup="change${answer.answerID.trim()}()" onchange="checkDuplicate${question.questionID.trim()}()" required>
                                                                                            </div>
                                                                                            <script>
                                                                                                function change${answer.answerID.trim()}() {
                                                                                                    var input_text = document.getElementById("${answer.answerID.trim()}_input").value;
                                                                                                    document.getElementById("${answer.answerID.trim()}_hidden").value = "${answer.answerID.trim()}-" + input_text;
                                                                                                }
                                                                                                function checkDuplicate${question.questionID.trim()}() {
                                                                                                    var array = document.getElementsByClassName("text-${question.questionID.trim()}");
                                                                                                    var count = new Int16Array(array.length);
                                                                                                    for (i = 0; i < array.length; i++) {
                                                                                                        for (j = 0; j < array.length; j++) {
                                                                                                            if (document.getElementsByClassName("text-${question.questionID.trim()}")[i].value !== "") {
                                                                                                                if (document.getElementsByClassName("text-${question.questionID.trim()}")[i].value === document.getElementsByClassName("text-${question.questionID.trim()}")[j].value) {
                                                                                                                    count[i]++;
                                                                                                                }
                                                                                                            }
                                                                                                        }
                                                                                                    }

                                                                                                    for (i = 0; i < array.length; i++) {
                                                                                                        if (count[i] > 1) {
                                                                                                            document.getElementById("button-update-${question.questionID.trim()}").disabled = true;
                                                                                                            document.getElementById("message-update-${question.questionID.trim()}").innerHTML = "You cannot input answers which are duplicated !!!";
                                                                                                            return;
                                                                                                        }
                                                                                                    }
                                                                                                    document.getElementById("button-update-${question.questionID.trim()}").disabled = false;
                                                                                                    document.getElementById("message-update-${question.questionID.trim()}").innerHTML = "";
                                                                                                }
                                                                                            </script>
                                                                                            <input type="checkbox" class="form-control-sm col-sm-3 checkbox-update-${question.questionID.trim()}" name="correct_answer" value="${answer.answerID.trim()}"<c:if test="${answer.isCorrect eq 'true'}">checked</c:if> onclick="
                                                                                                    var check_box = document.getElementsByClassName('checkbox-update-${question.questionID.trim()}');
                                                                                                    for (i = 0; i < check_box.length; i++) {
                                                                                                        if (document.getElementsByClassName('checkbox-update-${question.questionID.trim()}')[i].checked === true) {
                                                                                                            document.getElementById('button-update-${question.questionID.trim()}').disabled = false;
                                                                                                            document.getElementById('message-checkbox-${question.questionID.trim()}').style.color = 'green';
                                                                                                            document.getElementById('message-checkbox-${question.questionID.trim()}').innerHTML = ' (Complete) ';
                                                                                                            return;
                                                                                                        }
                                                                                                    }
                                                                                                    document.getElementById('button-update-${question.questionID.trim()}').disabled = true;
                                                                                                    document.getElementById('message-checkbox-${question.questionID.trim()}').style.color = 'red';
                                                                                                    document.getElementById('message-checkbox-${question.questionID.trim()}').innerHTML = ' (Incomplete) ';
                                                                                                   "/>
                                                                                        </div>
                                                                                    </c:forEach>
                                                                                    <p style="margin-left: 5px; font-weight: bold; color:black; font-size: 12px">* Please select at least 1 correct answer --- Status: <span id="message-checkbox-${question.questionID.trim()}" style="color:green"> (Complete) </span></p>
                                                                                </div>
                                                                            </c:if>
                                                                            <c:if test="${question.isUsed eq 'true'}">
                                                                                <p style="margin-top: 20px; margin-bottom: 20px; font-size: 14px"> Sorry!!! This question is used for quiz, so you cannot update it's information. </p>
                                                                            </c:if>
                                                                            <div class="modal-footer">
                                                                                <p id="message-update-${question.questionID.trim()}" style="margin-left: 10px; font-weight: bold; color:red; font-size: 12px"></p>
                                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                                                <c:if test="${question.isUsed eq 'false'}">
                                                                                    <input type="hidden" name="current_page" value="${current_page}" />
                                                                                    <button type="submit" id="button-update-${question.questionID.trim()}" class="btn btn-primary">Save</button>
                                                                                </c:if>
                                                                            </div>
                                                                        </form>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:if>
                                                    </td>
                                                    <td style="text-align: center">
                                                        <!-- Button trigger modal -->
                                                        <button type="button" <c:if test="${isDeleted eq 'false'}">style="background-color: #ff6666; border-color: #ff6666;  font-weight: bold "</c:if> 
                                                                <c:if test="${isDeleted}">style="background-color: gray; border-color: gray"</c:if>
                                                                class="btn btn-primary" data-toggle="modal" data-target="#deleteButton${question.questionID.trim()}" <c:if test="${isDeleted}">disabled</c:if>>
                                                                    <i class="fa fa-trash-alt"></i>Delete
                                                                </button>

                                                                <!-- Modal -->
                                                                <div class="modal fade" id="deleteButton${question.questionID.trim()}" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                                <div class="modal-content">
                                                                    <form action="delete_question" method="POST">
                                                                        <div class="modal-header">
                                                                            <h5 class="modal-title" id="exampleModalLongTitle">Delete question</h5>
                                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                                <span aria-hidden="true">&times;</span>
                                                                            </button>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <input type="hidden" name="questionID" value="${question.questionID.trim()}" />
                                                                            Do you want delete question "${question.questionID.trim()}" ?
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <input type="hidden" name="current_page" value="${current_page}" />
                                                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                                            <button type="submit" class="btn btn-primary">Delete</button>
                                                                        </div>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                            </div>
                        </c:if>
                    </c:forEach>
                    <nav aria-label="...">
                        <ul class="pagination pagination-sm">
                            <c:forEach begin="1" end="${requestScope.NUM_PAGE - 1}" var="countPage">
                                <li class="page-item <c:if test="${countPage eq param.pageIndex}">active</c:if>"><a class="page-link" href="search_by_name?txtSearch=${param.txtSearch}&pageIndex=${countPage}">${countPage}</a></li>
                                </c:forEach>
                        </ul>
                    </nav>
                </div>
            </c:if>
            <!--SEARCH THEO STATUS-->
            <c:if test="${empty param.txtSearch && not empty param.status && empty param.subjectID}">
                <div class="view">
                    <c:forEach items="${applicationScope.SUBJECT}" var="subject">
                        <div>
                            <c:if test="${not empty requestScope.LIST_QUESTION.get(subject.subjectID)}">
                                <h1>${subject.subjectID} - ${subject.name}</h1>
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th scope="col">No.</th>
                                                <th scope="col">Question ID</th>
                                                <th scope="col">Question</th>
                                                <th scope="col">Answers</th>
                                                <th scope="col">Correct Answer</th>
                                                <th scope="col">Update</th>
                                                <th scope="col">Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${requestScope.LIST_QUESTION.get(subject.subjectID)}" var="question" varStatus="counter">
                                                <c:set value="${question.status eq 'false'}" var="isDeleted" />
                                                <tr <c:if test="${isDeleted}">class="textblur"</c:if>>
                                                    <td>${counter.count}</td>
                                                    <td>${question.questionID}</td>
                                                    <td>${question.question_content}</td>
                                                    <td>
                                                        <ul>
                                                            <c:forEach items="${question.answers}" var="answer">
                                                                <li>${answer.answer_content}</li>
                                                                </c:forEach>
                                                        </ul>
                                                    </td>
                                                    <td>
                                                        <ul>
                                                            <c:forEach items="${question.answers}" var="answer">
                                                                <c:if test="${answer.isCorrect eq 'true'}">
                                                                    <li>${answer.answer_content}</li>
                                                                    </c:if>
                                                                </c:forEach>
                                                        </ul>
                                                    </td>
                                                    <td style="text-align: center">
                                                        <c:if test="${isDeleted eq 'true'}">
                                                            <form action="restore_question" method="POST">
                                                                <input type="hidden" name="current_page" value="${current_page}" />
                                                                <button type="submit" style="background-color: #ffff66; border-color: #ffff66; color: black; font-weight: bold;" class="btn btn-primary" name="questionID" value="${question.questionID.trim()}">
                                                                    <i class="fa fa-redo"></i> Restore
                                                                </button>
                                                            </form>
                                                        </c:if>
                                                        <c:if test="${isDeleted eq 'false'}">
                                                            <!-- Button trigger modal -->
                                                            <button type="button" style=" font-weight: bold" class="btn btn-primary" data-toggle="modal" data-target="#updateButton${question.questionID.trim()}">
                                                                <i class="fa fa-edit"></i>Update
                                                            </button>

                                                            <!-- Modal -->
                                                            <div class="modal fade" id="updateButton${question.questionID.trim()}" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                                                <div class="modal-dialog modal-dialog-centered" role="document">
                                                                    <div class="modal-content">
                                                                        <form action="update_question" method="GET">
                                                                            <div class="modal-header">
                                                                                <h5 class="modal-title" id="exampleModalLongTitle">Update question</h5>
                                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                                    <span aria-hidden="true">&times;</span>
                                                                                </button>
                                                                            </div>
                                                                            <c:if test="${question.isUsed eq 'false'}">
                                                                                <div class="modal-body">
                                                                                    <div class="form-group row">
                                                                                        <label for="inputQuestionID" class="col-sm-2 col-form-label col-form-label-sm">QuestionID: </label>
                                                                                        <div class="col-sm-10">
                                                                                            <input type="text" name="questionID" style="font-weight: bold" class="form-control-plaintext form-control-sm" id="${question.questionID}" readonly value="${question.questionID.trim()}">
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="form-group row">
                                                                                        <label for="inputQuestionContent" class="col-sm-2 col-form-label col-form-label-sm">Question: </label>
                                                                                        <div class="col-sm-10">
                                                                                            <input type="text" name="question_content" class="form-control form-control-sm" id="${question.question_content.trim()}" value="${question.question_content.trim()}" required>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div>
                                                                                        <div class="form-group row">
                                                                                            <label for="inputQuestionContent" class="col-sm-2 col-form-label col-form-label-sm">Question: </label>
                                                                                            <div class="col-sm-10">
                                                                                                <select name="subjectID" class="form-control form-control-sm">
                                                                                                    <c:forEach items="${applicationScope.SUBJECT}" var="subject">
                                                                                                        <c:if test="${subject.subjectID.trim() eq question.subjectID.trim()}">
                                                                                                            <option value="${subject.subjectID.trim()}">${subject.name}</option>
                                                                                                        </c:if>
                                                                                                    </c:forEach>
                                                                                                    <c:forEach items="${applicationScope.SUBJECT}" var="subject">
                                                                                                        <c:if test="${subject.subjectID.trim() ne question.subjectID.trim()}">
                                                                                                            <option value="${subject.subjectID.trim()}">${subject.name}</option>
                                                                                                        </c:if>
                                                                                                    </c:forEach>
                                                                                                </select>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div>
                                                                                        <p style="font-size: 11px;font-weight: bold;text-align: right; margin-right: 10px;">Correct Answer</p>
                                                                                    </div>
                                                                                    <c:forEach items="${question.answers}" var="answer" varStatus="counter">
                                                                                        <div class="form-group row">
                                                                                            <label for="inputAnswer${answer.answerID.trim()}" class="col-sm-3 col-form-label col-form-label-sm">Option ${counter.count}: </label>
                                                                                            <div class="col-sm-6">
                                                                                                <input type="hidden" name="answerID_content" id="${answer.answerID.trim()}_hidden" value="${answer.answerID.trim()}-${answer.answer_content.trim()}" />
                                                                                                <input type="text" class="form-control form-control-sm text-${question.questionID.trim()}" id="${answer.answerID.trim()}_input" value="${answer.answer_content.trim()}" onkeyup="change${answer.answerID.trim()}()" onchange="checkDuplicate${question.questionID.trim()}()" required>
                                                                                            </div>
                                                                                            <script>
                                                                                                function change${answer.answerID.trim()}() {
                                                                                                    var input_text = document.getElementById("${answer.answerID.trim()}_input").value;
                                                                                                    document.getElementById("${answer.answerID.trim()}_hidden").value = "${answer.answerID.trim()}-" + input_text;
                                                                                                }
                                                                                                function checkDuplicate${question.questionID.trim()}() {
                                                                                                    var array = document.getElementsByClassName("text-${question.questionID.trim()}");
                                                                                                    var count = new Int16Array(array.length);
                                                                                                    for (i = 0; i < array.length; i++) {
                                                                                                        for (j = 0; j < array.length; j++) {
                                                                                                            if (document.getElementsByClassName("text-${question.questionID.trim()}")[i].value !== "") {
                                                                                                                if (document.getElementsByClassName("text-${question.questionID.trim()}")[i].value === document.getElementsByClassName("text-${question.questionID.trim()}")[j].value) {
                                                                                                                    count[i]++;
                                                                                                                }
                                                                                                            }
                                                                                                        }
                                                                                                    }

                                                                                                    for (i = 0; i < array.length; i++) {
                                                                                                        if (count[i] > 1) {
                                                                                                            document.getElementById("button-update-${question.questionID.trim()}").disabled = true;
                                                                                                            document.getElementById("message-update-${question.questionID.trim()}").innerHTML = "You cannot input answers which are duplicated !!!";
                                                                                                            return;
                                                                                                        }
                                                                                                    }
                                                                                                    document.getElementById("button-update-${question.questionID.trim()}").disabled = false;
                                                                                                    document.getElementById("message-update-${question.questionID.trim()}").innerHTML = "";
                                                                                                }
                                                                                            </script>
                                                                                            <input type="checkbox" class="form-control-sm col-sm-3 checkbox-update-${question.questionID.trim()}" name="correct_answer" value="${answer.answerID.trim()}"<c:if test="${answer.isCorrect eq 'true'}">checked</c:if> onclick="
                                                                                                    var check_box = document.getElementsByClassName('checkbox-update-${question.questionID.trim()}');
                                                                                                    for (i = 0; i < check_box.length; i++) {
                                                                                                        if (document.getElementsByClassName('checkbox-update-${question.questionID.trim()}')[i].checked === true) {
                                                                                                            document.getElementById('button-update-${question.questionID.trim()}').disabled = false;
                                                                                                            document.getElementById('message-checkbox-${question.questionID.trim()}').style.color = 'green';
                                                                                                            document.getElementById('message-checkbox-${question.questionID.trim()}').innerHTML = ' (Complete) ';
                                                                                                            return;
                                                                                                        }
                                                                                                    }
                                                                                                    document.getElementById('button-update-${question.questionID.trim()}').disabled = true;
                                                                                                    document.getElementById('message-checkbox-${question.questionID.trim()}').style.color = 'red';
                                                                                                    document.getElementById('message-checkbox-${question.questionID.trim()}').innerHTML = ' (Incomplete) ';
                                                                                                   "/>                                                                                           
                                                                                        </div>
                                                                                    </c:forEach>
                                                                                    <p style="margin-left: 5px; font-weight: bold; color:black; font-size: 12px">* Please select at least 1 correct answer --- Status: <span id="message-checkbox-${question.questionID.trim()}" style="color:green"> (Complete) </span></p>
                                                                                </div>
                                                                            </c:if>
                                                                            <c:if test="${question.isUsed eq 'true'}">
                                                                                <p style="margin-top: 20px; margin-bottom: 20px; font-size: 14px"> Sorry!!! This question is used for quiz, so you cannot update it's information. </p>
                                                                            </c:if>
                                                                            <div class="modal-footer">
                                                                                <p id="message-update-${question.questionID.trim()}" style="margin-left: 10px; font-weight: bold; color:red; font-size: 12px"></p>
                                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                                                <c:if test="${question.isUsed eq 'false'}">
                                                                                    <input type="hidden" name="current_page" value="${current_page}" />
                                                                                    <button type="submit" id="button-update-${question.questionID.trim()}" class="btn btn-primary">Save</button>
                                                                                </c:if>
                                                                            </div>
                                                                        </form>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:if>
                                                    </td>
                                                    <td style="text-align: center">
                                                        <!-- Button trigger modal -->
                                                        <button type="button" <c:if test="${isDeleted eq 'false'}">style="background-color: #ff6666; border-color: #ff6666;  font-weight: bold "</c:if> 
                                                                <c:if test="${isDeleted}">style="background-color: gray; border-color: gray"</c:if>
                                                                class="btn btn-primary" data-toggle="modal" data-target="#deleteButton${question.questionID.trim()}" <c:if test="${isDeleted}">disabled</c:if>>
                                                                    <i class="fa fa-trash-alt"></i>Delete
                                                                </button>

                                                                <!-- Modal -->
                                                                <div class="modal fade" id="deleteButton${question.questionID.trim()}" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                                <div class="modal-content">
                                                                    <form action="delete_question" method="POST">
                                                                        <div class="modal-header">
                                                                            <h5 class="modal-title" id="exampleModalLongTitle">Delete question</h5>
                                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                                <span aria-hidden="true">&times;</span>
                                                                            </button>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <input type="hidden" name="questionID" value="${question.questionID.trim()}" />
                                                                            Do you want delete question "${question.questionID.trim()}" ?
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <input type="hidden" name="current_page" value="${current_page}" />
                                                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                                            <button type="submit" class="btn btn-primary">Delete</button>
                                                                        </div>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                            </div>
                        </c:if>
                    </c:forEach>
                    <nav aria-label="...">
                        <ul class="pagination pagination-sm">
                            <c:forEach begin="1" end="${requestScope.NUM_PAGE-1}" var="countPage">
                                <li class="page-item <c:if test="${countPage eq param.pageIndex}">active</c:if>"><a class="page-link" href="search_by_status?status=${param.status}&pageIndex=${countPage}">${countPage}</a></li>
                                </c:forEach>
                        </ul>
                    </nav>
                </div>
            </c:if>
            <!--SEARCH THEO SUBJECT-->
            <c:if test="${empty param.txtSearch && empty param.status && not empty param.subjectID}">
                <div class="view">

                    <div>
                        <c:if test="${not empty requestScope.LIST_QUESTION}">
                            <c:forEach items="${applicationScope.SUBJECT}" var="subject">
                                <c:if test="${subject.subjectID eq requestScope.LIST_QUESTION.get(0).subjectID}"><h1>${subject.subjectID} - ${subject.name}</h1></c:if>
                            </c:forEach>
                            <div class="table-responsive">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th scope="col">No.</th>
                                            <th scope="col">Question ID</th>
                                            <th scope="col">Question</th>
                                            <th scope="col">Answers</th>
                                            <th scope="col">Correct Answer</th>
                                            <th scope="col">Update</th>
                                            <th scope="col">Delete</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${requestScope.LIST_QUESTION}" var="question" varStatus="counter">
                                            <c:set value="${question.status eq 'false'}" var="isDeleted" />
                                            <tr <c:if test="${isDeleted}">class="textblur"</c:if>>
                                                <td>${counter.count}</td>
                                                <td>${question.questionID}</td>
                                                <td>${question.question_content}</td>
                                                <td>
                                                    <ul>
                                                        <c:forEach items="${question.answers}" var="answer">
                                                            <li>${answer.answer_content}</li>
                                                            </c:forEach>
                                                    </ul>
                                                </td>
                                                <td>
                                                    <ul>
                                                        <c:forEach items="${question.answers}" var="answer">
                                                            <c:if test="${answer.isCorrect eq 'true'}">
                                                                <li>${answer.answer_content}</li>
                                                                </c:if>
                                                            </c:forEach>
                                                    </ul>
                                                </td>
                                                <td style="text-align: center">
                                                    <c:if test="${isDeleted eq 'true'}">
                                                        <form action="restore_question" method="POST">
                                                            <input type="hidden" name="current_page" value="${current_page}" />
                                                            <button type="submit" style="background-color: #ffff66; border-color: #ffff66; color: black; font-weight: bold;" class="btn btn-primary" name="questionID" value="${question.questionID.trim()}">
                                                                <i class="fa fa-redo"></i> Restore
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                    <c:if test="${isDeleted eq 'false'}">
                                                        <!-- Button trigger modal -->
                                                        <button type="button" style=" font-weight: bold" class="btn btn-primary" data-toggle="modal" data-target="#updateButton${question.questionID.trim()}">
                                                            <i class="fa fa-edit"></i>Update
                                                        </button>

                                                        <!-- Modal -->
                                                        <div class="modal fade" id="updateButton${question.questionID.trim()}" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                                <div class="modal-content">
                                                                    <form action="update_question" method="GET">
                                                                        <div class="modal-header">
                                                                            <h5 class="modal-title" id="exampleModalLongTitle">Update question</h5>
                                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                                <span aria-hidden="true">&times;</span>
                                                                            </button>
                                                                        </div>
                                                                        <c:if test="${question.isUsed eq 'false'}">
                                                                            <div class="modal-body">
                                                                                <div class="form-group row">
                                                                                    <label for="inputQuestionID" class="col-sm-2 col-form-label col-form-label-sm">QuestionID: </label>
                                                                                    <div class="col-sm-10">
                                                                                        <input type="text" name="questionID" style="font-weight: bold" class="form-control-plaintext form-control-sm" id="${question.questionID}" readonly value="${question.questionID.trim()}">
                                                                                    </div>
                                                                                </div>
                                                                                <div class="form-group row">
                                                                                    <label for="inputQuestionContent" class="col-sm-2 col-form-label col-form-label-sm">Question: </label>
                                                                                    <div class="col-sm-10">
                                                                                        <input type="text" name="question_content" class="form-control form-control-sm" id="${question.question_content.trim()}" value="${question.question_content.trim()}" required>
                                                                                    </div>
                                                                                </div>
                                                                                <div>
                                                                                    <div class="form-group row">
                                                                                        <label for="inputQuestionContent" class="col-sm-2 col-form-label col-form-label-sm">Question: </label>
                                                                                        <div class="col-sm-10">
                                                                                            <select name="subjectID" class="form-control form-control-sm">
                                                                                                <c:forEach items="${applicationScope.SUBJECT}" var="subject">
                                                                                                    <c:if test="${subject.subjectID.trim() eq question.subjectID.trim()}">
                                                                                                        <option value="${subject.subjectID.trim()}">${subject.name}</option>
                                                                                                    </c:if>
                                                                                                </c:forEach>
                                                                                                <c:forEach items="${applicationScope.SUBJECT}" var="subject">
                                                                                                    <c:if test="${subject.subjectID.trim() ne question.subjectID.trim()}">
                                                                                                        <option value="${subject.subjectID.trim()}">${subject.name}</option>
                                                                                                    </c:if>
                                                                                                </c:forEach>
                                                                                            </select>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div>
                                                                                    <p style="font-size: 11px;font-weight: bold;text-align: right; margin-right: 10px;">Correct Answer</p>
                                                                                </div>
                                                                                <c:forEach items="${question.answers}" var="answer" varStatus="counter">
                                                                                    <div class="form-group row">
                                                                                        <label for="inputAnswer${answer.answerID.trim()}" class="col-sm-3 col-form-label col-form-label-sm">Option ${counter.count}: </label>
                                                                                        <div class="col-sm-6">
                                                                                            <input type="hidden" name="answerID_content" id="${answer.answerID.trim()}_hidden" value="${answer.answerID.trim()}-${answer.answer_content.trim()}" />
                                                                                            <input type="text" class="form-control form-control-sm text-${question.questionID.trim()}" id="${answer.answerID.trim()}_input" value="${answer.answer_content.trim()}" onkeyup="change${answer.answerID.trim()}()" onchange="checkDuplicate${question.questionID.trim()}()" required>
                                                                                        </div>
                                                                                        <script>
                                                                                            function change${answer.answerID.trim()}() {
                                                                                                var input_text = document.getElementById("${answer.answerID.trim()}_input").value;
                                                                                                document.getElementById("${answer.answerID.trim()}_hidden").value = "${answer.answerID.trim()}-" + input_text;
                                                                                            }
                                                                                            function checkDuplicate${question.questionID.trim()}() {
                                                                                                var array = document.getElementsByClassName("text-${question.questionID.trim()}");
                                                                                                var count = new Int16Array(array.length);
                                                                                                for (i = 0; i < array.length; i++) {
                                                                                                    for (j = 0; j < array.length; j++) {
                                                                                                        if (document.getElementsByClassName("text-${question.questionID.trim()}")[i].value !== "") {
                                                                                                            if (document.getElementsByClassName("text-${question.questionID.trim()}")[i].value === document.getElementsByClassName("text-${question.questionID.trim()}")[j].value) {
                                                                                                                count[i]++;
                                                                                                            }
                                                                                                        }
                                                                                                    }
                                                                                                }

                                                                                                for (i = 0; i < array.length; i++) {
                                                                                                    if (count[i] > 1) {
                                                                                                        document.getElementById("button-update-${question.questionID.trim()}").disabled = true;
                                                                                                        document.getElementById("message-update-${question.questionID.trim()}").innerHTML = "You cannot input answers which are duplicated !!!";
                                                                                                        return;
                                                                                                    }
                                                                                                }
                                                                                                document.getElementById("button-update-${question.questionID.trim()}").disabled = false;
                                                                                                document.getElementById("message-update-${question.questionID.trim()}").innerHTML = "";
                                                                                            }
                                                                                        </script>
                                                                                        <input type="checkbox" class="form-control-sm col-sm-3 checkbox-update-${question.questionID.trim()}" name="correct_answer" value="${answer.answerID.trim()}"<c:if test="${answer.isCorrect eq 'true'}">checked</c:if> onclick="
                                                                                                var check_box = document.getElementsByClassName('checkbox-update-${question.questionID.trim()}');
                                                                                                for (i = 0; i < check_box.length; i++) {
                                                                                                    if (document.getElementsByClassName('checkbox-update-${question.questionID.trim()}')[i].checked === true) {
                                                                                                        document.getElementById('button-update-${question.questionID.trim()}').disabled = false;
                                                                                                        document.getElementById('message-checkbox-${question.questionID.trim()}').style.color = 'green';
                                                                                                        document.getElementById('message-checkbox-${question.questionID.trim()}').innerHTML = ' (Complete) ';
                                                                                                        return;
                                                                                                    }
                                                                                                }
                                                                                                document.getElementById('button-update-${question.questionID.trim()}').disabled = true;
                                                                                                document.getElementById('message-checkbox-${question.questionID.trim()}').style.color = 'red';
                                                                                                document.getElementById('message-checkbox-${question.questionID.trim()}').innerHTML = ' (Incomplete) ';
                                                                                               "/>                                                                                        </div>
                                                                                    </c:forEach>
                                                                                <p style="margin-left: 5px; font-weight: bold; color:black; font-size: 12px">* Please select at least 1 correct answer --- Status: <span id="message-checkbox-${question.questionID.trim()}" style="color:green"> (Complete) </span></p>
                                                                            </div>
                                                                        </c:if>
                                                                        <c:if test="${question.isUsed eq 'true'}">
                                                                            <p style="margin-top: 20px; margin-bottom: 20px; font-size: 14px"> Sorry!!! This question is used for quiz, so you cannot update it's information. </p>
                                                                        </c:if>
                                                                        <div class="modal-footer">
                                                                            <p id="message-update-${question.questionID.trim()}" style="margin-left: 10px; font-weight: bold; color:red; font-size: 12px"></p>
                                                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                                            <c:if test="${question.isUsed eq 'false'}">
                                                                                <input type="hidden" name="current_page" value="${current_page}" />
                                                                                <button type="submit" id="button-update-${question.questionID.trim()}" class="btn btn-primary">Save</button>
                                                                            </c:if>
                                                                        </div>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                </td>
                                                <td style="text-align: center">
                                                    <!-- Button trigger modal -->
                                                    <button type="button" <c:if test="${isDeleted eq 'false'}">style="background-color: #ff6666; border-color: #ff6666;  font-weight: bold "</c:if> 
                                                            <c:if test="${isDeleted}">style="background-color: gray; border-color: gray"</c:if>
                                                            class="btn btn-primary" data-toggle="modal" data-target="#deleteButton${question.questionID.trim()}" <c:if test="${isDeleted}">disabled</c:if>>
                                                                <i class="fa fa-trash-alt"></i>Delete
                                                            </button>

                                                            <!-- Modal -->
                                                            <div class="modal fade" id="deleteButton${question.questionID.trim()}" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                                        <div class="modal-dialog modal-dialog-centered" role="document">
                                                            <div class="modal-content">
                                                                <form action="delete_question" method="POST">
                                                                    <div class="modal-header">
                                                                        <h5 class="modal-title" id="exampleModalLongTitle">Delete question</h5>
                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                            <span aria-hidden="true">&times;</span>
                                                                        </button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <input type="hidden" name="questionID" value="${question.questionID.trim()}" />
                                                                        Do you want delete question "${question.questionID.trim()}" ?
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <input type="hidden" name="current_page" value="${current_page}" />
                                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                                        <button type="submit" class="btn btn-primary">Delete</button>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </c:if>
                    <nav aria-label="...">
                        <ul class="pagination pagination-sm">
                            <c:forEach begin="1" end="${requestScope.NUM_PAGE-1}" var="countPage">
                                <li class="page-item <c:if test="${countPage eq param.pageIndex}">active</c:if>"><a class="page-link" href="search_by_subject?subjectID=${param.subjectID}&pageIndex=${countPage}">${countPage}</a></li>
                                </c:forEach>
                        </ul>
                    </nav>
                </div>
            </c:if>
        </div>
        <div class="footer-container">
        </div>
        <!-- Optional CSS -->
        <style>
            .view h1 {
                font-weight: bold;
                font-size: 24px;
            }

            .view table tbody{
                font-size: 12px;
            }
            .view table button{
                font-size: 12px;
            }
            .dropdown-menu {
                font-size: 14px;
                font-family: monospace;
            }

            .view .pagination {
                justify-content: center;
            }

            .footer-container {
                background-color: #e3f2fd;
                position: absolute;
                width: 100%;
                height: 300px;
                text-align: center;
            }

            .textblur {
                color: gray;
            }

            .view .table thead {
                text-align: center;
            }
            .view .table thead tr th {
                vertical-align: middle;
            }
        </style>
        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>

</html>