package src;

@:keep
class Scene {
    public var objects: Array<Object3D>;
    public var lights: Array<Light>;
    public var camera: Camera;

    public function new() {
        this.objects = [];
        this.lights = [];

        this.camera = new Camera();
    }

    public function add(obj: Object3D): Void objects.push(obj);
    public function remove(obj: Object3D): Void objects.remove(obj);
    
    public function addLight(light: Light): Void lights.push(light);
    public function removeLight(light: Light): Void lights.remove(light);
}