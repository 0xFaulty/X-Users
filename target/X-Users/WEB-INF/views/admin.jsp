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

    <title>Admin</title>

    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet">
    <script src="${contextPath}/resources/js/html5shiv.min.js"></script>
    <script src="${contextPath}/resources/js/respond.min.js"></script>

</head>

<body>
<div class="container">

    <div class="container">
        <c:if test="${pageContext.request.userPrincipal.name != null}">
            <form id="logoutForm" method="post" action="${contextPath}/logout">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            </form>
            <h2>Admin Page ${pageContext.request.userPrincipal.name} | <a
                    onclick="document.forms['logoutForm'].submit()">Logout</a>
            </h2>
        </c:if>
    </div>

    <c:url var="addAction" value="/admin/add"/>

    <form:form action="${addAction}" method="POST" modelAttribute="adminEditForm" class="form-signin">
        <div class="page-header">
            <c:if test="${empty adminEditForm.id}"><h2 class="form-signin-heading">Add a User</h2></c:if>
            <c:if test="${!empty adminEditForm.id}"><h2 class="form-signin-heading">Edit a User</h2></c:if>
        </div>
        <c:if test="${!empty adminEditForm.id}">
            <spring:bind path="id">
                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <form:input path="id" readonly="true" size="8" class="form-control"/>
                    <form:hidden path="id"/>
                    <form:errors path="id"/>
                </div>
            </spring:bind>
        </c:if>

        <spring:bind path="username">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <c:if test="${empty adminEditForm.id}">
                    <form:input type="text" path="username" class="form-control" placeholder="Username"
                                autofocus="true"/>
                </c:if>
                <c:if test="${!empty adminEditForm.id}">
                    <form:input type="text" path="username" class="form-control" placeholder="Username"
                                readonly="true"/>
                </c:if>
                <form:errors path="username"/>
            </div>
        </spring:bind>

        <spring:bind path="newPassword">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <c:if test="${empty adminEditForm.id}">
                    <form:input type="password" path="newPassword" class="form-control" placeholder="Password"/>
                </c:if>
                <c:if test="${!empty adminEditForm.id}">
                    <form:input type="password" path="newPassword" class="form-control" placeholder="*********"/>
                </c:if>
                <form:errors path="newPassword"/>
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

        <spring:bind path="active">
            <form:label path="active">
                <form:checkbox path="active"/>
                Is active
            </form:label>
        </spring:bind>

        <c:if test="${empty adminEditForm.id}">
            <button class="btn btn-lg btn-primary btn-block" type="submit">Add User</button>
        </c:if>
        <c:if test="${!empty adminEditForm.id}">
            <button class="btn btn-lg btn-primary btn-block" type="submit">Edit User</button>
            <br/>
            <div><a href="${contextPath}/admin" title="add user">add user</a></div>
        </c:if>

    </form:form>

    <div class="page-header"><h1> User List </h1></div>
    <div class="panel">
        <table class="table table-striped">
            <thead>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Firstname</th>
                <th>Lastname</th>
                <th>Email</th>
                <th>Active</th>
                <th>Birthday</th>
                <th>Created</th>
                <th>Last Update</th>
                <th>Address</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${listUsers}" var="adminEditForm">
                <tr>
                    <td>${adminEditForm.id}</td>
                    <td>${adminEditForm.username}</td>
                    <td>${adminEditForm.firstname}</td>
                    <td>${adminEditForm.lastname}</td>
                    <td>${adminEditForm.email}</td>
                    <td>${adminEditForm.active}</td>
                    <td>${adminEditForm.birthday}</td>
                    <td>${adminEditForm.createdTimestamp}</td>
                    <td>${adminEditForm.lastUpdatedTimestamp}</td>
                    <td><a href="<c:url value='/admin/addresses/${adminEditForm.id}'/>">View</a></td>
                    <td><a href="<c:url value='/admin/remove/${adminEditForm.id}'/>">Delete</a></td>
                    <c:if test="${adminEditForm.active eq true}">
                        <td><a href="<c:url value='/admin/activetoggle/${adminEditForm.id}'/>">Block</a></td>
                        <td><a href="<c:url value='/admin/edit/${adminEditForm.id}'/>">Edit</a></td>
                    </c:if>
                    <c:if test="${adminEditForm.active ne true}">
                        <td><a href="<c:url value='/admin/activetoggle/${adminEditForm.id}'/>">Activate</a></td>
                        <td></td>
                    </c:if>

                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<!-- /container -->
<script src="${contextPath}/resources/js/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>