package src;

class Mesh {
    public var vertices: Array<Vector3>;
    public var faces: Array<Face>;

    public function new(vertices: Array<Vector3> = null, faces: Array<Face> = null) {
        this.vertices = vertices != null ? vertices : [];
        this.faces = faces != null ? faces : [];
    }

    public static function createCube(size: Float = 1): Mesh {
        var s = size / 2;

        var verts = [
            new Vector3(-s, -s, -s),
            new Vector3(s, -s, -s),
            new Vector3(s, s, -s),
            new Vector3(-s, s, -s),
            new Vector3(-s, -s, s),
            new Vector3(s, -s, s),
            new Vector3(s, s, s),
            new Vector3(-s, s, s)
        ];

        var faces = [ // finish
            new Face([4, 5, 6, 7], new Vector3(0, 0, 1)), // the front
            new Face([1, 0, 3, 2], new Vector3(0, 0, -1)), // the back
            new Face([3, 2, 6, 7], new Vector3(0, 1, 0)), // top
            new Face([0, 1, 5, 4], new Vector3(0, -1, 0)), // bottom
            new Face([1, 5, 6, 2], new Vector3(1, 0, 0)), // right
            new Face([0, 4, 7, 3], new Vector3(-1, 0, 0)) // left
        ];

        return new Mesh(verts, faces);
    }
}

class Face {
    public var indices: Array<Int>;
    public var normal: Vector3;

    public function new(indices: Array<Int>, normal: Vector3) {
        this.indices = indices;
        this.normal = normal;
    }
}