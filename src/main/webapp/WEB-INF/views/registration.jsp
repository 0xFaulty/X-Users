<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Create an account</title>

    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet">
    <script src="${contextPath}/resources/js/html5shiv.min.js"></script>
    <script src="${contextPath}/resources/js/respond.min.js"></script>

</head>

<body>

<div class="container">

    <form:form method="POST" modelAttribute="userForm" class="form-signin">
        <h2 class="form-signin-heading">Create your account</h2>
        <spring:bind path="username">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="text" path="username" class="form-control" placeholder="Username" autofocus="true"/>
                <form:errors path="username"/>
            </div>
        </spring:bind>

        <spring:bind path="newPassword">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="password" path="newPassword" class="form-control" placeholder="Password"/>
                <form:errors path="newPassword"/>
            </div>
        </spring:bind>

        <spring:bind path="confirmPassword">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="password" path="confirmPassword" class="form-control"
                            placeholder="Confirm your password"/>
                <form:errors path="confirmPassword"/>
            </div>
        </spring:bind>

        <spring:bind path="firstname">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="text" path="firstname" class="form-control" placeholder="Firstname"/>
                <form:errors path="firstname"/>
            </div>
        </spring:bind>

        <spring:bind path="lastname">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="text" path="lastname" class="form-control" placeholder="Lastname"/>
                <form:errors path="lastname"/>
            </div>
        </spring:bind>

        <spring:bind path="email">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="text" path="email" class="form-control" placeholder="Email"/>
                <form:errors path="email"/>
            </div>
        </spring:bind>

        <spring:bind path="birthdayString">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="text" path="birthdayString" class="form-control" placeholder="Birthday (yyyy-mm-dd)"/>
                <form:errors path="birthdayString"/>
            </div>
        </spring:bind>

        <button class="btn btn-lg btn-primary btn-block" type="submit">Submit</button>
        <br/>
        <div><a href="${contextPath}/login" title="back">back</a></div>
    </form:form>

</div>
<!-- /container -->
<script src="${contextPath}/resources/js/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>