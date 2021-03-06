<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0" />
		<title>Worden - Identify Anonymous Document</title>
		<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
		<link href="<c:url value='/static/css/materialize.css' />" rel="stylesheet" />
		<link href="<c:url value='/static/css/bigfoot-default.css' />" rel="stylesheet" />
		<link href="<c:url value='/static/css/hint.css' />" rel="stylesheet" />
		<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.5/angular.min.js "></script>
		<script src="<c:url value='/static/js/ng-file-upload.js' />" ></script>
		<script src="<c:url value='/static/js/identifyUploadController.js' />"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.1/Chart.min.js"></script>
		<link href="<c:url value='/static/css/style.css' />" rel="stylesheet" rel="stylesheet" />
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
	</head>

	<body ng-app="fileUpload" ng-controller="identifyUploadController">
		<header>
			<nav class="white" role="navigation">
				<div class="nav-wrapper" style="margin-left: 1em;">
					<a href="../Worden/Welcome" class="brand-logo right"><img id="worden-logo" src="<c:url value='/static/images/worden-banner-logo.png' />"></a>
					<div class="col s12 hide-on-med-and-down">
						<a href="../Worden/Welcome" class="breadcrumb">Home</a>
						<a href="../Worden/IdentifyDocument" class="breadcrumb">Identify Anonymous Document</a>
						<span ng-show="results" ng-hide="results === false" class="breadcrumb">Results</span>
					</div>
				</div>
			</nav>
		</header>
		<main>
			<div ng-show="loading">
				<div class="section" id="index-banner">
					<h3 class="header center">This might take some time..... </i></h3>
				</div>
				<br>
				<h3 class="header center"><i style="color:#9B4DCA;" class="fa fa-circle-o-notch fa-spin fa-1x"></i></h3>
			</div>
			<div ng-hide="results || loading">
				<div class="section" id="index-banner">
					<h3 class="header center">Select Your Documents</h3>
				</div>
				<div class="container">
					<div class="row">
						<form action="#">
							<p>Select the anonymous document to identify:</p>
							<div class="file-field input-field">
								<div id="add-test-document" class="btn-large waves-effect waves-light purple col l4 s12" type="file" name="file" required ng-model="testFile" ngf-max-size="10MB" ngf-select ngf-model-invalid="errorFile">
									<span>Add Document</span>
									<input type="file" multiple>
								</div>
								<div class="col s12 chip-box inactive-box" id="test-document-box">
									<div class="custom-chip">
										<button class="custom-chip-delete-button" ng-click="testFile = null" ng-show="testFile">
											<i class="tiny material-icons">close</i>
										</button>
										{{testFile.name}}
									</div>
								</div>
							</div>
						</form>
						<br>
					</div>
					<div id="uploadAuthors" ng-show="testFile">
						<br>
						<div class="row">
							<p>Add documents from at least three authors your documents will be compared against.</p>
							<div class="col s12" style="padding-right:0;padding-left:0;">
								<div class="col s12" style="padding:0;overflow:hidden;height:200px;background-color:white;border: solid 1px #D1D1D1;border-radius:2px;">
									<div class="col s6" style="height:100%;border-right: 1px solid #D1D1D1;padding-left:0px;padding-right:0px;">
										<a href="" ng-click="addAuthor()" id="create-author" class="center btn waves-effect waves-light purple" style="text-transform: inherit; display: block; width: 100%;border-radius:0px;border-top-left-radius:1px;">Create Author</a>
										<div style="padding-top:0.5em;padding-left:0.5em;padding-right:0.5em;height:100%;overflow-y: scroll;padding-bottom:1em;">
											<div ng-click="selectAuthor($index)" ng-class="authors[$index].Selected"  style="cursor:pointer;" class="custom-chip" ng-show="author" ng-repeat="author in authors" style="display:inline-block;">
												<button class="custom-chip-delete-button" ng-click="removeAuthor($index)">
													<i class="tiny material-icons">close</i>
												</button>
												{{author.Name}}
											</div>
											<div ng-show="addNewAuthor">
												<input ng-keypress="checkIfEnterKeyWasPressed($event)" type="text" ng-model="addNewAuthorName" placeholder="Name">
												<button ng-click="submitNewAuthor()" class="btn waves-effect waves-light purple">Add</button>
												<button ng-click="clearNewAuthor()" class="btn waves-effect waves-light purple">Cancel</button>
											</div>
										</div>
									</div>
									<div ng-show="currentAuthor" class="col s6" style="padding-left:0px;padding-right:0px;">
										<div style="cursor:pointer;text-transform: inherit; display: block; width: 100%;border-radius:0px;border-top-right-radius:1px;" type="file" ng-change="setFile()" ngf-select multiple ngf-multiple="true" ng-model="currentAuthor.UploadFile" class="center btn waves-effect waves-light purple">Add To {{currentAuthor.Name}}'s Documents</div>
										<div style="padding-top:0.5em;padding-left:0.5em;padding-right:0.5em;height:100%;overflow-y: scroll;padding-bottom:3em;">
											<div class="custom-chip" ng-show="file" ng-repeat="file in currentAuthor.Files" style="display:inline-block;">
												<button class="custom-chip-delete-button" ng-click="removeOtherAuthorsDoc(file)">
													<i class="tiny material-icons">close</i>
												</button>
												{{file.name}}
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col s12">
								<button ng-click="startUpload()" id="text-your-own-document-next-page" class="btn waves-effect waves-light purple">Start</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div ng-show="results" ng-hide="results === false">
				<div class="section" id="index-banner">
					<h3 class="header center">Results</h3>
				</div>
				<div class="row">
					<h4 style="color:#9B4DCA" class="header center">{{ verdict }} {{suspectedAuthor}}</h4>
					<div class="container">
						<p>{{ response }}</p>
					</div>
					<div class="row" id="suggestions">
					</div>
				</div>
			</div>
		</main>
		<div class="center">
			<canvas width="1200" height="300" id="suspectConfidenceChart"></canvas>
		</div> 
		<div class="footnotes">
			<ol id="footnotes-list">
			</ol>
		</div>
		<footer class="page-footer white">
			<div class="container">
				<div class="row">
					<div class="center">
						<a href="http://drexel.edu/cci/"><img width="45" style="padding-top:15px;" src="<c:url value='/static/images/drexel-logo.png' />" /></a>
					</div>
				</div>
			</div>
		</footer>
		<!-- Scripts -->
		<script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
		<script type="text/javascript" src="<c:url value='/static/js/bigfoot.js' />"></script>
		<script src="<c:url value='/static/js/materialize.js' />"></script>
	</body>

	<style>
		.selectedAuthor {
			background-color: #9B4DCA !important;
			color: #FFF;
		}

		div.ng-valid~div.inactive-box,
		button.ng-valid~div.inactive-box {
			border-color: #84C43F;
		}

		div .ng-hide {
			min-width: 100px;
			min-height: 20px;
			background-color: red;
		}
	</style>
</html>