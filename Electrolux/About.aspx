<!DOCTYPE html>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="Kendo/styles/kendo.common.min.css" />
    <link rel="stylesheet" href="Kendo/styles/kendo.default.min.css" />
    
	<link href="Kendo/styles/kendo.mobile.min.css" rel="stylesheet" type="text/css" />

    <script src="Kendo/js/jquery.min.js"></script>
    <script src="Kendo/js/kendo.all.min.js"></script>
</head>
<body>
    <div data-role="view" data-init="mobileListViewEndlessScrolling" data-title="Scroll down to load">
    <header data-role="header">
        <div data-role="navbar">
            <span data-role="view-title"></span>
            <a data-align="right" data-role="button" class="nav-button" href="#/">Index</a>
        </div>
    </header>

    <ul id="endless-scrolling"></ul>
	<p style=" text-align: center;"><a   data-role="button" data-click="addItem">Add item</a></p>
	
</div>

<script type="text/x-kendo-tmpl" id="endless-scrolling-template">
    <div class="product">
        <h3>#:ProductName#</h3>
        <p>#:kendo.toString(UnitPrice, "c")#</p>
    </div>
</script>

<script>
	var max = 0;
	var data = [];
	function addItem() {
		
		for (i = 0; i < 10; i++) {
			var t = max + i;
			data.push({ ProductID: t, ProductName: 'prueba' + t, UnitPrice: 10 });
		}
		//$("#endless-scrolling").data("kendoMobileListView").append(data);
		max = max + 10;
		$("#endless-scrolling").data("kendoMobileListView").setDataSource(data);
	}

	function mobileListViewEndlessScrolling() {

		$("#endless-scrolling").kendoMobileListView({
			template: $("#endless-scrolling-template").text(),
			filterable: {
				field: "ProductName",
				operator: "contains"
			}
		});
		addItem();
	}
</script>

<style scoped>
    .product h3 {
        font-size: 1.3em;
        font-weight: normal;
        line-height: 1.4em;
        margin: 0;
        padding: .5em 0 0;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
    }
    .product p {
        font-size: 1em;
        margin: 0;
        padding: .3em 0 0;
    }
    .pullImage {
        width: 64px;
        height: 64px;
        border-radius: 3px;
        float: left;
        margin-right: 1em;
    }
</style>


<script>
	var app = new kendo.mobile.Application(document.body);
</script>
</body>
</html>