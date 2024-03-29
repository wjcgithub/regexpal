<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<!--
	RegexPal 0.1.4c
	(c) 2007-2008 Steven Levithan <stevenlevithan.com>
	GNU LGPL 3.0 license
-->

<cfsilent>
	<cfif structKeyExists(URL, "regex") OR structKeyExists(URL, "input") OR structKeyExists(URL, "flags")>
		<cfset Variables.isPermalink = TRUE />
		<cfif structKeyExists(URL, "regex")>
			<cfset Variables.regex = reReplaceNoCase(replace(URL.regex, "&", "&amp;", "ALL"), "</textarea\b[^>]*>", "", "ALL") />
		</cfif>
		<cfif structKeyExists(URL, "input")>
			<cfset Variables.input = reReplaceNoCase(replace(URL.input, "&", "&amp;", "ALL"), "</textarea\b[^>]*>", "", "ALL") />
		</cfif>
	</cfif>

	<cfparam name="URL.flags"             default="" />
	<cfparam name="Variables.regex"       default="Enter regex here." />
	<cfparam name="Variables.input"       default="Enter test data here." />
	<cfparam name="Variables.isPermaLink" default="FALSE" />
</cfsilent>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<title>Regex Tester &ndash; RegexPal<cfif Variables.isPermaLink> (Permalink)</cfif></title>
	<link href="./assets/regexpal.css" rel="stylesheet" type="text/css"/>
