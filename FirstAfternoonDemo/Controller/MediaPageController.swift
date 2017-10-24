import UIKit
import AVFoundation

public class MediaPageController : UIViewController
{
    
    @IBOutlet weak var imageFrame: UIImageView!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var soundSlider: UISlider!
    
    private lazy var color : ColorTools = ColorTools()
    private var imageCounter : Int = 0
    private var soundPlayer : AVAudioPlayer?
    
    public override func viewDidLoad() -> Void
    {
        super.viewDidLoad()
        view.backgroundColor = color.createRandomColor()
        loadAudioFile()
        // do any additional setup after loading the view.
    }
    
    
    
    
    
    
    
    
    
    private func loadAudioFile() -> Void
    {
        if let soundURL = NSDataAsset(name: "WiiMusic")
        {
            do
                {
                    try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                    try! AVAudioSession.sharedInstance().setActive(true)
                    
                    try soundPlayer = AVAudioPlayer(data: soundURL.data, fileTypeHint: AVFileType.mp3.rawValue)
                    soundSlider.maximumValue = Float ((soundPlayer?.duration)!)
                    Timer.sccheduledTimer(timeInterval: 0.2, target: self, selector: (#selector(self.updateSlider)), userInfo: nil, repeats: true)
            }
            catch
            {
                print("Audio File Load Error")
            }
        }
        
    }
    
    
    
    
    
}

