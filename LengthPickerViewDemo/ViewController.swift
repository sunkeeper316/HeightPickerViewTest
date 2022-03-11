
import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tfHeight: HeightPickerTextField!
    let metricHeightPickerView = MetricHeightPickerView()
    let imperialHeightPickerView = ImperialHeightPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let metricHeightPickerView = MetricHeightPickerView()
        metricHeightPickerView.metricHeightdelegate = self
        imperialHeightPickerView.imperialHeightdelegate = self
//        metricHeightPickerView.integer = 4
        imperialHeightPickerView.decimalDigits = 3
        tfHeight.text = "asdndskvndksk"
        tfHeight.value = 129.9
        tfHeight.decimalDigits = 2
//        tfHeight.unitSystem = .Imperial
//        tfHeight.inputView = imperialHeightPickerView
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func clickChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            tfHeight.unitSystem = .Metric
        }else{
            tfHeight.unitSystem = .Imperial
        }
        
    }
    
}
extension ViewController:MetricHeightPickerViewDelegate {
    func metricHeightPickerView(metricHeightPickerView: MetricHeightPickerView, value: Double) {
//        tfHeight.text = "\(value)"
    }
    
    
}
extension ViewController:ImperialHeightPickerViewDelegate {
    func imperialHeightPickerView(imperialHeightPickerView: ImperialHeightPickerView, value: Double, ftValue: Int, inchValue: Double) {
//        tfHeight.text = "\(value)"
    }
    
     
    
    
}
