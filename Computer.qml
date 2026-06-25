import QtQuick
import QtQuick3D

Node {
    id: node

    // Resources
    property url textureData: "maps/textureData.png"
    Texture {
        id: _0_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData
    }
    PrincipledMaterial {
        id: material_001_material
        objectName: "Material.001"
	//baseColorMap: Texture { source: "Comp_texture" }
	baseColor: "white"
	opacityMap: Texture { source: "Comp_Alpha.png" }
	opacityChannel: PrincipledMaterial.R
	alphaMode: PrincipledMaterial.Blend
    }
    // Nodes:
    Model {
        id: cube
        objectName: "Cube"
        position: Qt.vector3d(0, 2, 0)
        source: "meshes/cube_001_mesh.mesh"
        materials: [
            material_001_material

        ]
    }

    // Animations:
}
