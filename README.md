# GitHub-followers
StoryBoard free iOS app which lists your Github followers. 
This app uses Sean Allen's take-home project, as starting point. 
But it diverges from Sean implementation in various ways. 

What's similar to Sean's project:
- the visual interface is similar 
- used the same assets
- app functionalities are the same (for now): 
  - fetching data, used a collectionView with diffable dataSource
  - used tableView for favorites
- the general feel of the app is similar to Sean's project


What's different from Sean's project:
- implemented a CacheManager
- PersistenceManager uses FileManager to write to a local plist file, instead of UserDefaults 
- followed Coordinators design pattern instead of MVC
- delegated responsability of presenting ViewControllers to a concrete Router (protocol) implementation
- relied heavily on delegation pattern, when passing data from viewControllers to coordinators
- delegated networking responsability of cells (UICollectionViewCell & UITableViewCell) to a default implementation of Composer protocol
- added documentation for 95 % of the project
- and many other small changes



Sean Allen take-home project is available here: https://seanallen.teachable.com/



<img width="201" alt="image" src="https://user-images.githubusercontent.com/22425017/75874154-76466000-5e11-11ea-9ecc-27b40e1537ff.png">  <img width="201" alt="image" src="https://user-images.githubusercontent.com/22425017/75874267-a988ef00-5e11-11ea-95ac-7889c38243e2.png"> <img width="201" alt="image" src="https://user-images.githubusercontent.com/22425017/75876718-80b72880-5e16-11ea-84fc-89c76818e135.png"> <img width="215" alt="image" src="https://user-images.githubusercontent.com/22425017/75877201-6fbae700-5e17-11ea-9872-b761fb38717c.png">


