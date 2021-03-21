//
//  Bundle_Spec.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 3/21/21.
//  Copyright © 2021 Anton Plebanovich. All rights reserved.
//

import Quick
import Nimble
@testable import APExtensions

class Bundle_Spec: QuickSpec {
    override func spec() {
        describe("Bundle") {
            describe("appID") {
                it("should return proper ID") {
                    expect(Bundle.appID) == "com.anton-plebanovich.APExtensions-Example"
                }
            }
            describe("Version") {
                it("should have proper values") {
                    expect(Bundle.appVersionString) == "9.0.2"
                    expect(Bundle.appVersion) == "9.0.2"
                    expect(Bundle.appBuildVersionString) == "1217"
                    expect(Bundle.appFullVersionString) == "9.0.2.1217"
                    expect(Bundle.fullAppVersion) == "9.0.2.1217"
                }
            }
        }
    }
}
