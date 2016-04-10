<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="section" value="${gradeSheet.section}"/>

<style>
    .mark-attended {
        background: lightgreen;
    }

    .mark-missed {
        background: darkred;
    }
</style>

<script>
    $(function () {

        $('#studentsForm').on('click', 'td.mark-event', function (e) {
            var td = $(this), attended = -1;

            if (td.hasClass("mark-attended")) {
                // green --> red
                td.addClass("mark-missed").removeClass("mark-attended");
                attended = 0;
            } else if (td.hasClass("mark-missed")) {
                // red --> white
                td.removeClass("mark-missed");
                attended = -1;
            } else {
                // white --> green
                td.addClass("mark-attended");
                attended = 1;
            }

            var data = {
                userId: td.data('user'),
                sectionId: ${section.id},
                parentId: td.data('parent'),
                eventId: td.data('event'),
                attended: attended
            };

            var url = '<c:url value="/section/userEvent.html" />?userId='
                    + data.userId
                    + '&eventId=' + data.eventId
                    + '&attended=' + data.attended
                    + '&parentId=' + data.parentId
                    + '&sectionId=' + data.sectionId;

            console.log(url, data);

            $.ajax({
                url: url,
                cache: false,
                data: data
            });

        });

    });
</script>

<ul id="title">
    <li><a class="bc" href="<c:url value='/section/search' />">Sections</a></li>
    <c:if test="${not empty dept}">
        <li><a class="bc"
               href="<c:url value='/department/${dept}/sections?quarter=${section.quarter.code}' />">${fn:toUpperCase(dept)}</a>
        </li>
    </c:if>
    <li>${section.course.code}, ${section.quarter}</li>
</ul>

<p>Total Students: ${fn:length(gradeSheet.studentGrades)}</p>

<form id="eventForm" method="post" action="<c:url value="/section/addEvent.html" />">
    <input name=id value="${section.id}" type="hidden"/>
    <input name="name"/>
    <input type="submit" value="Add Event"/>
</form>

<form id="studentsForm" method="post">
    <table class="viewtable">
        <thead>
        <tr>
            <th>Student</th>
            <c:forEach items="${section.events}" var="e">
                <th>${e.name}</th>
            </c:forEach>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${gradeSheet.studentGrades}" var="studentGrade">
            <c:set var="enrollment" value="${studentGrade.key}"/>
            <tr>
                <td>
                    <a href="<c:url value='/section/grade?enrollmentId=${enrollment.id}' />">${enrollment.student.lastName},
                            ${enrollment.student.firstName}</a></td>

                <c:forEach items="${section.events}" var="e">
                    <c:set var="cls" value="mark-nothing"/>
                    <c:set var="eId" value=""/>
                    <c:forEach items="${enrollment.student.events}" var="evt">
                        <c:if test="${e.id eq evt.parent}">
                            ${evt.parent}
                            <c:set var="eId" value="${evt.id}"/>
                            <%--${evt.name}--%>

                            <c:if test="${empty evt.missed}">
                                <c:set var="cls" value="mark-attended"/>
                            </c:if>
                            <c:if test="${not empty evt.missed}">
                                <c:set var="cls" value="mark-missed"/>
                            </c:if>
                        </c:if>
                    </c:forEach>
                    <td class="center mark-event ${cls}" data-parent="${e.id}" data-event="${eId}" data-user="${enrollment.student.id}">
                        ${evt.missed}
                    </td>
                </c:forEach>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <input type="hidden" name="backUrl" value="/department/${dept}/section?id=${section.id}"/>
</form>
