//
//  InputAccessoryToolbar.swift
//  evo-web-example
//
//  Created by Paweł Wojtkowiak on 11/09/2019.
//  Copyright © 2019 Intelligent Payments. All rights reserved.
//

import UIKit

/// A UIToolbar subclass that can be set up with a button of given kind.
/// Set `action` closure to handle tap events.
final class InputAccessoryToolbar: UIToolbar {
    typealias Tag = Int

    enum Kind {
        case next
        case done
    }

    private var action: (() -> Void)?
    private var toggleInputView: (() -> Void)?
    private var toggleButtonItem: UIBarButtonItem?
    private var inputType: InputType = .keyboard

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(kind: Kind = .next, toggleInputAction: (() -> Void)?, action: @escaping (() -> Void)) {
        self.init(frame: .zero)
        var barButtonItems:[UIBarButtonItem] = []
        // check whether to add toggle button
        if let toggleAction = toggleInputAction {
            let toggleButton = UIBarButtonItem(title: "Keyboard", style: .done, target: self, action: #selector(toggleInputViewAction))
            barButtonItems.append(toggleButton)
            
            toggleButtonItem = toggleButton
            toggleInputView = toggleAction
            
            inputType = .picker
        }
        
        let actionButton: UIBarButtonItem

        switch kind {
        case .done:
            actionButton = UIBarButtonItem(barButtonSystemItem: .done,
                                           target: self,
                                           action: #selector(doneTapAction))
        case .next:
            let nextButton = UIButton(type: .system)
            nextButton.setTitle("→", for: .normal)
            nextButton.setTitleColor(tintColor, for: .normal)
            nextButton.titleLabel?.font = .boldSystemFont(ofSize: 19.0)
            nextButton.addTarget(self, action: #selector(nextTapAction(_:)), for: .touchUpInside)
            actionButton = UIBarButtonItem(customView: nextButton)
        }

        barButtonItems.append(contentsOf: [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            actionButton
        ])
        self.items = barButtonItems
        self.sizeToFit()

        self.action = action
    }

    @objc private func doneTapAction() {
        action?()
    }

    @objc private func nextTapAction(_ sender: UIButton) {
        action?()
    }
    
    @objc private func toggleInputViewAction() {
        switch inputType {
        case .picker:
            inputType = .keyboard
            toggleButtonItem?.title = "Selection"
        case .keyboard:
            inputType = .picker
            toggleButtonItem?.title = "Keyboard"
        }
        
        toggleInputView?()
    }

}
