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

    public static function createPlane(width: Float = 1, height: Float = 1): Mesh {
        var halfW = width / 2;
        var halfH = height / 2;

        var verts = [
            new Vector3(-halfW, -halfH, 0),
            new Vector3(halfW, -halfH, 0),
            new Vector3(halfW, halfH, 0),
            new Vector3(-halfW, halfH, 0)
        ];

        var faces = [new Face([3, 2, 1, 0], new Vector3(0, 0, -1))];

        return new Mesh(verts, faces);
    }

    public static function createPyramid(base: Float = 1, height: Float = 1): Mesh {
        var s = base / 2;

        var verts = [
            new Vector3(-s, 0, -s),
            new Vector3(s, 0, -s),
            new Vector3(s, 0, s),
            new Vector3(-s, 0, s),
            new Vector3(0, height, 0) // top
        ];

        var faces = [new Face([0, 3, 2, 1], new Vector3(0, -1, 0))]; // base

        var sides = [
            [0, 1],
            [1, 2],
            [2, 3],
            [3, 0]
        ];

        for (edge in sides) {
            var a = verts[edge[0]];
            var b = verts[edge[1]];
            var top = verts[4];
            var normal = top.sub(a).cross(b.sub(a)).normalize();

            faces.push(new Face([edge[0], edge[1], 4], normal));
        }

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