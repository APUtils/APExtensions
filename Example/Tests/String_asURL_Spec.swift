//
//  String_asURL_Spec.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 2/2/19.
//  Copyright © 2019 Anton Plebanovich All rights reserved.
//

import Quick
import Nimble
@testable import APExtensions

class String_asURL_Spec: QuickSpec {
    override func spec() {
        describe("String asURL property") {
            it("should return properly escaped URL") {
                expect("https://github.com/APUtils/APExtensions".asURL).to(equal(URL(string: "https://github.com/APUtils/APExtensions")))
                expect("https://github.com/APUtils/APExtensions#asd".asURL).to(equal(URL(string: "https://github.com/APUtils/APExtensions#asd")))
                expect("http://github.com/APUtils/APExtensions".asURL).to(equal(URL(string: "http://github.com/APUtils/APExtensions")))
                expect("https://github.com/APUtils/APExtensions?working=always".asURL).to(equal(URL(string: "https://github.com/APUtils/APExtensions?working=always")))
                expect("https://github.com/APUtils/АПЭкстеншены?working=always".asURL).to(equal(URL(string: "https://github.com/APUtils/%D0%90%D0%9F%D0%AD%D0%BA%D1%81%D1%82%D0%B5%D0%BD%D1%88%D0%B5%D0%BD%D1%8B?working=always")))
                expect("https://github.com/APUtils/APExtensions?работает=always".asURL).to(equal(URL(string: "https://github.com/APUtils/APExtensions?%D1%80%D0%B0%D0%B1%D0%BE%D1%82%D0%B0%D0%B5%D1%82=always")))
                expect("https://github.com/APUtils/АПЭкстеншены?работает=always".asURL).to(equal(URL(string: "https://github.com/APUtils/%D0%90%D0%9F%D0%AD%D0%BA%D1%81%D1%82%D0%B5%D0%BD%D1%88%D0%B5%D0%BD%D1%8B?%D1%80%D0%B0%D0%B1%D0%BE%D1%82%D0%B0%D0%B5%D1%82=always")))
                expect("https://github.com/APUtils/АПЭкстеншены?работает=always#asd".asURL).to(equal(URL(string: "https://github.com/APUtils/%D0%90%D0%9F%D0%AD%D0%BA%D1%81%D1%82%D0%B5%D0%BD%D1%88%D0%B5%D0%BD%D1%8B?%D1%80%D0%B0%D0%B1%D0%BE%D1%82%D0%B0%D0%B5%D1%82=always#asd")))
            }
        }
    }
}
