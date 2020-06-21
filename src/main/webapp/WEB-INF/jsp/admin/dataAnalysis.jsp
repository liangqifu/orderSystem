<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/jsp/common/htmlBase.jsp"%>

<script type="text/javascript">
        var date="";
        $(function () {
        	initDaterangepicker();
            showPie();
            showHorizontalBar();
            $("#pieChartForm").find("select[name='categoryId']").on('change',function(){
            	showPie()
            });
            $("#barChartForm").find("select[name='categoryId']").on('change',function(){
            	showBarChart()
            }); 
            
        });

        function showPie() {
        	var params = $("#pieChartForm").serializeJSON();
            $.ajax({
                type : "POST",
                dataType : 'json',
                url  : "${APP_PATH}/chart/proTypePie",
                data:JSON.stringify(params),
                contentType:"application/json",
                success : function(result) {
                    if ( result.code==100 ) {
                        var datas =result.extend.chartDatas;
                        buidPieChart(datas);
                    }
                }
            });
        }
        function buidPieChart(datas) {
            // 初始化echarts实例
            var arrayName = new Array();
            var arrayData = new Array();
            $.each( datas, function( index, data ){
            	arrayName.push(data.name);
            	arrayData.push({value:data.value,name:data.name});
            });
            var dom = document.getElementById("pieChart");
            var myChart = echarts.init(dom);
            var app = {};
            option = null;
            option = {
                title : {
                    text: $.i18n.prop('salesOfVariousCommodities'),
                    subtext: $.i18n.prop('totalSalesVolume'),
                    x:'center'
                },
                tooltip : {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                legend: {
                    orient: 'vertical',
                    left: 'left',
                    data: arrayName
                },
                series : [
                    {
                        name: $.i18n.prop('salesVolume'),
                        type: 'pie',
                        radius : '55%',
                        center: ['50%', '60%'],
                        data:arrayData,
                        itemStyle: {
                            emphasis: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };
            if (option && typeof option === "object") {
                myChart.setOption(option, true);
            }
        }
        function showBarChart() {
        	var params={
        			categoryId: $("#barChartForm").find("select[name='categoryId']").val(),
        			year:moment($('#barChartFormDatepicker').datepicker('getDate')).format('YYYY')
        	}
        	
            $.ajax({
                type : "POST",
                dataType : 'json',
                url  : "${APP_PATH}/chart/barData",
                data:JSON.stringify(params),
                contentType:"application/json",
                success : function(result) {
                    if ( result.code==100 ) {
                        buildBarChart(result.extend.barData);
                    }
                }
            });
        }
        function buildBarChart(datas) {
            var dom = document.getElementById("barChart");
            var myChart = echarts.init(dom);
            var app = {};
            var option = null;
            app.title = $.i18n.prop('app-title-bar-line');
            var xAxisData = [];
            xAxisData.push($.i18n.prop('monthNames-1'));
            xAxisData.push($.i18n.prop('monthNames-2'));
            xAxisData.push($.i18n.prop('monthNames-3'));
            xAxisData.push($.i18n.prop('monthNames-4'));
            xAxisData.push($.i18n.prop('monthNames-5'));
            xAxisData.push($.i18n.prop('monthNames-6'));
            xAxisData.push($.i18n.prop('monthNames-7'));
            xAxisData.push($.i18n.prop('monthNames-8'));
            xAxisData.push($.i18n.prop('monthNames-9'));
            xAxisData.push($.i18n.prop('monthNames-10'));
            xAxisData.push($.i18n.prop('monthNames-11'));
            xAxisData.push($.i18n.prop('monthNames-12'));
            option = {
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'cross',
                        crossStyle: {
                            color: '#999'
                        }
                    }
                },
                toolbox: {
                    feature: {
                        dataView: {show: true, readOnly: false},
                        magicType: {show: true, type: ['line', 'bar']},
                        restore: {show: true},
                        saveAsImage: {show: true}
                    }
                },
                legend: {
                    data:datas.items
                },
                xAxis: [
                    {
                        type: 'category',
                        data: xAxisData,
                        axisPointer: {
                            type: 'shadow'
                        }
                    }
                ],
                yAxis: [
                    {
                        type: 'value',
                        name: $.i18n.prop('quantity'),
                        min: 0,
                        max: datas.YAxis.maxCount,
                        interval: 50,
                        axisLabel: {
                            formatter: '{value} '
                        }
                    },
                    {
                        type: 'value',
                        name: $.i18n.prop('sales-amount'),
                        min: 0,
                        max: datas.YAxis.saleMax,
                        interval: 1000,
                        axisLabel: {
                            formatter: '{value} '
                        }
                    }
                ],
                series: datas.seriesData
            };
            ;
            if (option && typeof option === "object") {
                myChart.setOption(option, true);
            }
        }

        function showHorizontalBar() {
        	var params = $("#horBarForm").serializeJSON();
        	//params.categoryId = 1;
            $.ajax({
                type : "POST",
                dataType : 'json',
                url  : "${APP_PATH}/chart/horBarData",
                data:JSON.stringify(params),
                contentType:"application/json",
                success : function(result) {
                    if ( result.code==100 ) {
                        buildHorizontalBar(result.extend.datas);
                    }
                }
            });
        }
        function buildHorizontalBar(datas) {
            var dom = document.getElementById("horizontalBar");
            var cDate =$("#horBarForm").find("input[name='startDate']").val() + "~" + $("#horBarForm").find("input[name='endDate']").val()+$.i18n.prop('datas');
            var myChart = echarts.init(dom);
            var app = {};
            option = null;
            app.title = $.i18n.prop('app-title');

            option = {
                title: {
                    text: $.i18n.prop('app-title-1')+datas.total,
                    subtext: cDate
                },
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'shadow'
                    }
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                },
                xAxis: {
                    type: 'value',
                    boundaryGap: [0, 0.01]
                },
                yAxis: {
                    type: 'category',
                    data: datas.nameList
                },
                series: [
                    {
                        type: 'bar',
                        data: datas.valueList
                    }
                ]
            };
            ;
            if (option && typeof option === "object") {
                myChart.setOption(option, true);
            }
        }
        function initDaterangepicker(){
        	 var daysOfWeek = [];
             daysOfWeek.push($.i18n.prop('daterangepicker-daysOfWeek-1'))
             daysOfWeek.push($.i18n.prop('daterangepicker-daysOfWeek-2'))
             daysOfWeek.push($.i18n.prop('daterangepicker-daysOfWeek-3'))
             daysOfWeek.push($.i18n.prop('daterangepicker-daysOfWeek-4'))
             daysOfWeek.push($.i18n.prop('daterangepicker-daysOfWeek-5'))
             daysOfWeek.push($.i18n.prop('daterangepicker-daysOfWeek-6'))
             daysOfWeek.push($.i18n.prop('daterangepicker-daysOfWeek-7'))
             
             var monthNames = [];
             monthNames.push($.i18n.prop('daterangepicker-monthNames-1'))
             monthNames.push($.i18n.prop('daterangepicker-monthNames-2'))
             monthNames.push($.i18n.prop('daterangepicker-monthNames-3'))
             monthNames.push($.i18n.prop('daterangepicker-monthNames-4'))
             monthNames.push($.i18n.prop('daterangepicker-monthNames-5'))
             monthNames.push($.i18n.prop('daterangepicker-monthNames-6'))
             monthNames.push($.i18n.prop('daterangepicker-monthNames-7'))
             monthNames.push($.i18n.prop('daterangepicker-monthNames-8'))
             monthNames.push($.i18n.prop('daterangepicker-monthNames-9'))
             monthNames.push($.i18n.prop('daterangepicker-monthNames-10'))
             monthNames.push($.i18n.prop('daterangepicker-monthNames-11'))
             monthNames.push($.i18n.prop('daterangepicker-monthNames-12'))
             var locale = {
                     "format": $.i18n.prop('daterangepicker-format'),
                     "separator": " - ",
                     "applyLabel": $.i18n.prop('daterangepicker-applyLabel'),
                     "cancelLabel": $.i18n.prop('daterangepicker-cancelLabel'),
                     "fromLabel": $.i18n.prop('daterangepicker-fromLabel'),
                     "toLabel": $.i18n.prop('daterangepicker-toLabel'),
                     "customRangeLabel": $.i18n.prop('daterangepicker-customRangeLabel'),
                     "daysOfWeek": daysOfWeek,
                     "monthNames": monthNames
                 };
             var ranges = {};
             ranges[$.i18n.prop('daterangepicker-ranges-today')]=[moment(),moment()];
             ranges[$.i18n.prop('daterangepicker-ranges-week')]=[moment().startOf('week'), moment().endOf('week')];
             ranges[$.i18n.prop('daterangepicker-ranges-last-week')]=[moment().week(moment().week() -1).startOf('week'), moment().week(moment().week()-1).endOf('week')],
             ranges[$.i18n.prop('daterangepicker-ranges-this-month')]=[moment().startOf('month'), moment().endOf('month')];
             ranges[$.i18n.prop('daterangepicker-ranges-last-month')]=[moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')];
             ranges[$.i18n.prop('daterangepicker-ranges-this-year')]=[moment().startOf('year'), moment().endOf('year')];
             ranges[$.i18n.prop('daterangepicker-ranges-last-year')]=[moment().year(moment().year() -1).startOf('year'), moment().year(moment().year() -1).endOf('year')];
             $("#pieChartFormDaterangepicker").daterangepicker(
    	    		 {
    	    			timePicker24Hour:true,
    	    	        autoUpdateInput: false,
    	    	        startDate: moment().startOf('year').format('YYYY-MM-DD'),
    	    	        endDate:moment().endOf('year').format('YYYY-MM-DD'),
    	    	        drops:'down',
    	    	        opens: 'right', //日期选择框的弹出位置
    	    	        buttonClasses: ['btn btn-default'],
    	    	        applyClass: 'btn-small btn-primary blue',
    	    	        cancelClass: 'btn-small',
    	    	        ranges: ranges,
    	    	        locale: locale
    	    	     }
 		   	     ).on('cancel.daterangepicker', function(ev, picker) {
 		   	     }).on('apply.daterangepicker', function(ev, picker) {
	                $("#pieChartForm").find("input[name='startDate']").val(picker.startDate.format('YYYY-MM-DD'));
	                $("#pieChartForm").find("input[name='endDate']").val(picker.endDate.format('YYYY-MM-DD'));
	                $("#pieChartForm #pieChartFormDaterangepicker").val(picker.startDate.format($.i18n.prop('daterangepicker-format'))+" - "+picker.endDate.format($.i18n.prop('daterangepicker-format')));
	                showPie()
 		   	 });
             
             $("#pieChartForm").find("input[name='startDate']").val(moment().startOf('year').format('YYYY-MM-DD'));
             $("#pieChartForm").find("input[name='endDate']").val(moment().endOf('year').format('YYYY-MM-DD'));
             $("#pieChartForm #pieChartFormDaterangepicker").val(moment().startOf('year').format('YYYY-MM-DD')+" - "+moment().endOf('year').format('YYYY-MM-DD'));
             
             
             
             $("#horBarFormDaterangepicker").daterangepicker(
    	    		 {
    	    			timePicker24Hour:true,
    	    	        autoUpdateInput: false,
    	    	        startDate: moment().startOf('year').format('YYYY-MM-DD'),
    	    	        endDate:moment().endOf('year').format('YYYY-MM-DD'),
    	    	        drops:'down',
    	    	        opens: 'right', //日期选择框的弹出位置
    	    	        buttonClasses: ['btn btn-default'],
    	    	        applyClass: 'btn-small btn-primary blue',
    	    	        cancelClass: 'btn-small',
    	    	        ranges: ranges,
    	    	        locale: locale
    	    	     }
 		   	     ).on('cancel.daterangepicker', function(ev, picker) {
 		   	     }).on('apply.daterangepicker', function(ev, picker) {
	                $("#horBarForm").find("input[name='startDate']").val(picker.startDate.format('YYYY-MM-DD'));
	                $("#horBarForm").find("input[name='endDate']").val(picker.endDate.format('YYYY-MM-DD'));
	                $("#horBarForm #horBarFormDaterangepicker").val(picker.startDate.format($.i18n.prop('daterangepicker-format'))+" - "+picker.endDate.format($.i18n.prop('daterangepicker-format')));
	                showHorizontalBar()
 		   	 });
             
             $("#horBarForm").find("input[name='startDate']").val(moment().startOf('year').format('YYYY-MM-DD'));
             $("#horBarForm").find("input[name='endDate']").val(moment().endOf('year').format('YYYY-MM-DD'));
             $("#horBarForm #horBarFormDaterangepicker").val(moment().startOf('year').format('YYYY-MM-DD')+" - "+moment().endOf('year').format('YYYY-MM-DD'));
             
            $('#barChartFormDatepicker').datepicker({
           	   format: 'yyyy',
           	   autoclose:true,
           	   startView: 2,
           	   minViewMode: 2,
           	   maxViewMode: 2
           	}).on('changeDate',function(){
           		showBarChart();
           	});;
            $('#barChartFormDatepicker').datepicker('setDate', new Date());
        }
        
    </script>

<body>
        <div>
          
          <h1 class="page-header i18n"  data-properties="mean_102" data-ptype="text" ></h1>
          <div class="row placeholders">
            <div class="col-xs-6 col-sm-3 placeholder" style="width:100%;height:100%">
              
              <div style="float: left;width: 50%">
                <form id="pieChartForm" class="form-inline">
	                 <div class="form-group" style="width: 100%">
						<div class="col-sm-4">
						   <select class="form-control" name="categoryId" style="width: 100%;">
						      <c:forEach items="${categoryList}" var="item">
							      <c:if test="${item.id !=3 }">
							           <option value="${item.id}">${item.name}</option>
							      </c:if>
						      </c:forEach>
						   </select>
						</div>
						<div class="col-sm-4">
						    <input type="text" id="pieChartFormDaterangepicker" readonly="readonly" class="form-control i18n" data-properties="pleaseSelectDate" data-ptype="placeholder" >
				            <input type="hidden"  name="startDate" class="form-control" />
				            <input type="hidden"  name="endDate" class="form-control" /> 
						</div>
					  </div>
					  
                 </form>
                 <h1></h1>
                 <div id="pieChart" class="col-xs-6 col-sm-3 placeholder" style="width: 100%;height:350px;"></div>
              </div>
              
             
              <div style="float: left;width: 50%" >
                 <form id="horBarForm" class="form-inline">
	                 <div class="form-group" style="width: 100%">
						<%-- <div class="col-sm-4">
						   <select class="form-control" name="categoryId" style="width: 100%;">
						      <option></option>
						      <c:forEach items="${categoryList}" var="item">
						           
						           <option value="${item.id}">${item.name}</option>
						      </c:forEach>
						   </select>
						</div> --%>
						<div class="col-sm-4">
						    <input type="text" id="horBarFormDaterangepicker" readonly="readonly" class="form-control i18n" data-properties="pleaseSelectDate" data-ptype="placeholder" >
				            <input type="hidden"  name="startDate" class="form-control" />
				            <input type="hidden"  name="endDate" class="form-control" /> 
						</div>
					  </div>
                 </form>
                 <h1></h1>
                <div id="horizontalBar" class="col-xs-6 col-sm-3 placeholder" style="width: 100%;height:350px;"></div>
              </div>
            </div>
            <div class="col-xs-6 col-sm-3 placeholder" style="width: 100%;">
              <h3 >
                <span class="i18n" data-properties="sales-trend" data-ptype="text"></span>
                <small class="i18n" data-properties="quantity-and-amount" data-ptype="text" ></small>
              </h3>
              
            </div>
            
            <div>
                <form id="barChartForm" class="form-inline">
	                 <div class="form-group" style="width: 100%">
		                 <div class="col-sm-2">
							   <select class="form-control" name="categoryId" style="width: 100%;">
							      <c:forEach items="${categoryList}" var="item">
							           <c:if test="${item.id !=3 }">
							                <option value="${item.id}">${item.name}</option>
							           </c:if>
							      </c:forEach>
							   </select>
						 </div>
						<div class="col-sm-1">
						    <input style="width: 100%" type="text" name="year" id="barChartFormDatepicker" readonly="readonly" class="form-control i18n" data-properties="pleaseSelectYear" data-ptype="placeholder" >
						</div>
					  </div>
                 </form>
                 <h1></h1>
            
	            <div id="barChart" class="col-xs-6 col-sm-3 placeholder" style="width: 100%;height:500px;">
	            </div>
            </div>
            
          </div>
        </div>
</body>
</html>