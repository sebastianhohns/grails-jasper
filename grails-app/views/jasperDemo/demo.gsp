<%@page defaultCodec="none" %>

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>Welcome to Jasper-Grails</title>
  <meta name="layout" content="main"/>
</head>
<body>
<h1 style="margin-left:20px;">Jasper Plugin Instructions/Demo Page</h1>
<div class="dialog" style="margin-left:20px;width:60%;">
  <p>This Jasper Plugin allows you to launch reports built using
    <a href="http://jasperforge.org/projects/jasperreports">Jasperreports</a>
    from within a Grails application.  This is done by making available a new GSP tag called &lt;g:jasperReport&gt;.</p>

  <p>Basically, this tag renders as a sequence of icons representing the various output formats handled by Jasper (PDF, RTF, XML, etc.)
  See the examples in sections 3 and 4, below.
  When the user clicks on the icon, the corresponding report is generated.
  There are numerous options to control the rendering, including which of the seven possible formats to offer and how
  to accompany the icons with input fields for report parameters, text labels, icon delimiters, etc.</p>

  <p>If the &lt;g:jasperReport&gt; has a body, then the rendered HTML will be a &lt;form&gt; that includes that body.
  It is assumed that the body contains input tags which will be used to provide input parameters to the report.
  (The name of the input tag must match the name of the input parameter expected by the report.)</p>

  <p>If the &lt;g:jasperReport&gt; does not have a body, then the rendered HTML will be just a series of one or more &lt;a&gt; tags.</p>

  <hr/>
  <h2>1. Installation</h2>
  <p>Just execute the following from your application directory:</p>
  <pre>grails install-plugin jasper</pre>
  <p>What is installed:</p>
  <ul>
    <li>The jars for executing .jasper reports (already compiled) and/or compiling them from .jrxml files, on the fly, first.</li>
    <li>A GSP taglib for launching reports.</li>
    <li>Corresponding controller and service logic (that can be invoked directly)</li>
    <li>Seven 32x32 icons (web-app/images/icons/*.gif) .</li>
    <li>This demo GSP page.</li>
  </ul>

  <hr/>
  <h2>2. Configuration</h2>
  <p>Option One: Create a web-app/reports folder and place your *.jasper (and/or *.jrxml) files there.
  That's the default location.  If you follow this convention, then there is nothing more to configure.
  </p>
  <p>Option Two: In Config.groovy, set jasper.dir.reports to the location of your *.jasper files.
  If that location is already nested within the web-app folder, then your reports will automatically be included in the war when you deploy to test or production.
  In that case, you'll only have to set jasper.dir.reports universally.
  If not, then you'll probably need to set it separately for each environment (development, test, production), and you'll likely need
  to define grails.war.resources as well (with a closure containing GANT commands to copy the *.jasper files into
  the staging dir so that they'll be included in the war).
  </p>                                                        
  <p>Something like this:</p>

  <pre>
    grails.war.resources = {stagingDir ->
    mkdir(dir: "$stagingDir/web-app/reports")
    copy(todir: "$stagingDir/web-app/reports") {fileset(dir:"src/reports",includes:"*.jasper")}
    }
    environments {
    development {
    // relative to web-app
    jasper.dir.reports = '../src/reports'
    }
    production {
    // relative to web-app
    jasper.dir.reports = 'reports'
    }
    }
  </pre>

  <hr/>
  <h2>3. Test Your Install</h2>
  Type in your name and then click on any of the icons below to test your plugin installation and see a report of that type produced.<br/><br/>

  <g:jasperReport jasper="sample-jasper-plugin" format="PDF,HTML,XML,CSV,XLS,RTF,TEXT,ODT,ODS,DOCX,XLSX,PPTX" name="Parameter Example" buttonPosition="bottom" bodyBefore=" " delimiter=" ">
    Your name: <input type="text" name="name"/><br/><br/>
  </g:jasperReport>

  <br/><hr/>
  <h2>4. Some Other Examples</h2>

  <h3>All Default Values</h3>
  <ul><li>One line across</li>
    <li>Vertical bar delimiters</li>
    <li>Description shown after last button, followed by parameters (if any).</li>
    <li>Description is the report "name" (in this case, "Parameter Example").</li>
    <li>Default controller = JasperController (provided by plugin)</li>
    <li>Default action = index</li>
    <li>CSS class for the form is jasperReport</li>
    <li>CSS class for each button is jasperButton</li>
  </ul>
  <g:jasperReport
          jasper="sample-jasper-plugin"
          format="PDF,HTML,XML,CSV,XLS,RTF,TEXT,ODT,ODS,DOCX,XLSX,PPTX"
          name="Parameter Example">
    Your name: <input type="text" name="name"/>
  </g:jasperReport>

  <pre>
    &lt;g:jasperReport
    jasper="sample-jasper-plugin"
    format="PDF,HTML,XML,CSV,XLS,RTF,TEXT,ODT,ODS,DOCX,XLSX,PPTX"
    name="Parameter Example" &gt;
    Your name: &lt;input type="text" name="name" /&gt;
    &lt;/g:jasperReport&gt;
  </pre>

  <hr width="40%"/>

  <h3>Some Layout and Presentation Options</h3>
  <ul>
    <li>Buttons at end of form, rather than first</li>
    <li>Different delimiters before, between, and after buttons</li>
    <li>Description is suppressed (but the report name is still passed on to Jasper).</li>
    <li>Some formats not offered</li>
    <li>PDF format report will be displayed in the current browser window ("inline"), rather than downloaded.</li>
  </ul>
  <g:jasperReport
          jasper="sample-jasper-plugin"
          format="pdf, html, xls, rtf, text,odt,ods,docx,xlsx,pptx"
          name="Report Name for Jasper Only]"
          inline="true"
          buttonPosition="bottom"
          description=" "
          delimiter="*"
          delimiterBefore="((("
          delimiterAfter=")))">
    Your name: <input type="text" name="name"/>
    <br/><br/>
  </g:jasperReport>

  <pre>
    &lt;g:jasperReport
    jasper="sample-jasper-plugin"
    format="pdf, html, xls, rtf, text,odt,ods,docx,xlsx,pptx"
    name="Report Name for Jasper Only]"
    inline="true"
    buttonPosition="bottom"
    description=" "
    delimiter="*"
    delimiterBefore="((("
    delimiterAfter=")))"&gt;
    Your name: &lt;input type="text" name="name" /&gt;
    &lt;br/&gt;&lt;br/&gt;
    &lt;/g:jasperReport&gt;
  </pre>

  <hr width="40%"/>


  <h3>Grails-Supplied Domain Data</h3>
  The following data should appear in report form when you click on any of the icon buttons below.
  <table border="1" cellpadding="2" cellspacing="0">
    <tr><th>Person's Name</th><th>E-Mail Address</th></tr>
    <g:each var="person" in="${people}">
      <tr><td>${person.name}</td><td>${person.email}</td></tr>
    </g:each>
  </table>
  <ul>
    <li>Alternative controller/action supplies the data model</li>
    <li>Our action then chains to the provided JasperController.index to process the reports.</li>
  </ul>
  <g:jasperReport
          jasper="sample-list-domain-classes"
          controller="jasperDemo"
          action="exampleWithData"
          format="pdf, html, xml, csv, xls, rtf, text,odt,ods,docx,xlsx,pptx"
          name="GORM Example"
          description=" "
          delimiter=" "/>

  <br/>

  <pre>
    &lt;g:jasperReport
    jasper="sample-list-domain-classes"
    action="exampleWithData"
    format="pdf, html, xml, csv, xls, rtf, text,odt,ods,docx,xlsx,pptx"
    name="GORM Example"
    description=" "
    delimiter=" " /&gt;
  </pre>

  You can also use more specific tags to gain greater control over more complicated forms.
  <g:jasperForm controller="jasperDemo"
          action="exampleWithData"
          id="1498"
          name="GORM Example2"
          jasper="w_iReport">
    <table border="1" cellpadding="2" cellspacing="0">
      <tr><th>Person's Name</th><th>E-Mail Address</th></tr>
      <g:each var="person" in="${people}">
        <tr><td>${person.name}</td><td>${person.email}</td></tr>
      </g:each>
      <tr>
        <td colspan='2'><g:jasperButton format="pdf" text="PDF"/></td>
      </tr>
    </table>
  </g:jasperForm>

  <pre>
    &lt;g:jasperForm controller="jasper"
    action="exampleWithData"
    id="1498"
    jasper="w_iReport" &gt;

    ..form contents..

    &lt;g:jasperButton format="pdf" jasper="jasper-test" text="PDF" /&gt;

    .. other html..

    &lt;/g:jasperForm&gt;
  </pre>

  You can also use more complex parameters in the report.<br/>
  <g:jasperReport
          controller="jasperDemo"
          jasper="sample-list-domain-classes-2"
          action="exampleWithData"
          format="pdf, html, xml, csv, xls, rtf, text,odt,ods,docx,xlsx,pptx"
          name="GORM Example"
          description=" "
          delimiter=" ">

    Born between <input type="text" name="startDate"/> and <input type="text" name="endDate"/>

  </g:jasperReport>

  <h3>Report with graphs (JFreeChart support)</h3>
  Graph support is a common and useful feature used in reports. In Jasper/IReport the default chart library is <a href="http://www.jfree.org/jfreechart/">JFreeChart</a>.<br/>The Grails Jasper Plugin supports JFreeChart reports. The link below shows an example of chart usage in Jasper reports.
  <br/>
  <g:jasperReport
          controller="jasperDemo"
          jasper="sample-list-domain-classes-3-chart"
          action="exampleWithDataChart"
          format="pdf, html, xml, csv, xls, rtf, text,odt,ods,docx,xlsx,pptx"
          name="GORM chart Example"
          description=" "
          delimiter=" "/>

  <br/>

  <pre>
    &lt;g:jasperReport
    jasper="sample-list-domain-classes-3-chart"
    action="exampleWithDataChart"
    format="pdf, html, xml, csv, xls, rtf, text,odt,ods,docx,xlsx,pptx"
    name="GORM chart Example"
    description=" "
    delimiter=" " /&gt;
  </pre>

  <br/><br/>

  Additional parameters, which are supported for some file formats, can be passed through (see jasperreport documentation for details).
  Use the HTML_HEADER parameter to apply a custom html header to your output:<br/><br/>

  <g:jasperReport
          jasper="sample-jasper-plugin"
          format="html"
          inline="true"
          buttonPosition="bottom">
    <input type="hidden" name="HTML_HEADER" value="
             --------HTML_HEADER Content---------
            "/>
    <br/><br/>
  </g:jasperReport>

  <pre>
    &lt;g:jasperReport
    jasper="sample-jasper-plugin"
    format="html"
    inline="true"
    buttonPosition="bottom"&gt;
    &lt;input type="hidden" name="HTML_HEADER" value="&lt;h2&gt;-----------Header-----------&lt;/h2&gt;" /&gt;
    &lt;/g:jasperReport&gt;
  </pre>
  <br/>
  This plugin sets some default values for a bunch of these parameters. You can disable these defaults by submitting "useDefaultParameters" (Boolean values, defaults to true).
  <pre>
    &lt;g:jasperReport
    jasper="sample-jasper-plugin"
    format="html"
    inline="true"
    buttonPosition="bottom"&gt;
    &lt;input type="hidden" name="useDefaultParameters" value="false" /&gt;
    &lt;/g:jasperReport&gt;
  </pre>
  <hr/>
  <h2>5. Tag Reference</h2>
  <h3>&lt;g:jasperReport&gt;</h3>
  The jasperReport tag creates a link to a jasper report defined by the developer.
  By default, the report must either reside in the "%PROJECT_HOME%/web-app/reports/" folder, or the path must be defined in
  the <i>Config.groovy</i> file, in the variable <i>jasper.dir.reports</i>.
  <br/><br/>
  The following attributes can be defined in the tag:
  <br/><br/>
  <ul>
    <li>
      <strong>jasper</strong>
      (Required) The name of the report file, without the .jasper or .jrxml extension.
      This is also used to set the name attribute of the generated form tag.
    </li>
    <li>
      <strong>name</strong>
      (Optional) A displayable version of the report name.
      It appears in bold next to the submit buttons (by default).
      Not to be confused with the name attribute of the resultant form tag (see the jasper attribute, above.)
    </li>
    <li>
      <strong>id</strong>
      (Optional) The id attribute for the form.
    </li>
    <li>
      <strong>format</strong>
      (Required) A list of output formats that are appropriatre for the report and are to be available to the user, separated by commas.
      Case insensitive.
      Spaces allowed.
      This version supports PDF, HTML, XML, CSV, XML, RTF and TEXT formats.
      A button for each format is created by the tag.
    </li>
    <li>
      <strong>buttonPosition</strong>
      Whether the submit buttons are to appear at the top or bottom of the form (before or after the body).
      Choices are "top" and "bottom".
      The default is "top".
    </li>
    <li>
      <strong>class</strong>
      (Optional) Style class to use for the form.
      The default is "jasperReport".
    </li>
    <li>
      <strong>height</strong>
      (Optional) Height attribute for the icon img tags.
      The default is none, so the images will be full size (32px).
    </li>
    <li>
      <strong>buttonClass</strong>
      (Optional) Style class to use for the submit buttons (which are actually &lt;A&gt; tags).
      The default is "jasperButton".
    </li>
    <li>
      <strong>delimiter</strong>
      (Optional) Delimiter between icons.
      If you don't want any delimiter, use a single space (" ") instead of an empty string (""), as an empty string will use the default ("|").
    </li>
    <li>
      <strong>(The body of the tag)</strong>
      If the tag has a body, then it becomes the body of the form.
      Any HTML input elements defined in the body of the tag are sent as report parameters.
    </li>
  </ul>

  <h3>New Tags:</h3>
  <h3>&lt;g:jasperForm&gt;</h3>
  <br/>
  Much the same as the jasperReport tag, but gives you more control over how a form is rendered in HTML
  <ul>
    <li>
      <strong>jasper</strong>
      (Required) The name of the report file, without the .jasper or .jrxml extension.
      This is also used to set the name attribute of the generated form tag.
    </li>
    <li>
      <strong>controller</strong>
      (Required) The controller the form will submit to.
    </li>
    <li>
      <strong>action</strong>
      (Required) The action the form will submit to.
    </li>
    <li>
      <strong>id</strong>
      (Optional) The id attribute for the form.
    </li>
    <li>
      <strong>class</strong>
      (Optional) Style class to use for the form.
      The default is "jasperReport".
    </li>
  </ul>

  <h3>&lt;g:jasperButton&gt;</h3>
  <br/>
  The buttons that will submit a jasperForm when clicked. title can be any one of the types of reports that Jasper can output.
  <ul>
    <li>
      <strong>format</strong>
      (Required) the name of the supported output format. ex. 'pdf' or 'PDF'
    </li>
    <li>
      <strong>class</strong>
      (Optional) class of the element in addition to default.
    </li>
    <li>
      <strong>text</strong>
      (Optional) text to be included next to button ex. 'print'.
    </li>
  </ul>

  <hr/>
  <h2>6. Controller Action Chaining</h2>
  Here is the controller code that sets up the data for the Grails-supplied data example, above.
  As you can see, it then chains to the jasper/index action which handles everything else.
  <pre>
    def exampleWithData = {
    List people = [
    new ExamplePersonForReport(name: 'Amy', email: 'amy@example.com'),
    new ExamplePersonForReport(name: 'Brad', email: 'brad@example.com'),
    new ExamplePersonForReport(name: 'Charlie', email: 'charlie@example.com')]

    chain(controller:'jasper',action:'index',model:[data:people],params:params)
    }
  </pre>
  In the real world, this would be a GORM method call.  Something like: List people = ExamplePersonForReport.findAll()

  <hr/>

  <h2>7. Generate report with a service call</h2>
  From version 1.1 upwards it's possible to generate your report, without the controller action from above, with simple
  service methods (so that you can generate your reports with a cron job in combination with the Quartz plugin). <br/><br/>
  The central element for this feature is a new wrapper class JasperReportDef. Instead of putting anything in the parameter
  map you create a simple object containing the relevant data.

  <pre>
    def reportDef = JasperReportDef(name:'your_report.jasper',
    fileFormat:JasperExportFormat.PDF_FORMAT
    )
  </pre>

  As you can see there are only two required attributes. Of course you need provide the name of your report and the target file
  format. All available file formats can be found in the <strong>JasperExportFormat</strong> enum. You just have to choose one. <br/><br/>

  Additional attributes are:
  <ul>
    <li><strong>folder</strong>: the folder where you placed your reports. Defaults to /reports if unset and no global setting (jasper.report.dir in Config.groovy) exists.</li>
    <li><strong>locale</strong>: Locale to use in the report generation.</li>
    <li><strong>parameters</strong>: All additional parameters as a Map.</li>
  </ul>

  All you need to do now is to call one of the methods provided in <strong>JasperService</strong>:
  <ul>
    <li><strong>generateReport(JasperReportDef reportDef)</strong>: Generate a "normal" report.</li>
    <li><strong>generateReport(List&lt;JasperReportDef&gt; reports)</strong>: Generate a single response containing multiple reports.</li>
  </ul>

  Both return a <strong>ByteArrayOutputStream</strong> with which you can do everything you want. <br/><br/>

  Full example:
  <pre>
    class YourClass {
    def jasperService
    void yourMethod() {
    def reportDef = new JasperReportDef(name:'your_report.jasper',
    fileFormat:JasperExportFormat.PDF_FORMAT
    )

    FileUtils.writeByteArrayToFile(new File("/your/target/path/test.pdf"), jasperService.generateReport(reportDef).toByteArray())
    }
    }
  </pre>


  <hr/>

  <h2>8. Known Issues</h2>
  <ul>
    <li>The Inline option is not working (at least, not in FF3 on the Mac).</li>
    <li>The new tag demonstration won't work on this page if you are using the grails UI performance plugin or if you aren't using prototype library.</li>
  </ul>
</div>
</body>
</html>
