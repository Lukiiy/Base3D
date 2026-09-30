package src;

class Renderer {
    private static inline var NEAR_PLANE: Float = 0.1;

    private var target: IRenderer;

    public function new(target: IRenderer) {
        this.target = target;
    }

    public function render(width: Float, height: Float) {
        var queue: Array<RenderableFace> = [];

        for (obj in scene.objects) {
            if (obj.mesh == null) continue;

            var cameraPersp: Array<Vector3> = [];

            for (vector in obj.mesh.vertices) cameraPersp.push(toCamSpace(vector, obj, camera));
            for (face in obj.mesh.faces) processFace(face, obj, scene, cameraPersp, focalLen, width, height, queue);
        }

        queue.sort((a, b) -> (a.averageZ > b.averageZ) ? -1 : 1); // depth sort - further away renders first

        for (face in queue) drawFace(face);
    }

    private function toCamSpace(v: Vector3, obj: Object3D, camera: Camera): Vector3 {
        return new Vector3(v.x * obj.scale.x, v.y * obj.scale.y, v.z * obj.scale.z).rotateX(obj.rotation.x).rotateY(obj.rotation.y).rotateZ(obj.rotation.z).add(obj.position).sub(camera.position).rotateZ(-camera.rotation.z).rotateY(-camera.rotation.y).rotateX(-camera.rotation.x);
    }

    private function processFace(face: Face, obj: Object3D, scene: Scene, cameraPersp: Array<Vector3>, focalLen: Float, width: Float, height: Float, queue: Array<RenderableFace>): Void {
        var normal = face.normal.rotateX(obj.rotation.x).rotateY(obj.rotation.y).rotateZ(obj.rotation.z);
        var viewNormal = normal.rotateZ(-scene.camera.rotation.z).rotateY(-scene.camera.rotation.y).rotateX(-scene.camera.rotation.x);
        var viewDir = cameraPersp[face.indices[0]];

        if (!obj.material.wireframe && viewNormal.dot(viewDir) >= 0) return; // backface culling

        var faceVerts: Array<Vector3> = [];
        for (idx in face.indices) faceVerts.push(cameraPersp[idx]);

        var clipped = clipNear(faceVerts);
        if (clipped.length < 3) return;

        var sumZ: Float = 0;
        var projected: Array<{x: Float, y: Float}> = [];

        for (vert in clipped) {
            sumZ += cv.z;

            projected.push({
                x: (vert.x / vert.z) * focalLen + (width / 2),
                y: (-vert.y / vert.z) * focalLen + (height / 2)
            });
        }

        var fLight = calculateLighting(normal, obj.material, scene.lights);

        queue.push({
            coords: projected,
            averageZ: sumZ / clipped.length,
            color: ColorUtils.getShade(obj.material.color, fLight),
            wireframe: obj.material.wireframe,
            modifiers: obj.modifiers
        });
    }

    private function calculateLighting(normal: Vector3, material: Material, lights: Array<Light>): Float {
        var fLight: Float = 0.0;

        for (light in lights) {
            switch (light.type) {
                case Ambient:
                    fLight += light.intensity * material.ambientFactor;

                case Directional:
                    var dot = normal.dot(light.direction.scale(-1));

                    if (dot > 0) fLight += dot * light.intensity * material.diffuseFactor;
            }
        }

        return Math.max(0.0, Math.min(1.0, fLight));
    }

    private function drawFace(face: RenderableFace): Void {
        if (face.wireframe) {
            for (i in 0...face.coords.length) {
                var p1 = face.coords[i];
                var p2 = face.coords[(i + 1) % face.coords.length];

                target.drawLine(p1.x, p1.y, p2.x, p2.y, face.color, 1);
            }

            return;
        }

        target.drawPolygon(face.coords, face.color);

        for (i in 0...face.coords.length) {
            var p1 = face.coords[i];
            var p2 = face.coords[(i + 1) % face.coords.length];

            target.drawLine(p1.x, p1.y, p2.x, p2.y, face.color, 1);
        }

        for (mod in face.modifiers) mod.apply(face, target);
    }

    private function clipNear(verts: Array<Vector3>): Array<Vector3> {
        var output: Array<Vector3> = [];
        var count = verts.length;

        for (i in 0...count) {
            var vert = verts[i];
            var nextVert = verts[(i + 1) % count];
            var inside = vert.z > NEAR_PLANE;
            var nextInside = nextVert.z > NEAR_PLANE;

            if (inside) output.push(vert);

            if (inside != nextInside) {
                var interp = (NEAR_PLANE - vert.z) / (nextVert.z - vert.z);

                output.push(new Vector3(vert.x + (nextVert.x - vert.x) * interp, vert.y + (nextVert.y - vert.y) * interp, NEAR_PLANE));
            }
        }

        return output;
    }
}

typedef RenderableFace = {
    coords: Array<{x: Float, y: Float}>,
    averageZ: Float,
    color: Int,
    wireframe: Bool,
    modifiers: Array<PostModifier>
};