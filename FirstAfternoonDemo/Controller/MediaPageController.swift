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
    
    public override func didReceiveMemoryWarning() -> Void
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func imageButtonClick() -> Void
    {
        changeImage()
        view.backgroundColor = color.createRandomColor()
    }
    
    private func changeImage() -> Void
    {
        if (imageCounter > 2)
        {
            imageCounter = 0
        }
        
        if (imageCounter == 0)
        {
            imageFrame.image = UIImage(named: "congrats")
        }
        else if (imageCounter == 1)
        {
            imageFrame.image = UIImage(named: "Cow...")
        }
        else if (imageCounter == 2)
        {
            imageFrame.image = UIImage(named: "cow2")
        }
        else
        {
            
        }
        
        imageCounter += 1
    }
    
    @IBAction func soundButtonClick()
    {
        playMusicFile()
        view.backgroundColor = color.createRandomColor()
    }
    
    @IBAction func sliderMethod()
    {
        let seekTime = Double (soundSlider.value)
        soundPlayer?.currentTime = seekTime
    }
    
    private func playMusicFile() -> Void
    {
        if let isPlaying = soundPlayer?.isPlaying
        {
            if (isPlaying)
            {
                soundPlayer?.pause()
            }
            else
            {
                soundPlayer?.play()
            }
        }
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
                    Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: (#selector(self.updateSlider)), userInfo: nil, repeats: true)
            }
            catch
            {
                print("Audio File Load Error")
            }
        }
        
    }
    
    @objc private func updateSlider () -> Void
    {
        soundSlider.value = Float ((soundPlayer?.currentTime)!)
    }
}

