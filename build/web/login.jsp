<!doctype html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="en">

<head>
    <title>Login</title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>

<body>
    <div class="wrapper">
        <div class="container">
            <h1>Welcome to <span style="font-weight: bold; font-family: 'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;">QuizzerIT</span> ! </h1>
            <h5 style="color:red; font-weight: bold"><c:if test="${not empty requestScope.INVALID_USER}">${requestScope.INVALID_USER}</c:if></h5>
            <form class="form" action="login" method="POST">
                <h5 style="color:red; font-weight: bold">${requestScope.MESSAGE}</h5>
                <input type="email" name="txtEmail" value="" placeholder="Email" required>
                <input type="password" name="txtPassword" value="" placeholder="Password" required>
                <button type="submit" id="login-button">Login</button>
            </form>
            <div>
                <a href="register_page" style="position: relative; z-index: 9999999;font-weight: bold;">Sign Up</a>
            </div>
        </div>
        <ul class="bg-bubbles">
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
        </ul>
    </div>
    <!-- Optional CSS -->
    <style>
        body {
            background: aquamarine;
        }
        
        @font-face {
            font-family: 'Source Sans Pro';
            font-style: normal;
            font-weight: 200;
            src: url(https://fonts.gstatic.com/s/sourcesanspro/v14/6xKydSBYKcSV-LCoeQqfX1RYOo3i94_wlxdr.ttf) format('truetype');
        }
        
        @font-face {
            font-family: 'Source Sans Pro';
            font-style: normal;
            font-weight: 300;
            src: url(https://fonts.gstatic.com/s/sourcesanspro/v14/6xKydSBYKcSV-LCoeQqfX1RYOo3ik4zwlxdr.ttf) format('truetype');
        }
        
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-weight: 300;
        }
        
        body {
            font-family: "Source Sans Pro", sans-serif;
            color: white;
            font-weight: 300;
        }
        
        body ::-webkit-input-placeholder {
            /* WebKit browsers */
            font-family: "Source Sans Pro", sans-serif;
            color: white;
            font-weight: 300;
        }
        
        body :-moz-placeholder {
            /* Mozilla Firefox 4 to 18 */
            font-family: "Source Sans Pro", sans-serif;
            color: white;
            opacity: 1;
            font-weight: 300;
        }
        
        body ::-moz-placeholder {
            /* Mozilla Firefox 19+ */
            font-family: "Source Sans Pro", sans-serif;
            color: white;
            opacity: 1;
            font-weight: 300;
        }
        
        body :-ms-input-placeholder {
            /* Internet Explorer 10+ */
            font-family: "Source Sans Pro", sans-serif;
            color: white;
            font-weight: 300;
        }
        
        .wrapper {
            background: linear-gradient(to bottom right, #50a3a2 0%, #53e3a6 100%);
            position: absolute;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }
        
        .wrapper.form-success .container h1 {
            transform: translateY(85px);
        }
        
        .container {
            max-width: 600px;
            margin: 10% auto;
            padding: 80px 0;
            height: 400px;
            text-align: center;
        }
        
        .container h1 {
            font-size: 40px;
            transition-duration: 1s;
            transition-timing-function: ease-in-put;
            font-weight: 200;
        }
        
        form {
            padding: 20px 0;
            position: relative;
            z-index: 2;
        }
        
        form input {
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            outline: 0;
            border: 1px solid rgba(255, 255, 255, 0.4);
            background-color: rgba(255, 255, 255, 0.2);
            width: 250px;
            border-radius: 3px;
            padding: 10px 15px;
            margin: 0 auto 10px auto;
            display: block;
            text-align: center;
            font-size: 18px;
            color: white;
            transition-duration: 0.25s;
            font-weight: 300;
        }
        
        form input:hover {
            background-color: rgba(255, 255, 255, 0.4);
        }
        
        form input:focus {
            background-color: white;
            width: 300px;
            color: #53e3a6;
        }
        
        form button {
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            outline: 0;
            background-color: white;
            border: 0;
            padding: 10px 15px;
            color: #53e3a6;
            border-radius: 3px;
            width: 250px;
            cursor: pointer;
            font-size: 18px;
            transition-duration: 0.25s;
        }
        
        form button:hover {
            background-color: #f5f7f9;
        }
        
        .bg-bubbles {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1;
        }
        
        .bg-bubbles li {
            position: absolute;
            list-style: none;
            display: block;
            width: 40px;
            height: 40px;
            background-color: rgba(255, 255, 255, 0.15);
            bottom: -160px;
            -webkit-animation: square 25s infinite;
            animation: square 25s infinite;
            transition-timing-function: linear;
        }
        
        .bg-bubbles li:nth-child(1) {
            left: 10%;
        }
        
        .bg-bubbles li:nth-child(2) {
            left: 20%;
            width: 80px;
            height: 80px;
            -webkit-animation-delay: 2s;
            animation-delay: 2s;
            -webkit-animation-duration: 17s;
            animation-duration: 17s;
        }
        
        .bg-bubbles li:nth-child(3) {
            left: 25%;
            -webkit-animation-delay: 4s;
            animation-delay: 4s;
        }
        
        .bg-bubbles li:nth-child(4) {
            left: 40%;
            width: 60px;
            height: 60px;
            -webkit-animation-duration: 22s;
            animation-duration: 22s;
            background-color: rgba(255, 255, 255, 0.25);
        }
        
        .bg-bubbles li:nth-child(5) {
            left: 70%;
        }
        
        .bg-bubbles li:nth-child(6) {
            left: 80%;
            width: 120px;
            height: 120px;
            -webkit-animation-delay: 3s;
            animation-delay: 3s;
            background-color: rgba(255, 255, 255, 0.2);
        }
        
        .bg-bubbles li:nth-child(7) {
            left: 32%;
            width: 160px;
            height: 160px;
            -webkit-animation-delay: 7s;
            animation-delay: 7s;
        }
        
        .bg-bubbles li:nth-child(8) {
            left: 55%;
            width: 20px;
            height: 20px;
            -webkit-animation-delay: 15s;
            animation-delay: 15s;
            -webkit-animation-duration: 40s;
            animation-duration: 40s;
        }
        
        .bg-bubbles li:nth-child(9) {
            left: 25%;
            width: 10px;
            height: 10px;
            -webkit-animation-delay: 2s;
            animation-delay: 2s;
            -webkit-animation-duration: 40s;
            animation-duration: 40s;
            background-color: rgba(255, 255, 255, 0.3);
        }
        
        .bg-bubbles li:nth-child(10) {
            left: 90%;
            width: 160px;
            height: 160px;
            -webkit-animation-delay: 11s;
            animation-delay: 11s;
        }
        
        @-webkit-keyframes square {
            0% {
                transform: translateY(0);
            }
            100% {
                transform: translateY(-700px) rotate(600deg);
            }
        }
        
        @keyframes square {
            0% {
                transform: translateY(0);
            }
            100% {
                transform: translateY(-700px) rotate(600deg);
            }
        }
    </style>
    <!-- Optional JavaScript -->
    <script>
        $("#login-button").click(function(event) {
            event.preventDefault();

            $('form').fadeOut(500);
            $('.wrapper').addClass('form-success');
        });
    </script>
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>

</html>