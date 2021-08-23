//
//  Occupiable_Spec.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 23.08.21.
//  Copyright © 2021 Anton Plebanovich. All rights reserved.
//

import Quick
import Nimble
@testable import APExtensions

class Occupiable_Spec: QuickSpec {
    override func spec() {
        describe("Occupiable") {
            describe("isNilOrEmpty") {
                it("should work properly") {
                    var nilArray: [Int]? = nil
                    expect(nilArray.isNilOrEmpty) == true
                    nilArray = []
                    expect(nilArray.isNilOrEmpty) == true
                    nilArray = [1]
                    expect(nilArray.isNilOrEmpty) == false
                    
                    var nilDic: [String: String]? = nil
                    expect(nilDic.isNilOrEmpty) == true
                    nilDic = [:]
                    expect(nilDic.isNilOrEmpty) == true
                    nilDic?["1"] = "1"
                    expect(nilDic.isNilOrEmpty) == false
                    
                    var nilString: String? = nil
                    expect(nilString.isNilOrEmpty) == true
                    nilString = ""
                    expect(nilString.isNilOrEmpty) == true
                    nilString = "1"
                    expect(nilString.isNilOrEmpty) == false
                    
                    var nilData: Data? = nil
                    expect(nilData.isNilOrEmpty) == true
                    nilData = Data()
                    expect(nilData.isNilOrEmpty) == true
                    nilData = "1".data(using: .utf8)
                    expect(nilData.isNilOrEmpty) == false
                }
            }
        }
    }
}
