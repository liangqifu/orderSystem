<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul style="padding-left:0px;" class="list-group">
	<c:forEach items="${rootPermission.children}" var="permission">
		
		<c:if test="${empty permission.children}">
			<li class="list-group-item tree-closed" url="${APP_PATH}${permission.url}" >
				<a style="cursor: pointer;"><i style="cursor: pointer;" class="${permission.icon} i18n" data-properties="${permission.no}" data-ptype="text" ></i></a>
			</li>
		</c:if>
		
		<c:if test="${not empty permission.children}">
			<li class="list-group-item tree-closed" >
				<span><i style="cursor: pointer;" class="${permission.icon} i18n" data-properties="${permission.no}" data-ptype="text" ></i><span class="badge" style="float:right">${permission.children.size()}</span></span>
				<ul style="margin-top:10px;display: none;" class="nav nav-pills nav-stacked">
					<c:forEach items="${permission.children}" var="child" varStatus="status">
						<li url="${APP_PATH}${child.url}">
							<a  style="cursor: pointer;"><i style="cursor: pointer;" class="${child.icon} i18n" data-properties="${child.no}" data-ptype="text" ></i></a>
						</li>
					</c:forEach>
				</ul>
			</li>
		</c:if>
		
		
	</c:forEach>
	
</ul>

<script type="text/javascript">
	  $(function () {
	     $(".list-group-item i").click(function(){
	    	 if($(this).parent().parent().find('ul')){
	    		 $(this).parent().parent().toggleClass("tree-closed");
	    		 if ($(this).parent().parent().hasClass("tree-closed") ) {
	    			  $(this).parent().parent().find('ul').hide();
		            } else {
		              $(this).parent().parent().find('ul').show();
		            }
	    	 }
	     });  
	     
	    
	     $(".list-group li").on("click",function(){
	    	 if($(this).parent().hasClass('nav')){
	    		 $(".list-group li").removeClass('active')
	    		 $(this).addClass('active')
	    	 }
	    	 var url = $(this).attr('url');
	    	 $("#mainIframe").attr('src',url);
	     })
	     $($(".list-group-item i")[0]).trigger("click")
	     $($(".list-group ul.nav li")[0]).trigger("click")
	     
	   });
	</script>

