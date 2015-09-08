//
//  XMLParser.swift
//  DNReader
//
//  Created by Felix Hedlund on 08/09/2015.
//  Copyright (c) 2015 Tactel. All rights reserved.
//

import UIKit

@objc protocol XMLParserDelegate{
    func parsingWasFinished()
}

class XMLParser: NSObject, NSXMLParserDelegate {
    
    var arrParsedData = [Dictionary<String, String>]()
    var currentDataDictionary = Dictionary<String, String>()
    var currentElement = ""
    var foundCharacters = ""
    
    var delegate : XMLParserDelegate?
    
    func startParsingWithContentsOfURL(rssURL: NSURL) {
        let parser = NSXMLParser(contentsOfURL: rssURL)!
        parser.delegate = self
        parser.parse()
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if !foundCharacters.isEmpty {
            
            if elementName == "link"{
                foundCharacters = (foundCharacters as NSString).substringFromIndex(3)
            }
            
            currentDataDictionary[currentElement] = foundCharacters
            
            foundCharacters = ""
            
            if currentElement == "pubDate" {
                arrParsedData.append(currentDataDictionary)
            }
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        delegate?.parsingWasFinished()
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        println(parseError.description)
    }
    
    
    func parser(parser: NSXMLParser, validationErrorOccurred validationError: NSError) {
        println(validationError.description)
    }
}
