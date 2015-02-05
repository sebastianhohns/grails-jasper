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
 */

import grails.test.GroovyPagesTestCase

/**
 * @author craigjones Aug 11, 2008
 */
class JasperPluginTestCase extends GroovyPagesTestCase {
    /**
     * Testing utility reduce all whitespace (spaces and line breaks) to single spaces (before comparing it).
     * Any clump of whitespace (spaces, newlines) is reduced to a single space if internal, or reduced to nothing if
     * leading or trailing.
     * Note: All Tabs are left alone, being considered signifcant for testing purposes (e.g. for tab-separated lists).
     */
    String squeezeWhitespace(String s) {
        return s.replaceAll(/\n/,' ').replaceAll(/ {2,}/,' ').replaceAll(/^ /,'').replaceAll(/ $/,'')
    }

    /**
     * Closure version of squeezeWhitespace, for passing as the 4th parameter to assertOutputEquals
     * (The third parameter is a param map, which can be empty [:].)
     */
    def transformSqueezeWhitespace = { stringWriter ->
        squeezeWhitespace(stringWriter.toString())}

    void testSqueezeWhitespace() {
        assertEquals 'ALFA BRAVO CHARLIE',squeezeWhitespace("ALFA\nBRAVO\nCHARLIE")
        assertEquals 'ALFA BRAVO DELTA',squeezeWhitespace("\nALFA\nBRAVO\nDELTA")
        assertEquals 'ALFA BRAVO ECHO',squeezeWhitespace("ALFA\nBRAVO\nECHO\n")
        assertEquals 'ALFA BRAVO FOXTROT',squeezeWhitespace("\nALFA\nBRAVO\nFOXTROT\n")
        assertEquals 'GOLF HOTEL INDIA',squeezeWhitespace("GOLF\n\nHOTEL  \n  INDIA")
        assertEquals 'GOLF HOTEL JULIET',squeezeWhitespace("GOLF\n\nHOTEL  \n  JULIET   ")
        assertEquals 'GOLF HOTEL KILO',squeezeWhitespace("  GOLF\n\nHOTEL  \n  KILO")
        assertEquals 'GOLF HOTEL LIMA',squeezeWhitespace("   GOLF\n\nHOTEL  \n  LIMA   ")
        assertEquals '\t \t X-RAY YANKEE\t\t ZULU',squeezeWhitespace("  \t\n  \n\t   X-RAY\n \n\n\n YANKEE\t\t   \nZULU\n")
    }
}
