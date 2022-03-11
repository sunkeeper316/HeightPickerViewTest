import UIKit
import Foundation

public class HeightPickerTextField : UITextField {
    
    var pickerView : UIPickerView? = MetricHeightPickerView()
    public var decimalDigits = 1{
        didSet {
            if let pickerView = pickerView as? MetricHeightPickerView {
                pickerView.decimalDigits = self.decimalDigits
            }else
            if let pickerView = pickerView as? ImperialHeightPickerView {
                pickerView.decimalDigits = self.decimalDigits
            }
        }
    }
    public var value : Double = 0.0 {
        didSet {
            switch unitSystem {
            case .Metric:
                print(self.value)
                if let pickerView = pickerView as? MetricHeightPickerView {
                    pickerView.value = self.value
                }
                self.text = "\(String(format:"%.\(decimalDigits)f", self.value))"
            case .Imperial:
                print(self.value)
                if let pickerView = pickerView as? ImperialHeightPickerView {
                    pickerView.value = self.value
                }
                let _ftValue = Int(self.value / 12)
                let _inchValue = self.value - Double(_ftValue * 12)
                self.text = "\(_ftValue)'\(String(format:"%.\(decimalDigits)f", _inchValue))\""
                
            }
        }
    }
    
    public var unitSystem : UnitSystem = .Metric  {
        
        didSet {
            self.endEditing(true)
            switch unitSystem {
            case .Metric:
                self.value = self.value * 2.54
                setMetric()
            case .Imperial:
                self.value = self.value / 2.54
                setImperial()
            }
        }
    }
    public var doneBottonTitle = "OK"
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        setToolbar()
        setMetric()
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
        setToolbar()
        setMetric()
    }
    
    func setMetric(){
        pickerView = MetricHeightPickerView()
        if let pickerView = pickerView as? MetricHeightPickerView {
            pickerView.metricHeightdelegate = self
            pickerView.decimalDigits = self.decimalDigits
            pickerView.value = self.value
        }
        self.inputView = pickerView
    }
    func setImperial(){
        pickerView = ImperialHeightPickerView()
        if let pickerView = pickerView as? ImperialHeightPickerView {
            pickerView.imperialHeightdelegate = self
            pickerView.decimalDigits = self.decimalDigits
            pickerView.value = self.value
        }
        self.inputView = pickerView
    }
    
    
    public enum UnitSystem : Int {
        case Metric = 0 ,Imperial = 1
    }
    func setToolbar(){
        let toolBarHeight:CGFloat = 150
        //製作鍵盤上方幫手
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: toolBarHeight))
        //左邊空白處
        let flexSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //想製作的按鈕及用途
        let doneBotton: UIBarButtonItem = UIBarButtonItem(title: doneBottonTitle, style: .done, target: self, action: #selector(doneButtonAction))
        toolBar.setItems([flexSpace,doneBotton], animated: false)
        toolBar.sizeToFit()
        self.inputAccessoryView = toolBar
    }
    @objc func doneButtonAction() {
        self.endEditing(true)
    }
}

extension HeightPickerTextField : UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        switch unitSystem {
        case .Metric :
            
            break
            
        case .Imperial :
            
            break
        }
        return true
    }
    
}
extension HeightPickerTextField : ImperialHeightPickerViewDelegate , MetricHeightPickerViewDelegate {
    public func imperialHeightPickerView(imperialHeightPickerView: ImperialHeightPickerView, value: Double, ftValue: Int, inchValue: Double) {
        self.value = value
    }
    
    public func metricHeightPickerView(metricHeightPickerView: MetricHeightPickerView, value: Double) {
        self.value = value
    }
    
    
}


