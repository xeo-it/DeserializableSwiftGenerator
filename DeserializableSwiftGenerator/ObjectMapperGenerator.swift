//
//  ObjectMapperGenerator.swift
//  DeserializableSwiftGenerator
//
//  Created by Cem Olcay on 25/12/14.
//  Copyright (c) 2014 Cem Olcay. All rights reserved.
//

import Cocoa

final class ObjectMapperGenerator: SWGenerator {

    // MARK: SWGeneratorProtocol
    
    override var deserialzeProtocolName: String? {
        return "Object,Mappable"
    }
    
    override func generateClassBody(sw: SWClass) -> String {
        var body = generateInit(sw)
        body += "\n"
        body += generateMap(sw)
        return body
    }

    // MARK: ObjectMapper Generator
    
    func generateInit(sw: SWClass) -> String {
        var initMethod = "\n\t// MARK: Mappable\n\n\t"
        initMethod += sw.superName == nil ? "" : "override "
        initMethod += "required convenience init?(_ map: Map) {\n"
        initMethod += "\t\tself.init()\n"
        initMethod += "\t}\n"
        return initMethod
        
    }
    
    func generateMap (sw: SWClass) -> String {
        var map = ""
        if sw.superName != nil {
            map = "\toverride func mapping(map: Map) {\n"
            map += "\t\tsuper.mapping(map)\n"
        } else {
            map = "\tfunc mapping(map: Map) {\n"
        }
        if let p = sw.properties {
            for prop in p {
                map += "\t\t" +
                        prop.name +
                        " <- " +
                        "map[\"" +
                        prop.name +
                        "\"]\n"
            }
        }
        map += "\t}\n"
        return map
    }
}
