package src;

class Object3D {
    public var position: Vector3;
    public var rotation: Vector3;
    public var scale: Vector3;
    public var mesh: Mesh;
    public var material: Material;
    public var modifiers: Array<PostModifier>;

    public function new(mesh: Mesh = null, material: Material = null) {
        this.position = new Vector3(0, 0, 0);
        this.rotation = new Vector3(0, 0, 0);
        this.scale = new Vector3(1, 1, 1);
        this.mesh = mesh;
        this.material = material != null ? material : new Material();
        this.modifiers = [];
    }
}