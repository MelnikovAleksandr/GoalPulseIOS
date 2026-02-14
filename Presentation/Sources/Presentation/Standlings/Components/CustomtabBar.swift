//
//  CustomtabBar.swift
//  Presentation
//
//  Created by Александр Мельников on 31.01.2026.
//

import SwiftUI

struct CustomtabBar<UI: View>: UIViewRepresentable {
    
    var size: CGSize
    var activeTint: Color = Color.theme.primary
    var barTint: Color = .gray.opacity(0.15)
    @Binding var activeTab: Tab?
    var tabs: [Tab]
    @ViewBuilder var tabItemView: (Tab) -> UI
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let items = tabs.map(\.rawValue)
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        
        for(index, tab) in tabs.enumerated() {
            let renderer = ImageRenderer(content: tabItemView(tab))
            renderer.scale = 2
            let image = renderer.uiImage
            
            control.setImage(image, forSegmentAt: index)
        }
        
        DispatchQueue.main.async {
            for subview in control.subviews {
                if subview is UIImageView && subview != control.subviews.last {
                    subview.alpha = 0
                }
            }
        }
        control.selectedSegmentTintColor = UIColor(barTint)
        
        control.setTitleTextAttributes([.foregroundColor: UIColor(activeTint)], for: .selected)
        control.setTitleTextAttributes([.foregroundColor: UIColor(.gray)], for: .normal)
        
        control.addTarget(context.coordinator, action: #selector(context.coordinator.tabSelected(_:)),for: .valueChanged)
        return control
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let control = uiView as? UISegmentedControl else { return }
        
        if let activeTab = activeTab,
           let index = tabs.firstIndex(of: activeTab),
           control.selectedSegmentIndex != index {
            control.selectedSegmentIndex = index
        }
    }
    
    func sizeThatFits(_ proposal: ProposedViewSize, uiView: UIViewType, context: Context) -> CGSize? {
        return size
    }
    
    
    class Coordinator: NSObject {
        var parent: CustomtabBar
        init(parent: CustomtabBar) {
            self.parent = parent
        }
        
        @MainActor @objc func tabSelected(_ control: UISegmentedControl) {
            withAnimation(.smooth(duration: 0.3)) {
                parent.activeTab = Tab.allCases[control.selectedSegmentIndex]
            }
        }
        
    }
}
