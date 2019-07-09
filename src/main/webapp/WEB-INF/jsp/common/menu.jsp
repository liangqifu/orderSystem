<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul style="padding-left:0px;" class="list-group">
	<c:forEach items="${rootPermission.children}" var="permission">
		<c:if test="${empty permission.children}">
			<li class="list-group-item tree-closed"  >
				<a href="javacript:void(0);" url="${APP_PATH}${permission.url}" ><i class="${permission.icon}"></i> ${permission.name}</a>
			</li>
		</c:if>
		<c:if test="${not empty permission.children}">
			<li class="list-group-item tree-closed">
				<span><i class="${permission.icon}"></i> ${permission.name} <span class="badge" style="float:right">${permission.children.size()}</span></span>
				<ul style="margin-top:10px;display:none;">
					<c:forEach items="${permission.children}" var="child">
						<li style="height:30px;">
							<a href="javacript:void(0);" url="${APP_PATH}${child.url}"><i class="${child.icon}"></i> ${child.name}</a>
						</li>
					</c:forEach>
				</ul>
			</li>
		</c:if>
	</c:forEach>
</ul>

<script type="text/javascript">
	  $(function () {
	     $(".list-group-item").click(function(){
	        if ( $(this).find("ul") ) { // 3 li
	            
	        	 $(this).toggleClass("tree-closed");
	             if ( $(this).hasClass("tree-closed") ) {
	                $("ul", this).hide("fast");
	            } else {
	            	$("ul", this).show("fast");
	            }
	        }
	     });  
	     
	     $(".list-group a").on("click",function(){
	    	 var url = $(this).attr('url');
	    	 $("#mainIframe").attr('src',url);
	     })
	     
	     
	   });
	</script>

