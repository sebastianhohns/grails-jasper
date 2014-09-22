class JasperGrailsPlugin {
    def version = "1.10.0"
    def grailsVersion = "2.1.0 > *"
    def author = "Craig Andrews"
    def authorEmail = "candrews@integralblue.com"
    def license = "Apache License 2.0"
    def issueManagement = [system: "JIRA", url: "http://jira.grails.org/browse/GPJASPER"]
    def scm = [url: "https://github.com/candrews/grails-jasper"]

    List pluginExcludes = [
            'docs/**',
            'src/docs/**'
    ]

    def title = "Jasper Plugin"
    def description = '''
	Adds easy support for launching jasper reports from GSP pages.
	After installing, run your application and request (app-url)/jasper/demo for a demonstration and instructions.
    '''
    def documentation = "http://www.grails.org/plugin/jasper"

    def doWithWebDescriptor = { xml ->
        def servlets = xml.servlet
        def lastServlet = servlets[servlets.size() - 1]
        lastServlet + {
            servlet {
                'servlet-name'('image')
                'servlet-class'('net.sf.jasperreports.j2ee.servlets.ImageServlet')
            }
        }

        def mappings = xml.'servlet-mapping'
        def lastMapping = mappings[mappings.size() - 1]
        lastMapping + {
            'servlet-mapping' {
                'servlet-name'('image')
                'url-pattern'('/reports/image')
            }
        }
    }
}
