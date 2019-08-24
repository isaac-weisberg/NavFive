import UIKit

class LoadingView: XibModularView {
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var aLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

private extension LoadingView {
    func setup() {
        aLabel.text = "Loading..."
    }
}
