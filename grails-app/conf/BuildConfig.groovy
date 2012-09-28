grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir	= "target/test-reports"
//grails.project.war.file = "target/${appName}-${appVersion}.war"
grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits( "global" ) {
        // uncomment to disable ehcache
        // excludes 'ehcache'
    }
    log "warn" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    repositories {        
        grailsPlugins()
        grailsHome()
        grailsCentral()

        mavenCentral()

        mavenRepo "https://repository.jboss.org/nexus/"
    }
    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes eg.
       compile('net.sf.jasperreports:jasperreports:4.7.0'){
          excludes 'antlr', 'commons-beanutils', 'commons-collections', 'commons-logging',
                  'ant', 'mondrian', 'commons-javaflow','barbecue', 'xml-apis-ext','xml-apis', 'xalan', 'groovy-all', 'hibernate', 'saaj-api', 'servlet-api',
                  'xercesImpl','xmlParserAPIs','spring-core','bsh', 'spring-beans', 'jaxen', 'barcode4j','batik-svg-dom','batik-xml','batik-awt-util','batik-dom',
                  'batik-css','batik-gvt','batik-script', 'batik-svggen','batik-util','batik-bridge','persistence-api','jdtcore','bcmail-jdk16','bcprov-jdk16','bctsp-jdk16',
                  'bcmail-jdk14','bcprov-jdk14','bctsp-jdk14','xmlbeans'
        }

        compile('org.apache.poi:poi:3.8')
    }
    plugins{
        if (appName == "jasper") {
            compile (":hibernate:$grailsVersion") {
                export = false
            }
            build(":tomcat:$grailsVersion",":maven-publisher:0.8.1") {
                export = false
            }
        }
    }
}
