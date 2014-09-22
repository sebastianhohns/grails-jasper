grails.project.work.dir = 'target'

grails.project.repos.grailsCentral.username = System.getenv("GRAILS_CENTRAL_USERNAME")
grails.project.repos.grailsCentral.password = System.getenv("GRAILS_CENTRAL_PASSWORD")

grails.project.dependency.resolution = {

    inherits 'global'
    log 'warn'

    repositories {
        grailsCentral()
        mavenLocal()
        mavenCentral()
    }

    dependencies {
        compile('com.lowagie:itext:2.1.7')

        compile('net.sf.jasperreports:jasperreports:5.6.1') {
            excludes 'antlr', 'commons-beanutils', 'commons-collections', 'commons-logging',
                     'ant', 'mondrian', 'commons-javaflow','barbecue', 'xml-apis-ext','xml-apis', 'xalan', 'groovy-all', 'hibernate', 'saaj-api', 'servlet-api',
                     'xercesImpl','xmlParserAPIs','spring-core','bsh', 'spring-beans', 'jaxen', 'barcode4j','batik-svg-dom','batik-xml','batik-awt-util','batik-dom',
                     'batik-css','batik-gvt','batik-script', 'batik-svggen','batik-util','batik-bridge','persistence-api','jdtcore','bcmail-jdk16','bcprov-jdk16','bctsp-jdk16',
                     'bcmail-jdk14','bcprov-jdk14','bctsp-jdk14','xmlbeans', 'olap4j'
        }

        compile('org.apache.poi:poi:3.10-FINAL')
    }

    plugins {
        build ':release:2.2.1', ':rest-client-builder:1.0.3', {
            export = false
        }

        test(":hibernate:$grailsVersion") {
            export = false
        }
        test(":tomcat:$grailsVersion") {
            export = false
        }
    }
}
