//
//  Utils.swift
//  Pine
//
//  Created by Luka Kerr on 1/3/19.
//  Copyright © 2019 Luka Kerr. All rights reserved.
//

import Cocoa
import Foundation

class Utils {

  /// The current main window controller of the application
  public static func getCurrentMainWindowController() -> PineWindowController? {
    if let keyWindow = NSApp.keyWindow, keyWindow.isVisible {
      return keyWindow.windowController as? PineWindowController
    }

    return NSApp.windows.filter({ $0.isVisible }).first?.windowController as? PineWindowController
  }

  public static func setDefaultApplication() {
    guard
      let bundleId = Bundle.main.bundleIdentifier as CFString?,
      let utiTypes = Bundle.main.infoDictionary?["UTImportedTypeDeclarations"] as? [[String: Any]]
    else { return }

    for utiType in utiTypes {
      guard
        let tagSpec = utiType["UTTypeTagSpecification"] as? [String: Any],
        let exts = tagSpec["public.filename-extension"] as? [String]
        else { continue }

      var didError = false

      for ext in exts {
        guard
          let utiString = UTTypeCreatePreferredIdentifierForTag(
            kUTTagClassFilenameExtension,
            ext as CFString,
            nil
          )?.takeUnretainedValue()
        else { continue }

        let status = LSSetDefaultRoleHandlerForContentType(utiString, .all, bundleId)

        if status != kOSReturnSuccess {
          didError = true
        }
      }

      if didError {
        Alert.error(message: "There was a problem setting Pine as the Default Application")
      } else {
        Alert.success(message: "Successfully set Pine as the Default Application")
      }
    }
  }

}
