package src;

class Camera {
    public var position: Vector3;
    public var rotation: Vector3;
    public var fov: Float;

    public function new(fov: Float = 70) {
        this.position = new Vector3(0, 0, 0);
        this.rotation = new Vector3(0, 0, 0);
        this.fov = fov;
    }
}