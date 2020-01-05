//
//  Constants_isRunningUnitTests_Spec.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 2/2/19.
//  Copyright © 2019 Anton Plebanovich All rights reserved.
//

import Quick
import Nimble
@testable import APExtensions

class Constants_isRunningUnitTests_Spec: QuickSpec {
    override func spec() {
        describe("Constants.isRunning...") {
            it("should return valid value for Tests") {
                expect(Constants.isRunningTests).to(beTrue())
            }
            
            it("should return valid value for UITests") {
                expect(Constants.isRunningUITests).to(beFalse())
            }
            
            it("should return valid value for UnitTests") {
                expect(Constants.isRunningUnitTests).to(beTrue())
            }
        }
    }
}