</head>
<body>
	<div id="header">
		<img src="./assets/regexpal.gif" alt="RegexPal"/>
		<h1><a href="./"><span class="t1">Regex</span><span class="t2">Pal</span>
			<span id="version">0.1.4</span>
			<span id="subtitle">&mdash; a JavaScript regular expression tester</span></a>
		</h1>
		<ul id="nav">
			<li><a href="http://blog.stevenlevithan.com/archives/regexpal">Help</a></li>
			<li><a href="./history/">Version History</a></li>
			<li><a href="mailto:steves_list&#064;hotmail.com">Feedback</a></li>
			<li><a href="http://blog.stevenlevithan.com">Blog</a></li>
		</ul>
	</div>

	<div id="options">
		<ul>
			<li class="hidden"><input id="flagG" type="checkbox" checked="checked"/><label for="flagG">Global</label> <span class="flag">(g)</span></li>
			<li><input id="flagI" type="checkbox" <cfif find("i", URL.flags)>checked="checked"</cfif>/><label for="flagI">Case insensitive</label> <span class="flag">(i)</span></li>
			<li><input id="flagM" type="checkbox" <cfif find("m", URL.flags)>checked="checked"</cfif>/><label for="flagM">^$ match at line breaks</label> <span class="flag">(m)</span></li>
			<li><input id="flagS" type="checkbox" <cfif find("s", URL.flags)>checked="checked"</cfif>/><label for="flagS">Dot matches all</label> <span class="flag">(s<span class="plain">; via <a href="http://stevenlevithan.com/regex/xregexp/">XRegExp</a></span>)</span></li>
			<li class="optGroup" id="quickReferenceDropdown">Quick Reference</li>
			<li class="optGroup" id="optionsDropdown">Options
				<ul>
					<li><input id="highlightSyntax" type="checkbox" checked="checked"/><label for="highlightSyntax">Highlight regex syntax</label></li>
					<li><input id="highlightMatches" type="checkbox" checked="checked"/><label for="highlightMatches">Highlight matches</label></li>
					<li><input id="invertMatches" type="checkbox"/><label for="invertMatches" title="Match any text not matched by the regex">Invert results</label></li>
				</ul>
			</li>
		</ul>
	</div>

	<div id="quickReference" class="hidden">
		<h2>JavaScript Regex Quick Reference</h2>
		<img class="pin" src="./assets/pin.gif" alt="pin" title="pin"/>
		<img class="close" src="./assets/close.gif" alt="close" title="close"/>
		<table cellspacing="0" summary="Regular expressions reference">
			<tbody>
				<tr>
					<td><code>.</code></td>
					<td>Any character except newline.</td>
				</tr>
				<tr class="altBg">
					<td><code>\.</code></td>
					<td>A period (and so on for <code>\*</code>, <code>\(</code>, <code>\\</code>, etc.)</td>
				</tr>
				<tr>
					<td><code>^</code></td>
					<td>The start of the string.</td>
				</tr>
				<tr class="altBg">
					<td><code>$</code></td>
					<td>The end of the string.</td>
				</tr>
				<tr>
					<td><code>\d</code>,<code>\w</code>,<code>\s</code></td>
					<td>A digit, word character <code>[A-Za-z0-9_]</code>, or whitespace.</td>
				</tr>
				<tr class="altBg">
					<td><code>\D</code>,<code>\W</code>,<code>\S</code></td>
					<td>Anything except a digit, word character, or whitespace.</td>
				</tr>
				<tr>
					<td><code>[abc]</code></td>
					<td>Character a, b, or c.</td>
				</tr>
				<tr class="altBg">
					<td><code>[a-z]</code></td>
					<td>a through z.</td>
				</tr>
				<tr>
					<td><code>[^abc]</code></td>
					<td>Any character except a, b, or c.</td>
				</tr>
				<tr class="altBg">
					<td><code>aa|bb</code></td>
					<td>Either aa or bb.</td>
				</tr>
				<tr>
					<td><code>?</code></td>
					<td>Zero or one of the preceding element.</td>
				</tr>
				<tr class="altBg">
					<td><code>*</code></td>
					<td>Zero or more of the preceding element.</td>
				</tr>
				<tr>
					<td><code>+</code></td>
					<td>One or more of the preceding element.</td>
				</tr>
				<tr class="altBg">
					<td><code>{<em>n</em>}</code></td>
					<td>Exactly <em>n</em> of the preceding element.</td>
				</tr>
				<tr>
					<td><code>{<em>n</em>,}</code></td>
					<td><em>n</em> or more of the preceding element.</td>
				</tr>
				<tr class="altBg">
					<td><code>{<em>m</em>,<em>n</em>}</code></td>
					<td>Between <em>m</em> and <em>n</em> of the preceding element.</td>
				</tr>
				<tr>
					<td><code>??</code>,<code>*?</code>,<code>+?</code>,<br/><code>{<em>n</em>}?</code>, etc.</td>
					<td>Same as above, but as few times as possible.</td>
				</tr>
				<tr class="altBg">
					<td><code>(</code><em>expr</em><code>)</code></td>
					<td>Capture <em>expr</em> for use with <code>\1</code>, etc.</td>
				</tr>
				<tr>
					<td><code>(?:</code><em>expr</em><code>)</code></td>
					<td>Non-capturing group.</td>
				</tr>
				<tr class="altBg">
					<td><code>(?=</code><em>expr</em><code>)</code></td>
					<td>Followed by <em>expr</em>.</td>
				</tr>
				<tr>
					<td><code>(?!</code><em>expr</em><code>)</code></td>
					<td>Not followed by <em>expr</em>.</td>
				</tr>
			</tbody>
		</table>
		<p><a href="http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:RegExp#Special_characters_in_regular_expressions">Near-complete reference</a></p>
	</div>

	<div id="body">
		<div id="search" class="smartField">
			<textarea cols="100" rows="3" tabindex="1"><cfoutput>#Variables.regex#</cfoutput></textarea>
		</div>
		<div id="input" class="smartField">
			<textarea cols="100" rows="10" tabindex="2"><cfoutput>#Variables.input#</cfoutput></textarea>
		</div>
	</div>

	<div id="footer" class="small">
		<p><strong>Need more power?</strong> Get <a href="http://www.regexbuddy.com/cgi-bin/affref.pl?aff=SteveL">RegexBuddy</a> from <abbr title="Just Great Software">JGsoft</abbr>, a powerful regex tester &amp; builder that inspired many of this application's features.</p>
		<p id="copyright"><a href="javascript:RegexPal.permalink();" id="permalink">Permalink</a> &mdash; &copy; 2008 <a href="http://blog.stevenlevithan.com">Steven Levithan</a> &mdash; <a href="http://code.google.com/p/regexpal/">Google Code</a></p>
	</div>

	<script src="./assets/build-0.1.4.js"></script>
	<!-- Build file includes:
	<script src="./assets/xregexp.js"></script>
	<script src="./assets/helpers.js"></script>
	<script src="./assets/regexpal.js"></script>
	-->

	<!-- Stats by Mint <haveamint.com> -->
	<script src="/mint/?js"></script>
</body>
</html>
