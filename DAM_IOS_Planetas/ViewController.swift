//
//  ViewController.swift
//  DAM_IOS_Planetas
//
//  Created by raul.ramirez on 12/02/2020.
//  Copyright © 2020 Raul Ramirez. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var mSceneview: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.mSceneview.debugOptions = [.showWorldOrigin, .showFeaturePoints]
        self.mSceneview.session.run(configuration)
        
        self.mSceneview.autoenablesDefaultLighting = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let sun = self.planet(geomety: SCNSphere(radius: 0.35), diffuse: UIImage(named: "sun"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, -1))
        
        self.mSceneview.scene.rootNode.addChildNode(sun)
        
        let earth = self.planet(geomety: SCNSphere(radius: 0.2), diffuse: UIImage(named: "earth"), specular: UIImage(named: "earth-specular"), emission: UIImage(named: "earth-cloud"), normal: UIImage(named: "earth-nomral"), position: SCNVector3(1.2, 0, 0))
        
        let earthParent = SCNNode()
        earthParent.position = SCNVector3(0, 0, -1)
        self.mSceneview.scene.rootNode.addChildNode(earthParent)
        
        earthParent.addChildNode(earth)
        
        //Animamos la esfera para que de vueltas.
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 8)
        
        let forever = SCNAction.repeatForever(action) //Repite la acción siempre: la acción es dar una vuelta completa.
        sun.runAction(forever)
        
        let earthAction = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 14)
        
        let foreverEarth = SCNAction.repeatForever(earthAction)
        earthParent.runAction(foreverEarth)
        
        let moon = self.planet(geomety: SCNSphere(radius: 0.05), diffuse: UIImage(named: "moon"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, -0.3))
        
        earth.addChildNode(moon)
        
        let earthRotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 8)
        
        let foreverRotation = SCNAction.repeatForever(earthRotation)
        earth.runAction(foreverRotation)
    }
    
    func planet(geomety: SCNGeometry, diffuse: UIImage?, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode{
        let planet = SCNNode(geometry: geomety)
        
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        
        planet.position = position
        
        return planet
    }
}

extension Int{
    var degreesToRadians: Double { return Double(self) * .pi/180 }
}

