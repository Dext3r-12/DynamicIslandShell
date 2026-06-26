import QtQuick
import QtQuick3D

Node {
    id: node

    // Resources
    PrincipledMaterial {
        id: principledMaterial
        metalness: 1
        roughness: 1
        alphaMode: PrincipledMaterial.Opaque
    }

    // Nodes:
    Model {
        id: cube_001
        objectName: "Cube.001"
        position: Qt.vector3d(0, 2, 0)
        scale: Qt.vector3d(1, 1.9, 2)
        source: "meshes/cube_002_mesh.mesh"
        materials: [
            principledMaterial
        ]
    }

    // Animations:
}
