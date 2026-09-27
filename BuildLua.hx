@:native("_G")
extern class Global { // exposes the whole thing globally
    public static var Engine: Dynamic;
}

class BuildLua {
    static function main() {
        Global.Engine = {
            Vector3: src.Vector3,
            Camera: src.Camera,
            Light: src.Light,
            Material: src.Material,
            Mesh: src.Mesh,
            Object3D: src.Object3D,
            Scene: src.Scene,
            Stroke: src.Stroke
        };
    }
}