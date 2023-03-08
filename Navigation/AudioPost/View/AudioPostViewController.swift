//
//  AudioPostViewController.swift
//  Navigation
//
//  Created by Дина Шварова on 26.09.2022.
//

import UIKit
import AVFoundation

class AudioPostViewController: UIViewController {
    
    var output: AudioPostOutput?
    
    private var player = AVAudioPlayer()
    private var currentTrack = 0
    private var tracks = ["the-show-must-go-on", "bicycle-race", "radio-ga-ga", "don-t-stop-me-now", "bohemian-rhapsody"]
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Queen")
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.setContentCompressionResistancePriority(UILayoutPriority(100), for: .vertical)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var currentTrackLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.text = tracks[0]
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "arrowtriangle.forward.fill"), for: .normal)
        button.addTarget(self, action: #selector(playButtonTouched), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stopButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "stop.fill"), for: .normal)
        button.addTarget(self, action: #selector(stopButtonTouched), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var forwardButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "forward"), for: .normal)
        button.addTarget(self, action: #selector(forwardButtonTouched), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var previousButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "backward"), for: .normal)
        button.addTarget(self, action: #selector(previousButtonTouched), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView ()
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        let titleLabel = UILabel()
        titleLabel.text = "Queen"
        title = titleLabel.text
        navigationItem.backButtonTitle = "Назад"
        let infoImage = UIImage(named: "info")
        let infoButton = UIBarButtonItem(image: infoImage, style: .plain, target: self, action: #selector(buttonInfoClicked))
        navigationItem.rightBarButtonItem = infoButton
        setupView()
        prepareToPlayTrack(needToPlay: player.isPlaying)
        checkCurrentTrack()
    }
    
    private func prepareToPlayTrack(needToPlay: Bool) {
            do {
                player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: tracks[currentTrack], ofType: "mp3")!))
                player.prepareToPlay()
                if needToPlay {
                    player.play()
                }
            }
            catch {
                print(error)
            }
        }
    
    private func setupView() {
        view.addSubviews([image, currentTrackLabel, stackView])
        stackView.addArrangedSubview(previousButton)
        stackView.addArrangedSubview(playButton)
        stackView.addArrangedSubview(stopButton)
        stackView.addArrangedSubview(forwardButton)
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            image.bottomAnchor.constraint(equalTo: currentTrackLabel.bottomAnchor, constant: -40),
            image.heightAnchor.constraint(equalToConstant: 350),
            
            currentTrackLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -40),
            currentTrackLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            currentTrackLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            
            previousButton.widthAnchor.constraint(equalToConstant: 40),
            previousButton.heightAnchor.constraint(equalToConstant: 40),
            
            playButton.widthAnchor.constraint(equalToConstant: 40),
            playButton.heightAnchor.constraint(equalToConstant: 40),
            
            stopButton.widthAnchor.constraint(equalToConstant: 40),
            stopButton.heightAnchor.constraint(equalToConstant: 40),
            
            forwardButton.widthAnchor.constraint(equalToConstant: 40),
            forwardButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func checkCurrentTrack() {
            switch currentTrack {
            case 0:
                previousButton.alpha = 0
            case tracks.count - 1:
                forwardButton.alpha = 0
            default:
                previousButton.alpha = 1
                forwardButton.alpha = 1
            }
        }
    
    @objc func buttonInfoClicked() {
        output?.buttonInfoClicked()
    }
    
    @objc func playButtonTouched() {
        if player.isPlaying {
            playButton.setBackgroundImage(UIImage(systemName: "arrowtriangle.forward.fill"), for: .normal)
            player.stop()
        } else {
            playButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            player.play()
        }
    }
    
    @IBAction func stopButtonTouched() {
        player.currentTime = 0
        playButton.setBackgroundImage(UIImage(systemName: "arrowtriangle.forward.fill"), for: .normal)
        player.stop()
    }
    
    @objc func previousButtonTouched() {
        currentTrack -= 1
        checkCurrentTrack()
        currentTrackLabel.text = tracks[currentTrack]
        prepareToPlayTrack(needToPlay: player.isPlaying)
    }
    
    @objc func forwardButtonTouched() {
        currentTrack += 1
        checkCurrentTrack()
        currentTrackLabel.text = tracks[currentTrack]
        prepareToPlayTrack(needToPlay: player.isPlaying)
    }
}
