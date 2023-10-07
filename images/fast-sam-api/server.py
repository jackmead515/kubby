# generate Flask boilerplate
from flask import Flask, request, Response
from PIL import Image
from fastsam import FastSAM, FastSAMPrompt
import io

model = FastSAM('/app/FastSAM-x.pt')

image_cache = {}

app = Flask(__name__)

@app.route('/api/annotate/points', methods=['GET'])
def annotate_points():
    points = request.args.getlist('p')
    points = [p.split(',') for p in points]
    points = [[int(p[0]), int(p[1])] for p in points]
    
    image_hash = request.headers.get('x-image-hash')
    
    if image_hash is None:
        return Response('Missing x-image-hash header', status=400)
    
    if image_hash in image_cache:
        image = image_cache[image_hash]
    else:
        image = request.stream.read()
        image = Image.open(io.BytesIO(image)).convert('RGB')
        image_cache[image_hash] = image
        
    if len(image_cache) > 100:
        del image_cache[list(image_cache.keys())[0]]

    results = model(image, device='cpu', retina_masks=True, imgsz=1024, conf=0.4, iou=0.9)
    prompt_process = FastSAMPrompt(image, results, device='cpu')
    
    annotation = prompt_process.point_prompt(points=points, pointlabel=[1 for _ in points])
    
    response_headers = {
        'x-numpy-shape': str(annotation.shape),
        'x-numpy-dtype': str(annotation.dtype),
    }

    return Response(
        annotation.tobytes(),
        mimetype='application/octet-stream',
        headers=response_headers
    )


@app.route('/api/annotate/all', methods=['GET'])
def annotate_all():
    image = request.stream.read()
    image = Image.open(io.BytesIO(image)).convert('RGB')

    results = model(image, device='cpu', retina_masks=True, imgsz=1024, conf=0.4, iou=0.9)
    prompt_process = FastSAMPrompt(image, results, device='cpu')
    
    annotation = prompt_process.everything_prompt()

    annotation = annotation.cpu().detach().numpy()

    response_headers = {
        'x-numpy-shape': str(annotation.shape),
        'x-numpy-dtype': str(annotation.dtype),
    }

    return Response(
        annotation.tobytes(),
        mimetype='application/octet-stream',
        headers=response_headers
    )


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8181)