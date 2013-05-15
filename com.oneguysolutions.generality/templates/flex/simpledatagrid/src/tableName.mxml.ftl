<?xml version="1.0" encoding="utf-8"?>
<!--
	Main application MXML file.
	MXML defines the UI layout of your application as well as the connection of UI components
	to your data source (via data binding) and the ActionScript event handlers that
	implement your application's UI logic.
	The MXML file that starts with an <mx:Application> tag is the main source code file
	for your Flex application.
-->
<mx:Application xmlns:mx="http://www.adobe.com/2006/mxml" layout="absolute" pageTitle="${tableName}" 
	creationComplete="initApp()" backgroundGradientColors="[#ffffff, #ffffff]">

	<!-- 
		Externalized script "include" tag.
		This file contains the UI logic for the CRUD application.  All application logic
		in Flex is written in ActionScript, the same language used by Flash.
		Although all of this code could have been included directly in the mx:Script tag
		within this file, we recommend externalizing it for clarity.
	-->
    <mx:Script source="${tableName}Script.as" />

	<!--
		The tags below define the application's UI components and their initial properties.
		Every tag can be accessed in ActionScript via its "id" property, similar to HTML tags
		accessed via JavaScript.
		Note that unlike HTML, Flex does not use a flow-based model.  With the exception of
		some containers, Flex controls are positioned on the page using their width and height
		properties, so the order of the tags in the file does not affect the layout.
	-->
	<mx:ViewStack id="applicationScreens" width="100%" height="100%">
		<mx:Canvas id="view" width="100%" height="100%">

		<!--
			This DataGrid is bound to a data provider, the object "dataArr" which is
			instantiated in the included script file.  In general, data providers are collections
			such as Array, ArrayCollection, XMLObject, etc. that are declared with the [Bindable]
			tag and set as the "dataProvider" property of a UI component.  When the data in
			a data provider changes, Flex will automatically update any bound UI components
			with the new data.
		-->
		<mx:DataGrid id="dataGrid"
			dataProvider="{dataArr}"
			rowCount="8"
			editable="true"
			resizableColumns="true" 
			headerRelease="setOrder(event);"
			right="10" left="10" top="10" bottom="71">
				<mx:columns>
					<#list columns as column>
						<mx:DataGridColumn headerText="${column.columnName}" dataField="${column.columnName}Col" />
					</#list>
				</mx:columns>
		</mx:DataGrid>

		<!--
			These Buttons call ActionScript functions defined in
			employeesScript.as when they are clicked (as defined by the "click"
			event on the tag).  In general, UI event handling in Flex is done by assigning
			handler functions to the events on the UI component.
		-->
		<mx:Button id="btnAddNew" click="goToUpdate()" icon="@Embed('icons/AddRecord.png')" toolTip="Add Record" x="10" bottom="10"/>
		<mx:Button id="btnDelete" click="deleteItem()" icon="@Embed('icons/DeleteRecord.png')" toolTip="Delete Record" x="58" bottom="10"/>
		<mx:Label text="Search by nombre_usuario" right="300" bottom="11"/>
		<mx:TextInput id="filterTxt" width="238" toolTip="Search by nombre_usuario" enter="filterResults()" right="58" bottom="11"/>
		<mx:Button click="filterResults()" id="filterButton" icon="@Embed('icons/SearchRecord.png')" toolTip="Search by nombre_usuario" right="10" bottom="10"/>

	</mx:Canvas>

	<mx:Canvas id="update" width="100%" height="100%">
		<mx:Form width="100%" height="80%" id="${tableName}Form">
			<#list columns as column>
                    <mx:FormItem label="${column.columnName?cap_first}:" id="${column.columnName}_form">
                        <mx:TextInput id="${column.columnName}Col" text=""/>
                    </mx:FormItem>
            </#list>
		</mx:Form>
		<mx:Button label="Save" id="btnSubmit" click="insertItem()" right="81" bottom="10"/>
		<mx:Button label="Cancel" id="btnCancel" click="goToView()" right="10" bottom="10"/>
	</mx:Canvas>

	</mx:ViewStack>
</mx:Application>
