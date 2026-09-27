import src.Vector3;
import src.Camera;
import src.Light;
import src.Material;
import src.Mesh;
import src.Object3D;
import src.Scene;

@:native("_G")
extern class Global { // exposes the whole thing globally
    public static var Engine: Dynamic;
}

class BuildLua {
    static function main() {
        Global.Engine = {
            Vector3: Vector3,
            Camera: Camera,
            Light: Light,
            Material: Material,
            Mesh: Mesh,
            Object3D: Object3D
        };
    }
}
