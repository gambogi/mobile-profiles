module HTMLGen where
	-- I think this might be the most functional way to define dynamic webpages 
	-- (combination of folds, recursion, and heavily nested build-upon functions)
	import HTMLSanitize
	import HTMLBackend
	
	htmlPage pageTitle = prettyConcat ["<!DOCTYPE html>","<html>", htmlHeader "", htmlBody pageTitle, "</html>"]
	
	htmlHeader prelink= prettyConcat ["<head>", htmlTitle, htmlMeta, htmlIcon, htmlCSS prelink, googleAnalytics, "</head>"]
	htmlTitle = prettyConcat ["<title>","CSH Profiles","</title>"]
	htmlMeta = "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0\"/>"
	
	htmlIcon = prettyConcat ["<link rel=\"icon\" type=\"image/x-icon\" href=\"http://csh.rit.edu/files/favicon.ico\">",
		"<link rel=\"apple-touch-icon\" href=\"iui/iui-logo-touch-icon.png\" />"]
		
	htmlCSS prelink = prettyConcat [
		"<link rel=\"stylesheet\" href=\""++prelink++"iui/iui.css\" type=\"text/css\" />",
		"<link rel=\"stylesheet\" title=\"Default\" href=\""++prelink++"iui/t/default/default-theme.css\"  type=\"text/css\"/>",
		"<link rel=\"stylesheet\" href=\""++prelink++"iui/iui-panel-list.css\" type=\"text/css\" />",
		"<style type=\"text/css\">",
		".panel p.normalText { text-align: left;  padding: 0 10px 0 10px; }",
		"</style>"
		]
		
	googleAnalytics = prettyConcat ["<script type=\"text/javascript\">",
		"var _gaq = _gaq || [];",
		"_gaq.push(['_setAccount', 'UA-8634743-10'], ['_trackPageview']);",
		"</script>",
		"<script type=\"text/javascript\">",
		"(function() {",
		"var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;",
		"ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';",
		"var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);",
		"})();",
		"</script>"]
	
	htmlBody pageTitle = prettyConcat ["<body>", toolbar pageTitle, "</body>"]
	
	
	toolbar pageTitle = prettyConcat [
		"<div class=\"toolbar\">",
		"<h1 id=\"pageTitle\">"++pageTitle++"</h1>",
		"<a id=\"backButton\" class=\"button\" href=\"#\"></a>",
		"<a class=\"button\" href=\"http://members.csh.rit.edu/profiles/\">Old Site</a>",
		"</div>" ]
	
	contactPage [names, cellphones, homephones, emails, aims] = prettyConcat [
		"<!DOCTYPE html>",
		"<html>",
		htmlHeader "../",
		"<body>",
		toolbar "Contact",
		contactScreen [names, cellphones, homephones, emails, aims],
		"</body>",
		"</html>" ]
	
	contactPageExcerpt [names, cellphones, homephones, emails, aims] = prettyConcat [
		"<div title=\"Contact Excerpt\">",
		contactScreen [names, cellphones, homephones, emails, aims],
		"</div>"
		]
		
	contactScreen [names, cellphones, homephones, emails, aims] = prettyConcat [
		"<ul id=\"Contact\" title=\"Profiles\" selected=\"true\">",
		elementize "Name" names,
		elementLink "Cell Phone" cellphones "tel:",
		elementLink "Home Phone" homephones "tel:",
		elementLink "Email Address" emails "mailto:",
		elementLink "AIM Screen Name" aims "aim:goim?screenname=",
		"</ul>" ]
	
	
	indexPage = prettyConcat [
		"<!DOCTYPE html>",
		"<html>",
		htmlHeader "../",
		"<body>",
		toolbar "Profiles",
		"<ul id=\"Index\" title=\"Member Profiles\" selected=\"true\">",
		alphaList,
		"</ul>",
		"</body>",
		"</html>" ]


	
	listPage people = prettyConcat [
		"<!DOCTYPE html>",
		"<html>",
		htmlHeader "../",
		"<body>",
		toolbar "Profiles",
		listScreen people,
		"</body>",
		"</html>" ]
		
	listScreen people = prettyConcat [
		"<ul id=\"List\" title=\"Member Profiles\" selected=\"true\">",
		groupedList people,
		"</ul>" ]
		
		
	
