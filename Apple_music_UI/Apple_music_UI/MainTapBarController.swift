import UIKit

class MainTapBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainPage = MainViewController()
        let mediaPage = MediaViewController()
        let profilePage = ProfileViewController()
        
        let mainNav = UINavigationController(rootViewController: mainPage)
        let mediaNav = UINavigationController(rootViewController: mediaPage)
        let profileNav = UINavigationController(rootViewController: profilePage)
        
        mainNav.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "house"), tag: 0)
        mediaNav.tabBarItem = UITabBarItem(title: "Медиа", image: UIImage(systemName: "music.pages"), tag: 0)
        profileNav.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), tag: 0)
        
        viewControllers = [mainNav, mediaNav, profileNav]
    }
}
