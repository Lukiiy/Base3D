package src;

class Material {
    public var color: String;
    public var wireframe: Bool;
    public var ambientFactor: Float;
    public var diffuseFactor: Float;

    public function new(color: String = "#00ff00", wireframe: Bool = false) {
        this.color = color;
        this.wireframe = wireframe;
        this.ambientFactor = .2;
        this.diffuseFactor = .8;
    }
}