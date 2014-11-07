/* Copyright 2006-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

import org.codehaus.groovy.grails.web.util.WebUtils
import org.springframework.web.context.request.RequestContextHolder

/**
 * @author Craig Jones 11-Aug-2008
 */
class JasperTagLibTests extends JasperPluginTestCase {
    static final String SCRIPT_PART = """<script type="text/javascript"> function submit_myreport(link) { link.parentNode._format.value = link.title;
      link.parentNode.submit(); return false; } </script> """

    def grailsApplication

    void testJasperPluginTag_FormatRequired() {
        def template = '<g:jasperReport jasper="myreport"/>'
        shouldFail {
            applyTemplate(template)
        }
    }

    void testJasperPluginTag_JasperRequired() {
        def template = '<g:jasperReport format="pdf" />'
        def errMsg = shouldFail {
            applyTemplate(template)
        }
    }

    /**
     * A minimal call using all default values, resulting in a single, plain link enclosed in vert-bar delimiters.
     */
    void testJasperPluginTag_Link_Minimal_PDF() {
        def template = '<g:jasperReport format="pdf" jasper="myreport"/>'
        assertOutputEquals squeezeWhitespace("""| <a class="jasperButton" title="PDF" href="/myapp/jasper/index?_format=PDF&_name=&_file=myreport">
        <img border="0" alt="PDF" src="/myapp/images/icons/PDF.gif" /></a> |"""), template, [:], transformSqueezeWhitespace
    }

    /**
     * A minimal call using all default values, resulting in a single, plain link, but with delimiters suppressed.
     */
    void testJasperPluginTag_Link_Minimal_PDF_NoDelimiters() {
        def template = '<g:jasperReport format="pdf" jasper="myreport" name="The Report" delimiter=" "/>'
        assertOutputEquals squeezeWhitespace("""<a class="jasperButton" title="PDF" href="/myapp/jasper/index?_format=PDF&_name=The+Report&_file=myreport">
        <img border="0" alt="PDF" src="/myapp/images/icons/PDF.gif" /></a>  <strong>The Report</strong>"""), template, [:], transformSqueezeWhitespace
    }

    /**
     * A call resulting in dual links with delimiters suppressed.
     */
    void testJasperPluginTag_Link_Minimal_PDF_RTF_NoDelimiters() {
        def template = '<g:jasperReport format="pdf, rtf" jasper="myreport" name="The Report" delimiter=" "/>'
        assertOutputEquals squeezeWhitespace("""<a class="jasperButton" title="PDF" href="/myapp/jasper/index?_format=PDF&_name=The+Report&_file=myreport">
        <img border="0" alt="PDF" src="/myapp/images/icons/PDF.gif" /></a>  <a class="jasperButton" title="RTF" href="/myapp/jasper/index?_format=RTF&_name=The+Report&_file=myreport">
        <img border="0" alt="RTF" src="/myapp/images/icons/RTF.gif" /></a>  <strong>The Report</strong>"""), template, [:], transformSqueezeWhitespace
    }

    /**
     * A minimal call with a report name.
     */
    void testJasperPluginTag_Link_Name() {
        def template = '<g:jasperReport format="pdf" jasper="myreport" name="Print as PDF"/>'
        assertOutputEquals squeezeWhitespace("""|
        <a class="jasperButton" title="PDF" href="/myapp/jasper/index?_format=PDF&_name=Print+as+PDF&_file=myreport">
        <img border="0" alt="PDF" src="/myapp/images/icons/PDF.gif" /></a> | <strong>Print as PDF</strong>"""), template, [:], transformSqueezeWhitespace
    }

    /**
     * A minimal call with a description.
     */
    void testJasperPluginTag_Link_Description() {
        def template = '<g:jasperReport format="pdf" jasper="myreport" description="Print as PDF"/>'
        assertOutputEquals squeezeWhitespace("""|
        <a class="jasperButton" title="PDF" href="/myapp/jasper/index?_format=PDF&_name=&_file=myreport">
        <img border="0" alt="PDF" src="/myapp/images/icons/PDF.gif" /></a> | Print as PDF"""), template, [:], transformSqueezeWhitespace
    }

    /**
     * A call with a body, thus resulting in a form.
     */
    void testJasperPluginTag_Form() {
        def template = '<g:jasperReport format="pdf" jasper="myreport">A Body</g:jasperReport>'
        assertOutputEquals squeezeWhitespace(SCRIPT_PART + """
        <form class="jasperReport" name="myreport" action="/myapp/jasper/index"><input type="hidden" name="_format" />
          <input type="hidden" name="_name" value="" />
          <input type="hidden" name="_file" value="myreport" />
        | <a href="#" class="jasperButton" title="PDF" onclick="return submit_myreport(this)">
        <img border="0" alt="PDF" src="/myapp/images/icons/PDF.gif" /></a> |&nbsp;A Body</form>
        """), template, [:], transformSqueezeWhitespace
    }

    // TODO passing thru ID and CLASS attributes

    public void setUp() {
        super.setUp()
        RequestContextHolder.currentRequestAttributes().currentRequest."${WebUtils.INCLUDE_CONTEXT_PATH_ATTRIBUTE}" = '/myapp'
    }
}
