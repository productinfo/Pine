//
//  SidebarTableRowView.swift
//  Pine
//
//  Created by Luka Kerr on 10/3/19.
//  Copyright © 2019 Luka Kerr. All rights reserved.
//

import Cocoa

class SidebarTableRowView: NSTableRowView {

  // Draw a custom selection
  override func drawSelection(in dirtyRect: NSRect) {
    let selectionRect = NSInsetRect(self.bounds, 0, 0)

    NSColor.selectedControlColor.setStroke()
    NSColor.selectedControlColor.setFill()

    let selectionPath = NSBezierPath.init(roundedRect: selectionRect, xRadius: 0, yRadius: 0)
    selectionPath.fill()
    selectionPath.stroke()
  }

}
